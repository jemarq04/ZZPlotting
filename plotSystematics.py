#!/usr/bin/env python3
import array
import configparser
import json
import os
import sys
import ROOT
from Utilities.ConfigHistFactory import ConfigHistFactory
import Utilities.UserInput as UserInput
import Utilities.helper_functions as helper
import Utilities.plot_functions as plotter
from Utilities.scripts import makeSimpleHtml

with open("Templates/config.%s" % os.getlogin()) as fconfig:
    config = configparser.ConfigParser()
    config.read_file(fconfig)
    sys.path.insert(0, config["Setup"]["scriptPath"].replace("$CMSSW_BASE", os.environ["CMSSW_BASE"]))
import ConfigureJobs
import HistTools


def getComLineArgs():
    parser = UserInput.getDefaultParser()
    parser.add_argument("-s", "--selection", type=str, required=True, help="Specificy selection level to run over")
    parser.add_argument(
        "-b",
        "--branches",
        type=lambda val: [x.strip() for x in val.split(",")],
        default=["Mass"],
        help="List (separate by commas) of names of branches in root and config file to plot",
    )
    parser.add_argument("-g", "--group", default="qqZZ-powheg", help="name of plot group or sample to draw with variations")
    parser.add_argument(
        "-S",
        "--systematics",
        required=True,
        type=lambda val: [x.strip() for x in val.split(",")],
        help="name of systematic systematic to draw",
    )
    parser.add_argument("-y", "--year", required=True, help="year for analysis")
    return parser.parse_args()


def savePlotWithRatio(oldcanvas, dimensions, ratio_text, ratio_range, plot_path, html_path, plot_name, args):
    stacks = [p for p in oldcanvas.GetListOfPrimitives() if type(p) is ROOT.THStack]
    stack_hists = [i for s in stacks for i in s.GetHists()]

    do_error = False  # disabled for now, not working
    if do_error:
        ROOT.gStyle.SetHatchesLineWidth(1)
        ROOT.gStyle.SetHatchesSpacing(0.75)
        for hist in stacks[0].GetHists():
            error_hist = hist.Clone(f"{hist.GetName()}_errors")
            if not error_hist.GetSumw2():
                error_hist.Sumw2()
            error_hist.SetMarkerSize(0)
            error_hist.SetFillStyle(3345)
            error_hist.SetFillColor(hist.GetLineColor())
            error_hist.SetLineColor(hist.GetLineColor())
            error_hist.SetLineWidth(1)
            error_hist.Draw("same e2")

    name = oldcanvas.GetName()
    canvas = ROOT.TCanvas(f"{name}__new", name, *dimensions)

    ratioPad = ROOT.TPad("ratioPad", "ratioPad", 0.0, 0.0, 1.0, 0.3)
    ratioPad.Draw()

    stackPad = ROOT.TPad("stackPad", "stackPad", 0.0, 0.3, 1.0, 1.0)
    stackPad.Draw()

    stackPad.cd()
    oldcanvas.DrawClonePad()
    oldcanvas.Close()
    canvas.SetName(name)

    oldBottomMargin = stackPad.GetBottomMargin()
    stackPad.SetBottomMargin(0.0)
    ratioPad.cd()
    ratioPad.SetBottomMargin(oldBottomMargin / 0.3)
    ratioPad.SetTopMargin(0.05)

    ratio_hists = [h.Clone(f"{h.GetName()}_ratio_hist") for h in stack_hists[1:]]
    central_ratio_hist = stack_hists[0].Clone(f"{name}_central_ratio_hist")
    central_ratio_hist.SetFillColor(ROOT.TColor.GetColor("#828282"))
    central_ratio_hist.SetFillStyle(3345)
    central_ratio_hist.SetFillColorAlpha(0, 0.0)
    central_ratio_hist.SetMarkerSize(0)
    central_hist = central_ratio_hist.Clone("temp")

    for ratio_hist in ratio_hists:
        ratio_temp = ratio_hist.Clone("ratio_temp")
        ratio_hist.Divide(central_hist)
        for i in range(ratio_hist.GetNbinsX() + 2):
            denom = ratio_temp.GetBinContent(i)
            if denom == 0:
                continue
            ratio_hist.SetBinError(i, ratio_temp.GetBinError(i) / denom)
        ratio_hist.Sumw2()
        del ratio_temp
    for i in range(central_ratio_hist.GetNbinsX() + 2):
        denom = central_hist.GetBinContent(i)
        if denom == 0:
            continue
        central_ratio_hist.SetBinError(i, central_hist.GetBinError(i) / denom)
        central_ratio_hist.SetBinContent(i, 1.0)

    central_ratio_hist.GetYaxis().SetTitle(ratio_text)
    central_ratio_hist.GetYaxis().SetTitleOffset(1)
    central_ratio_hist.GetXaxis().SetLabelOffset(0.03)
    central_ratio_hist.GetYaxis().CenterTitle()
    central_ratio_hist.GetYaxis().SetRangeUser(*ratio_range)
    central_ratio_hist.GetYaxis().SetNdivisions(3)
    central_ratio_hist.GetYaxis().SetTitleSize(central_ratio_hist.GetYaxis().GetTitleSize() * 0.8)
    central_ratio_hist.GetYaxis().SetLabelSize(central_ratio_hist.GetYaxis().GetLabelSize() * 0.8)
    central_ratio_hist.Draw("E2")

    for ratio_hist in ratio_hists:
        ratio_hist.SetMarkerSize(0)
        ratio_hist.SetMarkerColor(ratio_hist.GetLineColor())
        ratio_hist.SetFillColor(ratio_hist.GetLineColor())
        ratio_hist.SetLineStyle(1)
        ratio_hist.Draw("same")

    xaxis = central_ratio_hist.GetXaxis()
    line = ROOT.TLine(xaxis.GetBinLowEdge(xaxis.GetFirst()), 1, xaxis.GetBinUpEdge(xaxis.GetLast()), 1)
    line.SetLineStyle(ROOT.kDotted)
    line.Draw()

    isLong = stackPad.GetWw() / stackPad.GetWh() > 1.1
    plotter.recursePrimitives(stackPad, plotter.fixFontSize, 1 / 0.7)
    stackPad.Modified()
    plotter.recursePrimitives(ratioPad, plotter.fixFontSize, 1 / 0.27, 0.85 if isLong else 1.15)
    ratioPad.Modified()
    canvas.Update()

    ratioPad.RedrawAxis()
    for p in [p for p in ratioPad.GetListOfPrimitives() if type(p) is ROOT.TPaveText]:
        p.Clear()
    canvas.cd()
    canvas.Update()

    helper.savePlot(canvas, plot_path, html_path, plot_name, False, args)
    return canvas


