#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "usage: $0 YEAR [INFILE]"
  exit 1
fi

analysis="ZZ4l$1"
filename="Hists-ZZ4l$1.root"
filepath="$CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/$filename"
[[ ! -z $2 ]] && filepath=$2
if [[ ! -f $filepath ]]; then
  echo invalid file: $filepath
  exit 1
fi

selection="ZZSelectionsTightLeps"
variables="Mass CosTheta1 CosTheta2 CosThetaStar RapidityDiff dPhiOSll"
channels="eeee eemm mmee mmmm"
dochannels=true
dir="output_polvars"

filelist="$analysis"
opts="-s $analysis/$selection -y $1 -u stat --latex --hist_file $filepath --preliminary --scaleymax 1.2 --scaleymin 0.0 --scalelegx 1.2"

echo "Output directory: $analysis/$selection/$dir"
for var in $variables; do
  echo ${var}

  moreopts="-f ${filelist}_pol -b ${var} --signal_files ppZ0Z04l,ppZ0ZT4l,ppZTZT4l"
  [[ $var = "Mass" ]] && moreopts="$moreopts --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0"
  [[ $var =~ ^Z[12]?Mass$ ]] && moreopts="$moreopts --legend_left"
  [[ $var =~ ^CosTheta[12]$ || $var = dPhiOSll ]] && moreopts="$moreopts --scaleymax 2.0"

  echo "All Channels"
  ./makeHistStack.py $opts $moreopts --folder_name ${dir}
  if $dochannels; then
    for ch in $channels; do
      [[ $var = dPhiOSll ]] && [[ $ch = eeee || $ch = mmmm ]] && continue
      echo "Plotting $ch channel"
      ./makeHistStack.py $opts $moreopts --folder_name ${dir}/$ch -c $ch
    done
    if [[ $channels = *eemm* ]] && [[ $channels = *mmee* ]]; then
      echo "Plotting 2e2mu channel"
      ./makeHistStack.py $opts $moreopts --folder_name ${dir}/2e2m -c eemm,mmee
    fi
  fi
done
