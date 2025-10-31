#!/usr/bin/env python3
import ROOT
import argparse
import datetime
import os
from Utilities.scripts import makeSimpleHtml
import Utilities.helper_functions as helper
import array
import configparser

def getTGraphAsymmErrors(frfile, folder, param, obj):
    tight_hist = frfile.Get("%s/passingTight%s%s_all%s" % (folder, obj ,param, obj))
    loose_hist = frfile.Get("%s/passingLoose%s%s_all%s" % (folder, obj ,param, obj))
    tight_hist.SetTitle("")
    loose_hist.SetTitle("")
    graph = ROOT.TGraphAsymmErrors(tight_hist, loose_hist)
    ROOT.SetOwnership(graph, False)
    graph.SetMarkerStyle(6)
    if obj=="E":
        graph.SetMinimum(0.01)
        graph.SetMaximum(0.35) if "Pt" in param else graph.SetMaximum(0.1)
    else:
        graph.SetMinimum(0.04)
        graph.SetMaximum(0.35) if "Pt" in param else graph.SetMaximum(0.3)
    return graph

def getTGraphAsymmErrorsPt(frfile, folder, param, obj):
    tight_hist_barrel = frfile.Get("%s/passingTight%s%s_barrel_all%s" % (folder, obj, param, obj))
    loose_hist_barrel = frfile.Get("%s/passingLoose%s%s_barrel_all%s" % (folder, obj, param, obj))
    tight_hist_barrel.SetTitle("")
    loose_hist_barrel.SetTitle("")
    barrel = ROOT.TGraphAsymmErrors(tight_hist_barrel, loose_hist_barrel)
    ROOT.SetOwnership(barrel, False)
    barrel.SetMarkerStyle(6)
    barrel.SetLineColor(ROOT.kBlue)
    tight_hist_endcap = frfile.Get("%s/passingTight%s%s_endcap_all%s" % (folder, obj, param, obj))
    loose_hist_endcap = frfile.Get("%s/passingLoose%s%s_endcap_all%s" % (folder,obj, param, obj))
    tight_hist_endcap.SetTitle("")
    loose_hist_endcap.SetTitle("")
    endcap = ROOT.TGraphAsymmErrors(tight_hist_endcap, loose_hist_endcap)
    ROOT.SetOwnership(endcap, False)
    endcap.SetMarkerStyle(6)
    endcap.SetLineColor(ROOT.kRed)
    if obj=="E":
        barrel.SetMinimum(0.01)
        barrel.SetMaximum(0.35) if "Pt" in param else barrel.SetMaximum(0.1)
        endcap.SetMinimum(0.01)
        endcap.SetMaximum(0.35) if "Pt" in param else endcap.SetMaximum(0.1)
    else:
        barrel.SetMinimum(0.04)
        barrel.SetMaximum(0.35) if "Pt" in param else barrel.SetMaximum(0.3)
        endcap.SetMinimum(0.04)
        endcap.SetMaximum(0.35) if "Pt" in param else endcap.SetMaximum(0.3)
    return barrel,endcap

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
    texS = ROOT.TLatex(0.615,0.95,"#sqrt{s} = 13 TeV, 35.9 fb^{-1}")
    texS.SetNDC()
    texS.SetTextFont(42)
    texS.SetTextSize(0.040)
    texS.Draw()
    texS1 = ROOT.TLatex(0.15,0.95,"#bf{CMS} #it{Preliminary}")
    texS1.SetNDC()
    texS1.SetTextFont(42)
    texS1.SetTextSize(0.040)
    texS1.Draw()
    
    ROOT.SetOwnership(texS, False)
    ROOT.SetOwnership(texS1, False)
    return texS,texS1

