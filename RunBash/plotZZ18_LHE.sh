#filename="Hists12Apr2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (default reweight first and ZZEFT reorg.)
#filename="Hists02May2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (2e2mu)
#filename="Hists03May2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (2e2mu) + SMlimit
filename="Hists13May2024-ZZ4l2018_MVA.root" #Signal + Bgk + LHE + IDs (eemm) + SMlimit
selection="ZZSelectionsTightLeps"
VVAnalysis_path="/afs/hep.wisc.edu/user/marquez5/public/SMEFTsim/uwvv_analysis/histograms/src/Analysis/VVAnalysis"
variable="Mass ZMass Z1Mass Z2Mass LepPt LepEta"

#The following command was found to be incorrect - the xsec must be calculated for default weights
#./Utilities/CorrectLHEXsection.py $weightID pp_eemm-cHWB_massless pp_eemm-cHG_massless pp_eemm-cll1_massless

weightID=0.0
restrict="SMlimit"
filelist="ZZEFT_$restrict"
dir="output_$restrict-$weightID"

for var in $variable; do

  if [ $var = "Mass" ]; then
    echo ${var}
    #echo "All Channels"
    #./makeHistStack.py -s ZZ4l2018/${selection} -f $filelist -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting eemm channel"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f $filelist -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 --lhe_weight_id $weightID
    #echo "Plotting 2e2mu channel"
    #./makeHistStack.py -s ZZ4l2018/${selection} -f $filelist -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 --lhe_weight_id $weightID

  elif [ $var = "ZMass" ]; then
    echo ${var}
    #echo "All Channels"
    #./makeHistStack.py -s ZZ4l2018/${selection} -f $filelist -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 
    echo "Plotting eemm channel"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f $filelist -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --lhe_weight_id $weightID

  elif [ $var = "LepPt" ]; then
    echo ${var}
    #echo "All Channels"
    #./makeHistStack.py -s ZZ4l2018/${selection} -f $filelist -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
    echo "Plotting eemm channel"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f $filelist -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --lhe_weight_id $weightID #--no_decorations   

  elif [ $var = "LepEta" ]; then
    echo ${var}
    #echo "All Channels"
    #./makeHistStack.py -s ZZ4l2018/${selection} -f $filelist -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
    echo "Plotting eemm channel"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f $filelist -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --lhe_weight_id $weightID #--no_decorations
	
	else
		echo "Attempting ${var}"
		echo "Plotting eemm channel"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f $filelist -l 59.7 -u stat --no_data --latex --hist_file $VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --lhe_weight_id $weightID #--no_decorations
  fi

done
