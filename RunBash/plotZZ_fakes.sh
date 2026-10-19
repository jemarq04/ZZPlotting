#!/bin/bash

source Utilities/BashArgParse.sh
#@opt -h/--help
#@optdesc Print help and exit
#@opt -i/--infile FILE
#@optdesc Path for fake rate histograms file (default: $CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/fakeRates-ZZ4l$year.root)
#@arg year
#@argdesc The year for the analysis

optstring="h/help*,i/infile:"

parse_args "$0" "$optstring" 1 "$@"
eval set -- "$BAP_PARSED"

year=$1
analysis="ZZ4l$year"
[[ -z $infile ]] && filepath="$CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/fakeRates-$analysis.root" || filepath="$infile"
[[ ! -f $filepath ]] && die "invalid file: $filepath"

./plotFakeRates.py --preliminary -a $analysis -y $year $filepath
