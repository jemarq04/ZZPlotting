import ROOT
import plot_functions as plotter
import Utilities.WeightInfo as WeightInfo
from Utilities.WeightedHistProducer import WeightedHistProducer
from Utilities.FromFileHistProducer import FromFileHistProducer
from Utilities.ConfigHistFactory import ConfigHistFactory 
from collections import OrderedDict
import os,sys
import subprocess
import glob
import logging
import datetime
import shutil
import errno
import math
import array
from IPython import embed
import pdb
import json

with open("Templates/config.%s" % os.getlogin()) as fconfig:
    for line in fconfig:
        if 'scriptPath' in line:
            
            scriptPath = line.split(" = ")[1].strip()
sys.path.insert(0,scriptPath)
import UserInput
import OutputTools
import ConfigureJobs
import HistTools

#logging.basicConfig(level=logging.DEBUG)
def truncateTH1(hist):
    
    for i in range(1,hist.GetNbinsX()+1):
        if hist.GetBinContent(i)<0.:
            tmperror = abs(hist.GetBinError(i)) #should be positive error, just in case
            hist.SetBinContent(i,0.)
            hist.SetBinError(i,tmperror)

def makePlots(hist_stacks, data_hists, name, args, signal_stacks=[0], errors=[]):
    canvas_dimensions = [800, 800] if "unrolled" not in name else [1200, 800]
    canvas = ROOT.TCanvas("%s_canvas" % name, name, *canvas_dimensions) 
    #canvas.SetFrameLineWidth(3)
    ROOT.gStyle.SetLineWidth(3) #For hists created before this command, line width not affected, if created after then affected
    first = True
    for hist_stack, data_hist, signal_stack in zip(hist_stacks, data_hists, signal_stacks):
        print "makePlot called"
        makePlot(hist_stack, data_hist, name, args, signal_stack, 
            same=(" same" if not first else ""))
        first = False
    offset = ROOT.gPad.GetLeftMargin() - 0.04 if args.legend_left else \
        ROOT.gPad.GetRightMargin() - 0.04 
    if hasattr(args, "selection"):
        width = .2 if "ZZ4l" in args.selection else 0.33
    else: 
        width = .33
    width *= args.scalelegx
    xdist = 0.1 if args.legend_left else 0.91
    xcoords = [xdist+offset, xdist+width+offset] if args.legend_left \
        else [xdist-width-offset, xdist-offset]
    unique_entries = min(len(hist_stacks[0].GetHists()), 8)
    ymax = 0.8 if args.legend_left else 0.9
    ycoords = [ymax, ymax - 0.08*unique_entries*args.scalelegy]
    coords = [xcoords[0], ycoords[0], xcoords[1], ycoords[1]]
    
    doSyst_diagnostic = True
    dosyst = glb_doSyst and doSyst_diagnostic
    if dosyst:
        mainband,ratioband=getSystValue(hist_stacks[0].GetStack().Last())
    else:
        mainband = None
        ratioband = None
    if mainband and ratioband:
        ROOT.SetOwnership(ratioband, False)
        ROOT.SetOwnership(mainband, False)
        #pdb.set_trace()

        #By design, if input channel is eemm, mainband should return 2e2m result 
        
        #hmb = mainband.GetHistogram() #hist used to draw xaxis
        totup = 0.
        totdn = 0.
        for bini in range(0,mainband.GetN()):
            totup+=mainband.GetErrorYhigh(bini)
            totdn+=mainband.GetErrorYlow(bini)
        
        #mainband bin centers (at least in the case of full mass range plots)
        mb_bc = [ int(mainband.GetX()[bini]) for bini in range(0,mainband.GetN())]
        if "Mass" in glb_var:
            with open("SystOutput.txt","a") as fsys: #append for all channels printout
                fsys.write("\nLuminosity: %0.2f fb^{-1}" % (glb_lumi))
                fsys.write("\nPlotting branch: %s" % glb_var)
                fsys.write("\nChannels: %s" % (",".join(glb_chan)))
                fsys.write("\nTotal sys up: %s"%totup)
                fsys.write("\nTotal sys dn: %s\n"%totdn)
            
            if "Full" in glb_var:
                #bin_Z = hmb.FindBin(90)-1
                #bin_H = hmb.FindBin(125)-1
                bin_Z = mb_bc.index(90)
                bin_H = mb_bc.index(125)
                Z_up = mainband.GetErrorYhigh(bin_Z)
                Z_dn = mainband.GetErrorYlow(bin_Z)
                H_up = mainband.GetErrorYhigh(bin_H)
                H_dn = mainband.GetErrorYlow(bin_H)
                with open("SystOutput.txt","a") as fsys:
                    fsys.write("\n sys up: 80-100 GeV %s"%Z_up)
                    fsys.write("\n sys dn: 80-100 GeV %s"%Z_dn)
                    fsys.write("\n sys up: 120-130 GeV %s"%H_up)
                    fsys.write("\n sys dn: 120-130 GeV %s\n"%H_dn)
            
    
    if "none" not in args.uncertainties:
        
        histErrors = getHistErrors(hist_stacks[0], args.nostack) if not errors else errors
        for error_hist,signal_stack,data_hist in zip(histErrors, signal_stacks, data_hists):
            ROOT.SetOwnership(error_hist, False)
            error_hist.SetLineWidth(1) #Changed from 1 to 3
            ROOT.gStyle.SetHatchesLineWidth(1)
            ROOT.gStyle.SetHatchesSpacing(0.75)
            #error_hist.Draw("same e2")
            if mainband:
                mainband.Draw('2 same')
            #hist_stacks[0].Draw('hist same')
            if signal_stack:
                signal_stack.Draw("nostack same hist")
            if not args.no_data:
                #pdb.set_trace()
                data_hist.SetLineWidth(3)
                data_hist.Draw("e0 same")
            #error_title = "Stat. unc."
            error_title = "Syst. unc."
            if "all" in args.uncertainties:
                error_title = "Stat.#oplusSyst."
            elif "scale" in args.uncertainties:
                error_title = "Stat.#oplusScale"
            error_hist.SetTitle(error_title)
            if mainband:
                mainband.SetTitle(error_title)
    else:
        histErrors = []
    #legend = getPrettyLegend(hist_stacks[0], data_hists[0], signal_stacks[0], histErrors, coords)
    if mainband:
        legend = getPrettyLegend(hist_stacks[0], data_hists[0], signal_stacks[0], [mainband], coords)
    else:
        legend = getPrettyLegend(hist_stacks[0], data_hists[0], signal_stacks[0], [], coords)
    legend.Draw()

    if not args.no_decorations:
        ROOT.dotrootImport('hhe62/CMSPlotDecorations')
        scale_label = "Normalized to Unity" if args.luminosity < 0 else \
            "%0.1f fb^{-1}" % args.luminosity
        
        lumi_text = ""
        if args.thesis:
            lumi_text = "Thesis" 
        elif args.preliminary:
            lumi_text = "Preliminary" 
        if args.simulation:
            lumi_text += "Simulation" 
        
        ROOT.CMSlumi(canvas, 0, 11, "%s (13 TeV)" % scale_label,lumi_text)
                #"Preliminary Simulation" if args.simulation else "Preliminary")
    if args.extra_text != "" or glb_var in ["jetPt[0]","jetPt[1]","absjetEta[0]","absjetEta[1]"]:
        if args.extra_text != "":
            lines = [x.strip() for x in args.extra_text.split(";")]
        elif glb_var in ["jetPt[0]","jetPt[1]","absjetEta[0]","absjetEta[1]"]:
            if "0" in glb_var:
                lines = ['Events with #geq 1 jet']
            elif "1" in glb_var:
                lines = ["Events with #geq 2 jets"]
            
        ymax = coords[3]-0.02
        box_size = 0.05*len(lines)*args.scalelegy*5
        if args.extra_text_above:
            ymax = coords[1] 
            coords[1] -= box_size
            coords[3] -= box_size
        ymin = ymax - box_size
        if args.logy:
            if glb_var in ["jetPt[0]","jetPt[1]","absjetEta[0]","absjetEta[1]"]:
                text_box = ROOT.TPaveText(coords[0]-0.5, ymin+0.46, coords[2]-0.5, ymax+0.46, "NDCnb")
            else:
                text_box = ROOT.TPaveText(coords[0]-0.5, ymin+0.4, coords[2]-0.5, ymax+0.4, "NDCnb")
        #For linear plot positions
        else:
            text_box = ROOT.TPaveText(coords[0], ymin, coords[2], ymax, "NDCnb")
        #text_box.SetFillColor(0)
        text_box.SetFillColorAlpha(0,0.0)        
        text_box.SetFillStyle(0)
        #text_box.SetLineColor(0)
        text_box.SetLineColorAlpha(0, 0.0)
        #text_box.SetTextFont(70)
        for i, line in enumerate(lines):
            text_box.AddText(line)
            #text_box.AddText("#geq 4")
        text_box.Draw()
        ROOT.SetOwnership(text_box, False)
    if args.logy:
        canvas.SetLogy()
    if not args.no_ratio:
        #pdb.set_trace()
        #canvas = plotter.splitCanvas(canvas, canvas_dimensions,
        #        "#scale[0.85]{Data / Pred.}" if data_hists[0] else args.ratio_text,
        #        [float(i) for i in args.ratio_range]
        #)
        #pdb.set_trace()
        canvas = plotter.splitCanvasWithSyst(ratioband,canvas, canvas_dimensions,
                "#scale[0.85]{Data / Pred.}" if data_hists[0] else args.ratio_text,
                [float(i) for i in args.ratio_range],glb_isFullMass,glb_var
        )
    
    #canvas.SetLogx()

    return canvas
