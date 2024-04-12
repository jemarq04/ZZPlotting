#!/usr/bin/env python
import Utilities.plot_functions as plotter
import Utilities.helper_functions as helper
import argparse
import ROOT
import Utilities.config_object as config_object
import Utilities.UserInput as UserInput
import os
from Utilities.ConfigHistFactory import ConfigHistFactory 
from Utilities.prettytable import PrettyTable
import math
import sys
import array
import datetime
from Utilities.scripts import makeSimpleHtml
from IPython import embed
import logging
import pdb,json

with open("Templates/config.%s" % os.getlogin()) as fconfig:
    for line in fconfig:
        if 'scriptPath' in line:
            scriptPath = line.split(" = ")[1].strip()
sys.path.insert(0,scriptPath)
import OutputTools
import ConfigureJobs
import HistTools

def getComLineArgs():
    parser = UserInput.getDefaultParser()
    parser.add_argument("-s", "--selection", type=str, required=True,
                        help="Specificy selection level to run over")
    parser.add_argument("--latex", action='store_true', help='table in latex format')
    parser.add_argument("-r", "--object_restrict", type=str, default="",
                        help="Use modified object file")
    parser.add_argument("-b", "--branches", type=str, default="all",
                        help="List (separate by commas) of names of branches "
                        "in root and config file to plot") 
    parser.add_argument("-m", "--make_cut", type=str, default="",
                        help="Enter a valid root cut string to apply")
    parser.add_argument("--blinding", type=list, default=["Mass < 400",
        "Pt < 200", "mjj < 500", "dEtajj < 2.5", "MTWZ < 400"],
        help="Blinding cuts to apply (only to that distribution)")
    parser.add_argument("--lhe_weight_id", type=float, default=None,
        help="LHE weight ID used to retrieve plots from LHE weight plots." \
        + " can only be used with modified UWVV ntuples")
    return parser.parse_args()

log_info = ""

#can trust weighted events and error, but not stat error and raw events, since raw event for eemm/mmee is incorrect
def writeMCLogInfo(hist_info, selection, branch_name, luminosity, cut_string, latex):
    mc_info = PrettyTable(["Plot Group", "Weighted Events", "Error", "Stat Error", "Raw Events"])
    weighted_events = 0
    total_background = 0
    background_err = 0
    total_err2 = 0
    signal = 0
    signal_err = 0
    for plot_set, entry in hist_info.iteritems():
        wevents = round(entry["weighted_events"], 3 if entry["weighted_events"] < 1 else 2) 
        mc_info.add_row([plot_set, wevents, 
            round(entry["error"],2),
            round(entry["stat error"],2),
            int(round(entry["raw_events"]))]
        )
        weighted_events += entry["weighted_events"]
        total_err2 += entry["error"]**2
        if "zz" not in plot_set:
            total_background += entry["weighted_events"]
            background_err += entry["error"]*entry["error"]
        else:
            signal += entry["weighted_events"]
            signal_err += entry["error"]
    total_err = math.sqrt(total_err2)
    likelihood = 0 if weighted_events <= 0 else \
        signal/math.sqrt(weighted_events)
    likelihood_err = 0 if signal <= 0 or weighted_events <= 0 else \
        likelihood*math.sqrt((signal_err/signal)**2 + \
            (0.5*total_err/weighted_events)**2)
    sigbkgd = 0 if weighted_events <= 0 else signal/weighted_events
    sigbkgd_err = 0 if signal <= 0 or weighted_events <= 0 else \
        sigbkgd*math.sqrt((signal_err/signal)**2 + (total_err/weighted_events)**2)
    if weighted_events == 0:
        raise RuntimeError("Empty histogram produced for variable " + branch_name)
    with open("temp.txt", "a") as mc_file:
        mc_file.write("\n"+(mc_info.get_string() if not latex else mc_info.get_latex_string())+"\n")
        mc_file.write("\nTotal sum of Monte Carlo: %0.2f +/- %0.2f" % (round(weighted_events, 2), 
            round(math.sqrt(sum([x["error"]*x["error"] for x in hist_info.values()])), 2)))
        mc_file.write("\nTotal sum of background Monte Carlo: %0.2f +/- %0.2f" % (round(total_background, 2), 
            round(math.sqrt(background_err), 2)))
        mc_file.write("\nRatio S/(S+B): %0.2f +/- %0.2f" % (round(sigbkgd, 2), 
            round(sigbkgd_err, 2)))
        mc_file.write("\nRatio S/sqrt(S+B): %0.2f +/- %0.2f" % (round(likelihood, 2), 
            round(likelihood_err, 2)))
    
    #with open("CurrentRun_Event_output.txt", "a") as current_evt:
    #    current_evt.write("\n"+(mc_info.get_string() if not latex else mc_info.get_latex_string())+"\n")
        
