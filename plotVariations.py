#!/usr/bin/env python3
import argparse
import array
import configparser
import json
import os
import sys
import ROOT
import Utilities.helper_functions as helper
from Utilities.scripts import makeSimpleHtml

with open("Templates/config.%s" % os.getlogin()) as fconfig:
    config = configparser.ConfigParser()
    config.read_file(fconfig)
    sys.path.insert(0, config["Setup"]["scriptPath"].replace("$CMSSW_BASE", os.environ["CMSSW_BASE"]))
import ConfigureJobs
import HistTools


def main():
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-l", "--luminosity", type=float, help="Luminosity in fb-1")
    parser.add_argument("-s", "--sample", default="qqZZ-powheg", help="name of plot group to draw with variations")
    parser.add_argument(
        "--rebin",
        type=lambda val: [float(x) for x in val.split(",")],
        default=[],
        help="list of comma-separated floats for hist rebinning",
    )
    parser.add_argument("-v", "--variable", default="Mass", help="name of variable to plot")
    parser.add_argument(
        "-S",
        "--systematics",
        required=True,
        type=lambda val: [x.strip() for x in val.split(",")],
        help="name of systematic systematic to draw",
    )
    parser.add_argument("-a", "--analysis", required=True, help="name of analysis (e.g. ZZ4l2022)")
    parser.add_argument("-y", "--year", required=True, help="year of analysis")
    parser.add_argument("--title", help="title to set for histogram before plotting")
    parser.add_argument("--thesis", action="store_true", help="Write 'Thesis' in CMS style text")
    parser.add_argument("--preliminary", action="store_true", help="Write 'Preliminary' in CMS style text")
    parser.add_argument("--simulation", action="store_true", help="Write 'Simulation' in CMS style text")
    parser.add_argument("--folder_name", type=str, default="output", help="folder name to save plots in")
    parser.add_argument("infile", help="input histogram file")
    args = parser.parse_args()

    print(f"{args.analysis}{args.systematics}: Using input file {args.infile}")

    manager_path = ConfigureJobs.getManagerPath()

    if args.luminosity is None:
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

    samples = [args.sample]
    with open(
        os.path.join(manager_path, ConfigureJobs.getManagerName(), "PlotGroups", f"{args.analysis}.json")
    ) as infile:
        info = json.load(infile)
        if args.sample in info:
            samples = info[args.sample]["Members"]

    config_name = "Templates/config.%s" % os.getlogin()
    if not os.path.isfile(config_name):
        parser.error("Failed to find valid config file. Looking for %s" % config_name)
    config = configparser.ConfigParser()
    with open(config_name) as fconfig:
        config.read_file(fconfig)
    if "gituser" not in config["Setup"]:
        parser.error("gituser not specified in config file %s" % config_name)
    ROOT.dotrootImport("%s/CMSPlotDecorations" % config["Setup"]["gituser"])

    ROOT.gROOT.SetBatch(True)
    ROOT.gStyle.SetLegendBorderSize(0)
    ROOT.gStyle.SetOptStat(0)
    canvas = ROOT.TCanvas("canvas", "canvas")

    # legend coordinates
    offset = ROOT.gPad.GetRightMargin() - 0.04
    width = 0.2
    xdist = 0.91
    xcoords = [xdist - width - offset, xdist - offset]
    ymax = 0.8
    ycoords = [ymax, ymax - 0.16]
    coords = [xcoords[0], ycoords[0], xcoords[1], ycoords[1]]

    with ROOT.TFile.Open(args.infile) as infile:
        for systematic in args.systematics:
            channels = ["eeee", "eemm", "mmee", "mmmm"]
            plotnames = ["_".join([args.variable, chan]) for chan in channels]
            plotnames += [
                "_".join([args.variable, systematic + var, chan]) for var in ["Up", "Down"] for chan in channels
            ]

            group, _ = HistTools.makeCompositeHists(
                infile,
                args.sample,
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
            plot_name = f"{args.variable}_{systematic}"
            for chan in channels:
                print(f"Plotting {chan}...")
                folder_name = f"{args.folder_name}/{chan}" if chan != "all" else args.folder_name
                plot_path, html_path = helper.getPlotPaths(f"{args.analysis}/SystematicVariations", folder_name, False)

                hist = group.FindObject("_".join([args.variable, chan]))
                histUp = group.FindObject("_".join([args.variable, systematic + "Up", chan]))
                histDown = group.FindObject("_".join([args.variable, systematic + "Down", chan]))

                histUp.SetLineStyle(2)
                histDown.SetLineStyle(2)

                if args.title is not None:
                    hist.SetTitle(args.title)
                hist.Draw("HIST")
                histUp.Draw("HIST SAME")
                histDown.Draw("HIST SAME")
                ROOT.CMSlumi(canvas, 0, 0, f"{args.luminosity:.1f} fb^{{-1}} (13.6 TeV)", " ".join(lumi_text))

                legend = ROOT.TLegend(*coords)
                legend.AddEntry(hist, args.sample, "l")
                legend.AddEntry(histUp, systematic, "l")
                legend.Draw()

                helper.savePlot(canvas, plot_path, html_path, plot_name, False, args)

                makeSimpleHtml.writeHTML(
                    html_path.replace("/plots", ""), f"Systematic Variations on {args.sample}", latest=plot_name
                )

            del group

    canvas.Close()
    print("Done.")


if __name__ == "__main__":
    main()