def makePlot(hist_stack, data_hist, name, args, signal_stack=0, same=""):
    canvas = ROOT.gROOT.FindObject("%s_canvas" % name)
    ROOT.SetOwnership(canvas, False)
    stack_signal = signal_stack != 0 and args.stack_signal
    stack_drawexpr = " ".join(["hist"] + 
        ["nostack" if args.nostack else ""]
    )
    hists = hist_stack.GetHists()
    first_stack = hist_stack

    hist_stack.Draw(stack_drawexpr + (same if "same" not in stack_drawexpr else ""))
    if signal_stack:
        if stack_signal:
            sum_stack = hists[0].Clone()
            for hist in hists[1:]:
                skip = False
                if args.exclude_from_sigstack:
                    for name in args.exclude_from_sigstack.split(","):
                        if name in hist.GetName():
                            skip = True
                if not skip:
                    sum_stack.Add(hist)
            for i,hist in enumerate(signal_stack.GetHists()):
                hist.Add(sum_stack)
        signal_stack.Draw("hist nostack same")
        signal_stack.GetHistogram().GetXaxis().SetTitle(
            hists[0].GetXaxis().GetTitle())
    #first_stack = signal_stack if stack_signal else hist_stack
    #pdb.set_trace()
    if data_hist:
        if not "yield" in name.lower() and not glb_isFullMass:
            data_hist.Sumw2(False)
            data_hist.SetBinErrorOption(ROOT.TH1.kPoisson)
        data_hist.Draw("e0 same") #Two places of data_hist.Draw
    first_stack.GetYaxis().SetTitleSize(hists[0].GetYaxis().GetTitleSize())    
    first_stack.GetYaxis().SetTitleOffset(hists[0].GetYaxis().GetTitleOffset())    
    first_stack.GetYaxis().SetTitle(
        hists[0].GetYaxis().GetTitle() if not glb_isFullMass else hists[0].GetYaxis().GetTitle()+"/GeV")

    if not args.no_ratio and float(ROOT.gROOT.GetVersion().split("/")[0]) > 6.07:
        # Remove first bin label to avoid overlap of canvases
        if hists[0].GetMinimum() == 0.0:
            first_stack.GetYaxis().ChangeLabel(1, -1.0, 0)
        print hists[0].GetMinimum() 
    first_stack.GetHistogram().GetXaxis().SetTitle(
        hists[0].GetXaxis().GetTitle())
    first_stack.GetHistogram().SetLabelSize(0.04)
    first_stack.SetMinimum(hists[0].GetMinimum()*args.scaleymin)
    ## Adding an arbirary factor of 100 here so the scaling doesn't cut off info from
    ## Hists. Not applied when lumi < 1. This should be fixed
    scale = args.luminosity/100 if args.luminosity > 0 else 1
    if data_hist:
        dataMax=data_hist.GetMaximum()
    else:
        dataMax=0
    mcMax=sum(map(lambda x:x.GetMaximum(),hists))
    if (dataMax>mcMax):
        print "scaleymax: ",args.scaleymax
        print "data_histMax: ",dataMax
        first_stack.SetMaximum(dataMax*args.scaleymax)
    elif(mcMax>dataMax):
        print "scaleymax: ",args.scaleymax
        print "MC_StackMaxSum: ",mcMax
        first_stack.SetMaximum(mcMax*args.scaleymax)
    else:
        first_stack.SetMaximum(hists[0].GetMaximum()*args.scaleymax*scale)
def getHistErrors(hist_stack, separate):
    histErrors = []
    for hist in hist_stack.GetHists():
        error_hist = plotter.getHistErrors(hist)
        if separate:
            error_hist.SetFillColor(hist.GetLineColor())
            error_hist.SetLineColor(hist.GetLineColor())
            histErrors.append(error_hist)
        else:
            if len(histErrors) == 0:
                histErrors.append(error_hist)
            else:
                histErrors[0].Add(error_hist)
    return histErrors
def getPrettyLegend(hist_stack, data_hist, signal_stack, error_hists, coords):
    hists = hist_stack.GetHists()
    if signal_stack != 0:
        #hists += signal_stack.GetHists()
        hists = signal_stack.GetHists() + hists
    legend = ROOT.TLegend(coords[0], coords[1], coords[2], coords[3])
    ROOT.SetOwnership(legend, False)
    legend.SetName("legend")
    legend.SetFillStyle(0)
    if data_hist:
        legend.AddEntry(data_hist, data_hist.GetTitle(), "lp")
    hist_names = []
    for hist in reversed(hists):
        if hist.GetTitle() not in hist_names:
            legend.AddEntry(hist, hist.GetTitle(), "f")
        hist_names.append(hist.GetTitle())
    for error_hist in error_hists:
        legend.AddEntry(error_hist, error_hist.GetTitle(), "f")
    return legend
