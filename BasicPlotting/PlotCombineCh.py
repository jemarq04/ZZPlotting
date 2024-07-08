import ROOT
import math
from ROOT import gROOT,gStyle
from glob import glob
import os
from collections import OrderedDict

Date='2018-03-13'
analysis='ZZ4l2018'
selection='preselectionTo4lmass-v1'
#Dir = '/hdfs/store/user/uhussain/ZZAnalysisJobs_'+Date
Dir = '/data/uhussain/ZZAnalysis_2018-03-13/FinalSelection'
outDir = '/afs/cern.ch/user/u/uhussain/www/ZZ2018Plots/Mar7'
lumi = 41.79
nbins = 40
variables = ["e1_e2_Mass","m1_m2_Mass"]
channels = {"eeee":variables[0],"eemm":variables,"mmmm":variables[1]}
#channels = {"mmmm":variables[1]}
#mcDupCut = ROOT.TCut("duplicated==0")
Z_MASS = 91.1876
def createDataH1(channels):
    eras=['B','C','D','E','F']
    data = ['DoubleMuon','DoubleEG','MuonEG','SingleElectron','SingleMuon']
    dataFiles=[]
    for d in data:
        for era in eras:
            dataPath=Date+'-'+d+'_'+'Run2017'+era+'-17Nov2017-v1-'+analysis+'-'+selection
            dataDir=os.path.join(Dir,dataPath)
            #print 'dataDir: ',dataDir
            dataFiles+=glob(dataDir+"/*.root")
            #print 'dataFiles added'
    print('Length of dataFiles: ',len(dataFiles))
    for ch in channels:
        locals()['chain_{0}'.format(ch)] = ROOT.TChain(ch+"/ntuple")
    for f in dataFiles:
        for ch in channels:
            (locals()['chain_{0}'.format(ch)]).Add(f)
    #print "Chain was made"
    #print 'chain Entries: ',chain.GetEntries()
    #chain.ls()
        #chain.SetBranchStatus(variable,1)
    data_Sum = "ZMass_AllChannels"
    hdataSum = ROOT.TH1F(data_Sum, data_Sum, nbins, 40, 120)
    #hdataSum.Sumw2()
    for ch in channels:
        data_hist = "ZMass_"+ch
        h1 = ROOT.TH1F(data_hist, data_hist, nbins, 40, 120)
    #print "can it draw"
        if (ch=="eeee" or ch=="mmmm"):
            (locals()['chain_{0}'.format(ch)]).Draw(channels[ch]+">>"+data_hist,"(nZZTightIsoElec+nZZTightIsoMu==4) && (Mass<115 || Mass>150)")
            #(locals()['chain_{0}'.format(ch)]).Draw(channels[ch]+">>"+data_hist,"")
            #print "chain Draw Successful"
    #Function to retrieve mZ1 in ch=eemm
        else:
            (locals()['chain_{0}'.format(ch)]).Draw("(( abs(e1_e2_Mass-91.1876)<abs(m1_m2_Mass-91.1876) ) ? e1_e2_Mass : m1_m2_Mass)>>"+data_hist, "(nZZTightIsoElec+nZZTightIsoMu==4)&&(Mass<115 || Mass>150)")
            #(locals()['chain_{0}'.format(ch)]).Draw("(( abs(e1_e2_Mass-91.1876)<abs(m1_m2_Mass-91.1876) ) ? e1_e2_Mass : m1_m2_Mass)>>"+data_hist, "")
        print("DataIntegral_",ch,": ",h1.Integral())
        h1.Sumw2()
        hdataSum.Add(h1)
        h1.SetDirectory(0)
    hdataSum.SetLineColor(ROOT.kWhite)
    hdataSum.SetLineWidth(2)
    hdataSum.SetStats(0)
    hdataSum.SetTitle("")
    hdataSum.GetXaxis().SetTitle("")
    hdataSum.GetXaxis().SetTickLength(0)
    hdataSum.GetXaxis().SetLabelOffset(999)
    hdataSum.GetYaxis().SetTitle("")
    hdataSum.GetYaxis().SetTickLength(0)
    hdataSum.GetYaxis().SetLabelOffset(999)
    return hdataSum

