filename="Hists20May2025-ZZ4l2023.root"
analysis="ZZ4l2023"
selection="ZZSelectionsTightLeps"
VVAnalysis_path="$CMSSW_BASE/src/Analysis/VVAnalysis"
variables="Mass ZMass Z1Mass Z2Mass LepPt LepEta SIP3D LepIso nJets nJets_central Mass0jFull Mass1jFull Mass2jFull Mass34jFull absjetEta[0] absjetEta[1] jetPt[0] jetPt[1]"
channels="eeee eemm mmee mmmm"
dochannels=true
lumi=27.76

opts="-s $analysis/$selection -l $lumi -u stat --latex --hist_file $VVAnalysis_path/HistFiles/$filename --preliminary --scaleymax 1.2 --scalelegx 1.5"

dir="output"
filelist="$analysis"
for var in $variables; do
  moreopts="-f $filelist -b ${var}"
  echo ${var}
  if [ $var = "Mass" ]; then
    moreopts="$moreopts --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0"
  fi
  echo "All Channels"
  ./makeHistStack.py $opts $moreopts --folder_name ${dir}
  if $dochannels; then
    for ch in $channels; do
      echo "Plotting $ch channel"
      ./makeHistStack.py $opts $moreopts --folder_name ${dir}/$ch -c $ch
    done
    if [[ $channels = *eemm* ]] && [[ $channels = *mmee* ]]; then
      echo "Plotting 2e2mu channel"
      ./makeHistStack.py $opts $moreopts --folder_name ${dir}/2e2m -c eemm,mmee
    fi
  fi
done