def getHistFactory(config_factory, selection, filelist, luminosity=1, hist_file=None):
    if "Gen" not in selection:
        metaTree_name = "metaInfo/metaInfo"
        sum_weights_branch = "summedWeights"
        weight_branch = "genWeight"
    else:
        metaTree_name = "analyze%s/MetaData" % ("ZZ" if "ZZ" in selection else "WZ")
        sum_weights_branch = "initSumWeights"
        weight_branch = "weight"
    mc_info = config_factory.getMonteCarloInfo()
    all_files = config_factory.getFileInfo()
    hist_factory = OrderedDict() 
    for name in filelist:
        base_name = name.split("__")[0]
        if name not in all_files.keys():
            if not hist_file is None and not hist_file.Get(name):
                logging.warning("%s is not a valid file name (must match a definition in FileInfo/%s.json)" % \
                    (name, selection))
                continue
            hist_factory[name] = dict(all_files[base_name])
        else:
            hist_factory[name] = dict(all_files[name])
        if "data" not in name.lower() and name != "nonprompt":
            #pdb.set_trace()
            kfac = 1. if 'kfactor' not in mc_info[base_name].keys() else mc_info[base_name]['kfactor']
            if not hist_file:
                metaTree = ROOT.TChain(metaTree_name)
                metaTree.Add(hist_factory[name]["file_path"])
                weight_info = WeightInfo.WeightInfoProducer(metaTree, 
                        mc_info[base_name]['cross_section']*kfac,
                        sum_weights_branch).produce()
            else:
                # Not the most elegant way to go about it, but better to read
                # sum_of_weights from the histogram created by the anlysis code than to recalculate
                # it from the metadata just in case the file paths have changed
                sumweights_hist = hist_file.Get(str("/".join([name, "sumweights"])))
                if not sumweights_hist:
                    logging.warning("Using sumWeights from %s for file %s" % (base_name, name))
                    sumweights_hist = hist_file.Get(str("/".join([base_name, "sumweights"])))
                ROOT.SetOwnership(sumweights_hist, False)
                weight_info = WeightInfo.WeightInfo(
                        mc_info[base_name]['cross_section']*kfac,
                        sumweights_hist.Integral(0,sumweights_hist.GetNbinsX()+1) if sumweights_hist else 0
                )
                #pdb.set_trace()
        else:
            weight_info = WeightInfo.WeightInfo(1, 1)
            weight_branch = ""
        if not hist_file:
            histProducer = WeightedHistProducer(weight_info, weight_branch)  
        else:
            histProducer = FromFileHistProducer(weight_info, hist_file)  
        if "data" not in name.lower() and name != "nonprompt":
            histProducer.setLumi(luminosity)
        hist_factory[name].update({"histProducer" : histProducer})
        hist_factory[name].update({"configFactory" : config_factory})
        hist_factory[name].update({"fromFile" : hist_file is not None})
    return hist_factory
def getConfigHist(hist_factory, branch_name, bin_info, plot_group, selection, states, 
        uncertainties="none", addOverflow=False, rebin=0, cut_string="", removeNegatives=True):
    hist_name = "_".join([plot_group, selection.replace("/", "_"), branch_name])
    # TODO: Understand why this is broken in newer ROOT versions
    #rootdir = "gProof" if hasattr(ROOT, "gProof") else "gROOT"
    #hist = getattr(ROOT, rootdir).FindObject(str(hist_name))
    hist = ROOT.gROOT.FindObject(hist_name)
    if hist:
        hist.Delete()
    if not hist_factory.itervalues().next()["fromFile"]:
        if "binning" in bin_info:
            hist = ROOT.TH1D(hist_name, hist_name, bin_info['nbins'], bin_info['binning'])
            print "FromFile doesn't go here: ",hist
        else:
            hist = ROOT.TH1D(hist_name, hist_name, bin_info['nbins'], bin_info['xmin'], bin_info['xmax'])
    log_info = "" 
    final_counts = {c : 0 for c in states}
    for name, entry in hist_factory.iteritems():
        log_info += "_"*80 + "\n"
        log_info += "Results for file %s in plot group %s\n" % (name, plot_group)
        producer = entry["histProducer"]
        config_factory = entry["configFactory"]
        weight = config_factory.getPlotGroupWeight(plot_group)
        if weight != 1 and not entry["fromFile"]:
            producer.addWeight(weight)
        for state in states:
            if entry["fromFile"]:
                chan = state
                state_hist_name = str("%s/%s_%s" % (name, branch_name, state))
                if str(plot_group).lower() == "nonprompt":
                    state_hist_name = state_hist_name.replace(state, "Fakes_"+state)
                args = [state_hist_name, addOverflow, rebin]
            else:
                chan = state.split("/")[0] if "ntuple" in state else ""
                config_factory.setProofAliases(chan)
                draw_expr = config_factory.getHistDrawExpr(branch_name, name, chan)
                proof_name = "_".join([name, "%s#/%s" % (selection.replace("/", "_"), state)])
                producer.setCutString(cut_string)
                args = [draw_expr, proof_name, addOverflow, rebin]
            
            try:
                #pdb.set_trace()
                state_hist = producer.produce(*args)
            except ValueError as error:
                logging.warning(error)
                logging.warning("Error for file %s: %s" % (name, error))
                log_info += "Number of events in %s channel: 0.0\n"  % state
                continue
            if not hist:
                hist = state_hist
                hist.SetName(hist_name)
                if state_hist.InheritsFrom("TH1"):
                    hist.SetTitle(hist_name)
            else:
                hist.Add(state_hist)
            final_counts[state] += state_hist.Integral() 
            log_info += "Number of events in %s channel: %0.2f\n" % (state, state_hist.Integral())
            log_info += "Number of entries is %i\n" % (state_hist.GetEntries() - addOverflow)
        log_info += "Total number of events: %0.2f\n" % (hist.Integral() if hist and hist.InheritsFrom("TH1") else 0)
        log_info += "Cross section is %0.4f\n" % producer.getCrossSection()
        log_info += "Sum of weights is %0.2f\n" % producer.getSumOfWeights() 
    logging.debug(log_info)
    logging.debug("Hist has %i entries" % (hist.GetEntries() if hist and hist.InheritsFrom("TH1") else 0) )
    log_info += "*"*80 + "\n"
    log_info += "    Summary for plot group %s\n" % plot_group
    log_info += "    Total entries in all states: %0.2f\n" % (hist.Integral() if hist and hist.InheritsFrom("TH1") else 0)
    for state in states:
        log_info += "    %0.2f events in state %s\n" % (final_counts[state], state)
    log_info += "*"*80 + "\n"
    with open("temp-verbose.txt", "a") as log_file:
        log_file.write(log_info)
    if not hist or not hist.InheritsFrom("TH1"):
        raise ValueError("Invalid histogram %s for selection %s" % (branch_name, selection))
    if removeNegatives and "data" not in name:
        removeZeros(hist)
    #pdb.set_trace()

    #myoutputFile=ROOT.TFile(hist_name+".root","RECREATE")
    #myoutputFile.cd()
    #hist.Write()
    #myoutputFile.Close()
    #print("File written")
    #sys.exit()
    return hist