def getStacked(name, config_factory, selection, filelist, branch_name, channels, blinding, addOverflow, latex,
               cut_string="", luminosity=1, rebin=0, uncertainties="none", hist_file="", lhe_weight_id=None):
    hist_stack = ROOT.THStack(name, "")
    ROOT.SetOwnership(hist_stack, False)
    hist_info = {}
    first_add = True
    first_add2 = True
    #signal_list = ["zzjj4l-ewk","ggZZ","qqZZ-amcnlo","HZZ-signal"] 
    print "Plot_set in filelist"
    for plot_set in filelist:
        #pdb.set_trace()
        print plot_set
        if hist_file == "":
            hist = helper.getConfigHistFromTree(config_factory, plot_set, selection,  
                    branch_name, channels, blinding, luminosity, addOverflow, rebin, cut_string, 
                    uncertainties)
        else:
            hist = helper.getConfigHistFromFile(hist_file, config_factory, plot_set, 
                        selection, branch_name, channels, luminosity, addOverflow=addOverflow, rebin=rebin, lhe_weight_id=lhe_weight_id)
            print "hists",hist
        if luminosity < 0:
            hist.Scale(1/hist.Integral())
        #raw_events = hist.GetEntries() - 1
        #why subtracting 1?
        #raw_events unrealiable for eemm and mmee hist, since by design there are weights set to zero but still filled
        raw_events = hist.GetEntries()
        correctOffHiggs = True
        if correctOffHiggs:
            if "ggZZ" in plot_set and "Mass" in branch_name: #correct for off-shell higgs interference
                hist.Sumw2() 
                offshellbin = hist.GetNbinsX()
                hist.SetBinContent(offshellbin,0.9*hist.GetBinContent(offshellbin))
                hist.SetBinError(offshellbin,0.9*hist.GetBinError(offshellbin))
        hist_stack.Add(hist)

        hist.Sumw2()

        if first_add2:
            tot_sum = hist.Clone(name+"totalsum")
            first_add2 = False
        else:
            tot_sum.Add(hist)

        #if plot_set in signal_list:
        #    if first_add:
        #        signal_sum = hist.Clone(name+"signalsum")
        #        first_add = False
        #    else:
        #        signal_sum.Add(hist)
        #else:
        #  print("NOTE: never made signal_sum")
            
        error = array.array('d', [0])
        #pdb.set_trace()
        
        weighted_events = hist.IntegralAndError(1, hist.GetNbinsX(), error)
        central_error = 0. if int(raw_events) <= 0 else error[0]
        if "Mass" in branch_name:
            with open("CurrentRun_Event_output.txt", "a") as current_evt:
                current_evt.write("\n %s: weighted events %s"%(plot_set,weighted_events))
                current_evt.write("\n %s: weighted events Error %s"%(plot_set,central_error))
            if "Full" in branch_name:
                bin_Z = hist.FindBin(90)
                bin_H = hist.FindBin(125)
                Z_events = hist.GetBinContent(bin_Z)
                H_events = hist.GetBinContent(bin_H)
                Z_error = hist.GetBinError(bin_Z)
                H_error = hist.GetBinError(bin_H)
                with open("CurrentRun_Event_output.txt", "a") as current_evt:
                    current_evt.write("\n %s: 80-100 GeV %s"%(plot_set,Z_events))
                    current_evt.write("\n %s: 80-100 GeV Error %s"%(plot_set,Z_error))
                    current_evt.write("\n %s: 120-130 GeV %s"%(plot_set,H_events))
                    current_evt.write("\n %s: 120-130 GeV Error %s"%(plot_set,H_error))
        #hist.Sumw2()
        #if not hist.GetSumw2(): hist.Sumw2()
        #pdb.set_trace()
        #can use error for information, but not sure what stat error statnds for, since we should calculate sum of weight^2.
        hist_info[plot_set] = {'raw_events' : raw_events, 
                               'weighted_events' : weighted_events,
                               'error' : 0 if int(raw_events) <= 0 else error[0],
                                'stat error' : 0 if raw_events <= 0 else \
                                    weighted_events/math.sqrt(raw_events) 
        }
    writeMCLogInfo(hist_info, selection, branch_name, luminosity, cut_string, latex)

    #total and stat unc. for signal (signal sum)
    error_sigs = array.array('d', [0])
    #weighted_events_sigs = signal_sum.IntegralAndError(1, signal_sum.GetNbinsX(), error_sigs)
    #central_error_sigs = 0. if int(signal_sum.GetEntries()) <= 0 else error_sigs[0]
    #if "Mass" in branch_name:
       # with open("CurrentRun_Event_output.txt", "a") as current_evt:
            #current_evt.write("\n %s: weighted events %s"%("signalSum",weighted_events_sigs))
            #current_evt.write("\n %s: weighted events Error %s"%("signalSum",central_error_sigs))
        #if "Full" in branch_name:
            #bin_Z_sigs = signal_sum.FindBin(90)
            #bin_H_sigs = signal_sum.FindBin(125)
            #Z_events_sigs = signal_sum.GetBinContent(bin_Z_sigs)
            #H_events_sigs = signal_sum.GetBinContent(bin_H_sigs)
            #Z_error_sigs = signal_sum.GetBinError(bin_Z_sigs)
            #H_error_sigs = signal_sum.GetBinError(bin_H_sigs)
            #with open("CurrentRun_Event_output.txt", "a") as current_evt:
            #    current_evt.write("\n %s: 80-100 GeV %s"%("signalSum",Z_events_sigs))
            #    current_evt.write("\n %s: 80-100 GeV Error %s"%("signalSum",Z_error_sigs))
            #    current_evt.write("\n %s: 120-130 GeV %s"%("signalSum",H_events_sigs))
            #    current_evt.write("\n %s: 120-130 GeV Error %s"%("signalSum",H_error_sigs))

    error_tots = array.array('d', [0])
    weighted_events_tots = tot_sum.IntegralAndError(1, tot_sum.GetNbinsX(), error_tots)
    central_error_tots = 0. if int(tot_sum.GetEntries()) <= 0 else error_tots[0]
    if "Mass" in branch_name:
        with open("CurrentRun_Event_output.txt", "a") as current_evt:
            current_evt.write("\n %s: weighted events %s"%("totexp",weighted_events_tots))
            current_evt.write("\n %s: weighted events Error %s"%("totexp",central_error_tots))
        if "Full" in branch_name:
            bin_Z_tots = tot_sum.FindBin(90)
            bin_H_tots = tot_sum.FindBin(125)
            Z_events_tots = tot_sum.GetBinContent(bin_Z_tots)
            H_events_tots = tot_sum.GetBinContent(bin_H_tots)
            Z_error_tots = tot_sum.GetBinError(bin_Z_tots)
            H_error_tots = tot_sum.GetBinError(bin_H_tots)
            with open("CurrentRun_Event_output.txt", "a") as current_evt:
                current_evt.write("\n %s: 80-100 GeV %s"%("totexp",Z_events_tots))
                current_evt.write("\n %s: 80-100 GeV Error %s"%("totexp",Z_error_tots))
                current_evt.write("\n %s: 120-130 GeV %s"%("totexp",H_events_tots))
                current_evt.write("\n %s: 120-130 GeV Error %s"%("totexp",H_error_tots))

    return hist_stack
