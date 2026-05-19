#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "usage: $0 YEAR [INFILE]"
  exit 1
fi

analysis="ZZ4l$1"
filename="SystHists-ZZ4l$1.root"
filepath="$CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/$filename"
[[ ! -z $2 ]] && filepath=$2
if [[ ! -f $filepath ]]; then
  echo invalid file: $filepath
  exit 1
fi

systematics="CMS_eff_e,CMS_eff_m,CMS_pileup"

./plotVariations.py --title ";m_{4l} [GeV];Events" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 -S $systematics -a ZZ4l$1 -y $1 --preliminary $filepath