def createMCStack(channels,leg):
    mcSamples = {"WZTo3LNu":[4.430,"WZ3LNu"],"TTJets-amcatnlo":[815.96,"top"],"TTTo2L2Nu-powheg":[87.31,"top"],"DYJetsToLL_M10to50":[18610,"dy-jets"],
            "DYJetsToLLM-50_ext1":[6104,"dy-jets"], 
            "GluGluZZTo2e2mu":[0.00319,"ggZZ"],"GluGluZZTo2e2tau":[0.00319,"ggZZ"],"GluGluZZTo2mu2tau":[0.00319,"ggZZ"],
            "GluGluZZTo4e":[0.00159,"ggZZ"],"GluGluZZTo4mu":[0.00159,"ggZZ"],"ZZTo4L-powheg_ext1":[1.256,"qqZZ-powheg"],
            "ttH_HToZZ_4L_ext1":[0.000393,"HZZ-signal"], "WminusHToZZ_ext1":[0.000147,"HZZ-signal"],"ggHZZ_ext1":[0.01218,"HZZ-signal"],
            "WplusHToZZ_ext1":[0.000232,"HZZ-signal"],"ZHToZZ_4L":[0.000668,"HZZ-signal"]}
    plotgroups=OrderedDict([
            ("WZ3LNu",{"Name": "WZ","Style": "fill-lightpurple","Members": ["WZTo3LNu"]}),
            ("top" , {"Name" : "ttbar","Style" : "fill-yellow","Members" : ["TTJets-amcatnlo","TTTo2L2Nu-powheg"]}),
            ("HZZ-signal" , {"Name" : "HZZ","Style" : "fill-lightred","Members" : ["ggHZZ_ext1","ttH_HToZZ_4L_ext1","WminusHToZZ_ext1","WplusHToZZ_ext1","ZHToZZ_4L"]}),
            ("ggZZ", {"Name" : "ggZZ", "Style" : "fill-blue","Members" : ["GluGluZZTo4e","GluGluZZTo4mu","GluGluZZTo2e2mu","GluGluZZTo2e2tau","GluGluZZTo2mu2tau"]}),
            ("dy-jets" , {"Name" : "Drell-Yan","Style" : "fill-green","Members" : ["DYJetsToLL_M10to50","DYJetsToLLM-50_ext1"]}),
            ("qqZZ-powheg" , {"Name" : "qqZZ","Style" : "fill-lightblue","Members" : ["ZZTo4L-powheg_ext1"]}) 
            ])

    styles={"fill-lightpurple" : {"SetFillColor": ROOT.TColor.GetColor("#cab2d6"),"SetLineColor": ROOT.TColor.GetColor("#7E668A")},
            "fill-green" : {"SetFillColor": ROOT.TColor.GetColor("#4daf4a"),"SetLineColor": ROOT.TColor.GetColor("#016300")},
            "fill-yellow" : {"SetFillColor": ROOT.TColor.GetColor("#ffff33"),"SetLineColor": ROOT.TColor.GetColor("#B3B300")},
            "fill-blue" : {"SetFillColor": ROOT.kBlue,"SetLineColor": ROOT.TColor.GetColor("#00326C")},
            "fill-lightblue" : {"SetFillColor":ROOT.TColor.GetColor("#00bfff") ,"SetLineColor": ROOT.TColor.GetColor("#377eb8")},
            "fill-lightred" : {"SetFillColor":ROOT.TColor.GetColor("#ffa07a") ,"SetLineColor": ROOT.TColor.GetColor("#e41a1c")}}
    #channels = ["eeee/ntuple","eemm/ntuple", "eeee/ntuple"]  
    MCStack = ROOT.THStack("stack", "stack")
    ROOT.SetOwnership(MCStack, False)
    print(list(plotgroups.keys()))
    for plotgroup in list(plotgroups.keys()):
        members=plotgroups[plotgroup]["Members"]
        mc_Group = "ZMass_AllChannels_"+plotgroup
        hmcGroup = ROOT.TH1F(mc_Group, mc_Group, nbins, 40, 120)
        #hmcGroup.Sumw2()
        for mc_Sample in members:
            #print "mcSample is: ", mc_Sample
            mcPath = Date+'-'+mc_Sample+'-'+analysis+'-'+selection
            mcDir = os.path.join(Dir,mcPath)
            #print 'mcDir: ',mcDir
            mcFiles=glob(mcDir+"/*.root")
            MetaChain = ROOT.TChain("metaInfo/metaInfo")
            
            for ch in channels:
                locals()['MCchain_{0}'.format(ch)] = ROOT.TChain(ch+"/ntuple")
            
            for g in mcFiles:
                for ch in channels:
                    (locals()['MCchain_{0}'.format(ch)]).Add(g)
                MetaChain.Add(g)

            mc_Sum = "ZMass_AllChannels_"+mc_Sample
            hmcSum = ROOT.TH1F(mc_Sum, mc_Sum, nbins, 40, 120)
            #hmcSum.Sumw2()
            for ch in channels:
                hist_name = "ZMass_"+mc_Sample+"_"+ch
                hist = ROOT.TH1F(hist_name, hist_name, nbins, 40, 120)
            #ROOT.SetOwnership(hist, False)
                if (ch=="eeee" or ch=="mmmm"):
                    (locals()['MCchain_{0}'.format(ch)]).Draw(channels[ch]+">>"+hist_name,"genWeight*(nZZTightIsoElec+nZZTightIsoMu==4)")
                    #(locals()['MCchain_{0}'.format(ch)]).Draw(channels[ch]+">>"+hist_name,"genWeight*(duplicated==0)")
            #Function to retrieve mZ1 in ch=eemm
                else:
                    (locals()['MCchain_{0}'.format(ch)]).Draw("(( abs(e1_e2_Mass-91.1876)<abs(m1_m2_Mass-91.1876) ) ? e1_e2_Mass : m1_m2_Mass)>>"+hist_name, "genWeight*(nZZTightIsoElec+nZZTightIsoMu==4)")
                    #(locals()['MCchain_{0}'.format(ch)]).Draw("(( abs(e1_e2_Mass-91.1876)<abs(m1_m2_Mass-91.1876) ) ? e1_e2_Mass : m1_m2_Mass)>>"+hist_name, "genWeight*(duplicated==0)") 
                hist.Sumw2()
                sumweights_hist = ROOT.TH1D("sumweights", "sumweights", 1,0,100)
                MetaChain.Draw("1>>sumweights","summedWeights")
                sumweights = sumweights_hist.Integral()
                xsec = mcSamples[mc_Sample][0]*1000
                hist.Scale((xsec*lumi)/sumweights)
                #Adding all the channels together for each member in a PlotGroup
                hmcSum.Add(hist)
                sumweights_hist.SetDirectory(0)
                hist.SetDirectory(0)
            #Adding all the members in a PlotGroup
            hmcGroup.Add(hmcSum)
            hmcSum.SetDirectory(0)
        #plotgroup = mcSamples[mc_Sample][1]
        style = plotgroups[plotgroup]["Style"]
        color=styles[style]["SetFillColor"]
        hmcGroup.SetFillColor(styles[style]["SetFillColor"])
        hmcGroup.SetLineColor(styles[style]["SetLineColor"])
        hmcGroup.SetLineStyle(1)
        hmcGroup.SetLineWidth(1)
        hmcGroup.SetMarkerSize(0)
        gROOT.cd()
        hnew = hmcGroup.Clone()
        if not hnew.GetSumw2(): hnew.Sumw2()
        #if MCStack.GetHists():
        #    print "Before length is", len(MCStack.GetHists())
        MCStack.Add(hnew)
        leg.AddEntry(hnew,plotgroups[plotgroup]["Name"],"F")
        hmcGroup.SetDirectory(0)
        #print "length is", len(MCStack.GetHists())
        #print hist.Integral()
    #ROOT.SetOwnership(MCStack, False)
    for i in MCStack.GetHists(): print(i.GetName(), "Integral is", i.Integral())
    return MCStack
