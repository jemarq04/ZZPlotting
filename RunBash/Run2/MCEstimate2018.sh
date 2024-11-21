filename="Hists17Jan2019-2018Signal_HZZ.root"
selection="HZZSelectionTightLeps"
dir="MCEstimate_17Jan2019"
#variable="Mass Z1Mass Z2Mass ZMass"
variable="Z1Mass"
for var in $variable
do
  if [ $var = "Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --no_data --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --no_data --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --no_data --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text 2018Signal --scaleymax 1.0 --scalelegx 1.2 --rebin 70.0,100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --no_data --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0     
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --no_data --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0 
    
  fi
  
  if [ $var = "Z1Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --no_data --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --no_data --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2
    
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --no_data --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --no_data --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --no_data --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2
  
  fi
  if [ $var = "ZMass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --legend_left  --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2
    
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2
  
  fi
  
  if [ $var = "Z2Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2019/${selection} -f ZZ4l2019 -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text 2018Signal --scaleymax 1.2 --scalelegx 1.2 
  fi
done
