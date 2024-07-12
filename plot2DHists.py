#!/usr/bin/env python3
import ROOT
import datetime
import os
import array
from Utilities.scripts import makeSimpleHtml

ROOT.gROOT.SetBatch(True)
canvas = ROOT.TCanvas("canvas", "canvas")

def getTGraphAsymmErrors(frfile, folder, param, obj):
    tight_hist = frfile.Get("%s/passingTight%s_all%s" % (folder, param, obj))
    loose_hist = frfile.Get("%s/passingLoose%s_all%s" % (folder, param, obj))
    tight_hist.SetTitle("")
    loose_hist.SetTitle("")
    graph = ROOT.TGraphAsymmErrors(tight_hist, loose_hist)
    graph.SetMarkerStyle(6)
    if obj=="E":
        graph.SetMinimum(0)
        graph.SetMaximum(0.16) if "Pt" in param else graph.SetMaximum(0.1)
    else:
        graph.SetMinimum(0)
        graph.SetMaximum(0.4) if "Pt" in param else graph.SetMaximum(0.3)
    return graph

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
    texS1 = ROOT.TLatex(0.15,0.95,"#bf{UW} #it{Internal}")
    texS1.SetNDC()
    texS1.SetTextFont(42)
    texS1.SetTextSize(0.040)
    texS1.Draw()
    return texS,texS1

def invert2DHist(hist):
    new_hist = ROOT.TH2D(hist.GetName(), hist.GetTitle(), 
            4, 0, 2.5,
            8, array.array('d', [5,10,20,30,40,50,60,70,200]))
    ROOT.SetOwnership(new_hist, False)
    for x in range(hist.GetNbinsX()+1):
        for y in range(hist.GetNbinsY()+1):
            value = hist.GetBinContent(x, y)
            new_hist.SetBinContent(y, x, value)
    new_hist.GetXaxis().SetTitle(hist.GetXaxis().GetTitle())
    new_hist.GetYaxis().SetTitle(hist.GetYaxis().GetTitle())
    return new_hist

def makeDataPlots(param, obj, outdir,chan):
    data_ewkcorr_graph = frfile.Get("AllData/%slep1_%slep2_%s_%s" % (param[:2],param[:2], obj,chan)) \
        if "2D" in param else getTGraphAsymmErrors(frfile, "AllData", param, obj)
    data_ewkcorr_graph.SetLineColor(ROOT.kRed)
    #draw_opt = "PA" if "2D" not in param else "colz text"
    draw_opt = "PA" if "2D" not in param else "scat"
    if "2D" in param:
        data_ewkcorr_graph.SetTitle("")
        ROOT.gStyle.SetOptStat(0)
        #data_ewkcorr_graph = invert2DHist(data_ewkcorr_graph)
        #data_ewkcorr_graph.GetYaxis().SetTitle("#eta")
        labels={"Pt":"p_{T} [GeV]","Eta":"#eta","Phi":"#phi"}
        print(labels[obj])
        data_ewkcorr_graph.GetXaxis().SetTitle("%s_{l1} %s"% (param[:2],labels[obj]))
        data_ewkcorr_graph.GetYaxis().SetTitle("%s_{l2} %s"% (param[:2],labels[obj]))
    else:
        data_ewkcorr_graph.SetTitle("")
        data_ewkcorr_graph.GetYaxis().SetTitle("Passing Tight / Passing Loose")
        xlabel = "p_{T} [GeV]" if "Pt" in param else "|#eta|"
        data_ewkcorr_graph.GetXaxis().SetTitle(xlabel)
    data_ewkcorr_graph.Draw(draw_opt)

    #text_box = getTextBox(obj)
    #text_box.Draw()
    texS,texS1=getLumiTextBox()

    if not "2D" in param:
        data_uncorr_graph = getTGraphAsymmErrors(frfile, "AllData", param, obj)
        data_uncorr_graph.SetTitle("")
        data_uncorr_graph.Draw("P")

        legend = ROOT.TLegend(0.2,.80,.40,.70)
        legend.AddEntry(data_uncorr_graph, "Data", "l")
        legend.AddEntry(data_ewkcorr_graph, "Data - EWK", "l")
        legend.Draw()

    canvas.Print("%s/%slep1_%slep2_%s.png" % (outdir, param[:2],param[:2], obj))
    canvas.Print("%s/%slep1_%slep2_%s.pdf" % (outdir, param[:2],param[:2], obj))

def makeMCPlots(param, obj, outdir):
    graph = frfile.Get("DYMC/ratio%s_all%s" % (param, obj)) \
        if "2D" in param else getTGraphAsymmErrors(frfile, "DYMC", param, obj)
    graph.SetLineColor(ROOT.kRed)
    draw_opt = "PA" if "2D" not in param else "colz text"
    if "2D" in param:
        graph.GetYaxis().SetTitle("|#eta|")
    else:
        graph.GetYaxis().SetTitle("Passing Tight / Passing Loose")
        xlabel = "p_{T} [GeV]" if "Pt" in param else "|#eta|"
        graph.GetXaxis().SetTitle(xlabel)
    graph.Draw(draw_opt)

    text_box = getTextBox(obj, "(MC)")
    text_box.Draw()

    if not "2D" in param:
        #In order to compare data-ewk with DY
        data_ewkcorr_graph=getTGraphAsymmErrors(frfile, "DataEWKCorrected", param, obj) 
        data_ewkcorr_graph.SetLineColor(ROOT.kBlue)
        data_ewkcorr_graph.SetTitle("")
        data_ewkcorr_graph.Draw("P")
        legend = ROOT.TLegend(0.2,.80,.40,.70)
        legend.AddEntry(data_ewkcorr_graph, "Data - EWK", "l")
        legend.AddEntry(graph, "DYJets MC", "l")
        legend.Draw()

    
    canvas.Print("%s/ratio%s_all%s.png" % (outdir, param, obj))
    canvas.Print("%s/ratio%s_all%s.pdf" % (outdir, param, obj))

frfile = ROOT.TFile("/data/uhussain/ZZTo4l/ZZ2018/VVAnalysisTools/CMSSW_9_4_2/src/Analysis/VVAnalysis/HistFiles/Hists29Nov2018-MuonTest.root")


data_folder_name = datetime.date.today().strftime("%Y%b%d"+"_2DHists") 
data_outdir = "~/www/ZZAnalysisData/PlottingResults/ZZ4l2018/HZZSelectionsTightLeps/" + data_folder_name
#mc_outdir = "~/www/ZZAnalysisData/PlottingResults/ZZ4l2018/HZZSelectionsTightLeps/" + data_folder_name + "-MC/plots"

def mkdir(data_outdir):
    for outdir in [data_outdir]:
        try:
            os.makedirs(os.path.expanduser(outdir))
        except OSError as e:
            print(e)
            pass
for channel in ["eeee","eemm","mmee","mmmm"]:
    OutputDir=data_outdir+"/"+channel+"/plots"
    mkdir(OutputDir)
    for param in ["Z12D", "Z22D"]:
#for param in ["1DPt", "1DEta"]:
        for obj in ["Pt", "Eta","Phi"]:
            makeDataPlots(param, obj, OutputDir,channel)
        #makeMCPlots(param, obj, mc_outdir)
makeSimpleHtml.writeHTML(os.path.expanduser(OutputDir.replace("/plots", "")), "2D Plots (from data)")
#makeSimpleHtml.writeHTML(os.path.expanduser(mc_outdir.replace("/plots", "")), "2D Plots (from MC)")
