#filename="Hists02May2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (2e2mu)
#filename="Hists28May2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (all coeffs + SMlimit + SM) eemm
#filename="Hists29May2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (all coeffs + SMlimit + SM) eemm - unweighted
filename="Hists08Jun2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (all coeffs + SMlimit + SM) eemm - unweighted 100K
filename="Hists26Jun2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (all coeffs + SMlimit + SM) eemm - 100K
selection="ZZSelectionsTightLeps"
VVAnalysis_path="/afs/hep.wisc.edu/user/marquez5/public/SMEFTsim/uwvv_analysis/histograms/src/Analysis/VVAnalysis"
variable="Mass ZMass Z1Mass Z2Mass LepPt LepEta Z1PolCos Z2PolCos"

#The following command was found to be incorrect - the xsec must be calculated for default weights
#./Utilities/CorrectLHEXsection.py $weightID pp_eemm-cHWB_massless pp_eemm-cHG_massless pp_eemm-cll1_massless

options="-s ZZ4l2018/$selection -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/$filename --preliminary --scaleymax 1.2 --scalelegx 1.2"

unweighted=false
if $unweighted; then
  var="Mass"
  for restrict in cHWB cHG cll1 SMlimit; do
    filelist="ZZEFT_${restrict}_nobkg"
    dir="${restrict}_nowgt"
    moreoptions="--unweighted --no_ratio -f $filelist -b ${var}"
    ./makeHistStack.py $options $moreoptions --folder_name ${dir}/eemm -c eemm --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0
  done
fi

weightID=0.0
for restrict in cHWB cHG cll1; do
	filelist="ZZEFT_$restrict"
	dir="output_$restrict-$weightID"
	for var in $variable; do
    moreoptions="--lhe_weight_id $weightID -f $filelist -b ${var}"
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
done
