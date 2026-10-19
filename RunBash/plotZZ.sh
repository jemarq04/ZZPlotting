#!/bin/bash

source Utilities/BashArgParse.sh
#@opt -h/--help
#@optdesc Print help and exit
#@opt -i/--infile FILE
#@optdesc Path for histograms file (default: $CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/Hists-ZZ4l$year.root)
#@opt -o/--outdir DIRNAME
#@optdesc Name of output directory for plots (default: output/)
#@opt -c/--channels "CHANNEL [CHANNEL ...]"
#@optdesc Whitespace-separated channels for plotting
#@opt -t/--total-only
#@optdesc Only plot channel-inclusive plots
#@opt --variables "VAR [VAR ...]"
#@optdesc Variables to plot
#@opt --jetvariables "VAR [VAR ...]"
#@optdesc Variables to plot with filelist 'jetplot'
#@opt --controlvariables "VAR [VAR ...]"
#@optdesc Variables to plot in control regions (both PPPF and PPFF)
#@arg year
#@argdesc The year for the analysis

optstring="h/help*,i/infile:,c/channels:,t/total-only,/variables:,/jetvariables:,/controlvariables:"
variables="Mass ZZPt ZPt ZMass Z1Mass Z2Mass LepPt LepPt1 LepPt2 LepEta ElePt EleEta EleZMass MuPt MuEta MuZMass"
jetvariables="nJets nJets_central MassFull Mass0jFull Mass1jFull Mass2jFull Mass34jFull absjetEta[0] absjetEta[1] jetPt[0] jetPt[1]"
controlvariables="Mass Z1Mass Z2Mass"
channels="eeee eemm mmee mmmm"
total_only=false
outdir="output"

parse_args "$0" "$optstring" 1 "$@"
eval set -- "$BAP_PARSED"

year="$1"
analysis="ZZ4l$year"
[[ -z $infile ]] && filepath="$CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/Hists-$analysis.root" || filepath="$infile"
[[ ! -f $filepath ]] && die "invalid file: $filepath"
selection="ZZSelectionsTightLeps"

filelist="$analysis"
opts="-s $analysis/$selection -y $year -u stat --latex --hist_file $filepath --preliminary --scaleymax 1.2 --scalelegx 1.2"

echo "Output directory: $analysis/$selection/$outdir"
for var in $variables; do
  echo ${var}

  moreopts="-f $filelist -b ${var}"
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

for var in $jetvariables; do
  echo ${var}

  moreopts="-f jetplot -b ${var}"

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

for var in $controlvariables; do
  for fakes in PPPF PPFF; do
    echo ${var}_${fakes}
    [[ $fakes = PPPF ]] && extratext="3P1F Region" || extratext="2P2F Region"

    moreopts="-f ${filelist}_nonprompt -b ${var}_${fakes}"
    [[ $var =~ Z[12]?Mass ]] && moreopts="$moreopts --legend_left"
    [[ $var =~ (Lep|Mu|Ele)(Eta|Phi)$ ]] && moreopts="$moreopts --scaleymax 2.1"

    echo "All Channels"
    ./makeHistStack.py $opts $moreopts --folder_name ${outdir} --extra_text "${extratext}"
    if ! $total_only; then
      for ch in $channels; do
        echo "Plotting $ch channel"
        ./makeHistStack.py $opts $moreopts --folder_name ${outdir}/$ch -c $ch --extra_text "${extratext}"
      done
      if [[ $channels = *eemm* ]] && [[ $channels = *mmee* ]]; then
        echo "Plotting 2e2mu channel"
        ./makeHistStack.py $opts $moreopts --folder_name ${outdir}/2e2m -c eemm,mmee --extra_text "${extratext}"
      fi
    fi
  done
done
