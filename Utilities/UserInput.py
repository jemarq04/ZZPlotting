import json
import glob
import argparse

def readAllJson(json_file_path):
    json_info = {}
    for json_file in glob.glob(json_file_path):
        json_info.update(readJson(json_file))
    return json_info
def readJson(json_file_name):
    json_info = {}
    with open(json_file_name) as json_file:
        try:
            json_info = json.load(json_file)
        except ValueError as err:
            print("Error reading JSON file %s. The error message was:" % json_file_name) 
            print(err)
    return json_info

def getDefaultParser():
    parser = argparse.ArgumentParser()
    parser.add_argument("-o", "--output_file", type=str, default="",
                        help="Name of file to be created (type pdf/png etc.) " \
                        "Note: Leave unspecified for auto naming")
    parser.add_argument("--hist_file", type=str, default="",
                        help="Read histograms from file")
    parser.add_argument("--stat_file", type=str, default="",
                        help="Read histograms from file")
    parser.add_argument("--rebin", type=lambda x: [float(i) for i in x.split(",")], default=None,
                        help="list of comma-separated floats for hist rebinning")
    parser.add_argument("--legend_left", action="store_true",
                        help="Put legend left or right")
    parser.add_argument("--folder_name", type=str, default="",
                        help="Folder name to save plots in (default is current time)")
    parser.add_argument("--ratio_text", default="",type=str, 
                        help="Ratio text")
    parser.add_argument("--scaleymax", type=float, default=1.0,
                        help="Scale default ymax by this amount")
    parser.add_argument("--scaleymin", type=float, default=1.0,
                        help="Scale default ymin by this amount")
    parser.add_argument("--scalelegy", type=float, default=1.0,
                        help="Scale default legend entry size by this amount")
    parser.add_argument("--scalelegx", type=float, default=1.0,
                        help="Scale default legend entry wdith by this amount")
    parser.add_argument("--ratio_range", nargs=2, default=[0.4,1.6],
                        help="Ratio min ratio max (default 0.5 1.5)")
    parser.add_argument("--scalexmax", type=float, default=1.0,
                        help="Scale default xmax by this amount")
    parser.add_argument("--extra_text", type=str, default="",
                        help="Extra text to be added below (above) the legend")
    parser.add_argument("--extra_text_above", action='store_true',
                        help="Position extra text above the legend")
    parser.add_argument("--simulation", action='store_true',
                        help="Write 'Simulation' in CMS style text")
    parser.add_argument("--thesis", action='store_true',
                        help="Write 'Thesis' in CMS style text")
    parser.add_argument("--preliminary", action='store_true',
                        help="Write 'Preliminary' in CMS style text")
    parser.add_argument("--no_overflow", action='store_true',
                        help="No overflow bin")
    parser.add_argument("-u", "--uncertainties", type=str, default="all",
                        choices=["all", "stat", "scale", "none"],
                        help="Include error bands for specfied uncertainties")
    parser.add_argument("-l", "--luminosity", type=float, default=-1,
                        help="Luminsoity in fb-1. Default 1 fb-1. "
                        "Set to -1 for unit normalization")
    parser.add_argument("--nostack", action='store_true',
                        help="Don't stack hists")
    parser.add_argument("--stack_signal", action='store_true',
                        help="Stack signal hists on top of background")
    parser.add_argument("--exclude_from_sigstack", type=str,
                        help="backgrounds to exclude when making signal stacks."
                        " Names separated by commas")
    parser.add_argument("--no_ratio", action="store_true",
                        help="Do not add ratio comparison")
    parser.add_argument("--no_html", action='store_true',
                        help="Don't copy plot pdfs to website")
    parser.add_argument("--no_data", action='store_true',
                        help="Plot only Monte Carlo")
    parser.add_argument("--no_decorations", action='store_true',
                        help="Don't add CMS plot decorations")
    parser.add_argument("--logy", action='store_true',
                        help="Use logaritmic scale on Y-axis")
    parser.add_argument("--logx", action='store_true',
                        help="Use logaritmic scale on X-axis")
    parser.add_argument("-c", "--channels", type=str, default="eeee,eemm,mmee,mmmm",
                        help="List (separate by commas) of channels to plot") 
    parser.add_argument("--no_scalefactors", action='store_true',
                        help="No scale factors")
    parser.add_argument("-f", "--files_to_plot", type=str, required=False,
                        default="ZZ4l2018", help="Files to make plots from, "
                        "separated by a comma (match name in file_info.json)")
    parser.add_argument("-a", "--append_to_name", type=str, default="",
                        help="Name plot as <branch_name>_<append_to_name>")
    parser.add_argument("--signal_files", type=str, required=False,
                        default="", help="Files to make plots "
                        "signal plots from i.e. on top, not stacked. List "
                        "separated by a comma (match name in file_info.json)")
    return parser 