def createRatio(h1, h2):
    Nbins = h1.GetNbinsX()
    Ratio = h1.Clone("Ratio")
    if not Ratio.GetSumw2(): Ratio.Sumw2()
    hStackLast = h2.Clone("hStackLast")
    if not hStackLast.GetSumw2(): hStackLast.Sumw2()
    for i in range(Nbins):
        stackcontent = hStackLast.GetBinContent(i)
        if stackcontent<0:
            print("stackcontent: ", stackcontent, "and bin: ",i)
        stackerror = hStackLast.GetBinError(i)
        datacontent = h1.GetBinContent(i)
        dataerror = h1.GetBinError(i)
        print("stackerror: ",stackerror, " and data error: ",dataerror)
        #print "stackcontent: ",stackcontent," and data content: ",datacontent
        ratiocontent=0
        if(datacontent!=0):
            ratiocontent = datacontent/stackcontent
        if(datacontent!=0):
            error = ratiocontent*(math.sqrt(math.pow((dataerror/datacontent),2) + math.pow((stackerror/stackcontent),2)))
        else:
            error = 2.07
        print("ratio content: ",ratiocontent," and error: ",error)
        Ratio.SetBinContent(i,ratiocontent)
        Ratio.SetBinError(i,error)

    Ratio.GetYaxis().SetRangeUser(0.0,2.2)
    Ratio.SetStats(0)
    Ratio.GetYaxis().CenterTitle()
    Ratio.SetMarkerStyle(20)
    Ratio.SetMarkerSize(0.7)

    line = ROOT.TLine(40, 1.,120, 1.)
    line.SetLineStyle(8)

    Ratio.GetYaxis().SetLabelSize(0.14)
    Ratio.GetYaxis().SetTitleSize(0.12)
    Ratio.GetYaxis().SetLabelFont(42)
    Ratio.GetYaxis().SetTitleFont(42)
    Ratio.GetYaxis().SetTitleOffset(0.25)
    Ratio.GetYaxis().SetNdivisions(100)
    Ratio.GetYaxis().SetTickLength(0.05)

    Ratio.GetXaxis().SetLabelSize(0.15)
    Ratio.GetXaxis().SetTitleSize(0.12)
    Ratio.GetXaxis().SetLabelFont(42)
    Ratio.GetXaxis().SetTitleFont(42)
    Ratio.GetXaxis().SetTitleOffset(0.90)
    Ratio.GetXaxis().SetTickLength(0.05)
    #Ratio.Draw("pex0")
    #line.SetLineColor(kBlack)
    #line.Draw("same");

    return Ratio,line