def invert2DHist(hist,obj,isMC):
    name = hist.GetName() + ("MC" if isMC else "")
    if (obj=="E"):
        new_hist = ROOT.TH2D(name, hist.GetTitle(), 
                4, array.array('d',[0.,0.7395,1.479,2.0,2.5]),
                6, array.array('d', [5,10,20,30,40,50,80]))
        ROOT.SetOwnership(new_hist, False)
        for x in range(hist.GetNbinsX()+1):
            for y in range(hist.GetNbinsY()+1):
                value = hist.GetBinContent(x, y)
                new_hist.SetBinContent(y, x, value)
        new_hist.GetXaxis().SetTitle(hist.GetXaxis().GetTitle())
        new_hist.GetYaxis().SetTitle(hist.GetYaxis().GetTitle())
    elif (obj=="Mu"):
        new_hist = ROOT.TH2D(name, hist.GetTitle(), 
                2, array.array('d',[0.,1.2,2.4]),
                6, array.array('d', [5,10,20,30,40,50,80]))
        ROOT.SetOwnership(new_hist, False)
        for x in range(hist.GetNbinsX()+1):
            for y in range(hist.GetNbinsY()+1):
                value = hist.GetBinContent(x, y)
                new_hist.SetBinContent(y, x, value)
        new_hist.GetXaxis().SetTitle(hist.GetXaxis().GetTitle())
        new_hist.GetYaxis().SetTitle(hist.GetYaxis().GetTitle())
    return new_hist

