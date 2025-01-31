filename="Hists30Jan2025-ZZ4l2022.root"
analysis="ZZ4l2022"
selection="ZZSelectionsTightLeps"
VVAnalysis_path="$CMSSW_BASE/src/Analysis/VVAnalysis"
variable="Mass ZMass Z1Mass Z2Mass LepPt LepEta SIP3D LepIso"
channels="eeee eemm mmee mmmm"
dochannels=true
lumi=37.90 #34.652

opts="-s $analysis/$selection -l $lumi -u stat --latex --hist_file $VVAnalysis_path/HistFiles/$filename --preliminary --scaleymax 1.2 --scalelegx 1.5"

dir="output_$analysis"
filelist="$analysis"
for var in $variable; do
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
