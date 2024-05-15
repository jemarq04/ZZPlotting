#!/usr/bin/env python
import argparse
import os,sys
import glob
import json
from collections import OrderedDict
import re

with open("Templates/config.%s" % os.getlogin()) as fconfig:
    for line in fconfig:
        if 'scriptPath' in line:       
            scriptPath = line.split(" = ")[1].strip()
sys.path.insert(0,scriptPath)
import ConfigureJobs

def main():
    print "Correcting LHE cross sections"
    DESC = ""
    parser = argparse.ArgumentParser(description=DESC, formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("id", type=str, help="weight ID")
    parser.add_argument("samples", type=str, nargs="+", help="samples to recalculate cross sections")
    args = parser.parse_args()

    if "," in args.id:
        parser.error("Weight ID cannot include a ','")

    montecarlo_dir = os.path.join(ConfigureJobs.getManagerPath(), ConfigureJobs.getManagerName(), "FileInfo/montecarlo")
    filepath = os.path.join(montecarlo_dir, "montecarlo_zzanalysis.json")
    lhe_dir = None
    with open("Templates/config.%s" % os.getlogin()) as fconfig:
        for line in fconfig:
            if 'lhe_storage_path' in line:
                lhe_dir = line.split(" = ")[1].strip()
                break

    if not os.path.isdir(montecarlo_dir):
        parser.error("Invalid directory: %s" % montecarlo_dir)
    if not os.path.isfile(filepath):
        parser.error("Invalid file: %s" % filepath)
    if lhe_dir is None:
        parser.error("lhe_storage_path not specified in config file Templates/config.%s" % os.getlogin())
    elif not os.path.isdir(lhe_dir):
        parser.error("Invalid directory: %s" % lhe_dir)

    with open(filepath, "r") as json_file:
        try:
            info = json.load(json_file, object_pairs_hook=OrderedDict)
        except ValueError as err:
            parser.error("Error reading JSON file (%s): %s" % (filepath, err))

    for sample in args.samples:
        if sample not in info:
            parser.error("Sample '%s' not found in JSON file (%s)" % (sample, filepath))
        if not os.path.isdir(os.path.join(lhe_dir, sample)):
            parser.error("Sample dir not found in LHE storage: %s" % sample)
        xsec = getXsecFromFiles(glob.glob(os.path.join(lhe_dir, sample, "*.lhe")), args.id)[args.id]
        print "%s: %s -> %s" % (sample, info[sample]["cross_section"] if "cross_section" in info[sample] else "''", xsec)
        info[sample]["cross_section"] = xsec

    with open(filepath, "w") as outfile:
        json.dump(info, outfile, indent=4)
    print "Finish calculating LHE cross sections"

def getXsecFromFiles(filelist, wids, verbose=False):
  if verbose:
    print("Calculating total cross sections...\n")
  sums = None
  for f in filelist:
    if sums is None:
      sums = getXsecFromFile(f, wids)
    else:
      temp = getXsecFromFile(f, wids)
      for key in sums.keys():
        sums[key] += temp[key]

  if verbose:
    print("WeightID CrossSection")
  for key in sums.keys():
    #sums[key] /= len(filelist)
    if verbose:
      print("%07s %.06f" % (key, sums[key]))

  return sums

def getXsecFromFile(filepath, wids, verbose=False):
  # filename = path to input LHE file
  # wids = comma-separated list of weight IDs (or "all")
  if verbose:
    print("Reading cross sections...\n")
  
  if not os.path.exists(filepath) or not filepath.endswith(".lhe"):
    raise ValueError("Invalid file", filepath)
  
  if verbose:
    print("WeightID CrossSection")
  sums = {}
  with open(filepath, "r") as lhe:
    text = lhe.read()
    if wids == "all":
      regex = re.compile(r'<weight id="(.*?)"')
      wids = ",".join([match.group(1) for match in regex.finditer(text)])
    for wid in wids.split(","):
      regex = re.compile(r"<wgt id='%s'> ([\d\.E\+\-]+) </wgt>\s*\n" % wid)
      results = [float(match.group(1)) for match in regex.finditer(text)]
      sums[wid] = 0.
      for wgt in results:
        sums[wid] += wgt
      if verbose:
        print("%07s %.06f" % (wid, sums[wid]))
  return sums

if __name__ == "__main__":
    main()