def getConfigHistFromFile(filename, config_factory, plot_group, selection, branch_name, channels,
        luminosity=1, addOverflow=False, rebin=0, uncertainties="none", removeNegatives=True):
    try:
        filelist = config_factory.getPlotGroupMembers(plot_group)
    except ValueError as e:
        logging.warning(e.message)
        logging.warning("Treating %s as file name" % plot_group)
        filelist = [plot_group]
    #print "Is error happening here in config_factory"
    if branch_name not in config_factory.getListOfPlotObjects():
        raise ValueError("Invalid histogram %s for selection %s" % (branch_name, selection))
    #print "No, somewhere else"
    
    # If reading from file, the weighted 1D hists need to be precomputed
    # Look for them stored in the file with the plot_group name
    weight = config_factory.getPlotGroupWeight(plot_group)
    if weight != 1:
        filelist = [str(plot_group)]
        logging.warning("Treating %s as file name" % plot_group)

    hist_file = ROOT.TFile(filename)
    ROOT.SetOwnership(hist_file, False)
    
    hist_factory = getHistFactory(config_factory, selection, filelist, luminosity, hist_file)

    bin_info = config_factory.getHistBinInfo(branch_name)
    states = channels.split(",")
    #print "OVERFLOW?", addOverflow
    #pdb.set_trace()
    hist = getConfigHist(hist_factory, branch_name, bin_info, plot_group, selection, states, uncertainties, addOverflow, rebin)
    config_factory.setHistAttributes(hist, branch_name, plot_group)

    return hist

def getConfigHistFromTree(config_factory, plot_group, selection, branch_name, channels, blinding=[],
    luminosity=1, addOverflow=False, rebin=0, cut_string="", uncertainties="none"):
    if "Gen" not in selection:
        states = [x.strip() for x in channels.split(",")]
        scale_weight_expr = "scaleWeights/scaleWeights[0]"
        trees = ["%s/ntuple" % state for state in states]
    else:
        trees = ["analyze%s/Ntuple" % ("ZZ" if "ZZ" in selection else "WZ")]
        scale_weight_expr = "LHEweights/LHEweights[0]"
        if channels != "eee,mmm,eem,emm":
            chan_cuts = []
            for chan in channels.split(","): 
                chan_cuts.append(getGenChannelCut(chan))
            cut_string = appendCut(cut_string, " || ".join(chan_cuts))
    try:
        filelist = config_factory.getPlotGroupMembers(plot_group)
    except ValueError as e:
        logging.warning(e.message)
        logging.warning("Treating %s as file name" % plot_group)
        filelist = [plot_group]
    hist_factory = getHistFactory(config_factory, selection, filelist, luminosity)
    bin_info = config_factory.getHistBinInfo(branch_name)
    
def histWithScaleUnc(scale_hist2D, entries, name):
    if not isinstance(scale_hist2D, ROOT.TH2):
        raise ValueError("Scale uncertainties require 2D histogram")
    scale_hist = scale_hist2D.ProjectionY("temp", 1, 1, "e")
    mmee,scale_hist.SetName(name)
    ROOT.SetOwnership(scale_hist, False)
    hists = []
    for i in range(2, entries+1):
        hist = scale_hist2D.ProjectionY(name+"_weight%i" % i, i, i, "e")
        hist.Sumw2()
        hists.append(hist)
    # Choose max variation between scale choices by bin
    for i in range(1, scale_hist.GetNbinsX()+1):
        try:
            maxScale = max([h.GetBinContent(i) for h in hists \
                    if not h.GetBinContent(i) == 0])
            minScale = min([h.GetBinContent(i) for h in hists \
                    if not h.GetBinContent(i) == 0])
            scaleUp_diff = maxScale - scale_hist.GetBinContent(i)
            scaleDown_diff = scale_hist.GetBinContent(i) - minScale
            maxScaleErr = max(scaleUp_diff, scaleDown_diff)
        except:
            maxScaleErr = 0
        # Just symmetric errors for now
        err = math.sqrt(scale_hist.GetBinError(i)**2 + maxScaleErr**2)
        scale_hist.SetBinError(i, err)
    return scale_hist 

def appendCut(cut_string, add_cut):
    if cut_string != "" and add_cut not in cut_string:
        append_cut = lambda x: "*(%s)" % x if x not in ["", None] else x
        return "(" + cut_string + ")" + append_cut(add_cut)
    else:
        return add_cut

def getScaleFactorExpression(state, muonId, electronId):
    if muonId == "tight" and electronId == "tight":
        return getScaleFactorExpressionAllTight(state)
    elif muonId == "medium" and electronId == "tightW":
        return getScaleFactorExpressionMedTightWElec(state)
    else:
        return "1"

def getScaleFactorExpressionMedTightWElec(state):
    if state == "eee":
        return "e1MediumIDSF*" \
                "e2MediumIDSF*" \
                "e3TightIDSF*" \
                "pileupSF"
    elif state == "eem":
        return "e1MediumIDSF*" \
                "e2MediumIDSF*" \
                "mTightIsoSF*" \
                "mMediumIDSF*" \
                "pileupSF"
    elif state == "emm":
        return "eTightIDSF*" \
                "m1MediumIDSF*" \
                "m1TightIsoSF*" \
                "m2TightIsoSF*" \
                "m2MediumIDSF*" \
                "pileupSF"
    elif state == "mmm":
        return "m1TightIsoSF*" \
                "m1MediumIDSF*" \
                "m2TightIsoSF*" \
                "m2MediumIDSF*" \
                "m3TightIsoSF*" \
                "m3MediumIDSF*" \
                "pileupSF"
def getScaleFactorExpressionAllTight(state):
    if state == "eee":
        return "e1TightIDSF*" \
                "e2TightIDSF*" \
                "e3TightIDSF*" \
                "pileupSF"
    elif state == "eem":
        return "e1TightIDSF*" \
                "e2TightIDSF*" \
                "mTightIsoSF*" \
                "mTightIDSF*" \
                "pileupSF"
    elif state == "emm":
        return "eTightIDSF*" \
                "m1TightIDSF*" \
                "m1TightIsoSF*" \
                "m2TightIsoSF*" \
                "m2TightIDSF*" \
                "pileupSF"
    elif state == "mmm":
        return "m1TightIsoSF*" \
                "m1TightIDSF*" \
                "m2TightIsoSF*" \
                "m2TightIDSF*" \
                "m3TightIsoSF*" \
                "m3TightIDSF*" \
                "pileupSF"
def getPlotPaths(selection, folder_name, write_log_file=False):
    if "hep.wisc.edu" in os.environ['HOSTNAME']:
        storage_area = "/nfs_scratch/uhussain"
        html_area = "/afs/hep.wisc.edu/home/hhe62/public_html"
    else:
        storage_area,html_area  = ConfigureJobs.getStorageArea()
        
    base_dir = "%s/ZZAnalysisData/PlottingResults" % storage_area
    plot_path = "/".join([base_dir, selection] +
       (['{:%Y-%m-%d}'.format(datetime.datetime.today()),
        '{:%Hh%M}'.format(datetime.datetime.today())] if folder_name == "" \
            else [folder_name])
    )
    makeDirectory(plot_path + "/plots")
    if write_log_file:
        makeDirectory(plot_path + "/logs")
    html_path = plot_path.replace(storage_area, html_area)
    return (plot_path, html_path)
