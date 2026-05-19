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

selection="SystematicVariations"
variables="Mass"
systematics="CMS_eff_e,CMS_eff_m,CMS_pileup"
channels="eeee eemm mmee mmmm"
dir="output"

opts="-s $analysis/$selection -y $1 --hist_file $filepath --preliminary --scaleymax 1.2 -S $systematics"

for var in $variables; do
  echo ${var}

  moreopts="--folder_name ${dir} -b ${var}"
  [[ $var = "Mass" ]] && moreopts="$moreopts --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0"

  ./plotVariations.py $opts $moreopts
done
