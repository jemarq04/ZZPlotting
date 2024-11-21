filename="Hists26Feb2019-HZZ2017.root"
selection="HZZSelectionsTightLeps"
dir="Sync/BkgEstimateHZZ2017ReReco_25Feb2019"
variable="Mass Z1Mass Z2Mass"
#variable="Z1Mass"
for var in $variable
do
  if [ $var = "Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0,174.0,178.0,182.0,186.0,190.0,194.0,198.0,202.0,206.0,210.0,214.0,218.0,222.0,226.0,230.0,234.0,238.0,242.0,246.0,250.0,254.0,258.0,262.0,266.0,270.0,274.0,278.0,282.0,286.0,290.0,294.0,298.0,302.0,306.0,310.0,314.0,318.0,322.0,326.0,330.0,334.0,338.0,342.0,346.0,350.0,354.0,358.0,362.0,366.0,370.0,374.0,378.0,382.0,386.0,390.0,394.0,398.0,402.0,406.0,410.0,414.0,418.0,422.0,426.0,430.0,434.0,438.0,442.0,446.0,450.0,454.0,458.0,462.0,466.0,470.0,474.0,478.0,482.0,486.0,490.0,494.0,498.0,502.0
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text HZZSelections -a LowMass --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text HZZSelections -a Full --no_overflow --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0,174.0,178.0,182.0,186.0,190.0,194.0,198.0,202.0,206.0,210.0,214.0,218.0,222.0,226.0,230.0,234.0,238.0,242.0,246.0,250.0,254.0,258.0,262.0,266.0,270.0,274.0,278.0,282.0,286.0,290.0,294.0,298.0,302.0,306.0,310.0,314.0,318.0,322.0,326.0,330.0,334.0,338.0,342.0,346.0,350.0,354.0,358.0,362.0,366.0,370.0,374.0,378.0,382.0,386.0,390.0,394.0,398.0,402.0,406.0,410.0,414.0,418.0,422.0,426.0,430.0,434.0,438.0,442.0,446.0,450.0,454.0,458.0,462.0,466.0,470.0,474.0,478.0,482.0,486.0,490.0,494.0,498.0,502.0
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text HZZSelections -a LowMass --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text HZZSelections -a Full --no_overflow --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text HZZSelections --scaleymax 1.0 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0,174.0,178.0,182.0,186.0,190.0,194.0,198.0,202.0,206.0,210.0,214.0,218.0,222.0,226.0,230.0,234.0,238.0,242.0,246.0,250.0,254.0,258.0,262.0,266.0,270.0,274.0,278.0,282.0,286.0,290.0,294.0,298.0,302.0,306.0,310.0,314.0,318.0,322.0,326.0,330.0,334.0,338.0,342.0,346.0,350.0,354.0,358.0,362.0,366.0,370.0,374.0,378.0,382.0,386.0,390.0,394.0,398.0,402.0,406.0,410.0,414.0,418.0,422.0,426.0,430.0,434.0,438.0,442.0,446.0,450.0,454.0,458.0,462.0,466.0,470.0,474.0,478.0,482.0,486.0,490.0,494.0,498.0,502.0  
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary -a LowMass --no_overflow --scaleymax 0.95 --scalelegx 1.04 --rebin 70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0,122.0,124.0,126.0,128.0,130.0,132.0,134.0,136.0,138.0,140.0,142.0,144.0,146.0,148.0,150.0,152.0,154.0,156.0,158.0,160.0,162.0,164.0,166.0,168.0,170.0
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text HZZSelections -a Full --no_overflow --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0,174.0,178.0,182.0,186.0,190.0,194.0,198.0,202.0,206.0,210.0,214.0,218.0,222.0,226.0,230.0,234.0,238.0,242.0,246.0,250.0,254.0,258.0,262.0,266.0,270.0,274.0,278.0,282.0,286.0,290.0,294.0,298.0,302.0,306.0,310.0,314.0,318.0,322.0,326.0,330.0,334.0,338.0,342.0,346.0,350.0,354.0,358.0,362.0,366.0,370.0,374.0,378.0,382.0,386.0,390.0,394.0,398.0,402.0,406.0,410.0,414.0,418.0,422.0,426.0,430.0,434.0,438.0,442.0,446.0,450.0,454.0,458.0,462.0,466.0,470.0,474.0,478.0,482.0,486.0,490.0,494.0,498.0,502.0
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text HZZSelections -a LowMass --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text HZZSelections -a Full --no_overflow --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0,174.0,178.0,182.0,186.0,190.0,194.0,198.0,202.0,206.0,210.0,214.0,218.0,222.0,226.0,230.0,234.0,238.0,242.0,246.0,250.0,254.0,258.0,262.0,266.0,270.0,274.0,278.0,282.0,286.0,290.0,294.0,298.0,302.0,306.0,310.0,314.0,318.0,322.0,326.0,330.0,334.0,338.0,342.0,346.0,350.0,354.0,358.0,362.0,366.0,370.0,374.0,378.0,382.0,386.0,390.0,394.0,398.0,402.0,406.0,410.0,414.0,418.0,422.0,426.0,430.0,434.0,438.0,442.0,446.0,450.0,454.0,458.0,462.0,466.0,470.0,474.0,478.0,482.0,486.0,490.0,494.0,498.0,502.0
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text HZZSelections -a LowMass --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0
  
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text HZZSelections -a Full --no_overflow --scaleymax 1.2 --scalelegx 1.2 
  
    echo "Plotting 2e2m channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0,174.0,178.0,182.0,186.0,190.0,194.0,198.0,202.0,206.0,210.0,214.0,218.0,222.0,226.0,230.0,234.0,238.0,242.0,246.0,250.0,254.0,258.0,262.0,266.0,270.0,274.0,278.0,282.0,286.0,290.0,294.0,298.0,302.0,306.0,310.0,314.0,318.0,322.0,326.0,330.0,334.0,338.0,342.0,346.0,350.0,354.0,358.0,362.0,366.0,370.0,374.0,378.0,382.0,386.0,390.0,394.0,398.0,402.0,406.0,410.0,414.0,418.0,422.0,426.0,430.0,434.0,438.0,442.0,446.0,450.0,454.0,458.0,462.0,466.0,470.0,474.0,478.0,482.0,486.0,490.0,494.0,498.0,502.0
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --extra_text HZZSelections -a LowMass --no_overflow --scaleymax 1.2 --scalelegx 1.2 --rebin 70.0,74.0,78.0,82.0,86.0,90.0,94.0,98.0,102.0,106.0,110.0,114.0,118.0,122.0,126.0,130.0,134.0,138.0,142.0,146.0,150.0,154.0,158.0,162.0,166.0,170.0
  
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --extra_text HZZSelections -a Full --no_overflow --scaleymax 1.2 --scalelegx 1.2 
  fi
  
  if [ $var = "Z1Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 
     
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2
  
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
  
    echo "Plotting 2e2m channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2
  
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
  fi
#  if [ $var = "Z1Mass" ];
#  then
#    echo ${var}
#    echo "All Channels"
#    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --no_data --nostack --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 
#     
#    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --no_data --nostack -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
#    echo "Plotting 4e channel"
#    
#    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --no_data --nostack  --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2
#    
#    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --no_data --nostack -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
#    echo "Plotting 4mu channel"
#    
#    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --no_data --nostack --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 
#    
#    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --no_data --nostack -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
#    echo "Plotting eemm channel"
#    
#    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --no_data --nostack --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 
#    
#    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --no_data --nostack -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
#    echo "Plotting mmee channel"
#    
#    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --no_data --nostack --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2
#  
#    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --no_data --nostack -a ZMass --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0   
#  fi
  
  if [ $var = "Z2Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0 
    
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0
    
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0
  
    echo "Plotting 2e2m channel"
    
    ./makeHistStack.py -s ZZ4l2018/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --legend_left --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --extra_text HZZSelections --scaleymax 1.2 --scalelegx 1.2 --rebin 12.0,14.0,16.0,18.0,20.0,22.0,24.0,26.0,28.0,30.0,32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0,52.0,54.0,56.0,58.0,60.0,62.0,64.0,66.0,68.0,70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0,108.0,110.0,112.0,114.0,116.0,118.0,120.0
  fi
done