def getGenChannelCut(channel):
    cut_string = ""
    if channel == "eem":
        cut_string = "((abs(l1pdgId) == 11 && abs(l2pdgId) == 11 && abs(l3pdgId) == 13)" \
            " || (abs(l1pdgId) == 11 && abs(l2pdgId) == 13 && abs(l3pdgId) == 11)" \
            " || (abs(l1pdgId) == 13 && abs(l2pdgId) == 11 && abs(l3pdgId) == 11))"
    elif channel == "emm":
        cut_string = "((abs(l1pdgId) == 13 && abs(l2pdgId) == 13 && abs(l3pdgId) == 11)" \
            " || (abs(l1pdgId) == 13 && abs(l2pdgId) == 11 && abs(l3pdgId) == 13)" \
            " || (abs(l1pdgId) == 11 && abs(l2pdgId) == 13 && abs(l3pdgId) == 13))"
    elif channel == "eee":
        cut_string = "(abs(l1pdgId) == 11 && abs(l2pdgId) == 11 && abs(l3pdgId) == 11)"
    elif channel == "mmm":
        cut_string = "(abs(l1pdgId) == 13 && abs(l2pdgId) == 13 && abs(l3pdgId) == 13)"
    return cut_string
def savePlot(canvas, plot_path, html_path, branch_name, write_log_file, args):
    canvas.Update()
    if args.output_file != "":
        canvas.Print(args.output_file)
        return
    if write_log_file:
        log_file = "/".join([plot_path, "logs", "%s_event_info.log" % branch_name])
        verbose_log = log_file.replace("event_info", "event_info-verbose")
        shutil.move("temp.txt", log_file) 
        if os.path.isfile("temp-verbose.txt"):
            shutil.move("temp-verbose.txt", verbose_log) 
    output_name ="/".join([plot_path, "plots", branch_name]) 
    canvas.Print(output_name + ".root")
    canvas.Print(output_name + ".C")
    if not args.no_html:
        makeDirectory(html_path + "/plots")
        output_name ="/".join([html_path, "plots", branch_name])
        canvas.Print(output_name + ".png")
        canvas.Print(output_name + ".eps")
        #canvas.Print(output_name + ".pdf")
        subprocess.call(["epstopdf", "--outfile=%s" % output_name+".pdf", output_name+".eps"],env={})
        os.remove(output_name+".eps")
        if write_log_file:
            makeDirectory(html_path + "/logs")
            shutil.copy(log_file, log_file.replace(plot_path, html_path))
            if os.path.isfile(verbose_log):
                shutil.copy(verbose_log, verbose_log.replace(plot_path, html_path))
    del canvas

# Leave zero events untouched, fix negative yields (for nonprompt)
def removeZeros(hist):
    for i in range(hist.GetNbinsX()+2):
        err = hist.GetBinError(i)
        if hist.GetBinContent(i) < 0:
            if "Up" in hist.GetName():
                hist.SetBinContent(i, 0.0001)
            elif "Down" in hist.GetName():
                hist.SetBinContent(i, 0.00001)
            else: 
                hist.SetBinContent(i, 0.001)
            hist.SetBinError(i, err)

def makeDirectory(path):
    '''
    Make a directory, don't crash
    '''
    try:
        os.makedirs(path)
    except OSError as e:
        if e.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else: 
            raise

#===========================================Systematic Uncertainties implementation
#for main script to set global channel
def setGlobalChannel(channels,selection,lumi,branches,hist_file,doSyst):
    global glb_chan 
    global which_analysis
    global glb_lumi
    global glb_var
    global glb_file
    global glb_isFullMass
    global glb_doSyst

    glb_chan= channels.split(',')
    which_analysis = selection.split('/')[0]
    glb_lumi = lumi
    glb_var = branches
    glb_file = hist_file
    glb_doSyst = doSyst
    glb_isFullMass = False
    if "Full" in glb_var and "Mass" in glb_var:
        glb_isFullMass = True

#rebin histos and take care of overflow bins
def rebin(hist,variable):
    ROOT.SetOwnership(hist, False)
    #No need to rebin certain variables but still might need overflow check
    if variable not in ['eta']:
        bins=array.array('d',_binning[variable])
        Nbins=len(bins)-1 
        hist=hist.Rebin(Nbins,"",bins)
    else:
        Nbins = hist.GetSize() - 2
    add_overflow = hist.GetBinContent(Nbins) + hist.GetBinContent(Nbins + 1)
    lastbin_error = math.sqrt(math.pow(hist.GetBinError(Nbins),2)+math.pow(hist.GetBinError(Nbins+1),2))
    hist.SetBinContent(Nbins, add_overflow)
    hist.SetBinError(Nbins, lastbin_error)
    hist.SetBinContent(Nbins+1,0)
    hist.SetBinError(Nbins+1,0)
    #if not hist.GetSumw2(): hist.Sumw2()
    return hist