def createCanvasPads():
    c = ROOT.TCanvas("c", "canvas", 800, 800)
    gStyle.SetOptStat(0)
    gStyle.SetLegendBorderSize(0)
    # Upper histogram plot is pad1
    pad1 = ROOT.TPad("pad1", "pad1", 0.01, 0.25, 0.99, 0.99)
    pad1.Draw()
    pad1.cd()
    pad1.SetFillColor(0)
    pad1.SetFrameBorderMode(0)
    pad1.SetBorderMode(0)
    pad1.SetBottomMargin(0)  # joins upper and lower plot
    #pad1.SetGridx()
    #pad1.Draw()
    return c,pad1

def createPad2(canvas):
    texS = ROOT.TLatex(0.20,0.837173,"#sqrt{s} = 13 TeV, 41.8 fb^{-1}")
    texS.SetNDC()
    texS.SetTextFont(42)
    texS.SetTextSize(0.040)
    texS.Draw()
    texS1 = ROOT.TLatex(0.12092,0.907173,"#bf{UW} #it{Internal}")
    texS1.SetNDC()
    texS1.SetTextFont(42)
    texS1.SetTextSize(0.040)
    texS1.Draw()
    # Lower ratio plot is pad2
    canvas.cd()  # returns to main canvas before defining pad2
    pad2 = ROOT.TPad("pad2", "pad2", 0.01, 0.01, 0.99, 0.25)
    pad2.Draw()
    pad2.cd()
    pad2.SetFillColor(0)
    pad2.SetFrameBorderMode(0)
    pad2.SetBorderMode(0)
    pad2.SetTopMargin(0)  # joins upper and lower plot
    pad2.SetBottomMargin(0.2)
    #pad2.SetGridx()
    #pad2.Draw()
    return texS,texS1,pad2