def makePlots(frfile, param, obj, isMC):
    if "Pt" in param: 
        data_ewkcorr_barrel,data_ewkcorr_endcap = getTGraphAsymmErrorsPt(frfile, "DataEWKCorrected", param, obj) 
    elif "2D" in param:
        data_ewkcorr_graph = frfile.Get("DataEWKCorrected/ratio%s%s_all%s" % (obj,param, obj))
    else: 
        data_ewkcorr_graph = getTGraphAsymmErrors(frfile, "DataEWKCorrected", param, obj)
        data_ewkcorr_graph.SetLineColor(ROOT.kRed)
    draw_opt = "PA" if "2D" not in param else "colz text"
    if "2D" in param:
        data_ewkcorr_graph.SetTitle("")
        ROOT.gStyle.SetOptStat(0)
        data_ewkcorr_graph = invert2DHist(data_ewkcorr_graph,obj,isMC)
        #data_ewkcorr_graph.GetYaxis().SetTitle("#eta")
        data_ewkcorr_graph.GetYaxis().SetTitle("p_{T} [GeV]")
        data_ewkcorr_graph.GetXaxis().SetTitle("|#eta|")
        data_ewkcorr_graph.Draw(draw_opt)
    elif "Eta" in param:
        data_ewkcorr_graph.SetTitle("")
        data_ewkcorr_graph.GetYaxis().SetTitle("Passing Tight / Passing Loose")
        xlabel = "|#eta|"
        data_ewkcorr_graph.GetXaxis().SetTitle(xlabel)
        data_ewkcorr_graph.Draw(draw_opt)
    else:
        data_ewkcorr_barrel.SetTitle("")
        data_ewkcorr_barrel.SetLineStyle(2)
        data_ewkcorr_barrel.GetYaxis().SetTitle("Passing Tight / Passing Loose")
        xlabel = "p_{T} [GeV]" 
        data_ewkcorr_barrel.GetXaxis().SetTitle(xlabel)
        data_ewkcorr_barrel.Draw("PA")
        data_ewkcorr_endcap.SetLineStyle(2)
        data_ewkcorr_endcap.SetTitle("")
        data_ewkcorr_endcap.Draw("P")

    text_box = getTextBox(obj)
    text_box.Draw()
    #texS,texS1=getLumiTextBox()

    if (not "2D" in param) and ("Eta" in param):
        data_uncorr_graph = getTGraphAsymmErrors(frfile, "DYMC" if isMC else "AllData", param, obj)
        data_uncorr_graph.SetTitle("")
        data_uncorr_graph.Draw("P")

        legend = ROOT.TLegend(0.2,.80,.40,.70)
        ROOT.SetOwnership(legend, False)
        if isMC:
            legend.AddEntry(data_ewkcorr_graph, "Data - EWK", "l")
            legend.AddEntry(data_uncorr_graph, "DYJets (MC)", "l")
        else:
            legend.AddEntry(data_uncorr_graph, "Data", "l")
            legend.AddEntry(data_ewkcorr_graph, "Data - EWK", "l")
        legend.Draw()
    elif ("Pt" in param):
        data_uncorr_barrel,data_uncorr_endcap = getTGraphAsymmErrorsPt(frfile, "DYMC" if isMC else "AllData", param, obj)
        data_uncorr_barrel.SetTitle("")
        data_uncorr_barrel.Draw("P SAME")
        data_uncorr_endcap.SetTitle("")
        data_uncorr_endcap.Draw("P SAME")

        legend = ROOT.TLegend(0.2,.80,.40,.70)
        ROOT.SetOwnership(legend, False)
        uncorr  = "DYJets MC" if isMC else "uncorrected"
        ewkcorr = "Data-EWK"  if isMC else "corrected"
        if isMC:
            legend.AddEntry(data_ewkcorr_barrel, f"barrel {ewkcorr}", "l")
            legend.AddEntry(data_uncorr_barrel, f"barrel {uncorr}", "l")
            legend.AddEntry(data_ewkcorr_endcap, f"endcap {ewkcorr}", "l")
            legend.AddEntry(data_uncorr_endcap, f"endcap {uncorr}", "l")
        else:
            legend.AddEntry(data_uncorr_barrel, f"barrel {uncorr}", "l")
            legend.AddEntry(data_ewkcorr_barrel, f"barrel {ewkcorr}", "l")
            legend.AddEntry(data_uncorr_endcap, f"endcap {uncorr}", "l")
            legend.AddEntry(data_ewkcorr_endcap, f"endcap {ewkcorr}", "l")
        legend.Draw()

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-l", "--luminosity", type=float, help="Luminosity in fb-1.")
    parser.add_argument("-a", "--analysis", required=True, help="name of analysis (e.g. ZZ4l2022)")
    parser.add_argument("--thesis", action="store_true",
                        help="Write 'Thesis' in CMS style text")
    parser.add_argument("--preliminary", action="store_true",
                        help="Write 'Preliminary' in CMS style text")
    parser.add_argument("--simulation", action="store_true",
                        help="Write 'Simulation' in CMS style text")
    parser.add_argument("infile", help="input fake rate histogram file")
    args = parser.parse_args()

    lumi_text = []
    if args.thesis:
        lumi_text.append("Thesis")
    elif args.preliminary:
        lumi_text.append("Preliminary")
    if args.simulation:
        lumi_text.append("Simulation")

    # For compatibility with helper.savePlot
    args.output_file = ""
    args.no_html = False
    
    config_name = "Templates/config.%s" % os.getlogin()
    if not os.path.isfile(config_name):
        parser.error("Failed to find valid config file. Looking for %s" % config_name)
    config = configparser.ConfigParser()
    with open(config_name) as fconfig:
        config.read_file(fconfig)
    if "gituser" not in config['Setup']:
        parser.error("gituser not specified in config file %s" % config_name)
    ROOT.dotrootImport('%s/CMSPlotDecorations' % config["Setup"]["gituser"])

    ROOT.gROOT.SetBatch(True)
    canvas = ROOT.TCanvas("canvas", "canvas")

    with ROOT.TFile.Open(args.infile) as frfile:
        for group in ["Data", "MC"]:
            plot_path, html_path = helper.getPlotPaths(f"{args.analysis}/FakeRates", group, True)
            for param in ["1DPt", "1DEta", "2D"]:
                for obj in ["E", "Mu"]:
                    plot_name = f"ratio{param}_all{obj}"
                    print(f"\n{plot_name}")

                    makePlots(frfile, param, obj, group == "MC")
                    ROOT.CMSlumi(canvas, 0, 0, "%.1f fb^{-1} (13.6 TeV)" % args.luminosity, " ".join(lumi_text))

                    helper.savePlot(canvas, plot_path, html_path, plot_name, False, args)
                    makeSimpleHtml.writeHTML(html_path.replace("/plots",""), f"Fake Rates (from {group})")

if __name__ == "__main__":
    main()
