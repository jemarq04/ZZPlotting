#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "usage: $0 YEAR [INFILE]"
  exit 1
fi

year=$1
analysis="ZZ4l$year"
filename="fakeRates-ZZ4l$year.root"
filepath="$CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/$filename"
[[ ! -z $2 ]] && filepath=$2
if [[ ! -f $filepath ]]; then
  echo invalid file: $filepath
  exit 1
fi

./plotFakeRates.py --preliminary -a $analysis -y $year $filepath
