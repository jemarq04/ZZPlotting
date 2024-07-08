#!/usr/bin/env python
import ROOT
import datetime
import os
import array
from Utilities.scripts import makeSimpleHtml

ROOT.gROOT.SetBatch(True)
canvas = ROOT.TCanvas("canvas", "canvas")

def getTextBox(obj, extra_text=""):
    text_box = ROOT.TPaveText(0.2, 0.88, 0.4+0.02*len(extra_text), 0.81, "blNDC")
    text_box.SetFillColor(0)
    text_box.SetLineColor(ROOT.kBlack)
    text_box.SetTextFont(42)
    text_box.AddText(" %s Fake Rate %s" % ("#mu" if "Mu" in obj else "e", extra_text))
    text_box.SetBorderSize(1)
    ROOT.SetOwnership(text_box, False)
    return text_box

def getLumiTextBox():
    texS = ROOT.TLatex(0.615,0.95,"#sqrt{s} = 13 TeV, 41.5 fb^{-1}")
    texS.SetNDC()
    texS.SetTextFont(42)
    texS.SetTextSize(0.040)
    texS.Draw()
    texS1 = ROOT.TLatex(0.15,0.95,"#bf{CMS} #it{Preliminary}")
    texS1.SetNDC()
    texS1.SetTextFont(42)
    texS1.SetTextSize(0.040)
    texS1.Draw()
    return texS,texS1


def makeResponseMatrix(hfile,sample,var, outdir,chan):
    histfile = ROOT.TFile("/data/uhussain/ZZTo4l/ZZ2018/VVAnalysisTools/CMSSW_9_4_2/src/Analysis/VVAnalysis/HistFiles/"+hfile)
    print(histfile)
    print("sample: ",sample)
    print("variable: ",var)
    print("channel: ",chan)
    print("%s/Gen%s_%s"%(sample,var,chan))
    GenHist = histfile.Get("%s/Gen%s_%s"%(sample,var,chan))
    RecoHist = histfile.Get("%s/Gen%s_%s"%(sample,var,chan))
    print ("GenHist: ", GenHist) 
    nbins={"Mass":11,"ZZPt":12}
    low={"Mass":100,"ZZPt":0}
    high={"Mass":1200,"ZZPt":1200}

    RespMat = ROOT.TH2D('RespMat','Reco vs True',nbins[var],low[var],high[var],nbins[var],low[var],high[var])
    #Fill the 2D Hist bin by bin
    for i in range(1,GenHist.GetNbinsX()+1):
        for j in range(1,RecoHist.GetNbinsX()+1):
            if(GenHist.GetBinContent(i)>0):
                RespMat.SetBinContent(i,j,RecoHist.GetBinContent(j)/GenHist.GetBinContent(i))
            else:
                RespMat.SetBinContent(i,j,(-1)*RecoHist.GetBinContent(j))

    draw_opt = "colz text45"
    ROOT.gStyle.SetPaintTextFormat("3.2f"); 
    ROOT.gStyle.SetOptStat(0)
    labels={"ZZPt":"Pt_{4l} [GeV]","Mass":"m_{4l} [GeV]"}
    print(labels[var])
    RespMat.SetTitle("")
    RespMat.GetXaxis().SetTitle("Reco%s"% (labels[var]))
    RespMat.GetYaxis().SetTitle("True%s"% (labels[var]))
    
    RespMat.Draw(draw_opt)

    #text_box = getTextBox(obj, "(MC)")
    #text_box.Draw()

    
    canvas.Print("%s/matrix%s_%s.png" % (outdir, var, chan))
    canvas.Print("%s/matrix%s_%s.pdf" % (outdir, var, chan))

#histfile = ROOT.TFile.Open("/data/uhussain/ZZTo4l/ZZ2018/VVAnalysisTools/CMSSW_9_4_2/src/Analysis/VVAnalysis/HistFiles/Hists05Apr2019-zzPowhegWGen.root")


data_folder_name = datetime.date.today().strftime("ResponseMatrces_"+"%Y%b%d") 
mc_outdir = "~/www/ZZAnalysisData/PlottingResults/ZZ4l2018/Unfolding/" + data_folder_name

def mkdir(mc_outdir):
    for outdir in [mc_outdir]:
        try:
            os.makedirs(os.path.expanduser(outdir))
        except OSError as e:
            print(e)
            pass
hfile="Hists05Apr2019-zzPowhegWGen.root"
for channel in ["eeee","eemm","mmee","mmmm"]:
    OutputDir=mc_outdir+"/"+channel+"/plots"
    mkdir(OutputDir)
    for sample in ["zz4l-powheg"]:
        for var in ["ZZPt", "Mass"]:
            makeResponseMatrix(hfile,sample, var, OutputDir,channel)
makeSimpleHtml.writeHTML(os.path.expanduser(OutputDir.replace("/plots", "")), "2D ResponseMatrices (from MC)")