def main():
    #pdb.set_trace()
    #=================================
    #When printing for table, remember to swithch bw normalization in helper_functions and FromFileHistProducer
    #=================================
    args = getComLineArgs()
    doSyst = True
    do3ChanSys = True #Do 3 channels separately and totoal for table printout
   
    if not do3ChanSys:
        if not args.channels == "eeee,eemm,mmee,mmmm": #only run syst band for total channels
            return
            doSyst = False
        if args.channels == "eemm" or args.channels == "mmee": #only look at combined 2e2m channel
            return
            
            if "mmee" in args.channels:
                return
                doSyst = False
    else:
        if not args.channels == "eeee,eemm,mmee,mmmm": #only run syst band for total channels
            
            if "mmee" in args.channels: #only allow eeee,eemm,mmmm as input
                return
                

    #if args.channels == "eemm" or args.channels == "mmee": #only look at combined 2e2m channel
    #    return
        
    with open('varsFile.json') as var_json_file:
        myvar_dict = json.load(var_json_file)
    for key in myvar_dict.keys():
        if args.branches==str(key):
            args.rebin = myvar_dict[key]['_binning']
            
    ROOT.gROOT.SetBatch(True)
    ROOT.gStyle.SetOptDate(0)
    if args.hist_file == "":
        ROOT.TProof.Open('workers=12')
    filelist = UserInput.getListOfFiles(args.files_to_plot, args.selection)
    print filelist
    path = ConfigureJobs.getManagerPath()[:-1]
    manager_name = ConfigureJobs.getManagerName()
    config_factory = ConfigHistFactory(
        "%s/%s" % (path, manager_name),
        args.selection.split("_")[0],
        args.object_restrict
    )
    #print args.selection, args.selection.split("_")[0]
    #print args.rebin
    branches = config_factory.getListOfPlotObjects() if args.branches == "all" \
            else [x.strip() for x in args.branches.split(",")]
    print branches
    cut_string = args.make_cut
    (plot_path, html_path) = helper.getPlotPaths(args.selection, args.folder_name, True)
    meta_info = '-'*80 + '\n' + \
        'Script called at %s\n' % datetime.datetime.now() + \
        'The command was: %s\n' % ' '.join(sys.argv) + \
        '-'*80 + '\n'
    for branch in branches:
        hist_stacks = []
        signal_stacks = []
        data_hists = []
        for branch_name in branch.split("+"):
            with open("temp.txt", "w") as mc_file:
                mc_file.write(meta_info)
                mc_file.write("Selection: %s" % args.selection)
                mc_file.write("\nAdditional cut: %s" % ("None" if cut_string == "" else cut_string))
                mc_file.write("\nLuminosity: %0.2f fb^{-1}" % (args.luminosity))
                mc_file.write("\nPlotting branch: %s\n" % branch_name)
            with open("CurrentRun_Event_output.txt", "a") as current_evt:
                if "Mass" in branch_name:
                    current_evt.write("\nLuminosity: %0.2f fb^{-1}" % (args.luminosity))
                    current_evt.write("\nPlotting branch: %s" % branch_name)
                    current_evt.write("\nChannels: %s\n" % args.channels)
            try:
                #pdb.set_trace()
                hist_stack = getStacked("stack_"+branch_name, config_factory, args.selection, filelist, 
                        branch_name, args.channels, args.blinding, not args.no_overflow, args.latex, cut_string,
                        args.luminosity, args.rebin, args.uncertainties, args.hist_file, args.lhe_weight_id)
            except ValueError as e:
                logging.warning('\033[91m'+ str(e)+'\033[0m')
                continue
            if not args.no_data:
                #pdb.set_trace()
                if args.hist_file == "":
                    #data_hist = helper.getConfigHistFromTree(config_factory, "data_all", args.selection, 
                    data_hist = helper.getConfigHistFromTree(config_factory, "data_all", args.selection, 
                            branch_name, args.channels, args.blinding, 1, not args.no_overflow, args.rebin, 
                            cut_string)
                else:
                    #data_hist = helper.getConfigHistFromFile(args.hist_file, config_factory, "data_all",
                    data_hist = helper.getConfigHistFromFile(args.hist_file, config_factory, "data_all", 
                            args.selection, branch_name, args.channels,addOverflow=(not args.no_overflow), rebin=args.rebin, lhe_weight_id=args.lhe_weight_id)
                with open("temp.txt", "a") as events_log_file:
                    events_log_file.write("\nNumber of events in data: %i\n" % data_hist.Integral())
                with open("CurrentRun_Event_output.txt", "a") as current_evt:
                    if "Mass" in branch_name:
                        current_evt.write("\nNumber of events in data: %i\n" % data_hist.Integral())
                        if "Full" in branch_name:
                            bin_Z = data_hist.FindBin(90)
                            bin_H = data_hist.FindBin(125)
                            current_evt.write("\ndata events 80-100 GeV: %i\n" % data_hist.GetBinContent(bin_Z))
                            current_evt.write("\ndata events 120-130 GeV: %i\n" % data_hist.GetBinContent(bin_H))
            else:
                data_hist = 0
            signal_stack = 0
            if len(args.signal_files) > 0:
                signal_filelist = UserInput.getListOfFiles(args.signal_files, args.selection)
                signal_stack = getStacked("signal_stack_"+branch_name, config_factory, args.selection, signal_filelist, 
                        branch_name, args.channels, args.blinding, not args.no_overflow, args.latex, cut_string,
                        args.luminosity, args.rebin, args.uncertainties, args.hist_file)
            hist_stacks.append(hist_stack)
            signal_stacks.append(signal_stack)
            data_hists.append(data_hist)
        if not hist_stacks:
            continue
        name = branch.replace("+","_")
        plot_name = name if args.append_to_name == "" else "_".join([name, args.append_to_name])

        #embed()
        #pdb.set_trace()
        completeHist = hist_stacks[0].GetStack().Last()
        tmpCmpHist = ROOT.TH1D(args.branches+"_jetPUSFtest","",len(args.rebin)-1,array.array('d',args.rebin))
        for i in range(completeHist.GetNbinsX()):
            print("Complete Hist Content bin %s: %s"%(i+1,completeHist.GetBinContent(i+1)))
            tmpCmpHist.SetBinContent(i+1,completeHist.GetBinContent(i+1))
            tmpCmpHist.SetBinError(i+1,completeHist.GetBinError(i+1))
            #Don't know why, but cannot draw this completeHist so have to copy it manually

        tmpOut = False
        if tmpOut:
            #pdb.set_trace()
            myoutputFile=ROOT.TFile("writeFile.root","UPDATE")
            myoutputFile.cd()
            completeHist2 = completeHist.Clone(args.branches+"_jetPUSFtest")
            tmpCmpHist.Write()
            #completeHist2.Write()
            myoutputFile.Close()
            print("File written")
            sys.exit()

        helper.setGlobalChannel(args.channels,args.selection,args.luminosity,args.branches,args.hist_file,doSyst) 
        canvas = helper.makePlots(hist_stacks, data_hists, name, args, signal_stacks)
        helper.savePlot(canvas, plot_path, html_path, plot_name, True, args)
        makeSimpleHtml.writeHTML(html_path.replace("/plots",""), args.selection)

if __name__ == "__main__":
    
    main()