def getSystValue(hMain):
    #pdb.set_trace()
    with open('listFile.json') as list_json_file:
        mylist_dict = json.load(list_json_file)

    manager_path = ConfigureJobs.getManagerPath()
    if not glb_chan or not which_analysis or not glb_lumi or not glb_var or not glb_file:
        raise ValueError("Channels/analysis/lumi/variable/file_name not set")

    channels = glb_chan #["eeee","eemm","mmmm"]
    analysis = which_analysis
    year = analysis.replace("ZZ4l","")
    func_lumi = glb_lumi
    variable = glb_var
    #strange python debug
    #print "channels: ",channels
    if "mmee" in channels:
        channels.remove("mmee")
    if not channels: #if becomes empty now after removing mmee
        raise ValueError("Single entering of mmee channel not allowed for systematic calculation")
        #channels = ["eeee","eemm","mmmm"]

    mynominalName=mylist_dict['nomname']
    myaltname= mylist_dict['altname']
    varList=[variable]

    with open('varsFile.json') as var_json_file:
        myvar_dict = json.load(var_json_file)

    global _binning
    _binning = {}
    for key in myvar_dict.keys(): #key is the variable
        _binning[key] = myvar_dict[key]["_binning"]
        
    sigSampleDic=ConfigureJobs.getListOfFilesWithXSec(ConfigureJobs.getListOfEWK())
    sigSampleList=[str(i) for i in sigSampleDic.keys()]
    
    AltsigSampleDic=ConfigureJobs.getListOfFilesWithXSec([myaltname,])
    AltsigSampleList=[str(i) for i in AltsigSampleDic.keys()]
    
    #Combine sigSamples
    TotSigSampleList = list(set(sigSampleList) | set(AltsigSampleList))
    sigSampleDic.update(AltsigSampleDic)

    sigSamplesPath={}
    
    fUse = ROOT.TFile(glb_file)#,"update") 
    fOut=fUse
    ROOT.SetOwnership(fOut, False)    
    # file_path is not used for plotting    
    for dataset in TotSigSampleList:
        file_path = '' #ConfigureJobs.getInputFilesPath(dataset,selection, analysis)
        sigSamplesPath[dataset]=file_path

    #Sum all data and return a TList of all histograms that are booked. And an empty datSumW dictionary as there are no sumWeights
    alldata,dataSumW = HistTools.makeCompositeHists(fOut,"AllData", 
        ConfigureJobs.getListOfFilesWithXSec([analysis+"data"],manager_path), func_lumi,
        underflow=False, overflow=False)


    #all ewkmc/this is also allSignal histos, scaled properly, kind of a repeat of above but with ggZZ added
    
    ewkmc,ewkSumW = HistTools.makeCompositeHists(fOut,"AllEWK", ConfigureJobs.getListOfFilesWithXSec(
        ConfigureJobs.getListOfEWK(), manager_path), func_lumi,
        underflow=False, overflow=False)

    ewkmc_qqZZonly,ewkSumW_qqZZonly = HistTools.makeCompositeHists(fOut,"AllEWKqqZZonly", ConfigureJobs.getListOfFilesWithXSec(
        ConfigureJobs.getListOfEWK()[:1], manager_path), func_lumi,
        underflow=False, overflow=False)

    ewkmc_ggZZonly,ewkSumW_ggZZonly = HistTools.makeCompositeHists(fOut,"AllEWKggZZonly", ConfigureJobs.getListOfFilesWithXSec(
        ConfigureJobs.getListOfEWK()[1:], manager_path), func_lumi,
        underflow=False, overflow=False)


    ewkmc_ggZZup,ewkSumW_ggZZup = HistTools.makeCompositeHists_scaling(fOut,"AllEWKggZZup", ConfigureJobs.getListOfFilesWithXSec(
        ConfigureJobs.getListOfEWK(), manager_path), func_lumi,
        underflow=False, overflow=False,scale_fac=1.+0.18)

    ewkmc_ggZZdn,ewkSumW_ggZZdn = HistTools.makeCompositeHists_scaling(fOut,"AllEWKggZZdn", ConfigureJobs.getListOfFilesWithXSec(
        ConfigureJobs.getListOfEWK(), manager_path), func_lumi,
        underflow=False, overflow=False,scale_fac=1.-0.14)

    altSigmc,altSigSumW = HistTools.makeCompositeHists(fOut,"AltSig", ConfigureJobs.getListOfFilesWithXSec(
        ConfigureJobs.getListOfaltSig(), manager_path), func_lumi,
        underflow=False, overflow=False)

    #Update ewkSumW dictionary with sumWeights value of zz4l-amcatnlo (now it is POWHEG) from altSigSumW, the common keys should not be duplicated
    ewkSumW.update(altSigSumW)

    #all mcbkg that needs to be subtracted
    allVVVmc,VVVSumW = HistTools.makeCompositeHists(fOut,"AllVVV", ConfigureJobs.getListOfFilesWithXSec(
        ConfigureJobs.getListOfVVV(), manager_path), func_lumi,
        underflow=False, overflow=False)

    #This is the non-prompt background
    ewkcorr = HistTools.getDifferenceDirect(fOut, "DataEWKCorrected", alldata, ewkmc)

    zzSumWeights = ewkSumW[mynominalName]  
    

    #getHistInDic function also takes care of adding the histograms in eemm+mmee, hence the input here is channels=[eeee,eemm,mmmm]
    #dataHists dictionary
    hDataDic=OutputTools.getHistsInDic(alldata,varList,channels)

    hSigDic=OutputTools.getHistsInDic(ewkmc,varList,channels)
    hSigDic_ggZZonly=OutputTools.getHistsInDic(ewkmc_ggZZonly,varList,channels)
    hSigDic_ggZZup=OutputTools.getHistsInDic(ewkmc_ggZZup,varList,channels)
    hSigDic_ggZZdn=OutputTools.getHistsInDic(ewkmc_ggZZdn,varList,channels)

    #Alt signals containing zzl4-amcatnlo instead of zz4l-powheg #Now alt is POWHEG
    hAltSigDic=OutputTools.getHistsInDic(altSigmc,varList,channels)

    #TrueHists dictionary
    #Not needed for RECO plotting, but used to calculate ratio between channels
    
    hTrueDic=OutputTools.getHistsInDic(ewkmc,["Gen"+s for s in varList],channels)
    hTrueDic_qqZZonly=OutputTools.getHistsInDic(ewkmc_qqZZonly,["Gen"+s for s in varList],channels)
    #hTrueDic_ggZZonly=OutputTools.getHistsInDic(ewkmc_ggZZonly,["Gen"+s for s in varList],channels)
    #hTrueDic_ggZZup=OutputTools.getHistsInDic(ewkmc_ggZZup,["Gen"+s for s in varList],channels)
    #hTrueDic_ggZZdn=OutputTools.getHistsInDic(ewkmc_ggZZdn,["Gen"+s for s in varList],channels)

    #Alt signals containing zzl4-amcatnlo instead of zz4l-powheg
    #hAltTrueDic=OutputTools.getHistsInDic(altSigmc,["Gen"+s for s in varList],channels)

    #Non-prompt background dictionary
    hbkgDic=OutputTools.getHistsInDic(ewkcorr,[s+"_Fakes" for s in varList],channels)

    
    
    #VVV background dictionary
    hbkgMCDic=OutputTools.getHistsInDic(allVVVmc,varList,channels)
    

    runVariables=[]
    runVariables.append(variable)
    

    ##Systematic histos
    systList=[]
    #gensystList=[]
    for chan in channels:
        for s in runVariables:
            systList.append(variable+"_lheWeights")
            #gensystList.append("Gen"+variable+"_lheWeights")
            systList.append(variable+"_jetsysts")
        for sys in ["Up","Down"]: 
            for s in runVariables:
                systList.append(variable+"_CMS_pileup"+sys)
                for lep in set(chan):         
                    systList.append(variable+"_CMS_eff_"+lep+sys)

    #systList has repeated variables, but shouldn't matter as it will just reassigin same value in the dictionary
    systList = list(set(systList)) # remove duplicate just in case
    hSigSystDic=OutputTools.getHistsInDic(ewkmc,systList,channels)
    hSigSystDic_qqZZonly=OutputTools.getHistsInDic(ewkmc_qqZZonly,systList,channels)
    #hTrueSystDic_qqZZonly=OutputTools.getHistsInDic(ewkmc_qqZZonly,gensystList,channels)
    hbkgMCSystDic=OutputTools.getHistsInDic(allVVVmc,systList,channels)

    SysDic = {"Up":{},"Down":{}}
    errkeys = ['ggZZXsec','generator','lumi','PU','jes','jer','e_eff','m_eff',"trigger","fake"] #not used, for information

    with open("ChannelRatio.txt","a") as fchan:
        fchan.write("Variable:%s\n"%variable)

    for chan in channels:
        #Nominal
        hSigNominal = hSigDic[chan][variable].Clone()
        hBkgNominal = hbkgDic[chan][variable+"_Fakes"].Clone()
        hBkgMCNominal = hbkgMCDic[chan][variable].Clone()
        hBkgNominal = rebin(hBkgNominal,variable)
        hTrue = hTrueDic[chan]["Gen"+variable]
        hTrue = rebin(hTrue,variable)
        hTrue_qqZZonly = hTrueDic_qqZZonly[chan]["Gen"+variable]
        hTrue_qqZZonly = rebin(hTrue_qqZZonly,variable)
        hTrueBinCont = [hTrue.GetBinContent(htb) for htb in range(1,hTrue.GetNbinsX()+1)]
        hTrueInt = hTrue.Integral(1,hTrue.GetNbinsX())

        hTrueBinCont_qqZZonly = [hTrue_qqZZonly.GetBinContent(htb) for htb in range(1,hTrue_qqZZonly.GetNbinsX()+1)]
        hTrueInt_qqZZonly = hTrue_qqZZonly.Integral(1,hTrue_qqZZonly.GetNbinsX())

        with open("ChannelRatio.txt","a") as fchan:
            fchan.write("Channel:%s\n"%chan)
            fchan.write("Bin Content:\n")
            fchan.write("%s\n"%hTrueBinCont)
            fchan.write("Total event:%s\n"%hTrueInt)

            fchan.write("qqZZ Bin Content:\n")
            fchan.write("%s\n"%hTrueBinCont_qqZZonly)
            fchan.write("Total qqZZ event:%s\n"%hTrueInt_qqZZonly)

        #truncateTH1(hBkgNominal)
        hBkgMCNominal = rebin(hBkgMCNominal,variable)
        hSigNominal=rebin(hSigNominal,variable)

        hBkgTotal=hBkgNominal.Clone()
        hBkgTotal.Add(hBkgMCNominal)

        #ggZZ xsec
        for sys in ['Up','Down']:
            if "Up" in sys: #no need to clone, only used once
                hSigGX = hSigDic_ggZZup[chan][variable].Clone()
                    
            else:
                hSigGX = hSigDic_ggZZdn[chan][variable].Clone()

            hSigGX.SetDirectory(0)
            hSigGX=rebin(hSigGX,variable)        
            hErrGX = hSigGX.Clone()
            hErrGX.Add(hSigNominal,-1)

            if chan == channels[0]:
                SysDic[sys]['ggZZXsec'] = hErrGX
           
            else:
                SysDic[sys]['ggZZXsec'].Add(hErrGX)

        #generator choice
        hAltSigNominal = hAltSigDic[chan][variable].Clone()
        hAltSigNominal=rebin(hAltSigNominal,variable)
        for sys in ['Up','Down']:
            hErrGr = hAltSigNominal.Clone()
            hErrGr.Add(hSigNominal,-1)
            hErrGr.SetDirectory(0)

            if chan == channels[0]:
                SysDic[sys]['generator'] = hErrGr
                
            else:
                SysDic[sys]['generator'].Add(hErrGr)
        
        #lumi
        if year == "2016":
            lumiUnc = 0.012
        if year == "2017":
            lumiUnc = 0.023
        if year == "2018":
            lumiUnc = 0.025
            
        lumiScale = {'Up':1.+lumiUnc,'Down':1.-lumiUnc}
        for sys, scale in lumiScale.iteritems():
            hNoFake = hMain.Clone("NoFakeLumi")
            #hNoFake.SetDirectory(0)

            hBkgLumi = hbkgDic[chan][variable+"_Fakes"].Clone()
            #hBkgLumi.SetDirectory(0)
            hBkgLumi=rebin(hBkgLumi,variable)
            #truncateTH1(hBkgLumi)

            hNoFake.Add(hBkgLumi,-1)
            hChangeLumi = hNoFake*(scale-1.)
            #hChangeLumi.SetDirectory(0)

            if chan == channels[0]:
                SysDic[sys]['lumi'] = hChangeLumi
                
            else:
                SysDic[sys]['lumi'].Add(hChangeLumi)
        
        #lepton efficiency
        for lep in set(chan):
            for sys in ['Up','Down']:
                hSiglep = hSigSystDic[chan][variable+"_CMS_eff_"+lep+sys].Clone()
                hSiglep = rebin(hSiglep,variable)
                hBkgMClep = hbkgMCSystDic[chan][variable+"_CMS_eff_"+lep+sys].Clone()
                hBkgMClep = rebin(hBkgMClep,variable)

                hChangelep = hSiglep.Clone("lep change %s %s %s"%(chan,sys,lep))
                hChangelep.Add(hBkgMClep)
                hChangelep.Add(hSigNominal,-1)
                hChangelep.Add(hBkgMCNominal,-1)

                if not SysDic[sys].has_key(lep+'_eff'):
                    SysDic[sys][lep+'_eff'] = hChangelep
                
                else:
                    SysDic[sys][lep+'_eff'].Add(hChangelep)

        #Trigger efficiency
        TrigUnc = 0.02
        TrigScale = {'Up':1.+TrigUnc,'Down':1.-TrigUnc}
        for sys, scale in TrigScale.iteritems():
            hNoFakeTrig = hMain.Clone("NoFakeTrig")
            #hNoFake.SetDirectory(0)

            hBkgTrig = hbkgDic[chan][variable+"_Fakes"].Clone()
            #hBkgLumi.SetDirectory(0)
            hBkgTrig=rebin(hBkgTrig,variable)
            #truncateTH1(hBkgLumi)

            hNoFakeTrig.Add(hBkgTrig,-1)
            hChangeTrig= hNoFakeTrig*(scale-1.)
            #hChangeLumi.SetDirectory(0)

            if chan == channels[0]:
                SysDic[sys]['trigger'] = hChangeTrig
                
            else:
                SysDic[sys]['trigger'].Add(hChangeTrig)


        # fake rate
        turnoffFake = False
        if not turnoffFake:
            fakeUnc = 0.4
            fakeScale = {'Up':1.+fakeUnc,'Down':1.-fakeUnc}
            for sys, scale in fakeScale.iteritems():

                hBkgFake = hbkgDic[chan][variable+"_Fakes"].Clone()
                hBkgFake=rebin(hBkgFake,variable)
                truncateTH1(hBkgFake)
                hBkgFake.Scale(scale-1.)
                #hBkgFake.SetDirectory(0)
                

                if chan == channels[0]:
                    SysDic[sys]['fake'] = hBkgFake
                    
                else:
                    SysDic[sys]['fake'].Add(hBkgFake)
            

        #Pileup reweight
        for sys in ['Up','Down']:
            
            #should include RECO ewk as long as it is added in listFile.json 
            hSigPU = hSigSystDic[chan][variable+"_CMS_pileup"+sys].Clone()
            hSigPU=rebin(hSigPU,variable)
            #hSigPU.SetDirectory(0)
            
            hBkgPU = hbkgDic[chan][variable+"_Fakes"].Clone()
            #hBkgPU.SetDirectory(0)
            hBkgPU=rebin(hBkgPU,variable)
            #truncateTH1(hBkgPU)
            
            hBkgMCPU = hbkgMCSystDic[chan][variable+"_CMS_pileup"+sys].Clone()
            #hBkgMCPU.SetDirectory(0)
            hBkgMCPU=rebin(hBkgMCPU,variable)

            hChangePU = hSigPU.Clone("PU change %s"%sys)
            hChangePU.Add(hBkgMCPU)
            hChangePU.Add(hSigNominal,-1)
            hChangePU.Add(hBkgMCNominal,-1)

            if chan == channels[0]:
                SysDic[sys]['PU'] = hChangePU
                
            else:
                SysDic[sys]['PU'].Add(hChangePU)

        #Add systematics for JES and JER
        
        hSigJET = hSigSystDic[chan][variable+"_jetsysts"].Clone() #TH2
        #hSigJET.SetDirectory(0)
            
        hBkgJET = hbkgDic[chan][variable+"_Fakes"].Clone()
        #hBkgJET.SetDirectory(0)
        hBkgJET=rebin(hBkgJET,variable)
        #truncateTH1(hBkgJET)
            
        hBkgMCJET = hbkgMCSystDic[chan][variable+"_jetsysts"].Clone() #TH2
        #hBkgMCJET.SetDirectory(0)

        for i,sys in enumerate(["jes_up","jes_dn","jer_up","jer_dn"]):

            hSigJETsub = hSigJET.ProjectionX("JET_%s"%i,i+1,i+1,"e") #histogram bin count starts with 1
            #hSigJETsub.SetDirectory(0)
            hSigJETsub=rebin(hSigJETsub,variable)
            
            hBkgMCJETsub = hBkgMCJET.ProjectionX("JETBkg_%s"%i,i+1,i+1,"e")
            hBkgMCJETsub=rebin(hBkgMCJETsub,variable)

            hChangeJet = hSigJETsub.Clone("Change in jet")
            hChangeJet.Add(hBkgMCJETsub)
            hChangeJet.Add(hSigNominal,-1)
            hChangeJet.Add(hBkgMCNominal,-1)

            syskey = sys.split('_')[0]
            if 'up' in sys.split('_')[1]:
                ud = 'Up'
            elif 'dn' in sys.split('_')[1]:
                ud = 'Down'

            if chan == channels[0]:

                SysDic[ud][syskey] = hChangePU
                
            else:
                SysDic[ud][syskey].Add(hChangePU)

            
            
            
            
            
            

            

    
    histbins=array.array('d',_binning[variable])
    hUncUp=ROOT.TH1D("hUncUp","Total Up Uncert.",len(histbins)-1,histbins)
    hUncDn=ROOT.TH1D("hUncDn","Total Dn Uncert.",len(histbins)-1,histbins)
    sysList = SysDic['Up'].keys()
    UncUpHistos= [SysDic['Up'][sys] for sys in sysList]
    UncDnHistos= [SysDic['Down'][sys] for sys in sysList]
    totUncUp=totUncDn=0.

    for i in range(1,hUncUp.GetNbinsX()+1):
        totUncUp=totUncDn=0.
        for h1, h2 in zip(UncUpHistos,UncDnHistos):
            
            totUncUp += max(h1.GetBinContent(i),h2.GetBinContent(i))**2
            totUncDn += min(h1.GetBinContent(i),h2.GetBinContent(i))**2

        totUncUp = math.sqrt(totUncUp)
        totUncDn = math.sqrt(totUncDn)
        #print "totUncUp: ",totUncUp
        #print "totUncDn: ",totUncDn
        hUncUp.SetBinContent(i,totUncUp)
        hUncDn.SetBinContent(i,totUncDn)

    
    MainGraph=ROOT.TGraphAsymmErrors(hMain)
    ROOT.SetOwnership(MainGraph,False) #won't be deleted when the proxy is deleted
    #MainGraph.SetDirectory(0) #won't be deleted when the file is closed. Global file variable now, shouldn't matter. 
    #Not needed for TGraphAsymmErrors thus SetDirectory method doesn't exist

    tmpData = hMain.Clone("tmp")
    nbw_for_table = True #Set False when printing table and don't want to normalize by BW
    normBW = glb_isFullMass and nbw_for_table
    

    for i in range(1, tmpData.GetNbinsX()+1):
        if hMain.GetBinContent(i)==0:
            continue
        bw = tmpData.GetBinWidth(i) if normBW else 1.
        eUp=hUncUp.GetBinContent(i)/bw
        eDn=hUncDn.GetBinContent(i)/bw
        
        #don't add data stat error in syst
        #errorUp = tmpData.GetBinContent(i) + math.sqrt(math.pow(tmpData.GetBinError(i),2) + math.pow(eUp,2))
        errorUp = tmpData.GetBinContent(i) + math.sqrt(math.pow(eUp,2))
        errorUp -= hMain.GetBinContent(i) 
        #errorDn = max(tmpData.GetBinContent(i) - math.sqrt(math.pow(tmpData.GetBinError(i),2) + math.pow(eDn,2)),0)
        errorDn = max(tmpData.GetBinContent(i) - math.sqrt(math.pow(eDn,2)),0)
        errorDn = hMain.GetBinContent(i) - errorDn
       
        MainGraph.SetPointEYhigh(i-1, errorUp)
        MainGraph.SetPointEYlow(i-1, errorDn)
    MainGraph.SetFillColorAlpha(1,0.3)
