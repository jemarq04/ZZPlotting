#!/usr/bin/env python
import argparse
import os,sys
import json
import ROOT

with open("Templates/config.%s" % os.getlogin()) as fconfig:
    for line in fconfig:
        if 'scriptPath' in line:       
            scriptPath = line.split(" = ")[1].strip()
sys.path.insert(0,scriptPath)
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
    filename = os.path.join(data_path, "ntuples.json")
    precstr = "%%.%if" % args.precision

    if not os.path.isdir(manager_path):
        parser.error("invalid manager path: %s" % manager_path)
    elif not os.path.isdir(data_path):
        parser.error("invalid analysis: %s" % args.analysis)
    elif not os.path.isfile(filename):
        parser.error("error finding file: %s" % filename)

    with open(filename) as infile:
        try:
            info = json.load(infile)
        except:
            parser.error("error reading JSON file: %s" % filename)

        if args.sample not in info:
            parser.error("args.sample '%s' not found in JSON file" % args.sample)
        elif "file_path" not in info[args.sample]:
            parser.error("'file_path' not in JSON file entry '%s'")
        chain = ROOT.TChain("eemm/ntuple")
        root_file_path = info[args.sample]["file_path"]
        if root_file_path.startswith("/store"):
            root_file_path = "/hdfs" + root_file_path
        chain.Add(root_file_path)
        for event in chain:
            wids = [precstr % wid for wid in event.scaleWeightIDs]
            print(" ".join(wids))
            break


if __name__ == "__main__":
    main()
