#!/usr/bin/env python3
import argparse
import os,sys
import json
import ROOT

import configparser
with open("Templates/config.%s" % os.getlogin()) as fconfig:
    config = configparser.ConfigParser()
    config.read_file(fconfig)
    sys.path.insert(0,config["Setup"]["scriptPath"])
import ConfigureJobs

def main():
    DESC = ""
    parser = argparse.ArgumentParser(description=DESC, formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("--precision", type=int, default=3, help="precision of float weight IDs")
    parser.add_argument("-a", "--analysis", type=str, required=True, help="Specific analysis directory to read")
    parser.add_argument("sample", type=str, help="sample to find weight IDs")
    args = parser.parse_args()
    
    manager_path = os.path.join(ConfigureJobs.getManagerPath(), ConfigureJobs.getManagerName())
    data_path = os.path.join(manager_path, "FileInfo", args.analysis)
    if not os.path.isdir(manager_path):
        parser.error("invalid manager path: %s" % manager_path)
    elif not os.path.isdir(data_path):
        parser.error("invalid analysis: %s" % args.analysis)
    elif not os.path.isfile(os.path.join(data_path, "ntuples.json")):
        parser.error("error finding JSON file: ntuples.json")
    if args.precision <= 0:
        parser.error("invalid precision value. must be >0")

    print(" ".join(ConfigureJobs.getLHEWeightIDs(args.sample, args.analysis, args.precision)))

if __name__ == "__main__":
    main()