#        
    MainGraph.SetFillStyle(3001)
    MainGraph.SetLineColor(0)
    #pdb.set_trace()
    hflat = hMain.Clone("flat")
    for i in range(1, hflat.GetNbinsX()+1):
        hflat.SetBinContent(i,1.)
    ratioGraph=ROOT.TGraphAsymmErrors(hflat)
    ROOT.SetOwnership(ratioGraph,False)
    #ratioGraph.SetDirectory(0) not needed thus doesn't work for TGraphAsymmErrors

    tmpData = hMain.Clone("tmp")
    for i in range(1, tmpData.GetNbinsX()+1):
        if hMain.GetBinContent(i)==0:
            #ratioGraph.SetPointY(i-1,1.)
            ratioGraph.SetPointEYhigh(i-1, 0.)
            ratioGraph.SetPointEYlow(i-1, 0.)
            continue
        bw = tmpData.GetBinWidth(i) if normBW else 1.
        eUp=hUncUp.GetBinContent(i)/bw
        eDn=hUncDn.GetBinContent(i)/bw
        mc=hMain.GetBinContent(i)
        #print "eUp: ",eUp, "","eDn: ",eDn

        #don't add data's error
        #errorUp = 1. + math.sqrt(math.pow(tmpData.GetBinError(i)/mc,2) + math.pow((eUp/mc),2))
        errorUp = 1. + math.sqrt( math.pow((eUp/mc),2)) 
        errorUp -= 1.
        #errorDn = max(1. - math.sqrt(math.pow(tmpData.GetBinError(i)/mc,2) + math.pow((eDn/mc),2)),0)
        errorDn = max(1. - math.sqrt(math.pow((eDn/mc),2)),0)
        errorDn = 1. - errorDn
        #ratioGraph.SetPointY(i-1,1.)
        ratioGraph.SetPointEYhigh(i-1, errorUp)
        ratioGraph.SetPointEYlow(i-1, errorDn)
    ratioGraph.SetFillColorAlpha(1,0.3)
    ratioGraph.SetFillStyle(3001)
    
    #MainGraph.SetDirectory(0)
    #ratioGraph.SetDirectory(0)

    return MainGraph,ratioGraph
    


    
    

