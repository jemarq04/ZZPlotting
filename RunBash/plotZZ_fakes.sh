#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "usage: $0 YEAR [INFILE]"
  exit 1
elif [[ ! $1 =~ ^202[2-4]$ && ! $1 = Run3Combined ]]; then
  echo invalid year: $1
  exit 1
fi

analysis="ZZ4l$1"
filename="fakeRates-ZZ4l$1.root"
filepath="$CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/$filename"
[[ ! -z $2 ]] && filepath=$2
if [[ ! -f $filepath ]]; then
  echo invalid file: $filepath
  exit 1
fi

./plotFakeRates.py --preliminary -a $analysis $filepath