def main():
    args = getComLineArgs()

    print(f"{args.selection}: {args.systematics}")
    print(f"Using input file {args.hist_file}")

    manager_path = ConfigureJobs.getManagerPath()
    manager_name = ConfigureJobs.getManagerName()

    if args.luminosity == -1:
        args.luminosity = ConfigureJobs.getLuminosity(args.year, manager_path=manager_path)

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

    groupname = args.group
    samples = [args.group]
    with open(os.path.join(manager_path, manager_name, "PlotGroups", f"{args.selection.split('/')[0]}.json")) as infile:
        info = json.load(infile)
        if args.group in info:
            samples = info[args.group]["Members"]
        else:
            groupname = [name for name in info if args.group in info[name]["Members"]][0]

    config_name = "Templates/config.%s" % os.getlogin()
    config = configparser.ConfigParser()
    with open(config_name) as fconfig:
        config.read_file(fconfig)
    ROOT.dotrootImport("%s/CMSPlotDecorations" % config["Setup"]["gituser"])

    try:
        config_factory = ConfigHistFactory(f"{manager_path}/{manager_name}", args.selection.split("_")[0])
    except FileNotFoundError:
        config_factory = ConfigHistFactory(
            f"{manager_path}/{manager_name}", f"{args.selection.split('/')[0]}/ZZSelectionsTightLeps"
        )

    ROOT.gROOT.SetBatch(True)
    ROOT.gStyle.SetLegendBorderSize(0)
    ROOT.gStyle.SetOptStat(0)
    ROOT.gStyle.SetLineWidth(3)

    with ROOT.TFile.Open(args.hist_file) as infile:
        for branch in args.branches:
            for systematic in args.systematics:
                channels = ["eeee", "eemm", "mmee", "mmmm"]
                plotnames = ["_".join([branch, chan]) for chan in channels]
                plotnames += ["_".join([branch, systematic + var, chan]) for var in ["Up", "Down"] for chan in channels]

                group, _ = HistTools.makeCompositeHists(
                    infile,
                    groupname,
                    ConfigureJobs.getListOfFilesWithXSec(samples, manager_path),
                    args.luminosity,
                    hists=plotnames,
                    rebin=array.array("d", args.rebin) if args.rebin else None,
                )

                for histname in plotnames:
                    if not histname.endswith(channels[0]):
                        continue
                    basename = "_".join(histname.split("_")[:-1])
                    hsum = group.FindObject(histname).Clone(f"{basename}_all")
                    for chan in channels[1:]:
                        hsum.Add(group.FindObject(f"{basename}_{chan}"))
                    group.Add(hsum)

                    hsum_2e2m = group.FindObject(f"{basename}_eemm").Clone(f"{basename}_2e2m")
                    hsum_2e2m.Add(group.FindObject(f"{basename}_mmee"))
                    group.Add(hsum_2e2m)

                channels += ["2e2m", "all"]
                plot_name = f"{branch}_{systematic}"
                for chan in channels:
                    print(f"Plotting {chan}...")
                    folder_name = f"{args.folder_name}/{chan}" if chan != "all" else args.folder_name
                    plot_path, html_path = helper.getPlotPaths(args.selection, folder_name, False)

                    hist = group.FindObject("_".join([branch, chan]))
                    histUp = group.FindObject("_".join([branch, systematic + "Up", chan]))
                    histDown = group.FindObject("_".join([branch, systematic + "Down", chan]))

                    config_factory.setHistAttributes(hist, branch, groupname)
                    config_factory.setHistAttributes(histUp, branch, groupname)
                    config_factory.setHistAttributes(histDown, branch, groupname)
                    hist.SetFillColor(0)
                    histUp.SetFillColor(0)
                    histDown.SetFillColor(0)

                    hist.SetLineStyle(1)
                    histUp.SetLineStyle(5)
                    histDown.SetLineStyle(5)
                    hist.SetLineWidth(2)
                    histUp.SetLineWidth(2)
                    histDown.SetLineWidth(2)

                    canvasDimensions = [800, 800]
                    canvas = ROOT.TCanvas(f"canvas_{chan}", "canvas", *canvasDimensions)

                    # legend coordinates
                    offset = ROOT.gPad.GetRightMargin() - 0.04
                    width = 0.2 * args.scalelegx
                    xdist = 0.91
                    xcoords = [xdist - width - offset, xdist - offset]
                    ymax = 0.8
                    ycoords = [ymax, ymax - 0.16 * args.scalelegy]
                    coords = [xcoords[0], ycoords[0], xcoords[1], ycoords[1]]

                    stack = ROOT.THStack(f"stack_{plot_name}_{chan}", "")
                    stack.Add(hist)
                    stack.Add(histUp)
                    stack.Add(histDown)
                    stack.Draw("nostack hist")

                    stack.GetYaxis().SetTitleSize(hist.GetYaxis().GetTitleSize())
                    stack.GetYaxis().SetTitleOffset(hist.GetYaxis().GetTitleOffset())
                    stack.GetYaxis().SetTitle(hist.GetYaxis().GetTitle())
                    if hist.GetMinimum() == 0.0:
                        stack.GetYaxis().ChangeLabel(1, -1.0, 0)
                    stack.GetHistogram().GetXaxis().SetTitle(hist.GetXaxis().GetTitle())
                    stack.GetHistogram().SetLabelSize(0.04)
                    stack.SetMinimum(hist.GetMinimum() * args.scaleymin)
                    stack.SetMaximum(max([x.GetMaximum() for x in stack.GetHists()]) * args.scaleymax)
                    stack.GetHistogram().GetYaxis().SetTitleOffset(1.05)

                    legend = ROOT.TLegend(*coords)
                    legend.AddEntry(hist, args.group, "l")
                    legend.AddEntry(histUp, systematic, "l")
                    legend.Draw()
                    ROOT.CMSlumi(canvas, 0, 0, f"{args.luminosity:.1f} fb^{{-1}} (13.6 TeV)", " ".join(lumi_text))

                    canvas = savePlotWithRatio(
                        canvas,
                        canvasDimensions,
                        "#scale[0.85]{syst. / cent.}",
                        [0.9, 1.1],
                        plot_path,
                        html_path,
                        plot_name,
                        args,
                    )

                    makeSimpleHtml.writeHTML(
                        html_path.replace("/plots", ""), f"Systematic Variations on {args.group}", latest=plot_name
                    )

                    canvas.Close()

                del group

    print("Done.")


if __name__ == "__main__":
    main()
