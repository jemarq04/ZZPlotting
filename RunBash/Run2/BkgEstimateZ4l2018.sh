filename="Hists03Feb2019-Z4l2018.root"
selection="Z4lSelectionsTightLeps"
dir="Sync/BkgEstimate_03Feb2019"
variable="Mass Z1Mass Z2Mass"
for var in $variable
do
  if [ $var = "Mass" ];
  then
    echo ${var}
    echo "All Channels"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text Z4lSelections --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 78.0,82.0,86.0,90.0,94.0,98.0,102.0
     
    echo "Plotting 4e channel" 
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text Z4lSelections --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 78.0,82.0,86.0,90.0,94.0,98.0,102.0   
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text Z4lSelections --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 78.0,82.0,86.0,90.0,94.0,98.0,102.0  
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text Z4lSelections --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 78.0,82.0,86.0,90.0,94.0,98.0,102.0  
    
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text Z4lSelections --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 78.0,82.0,86.0,90.0,94.0,98.0,102.0  
  
    echo "Plotting 2e2m channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --extra_text Z4lSelections  --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 78.0,82.0,86.0,90.0,94.0,98.0,102.0  
  
  fi
  
  if [ $var = "Z1Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 
     
    #./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2
    
    #./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 
    
    #./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 
    
    #./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2
  
    #./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
  
    echo "Plotting 2e2m channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2
  
    #./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
  fi
  
  if [ $var = "Z2Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0 
    
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0
    
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0
  
    echo "Plotting 2e2m channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019NonPrompt -l 59.95 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --extra_text Z4lSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0
  fi
done
