import ROOT
import math
from ROOT import gROOT,gStyle
from glob import glob
import os

mcDir = '/data/uhussain/SkimmedZZNtuples_mc_2018-03-06_hadd/results_full/'
outDir = '/afs/cern.ch/user/u/uhussain/www/ZZ2018Plots/Mar7'
lumi = 41.79
nbins = 40
variables = ["e1_e2_Mass","m1_m2_Mass"]
channels = {"eeee":variables[0],"eemm":variables,"mmmm":variables[1]}
#mcDupCut = ROOT.TCut("duplicated==0")
Z_MASS = 91.1876
mcSamples = ["ZZTo4L-powheg"] 
def createDataH1(ch,channels):    
    mc2017Files = glob("/data/uhussain/SkimmedZZNtuples_mc_2018-03-06_hadd/2017ZZTo4L/2018-03-06-ZZTo4L-powheg_ext1-ZZ4l2018-preselectionToQCDVeto-v1/*.root") 
    tree = ROOT.TChain(ch+"/ntuple")
    meta_tree = ROOT.TChain("metaInfo/metaInfo")
    for f in mc2017Files:
        tree.Add(f)
        meta_tree.Add(f)
    data_hist = "ZMass_2017_"+mcSamples[0]+"_"+ch
    #dataFile = ROOT.TFile("/data/uhussain/SkimmedZZNtuples_mc_2018-03-06_hadd/results_full/ZZTo4L-powheg_ext1.root")
    ##print dataFiles
    #tree = dataFile.Get(ch+"/ntuple")
    #meta_tree = dataFile.Get("metaInfo/metaInfo")
    data_hist = "ZMass2017_"+ch
    h1 = ROOT.TH1F(data_hist, data_hist, nbins, 40, 120)
    if (ch=="eeee" or ch=="mmmm"):
        tree.Draw(channels[ch]+">>"+data_hist,"genWeight*(nZZTightIsoElec+nZZTightIsoMu==4)")
    #Function to retrieve mZ1 in ch=eemm
    else:
        tree.Draw("(( abs(e1_e2_Mass-91.1876)<abs(m1_m2_Mass-91.1876) ) ? e1_e2_Mass : m1_m2_Mass)>>"+data_hist, "genWeight*(nZZTightIsoElec+nZZTightIsoMu==4)")
    
    sumweights_hist = ROOT.TH1D("sumweights", "sumweights", 1,0,100)
    meta_tree.Draw("1>>sumweights","summedWeights")
    sumweights = sumweights_hist.Integral()
    print("2017sumweights: ",sumweights)

    nevents_hist = ROOT.TH1D("nevents", "nevents", 1,0,100)
    meta_tree.Draw("1>>nevents","nevents")
    nevents = nevents_hist.Integral()
    print("2017nevents: ",nevents)
    xsec = 1.256*1000
    h1.Scale((xsec*lumi)/sumweights)
    h1.SetLineColor(ROOT.kRed)
    h1.SetLineWidth(2)
    h1.SetStats(0)
    h1.SetTitle("")
    h1.GetXaxis().SetTitle("")
    h1.GetXaxis().SetTickLength(0)
    h1.GetXaxis().SetLabelOffset(999)
    h1.GetYaxis().SetTitle("")
    h1.GetYaxis().SetTickLength(0)
    h1.GetYaxis().SetLabelOffset(999)
    print(h1.Integral())
    gROOT.cd()
    h2017 = h1.Clone()
    return h2017

def createMCStack(ch,channels):
    #channels = ["eeee/ntuple","eemm/ntuple", "eeee/ntuple"]  
    mc2016Files = glob("/data/uhussain/SkimmedZZNtuples_mc_2018-03-06_hadd/2016ZZTo4L/2018-03-15-ZZTo4L-powheg-ZZ4l2017-preselectionToQCDVeto-v1/*.root") 
    chain = ROOT.TChain(ch+"/ntuple")
    meta_tree = ROOT.TChain("metaInfo/metaInfo")
    for f in mc2016Files:
        chain.Add(f)
        meta_tree.Add(f)
    hist_name = "ZMass_2016_"+mcSamples[0]+"_"+ch
    hist = ROOT.TH1F(hist_name, hist_name, nbins, 40, 120)
    #ROOT.SetOwnership(hist, False)
    if (ch=="eeee" or ch=="mmmm"):
        chain.Draw(channels[ch]+">>"+hist_name,"genWeight*(nZZTightIsoElec+nZZTightIsoMu==4)")
    #Function to retrieve mZ1 in ch=eemm
    else:
        chain.Draw("(( abs(e1_e2_Mass-91.1876)<abs(m1_m2_Mass-91.1876) ) ? e1_e2_Mass : m1_m2_Mass)>>"+hist_name, "genWeight*(nZZTightIsoElec+nZZTightIsoMu==4)")
    sumweights_hist = ROOT.TH1D("sumweights", "sumweights", 1,0,100)
    meta_tree.Draw("1>>sumweights","summedWeights")
    sumweights = sumweights_hist.Integral()
    print("2016sumweights: ",sumweights)

    nevents_hist = ROOT.TH1D("nevents", "nevents", 1,0,100)
    meta_tree.Draw("1>>nevents","nevents")
    nevents = nevents_hist.Integral()
    print("2016nevents: ",nevents)
    xsec = 1.256*1000
    hist.Scale((xsec*lumi)/sumweights)
    hist.SetFillColor(ROOT.kBlue)
    #print hist.Integral()
        
    return hist
def createRatio(h1, h2):
    Nbins = h1.GetNbinsX()
    gROOT.cd()
    Ratio = h1.Clone("Ratio")
    hStackLast = h2.Clone("hStackLast")
    for i in range(Nbins):
        stackcontent = hStackLast.GetBinContent(i)
        stackerror = hStackLast.GetBinError(i)
        datacontent = h1.GetBinContent(i)
        dataerror = h1.GetBinError(i)
        print("stackcontent: ",stackcontent," and data content: ",datacontent)
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

def stackplot(ch,channels):
    # create required parts

    c,pad1 = createCanvasPads()
    h1 = createDataH1(ch,channels)
    print("2017 ZZTo4L Integral: ", h1.Integral())
    Datamaximum = h1.GetMaximum()
    h2 = createMCStack(ch,channels)
    print("2016 ZZTo4L Integral",h2.Integral())
    h2maximum = h2.GetMaximum()
    h2.SetTitle("ZZTo4L_2016vs2017_"+ch)
    #h2.Draw("HIST")
    h2.SetMinimum(0)
    if(Datamaximum > h2maximum):
        h2.SetMaximum(Datamaximum*1.2)
    else:
        h2.SetMaximum(h2maximum*1.2)

    h2.GetYaxis().SetTitle("Events / 2 GeV")
    h2.GetYaxis().SetTitleOffset(1.0)
    h2.Draw("HIST")
    h1.SetMarkerStyle(20)
    h1.SetMarkerSize(0.7)
    h1.Draw("HISTSAME")
   
    leg = ROOT.TLegend(0.20,0.54,0.48,0.84,"")
    leg.AddEntry(h1,"2017 ZZTo4L Bkg")
    leg.AddEntry(h2, "2016 ZZTo4L Bkg")
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
    c.SaveAs("2016vs2017/ZMass_"+ch+"_ZZTo4L.pdf") 
    #text = raw_input()
    from IPython import embed
    embed()

if __name__ == "__main__":
    for ch in channels:
        print("Plotting channel: ",ch)
        stackplot(ch,channels)
