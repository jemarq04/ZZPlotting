#filename="Hists28May2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (all coeffs + SMlimit + SM) eemm
filename="Hists28Jun2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (all coeffs + SMlimit + SM) eemm - 100K
selection="ZZSelectionsTightLeps"
VVAnalysis_path="/afs/hep.wisc.edu/user/marquez5/public/SMEFTsim/uwvv_analysis/histograms/src/Analysis/VVAnalysis"
variable="Mass" # ZMass Z1Mass Z2Mass ZPt ZZPt LepPt LepEta"

options="-s ZZ4l2018/$selection -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/$filename --preliminary --scaleymax 1.5 --scalelegx 1.5 --lhe_weight_id 0.0"

filelist="ZZEFT_all_nobkg"
dir="EFTcompare/eemm"
for var in $variable; do
  moreoptions="--scatter -f $filelist --folder_name $dir -c eemm -b $var"
  echo ${var}
  if [[ $var = "Mass" ]]; then
    echo "Plotting eemm channel"
    ./makeHistStack.py $options $moreoptions --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0
  else
    echo "Attempting ${var}"
    echo "Plotting eemm channel"
    ./makeHistStack.py $options $moreoptions
  fi
done
