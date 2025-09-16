#filename="Hists02May2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (2e2mu)
filename="Hists30Jun2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (all coeffs + SMlimit + SM) eemm - 100K unweighted
filename="Hists28Jun2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (all coeffs + SMlimit + SM) eemm - 100K
analysis="ZZ4l2018"
selection="ZZSelectionsTightLeps"
VVAnalysis_path="/afs/hep.wisc.edu/user/marquez5/public/SMEFTsim/uwvv_analysis/histograms/src/Analysis/VVAnalysis"
variable="Mass ZMass Z1Mass Z2Mass LepPt LepEta Z1PolCos Z2PolCos"
params="cHWB cHG cll1"
weightID=0.0 # weight ID or 'all' for all weight IDs

options="-s $analysis/$selection -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/$filename --preliminary --scaleymax 1.2 --scalelegx 1.5 --no_ratio"

unweighted=false
if $unweighted; then
  var="Mass"
  for restrict in $params SMlimit; do
    filelist="ZZEFT_${restrict}_nobkg"
    dir="${restrict}_nowgt"
    moreoptions="--unweighted --no_ratio -f $filelist -b ${var}"
    ./makeHistStack.py $options $moreoptions --folder_name ${dir}/eemm -c eemm --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0
  done
fi

for restrict in $params; do
  echo pp_eemm-${restrict}_massless
  wids=$(./Utilities/GetLHEWeightIDs.py -a $analysis pp_eemm-${restrict}_massless)
  if [[ $? -ne 0 ]]; then
    echo "error finding weight IDs for pp_eemm-${restrict}_massless:"
    echo
    echo $wids
    continue
  fi
  for wid in $wids; do 
    foundwid=false
    if [[ "$weightID" != "all" ]]; then
      widdiff=$(bc -l <<< "$weightID - $wid")
      (( $(bc -l <<< "$widdiff * (($widdiff>0)-($widdiff<0)) < 0.0001") )) && foundwid=true
    fi
    if $foundwid || [[ "$weightID" == "all" ]]; then
      echo Plotting Weight ID $wid
      filelist="ZZEFT_$restrict"
      dir="output_$restrict-$wid"
      for var in $variable; do
        moreoptions="--lhe_weight_id $wid -f $filelist -b ${var}"
        echo ${var}
        if [ $var = "Mass" ]; then
          #echo "All Channels"
          #./makeHistStack.py $options $moreoptions --folder_name $dir --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0
          echo "Plotting eemm channel"
          ./makeHistStack.py $options $moreoptions --folder_name $dir/eemm -c eemm --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0
          #echo "Plotting 2e2mu channel"
          #./makeHistStack.py $options $moreoptions --folder_name $dir/2e2m -c eemm,mmee --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0
        else
          echo "Attempting ${var}"
          echo "Plotting eemm channel"
          ./makeHistStack.py $options $moreoptions --folder_name ${dir}/eemm -c eemm
        fi
      done
    fi
  done
done