def getListOfFiles(file_set, selection):
    filelist = []
    for files in [x.strip() for x in file_set.split(",")]:
        fileset_nc = files.lower()
        if "zz4l2018" in fileset_nc and "ul" not in fileset_nc:
            if "nonprompt" in fileset_nc:
                filelist.append("HZZ-signal")
                filelist.append("nonprompt")
                filelist.append("VVV")
                filelist.append("qqZZ-powheg")
                filelist.append("ggZZ")
                filelist.append("zzjj4l-ewk")
            else:
                if "dyjets-nlo" in fileset_nc:
                    drellyan = "dyjets_nlo"
                elif "dylo" in fileset_nc:
                    drellyan = "dy-lo"
                else:
                    drellyan = "dy-jets"
                filelist.append("ggZZ")
                filelist.append("qqZZ-powheg")
                filelist.append("wz3lnu-amcnlo")
                filelist.append("top")
                filelist.append(drellyan)
            #if "nonprompt" in fileset_nc:
            #    filelist.append("HZZ-signal")
            #    #filelist.append("nonprompt")
        elif "zz4l2019" in fileset_nc:
            if "nonprompt" in fileset_nc:
                filelist.append("HZZ-signal")
                filelist.append("VVV")
                filelist.append("nonprompt")
                filelist.append("ggZZ")
                filelist.append("qqZZ-powheg")
            else:
                if "dyjets-nlo" in fileset_nc:
                    drellyan = "dyjets_nlo"
                elif "dylo" in fileset_nc:
                    drellyan = "dy-lo"
                else:
                    drellyan = "dy-jets"
                filelist.append("ggZZ")
                filelist.append("qqZZ-powheg")
                #filelist.append("wz3lnu-amcnlo")
                filelist.append("wz3lnu-powheg")#New Ntupples has powheg sample
                filelist.append("top")
                filelist.append(drellyan)
                #filelist.append("wz3lnu-amcnlo")
                #filelist.append("top")
                #filelist.append(drellyan)
            #if "nonprompt" in fileset_nc:
            #    filelist.append("HZZ-signal")
            #    #filelist.append("nonprompt")
        elif "jetplot" in fileset_nc:
                #print("Data only")
                filelist.append("nonprompt")
                filelist.append("VVV")
                #filelist.append("ggZZSpecg")
                #filelist.append("ggZZSpecgH")
                filelist.append("zzjj4l-ewk") #EWK
                filelist.append("ggZZ")
                #filelist.append("qqZZSpecg")
                filelist.append("qqZZ-amcnlo")
                #filelist.append("qqZZ-powheg")
                #filelist.append("HZZ-signal")
                #filelist.append("ggHZZ-only")
                #filelist.append("ggZZ")
                #filelist.append("GGZZ")
                #filelist.append("zzjj4l-ewk") #EWK
                #filelist.append("EWK-Extra4lg")
                #filelist.append("EWK-Extra2e2mujjg")
        elif "zz4l2018ul" in fileset_nc:
            filelist.append("ggZZ")
            filelist.append("qqZZ-powheg")
        elif "zzeft" in fileset_nc:
                draw_all = "all" in fileset_nc
                #Backgrounds
                if "nobkg" not in fileset_nc:
                    filelist.append("nonprompt")
                    filelist.append("VVV")
                    filelist.append("ggZZ")
                #qqZZ
                if "def" in fileset_nc:
                    for param in ["cHWB", "cHG", "cll1"]:
                        for i in range(10):
                            if draw_all and param.lower() in fileset_nc:
                                filelist.append("ZZEFT_%s%s" % (param,i))
                            elif "%s%s" % (param.lower(), i) in fileset_nc:
                                filelist.append("ZZEFT_%s%s" % (param,i))
                    if draw_all or "smlimit" in fileset_nc:
                        filelist.append("ZZEFT_SMlimit")
                else:
                    if "smfull" in fileset_nc:
                        filelist.append("ZZEFT_SMfull") #SM w/o EFT model
                    for param in ["SMlimit", "cHWB", "cHG", "cll1"]:
                        if draw_all or param.lower() in fileset_nc:
                            filelist.append("ZZEFT_%s" % param)
                    if "qqz0z0" in fileset_nc:
                        filelist.append("qqZ0Z0");
                    if "qqztzt" in fileset_nc:
                        filelist.append("qqZTZT");
        else:
            filelist.append(files)
    return filelist
