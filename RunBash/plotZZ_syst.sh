#!/bin/bash

source Utilities/BashArgParse.sh
#@opt -h/--help
#@optdesc Print help and exit
#@opt -i/--infile FILE
#@optdesc Path for histograms file with systematics (default: $CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/SystHists-ZZ4l$year.root)
#@opt -o/--outdir DIRNAME
#@optdesc Name of output directory for plots (default: output/)
#@opt --variables "VAR [VAR ...]"
#@optdesc Variables to plot (default: Mass)
#@opt --systematics "SYST [SYST ...]"
#@optdesc Systematics to plot (default: CMS_eff_e, CMS_eff_m, CMS_pileup)
#@arg year
#@argdesc The year for the analysis

optstring="h/help*,i/infile:,o/outdir:,/variables:,/systematics:"
variables="Mass"
systematics="CMS_eff_e,CMS_eff_m,CMS_pileup"
outdir="output"

parse_args "$0" "$optstring" 1 "$@"
eval set -- "$BAP_PARSED"

year=$1
analysis="ZZ4l$year"
[[ -z $infile ]] && filepath="$CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/SystHists-$analysis.root" || filepath="$infile"
[[ ! -f $filepath ]] && die "invalid file: $filepath"

selection="SystematicVariations"
opts="-s $analysis/$selection -y $year --hist_file $filepath --preliminary --scaleymax 1.2 -S $systematics"

for var in $variables; do
  echo ${var}

  moreopts="--folder_name ${outdir} -b ${var}"
  [[ $var = "Mass" ]] && moreopts="$moreopts --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0"

  ./plotSystematics.py $opts $moreopts
done