def stackplot(channels):
    # create required parts

    c,pad1 = createCanvasPads()
    h1 = createDataH1(channels)
    if not h1.GetSumw2(): h1.Sumw2()
    print("Data Integral (AllChannels): ", h1.Integral())
    Datamaximum = h1.GetMaximum()
    leg = ROOT.TLegend(0.20,0.54,0.48,0.84,"")
    leg.AddEntry(h1,"Data")
    hStack = createMCStack(channels,leg)
    
    #Where is this negative stackContent coming from? its possible because of genWeight
    #for i in hStack.GetHists(): print i.GetName(), "BinContent(36) is: ", i.GetBinContent(36)
    h2 = hStack.GetStack().Last()
    #h2.SetFillColor(ROOT.kBlue)
    print("Total Stack Integral",h2.Integral())
    Stackmaximum = h2.GetMaximum()
    hStack.SetTitle("mZ1_AllChannels")
    hStack.Draw("HIST")
    hStack.SetMinimum(0)
    if(Datamaximum > Stackmaximum):
        hStack.SetMaximum(Datamaximum*1.2)
    else:
        hStack.SetMaximum(Stackmaximum*1.2)

    hStack.GetYaxis().SetTitle("Events / 2 GeV")
    hStack.GetYaxis().SetTitleOffset(1.0)
    hStack.Draw("HIST")
    h1.SetLineColor(ROOT.kBlack)
    h1.SetMarkerStyle(20)
    h1.SetMarkerSize(1.0)
    h1.Draw("pex0same")
    
    #leg = ROOT.TLegend(0.20,0.54,0.48,0.84,"")
    #leg.AddEntry(h1,"Data")
    #leg.AddEntry(h2, "2017 Background MC Samples")
    leg.SetFillColor(ROOT.kWhite)
    leg.SetFillStyle(0)
    leg.SetTextSize(0.025)
    leg.Draw()

    #SecondPad
    texS,texS1,pad2 = createPad2(c)
    #Starting the ratio proceedure
    Ratio,line = createRatio(h1, h2)
    Ratio.Draw("pex0")
    line.SetLineColor(ROOT.kBlack)
    line.Draw("same")

    #redraw axis
    xaxis = ROOT.TGaxis(40,0,120,0,40,120,510)
    xaxis.SetTitle("m_{Z_{1}} (GeV)")
    xaxis.SetLabelFont(42)
    xaxis.SetLabelSize(0.10)
    xaxis.SetTitleFont(42)
    xaxis.SetTitleSize(0.12)
    xaxis.SetTitleOffset(0.70)
    xaxis.Draw("SAME")

    yaxis = ROOT.TGaxis(40,0,40,2.2,0,2.2,6,"")
    yaxis.SetTitle("Data/MC")
    yaxis.SetLabelFont(42)
    yaxis.SetLabelSize(0.10)
    yaxis.SetTitleFont(42)
    yaxis.SetTitleSize(0.12)
    yaxis.SetTitleOffset(0.35)
    yaxis.Draw("SAME")

    c.Update()
    #print hStack.ls()
    #hStack.GetYaxis().SetTitle("Events / 2 GeV")
    #hStack.GetYaxis().SetTitleOffset(1.0)
    #c, pad1, pad2 = createCanvasPads()
    #c = createCanvasPads()
    # draw everything
    #pad1.cd()
    #c.cd()
    #h1.Draw("pex0")
    #hStack.Draw("HIST SAME")
    #h1.Draw("pex0same")
    # to avoid clipping the bottom zero, redraw a small axis
    #h1.GetYaxis().SetLabelSize(0.0)
    #maximum = h1.GetMaximum()
    #print "h1.GetMaximum(): ", maximum
    #axis = ROOT.TGaxis(0, 120, 0, maximum*1.2, 120, maximum*1.2, 510, "")
    #axis.SetLabelFont(43)
    #axis.SetLabelSize(15)
    #axis.Draw()
    #pad2.cd()
    #h3.Draw("ep")
    c.SaveAs("DataMCPlots_Mar21/Z1Mass_AllChannels_blinded_4l_Sumw2_"+Date+".pdf") 
    #text = raw_input()
    from IPython import embed
    embed()

if __name__ == "__main__":
    stackplot(channels)
