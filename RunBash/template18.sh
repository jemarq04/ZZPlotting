filename="file.root" 
selection="ZZSelectionsTightLeps"
dir="output_folder_name"
variable="Mass ZMass LepPt LepEta"

for var in $variable
do
  if [ $var = "Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "ZMass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 
    
  fi
  if [ $var = "LepPt" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "LepEta" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f jetPlot -l 59.7 -u stat --no_data --latex --hist_file VVAnalysis_path/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi

  
done
