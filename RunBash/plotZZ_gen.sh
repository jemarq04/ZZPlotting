#!/bin/bash

source Utilities/BashArgParse.sh
#@opt -h/--help
#@optdesc Print help and exit
#@opt -i/--infile FILE
#@optdesc Path for histograms file with gen info (default: $CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/Hists-ZZ4l$year.root)
#@opt -o/--outdir DIRNAME
#@optdesc Name of output directory for plots (default: output_genvars/)
#@opt -c/--channels "CHANNEL [CHANNEL ...]"
#@optdesc Whitespace-separated channels for plotting
#@opt -t/--total-only
#@optdesc Only plot channel-inclusive plots
#@opt --variables "VAR [VAR ...]"
#@optdesc Variables to plot (default: Mass, LepPt, LepEta)
#@arg year
#@argdesc The year for the analysis

optstring="h/help*,i/infile:,o/outdir:,c/channels:,t/total-only,/variables:"
variables="Mass LepPt LepEta"
channels="eeee eemm mmee mmmm"
total_only=false
outdir="output_genvars"

parse_args "$0" "$optstring" 1 "$@"
eval set -- "$BAP_PARSED"

year=$1
analysis="ZZ4l$year"
[[ -z $infile ]] && filepath="$CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/Hists-$analysis.root" || filepath="$infile"
[[ ! -f $filepath ]] && die "invalid file: $filepath"

selection="ZZSelectionsTightLeps"

filelist="$analysis"
opts="-s $analysis/$selection -y $1 -u stat --latex --hist_file $filepath --preliminary --scaleymax 1.2 --scalelegx 1.2 --gen --no_data"

echo "Output directory: $analysis/$selection/$outdir"
for var in $variables; do
  echo ${var}

  moreopts="-f ${filelist}_gen -b ${var}"
  [[ $var = "Mass" ]] && moreopts="$moreopts --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0"
  [[ $var =~ Z[12]?Mass ]] && moreopts="$moreopts --legend_left"
  [[ $var =~ ^(Lep|Mu|Ele)(Eta|Phi)$ ]] && moreopts="$moreopts --scaleymax 2.0"

  echo "All Channels"
  ./makeHistStack.py $opts $moreopts --folder_name ${outdir}
  if ! $total_only; then
    for ch in $channels; do
      echo "Plotting $ch channel"
      ./makeHistStack.py $opts $moreopts --folder_name ${outdir}/$ch -c $ch
    done
    if [[ $channels = *eemm* ]] && [[ $channels = *mmee* ]]; then
      echo "Plotting 2e2mu channel"
      ./makeHistStack.py $opts $moreopts --folder_name ${outdir}/2e2m -c eemm,mmee
    fi
  fi
done
