#filename="Hists28Feb2019-ZZ4l2017HZZID.root"
filename="Hists12Sep2019-ZZ4l2017_withoutCut.root"
#filename="Hists06Mar2019-ZZ4l2017dPhi.root"
selection="ZZSelectionsTightLeps"
dir="Sep12_TestWithoutCut"
#variable="Mass Z1Mass Z2Mass ZMass ZPt Z1Pt Z2Pt ZZPt"
variable="Mass ZMass ZPt ZZPt LepPt LepEta dPhiZ1Z2 nJets jetPt[0] jetPt[1] jetEta[0] jetEta[1] mjj dEtajj CosTheta zeppenfeld"
for var in $variable
do
  if [ $var = "CosTheta" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "nJets" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "jetPt[0]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "jetEta[0]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
   if [ $var = "jetPt[0]50" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "jetEta[0]50" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "jetPt[1]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "jetEta[1]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "mjj" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --logy --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 90 --scalelegx 1.2 --rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --logy --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 90 --scalelegx 1.2 --rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --logy --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 90 --scalelegx 1.2 --rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --logy --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 90 --scalelegx 1.2 --rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --logy --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 90 --scalelegx 1.2 --rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --logy --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 90 --scalelegx 1.2 --rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations 
    
  fi
  if [ $var = "dEtajj" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --extra_text "mjj > 100 GeV" --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0 #--no_decorations 
    
  fi
  if [ $var = "zeppenfeld" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f jetPlot -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0,1200.0 #--no_decorations 
    
  fi
  if [ $var = "ZPt" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "ZZPt" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations 
    
  fi
  if [ $var = "ZMass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 60.0,61.0,62.0,63.0,64.0,65.0,66.0,67.0,68.0,69.0,70.0,71.0,72.0,73.0,74.0,75.0,76.0,77.0,78.0,79.0,80.0,81.0,82.0,83.0,84.0,85.0,86.0,87.0,88.0,89.0,90.0,91.0,92.0,93.0,94.0,95.0,96.0,97.0,98.0,99.0,100.0,101.0,102.0,103.0,104.0,105.0,106.0,107.0,108.0,109.0,110.0,111.0,112.0,113.0,114.0,115.0,116.0,117.0,118.0,119.0,120.0 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 60.0,61.0,62.0,63.0,64.0,65.0,66.0,67.0,68.0,69.0,70.0,71.0,72.0,73.0,74.0,75.0,76.0,77.0,78.0,79.0,80.0,81.0,82.0,83.0,84.0,85.0,86.0,87.0,88.0,89.0,90.0,91.0,92.0,93.0,94.0,95.0,96.0,97.0,98.0,99.0,100.0,101.0,102.0,103.0,104.0,105.0,106.0,107.0,108.0,109.0,110.0,111.0,112.0,113.0,114.0,115.0,116.0,117.0,118.0,119.0,120.0 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 60.0,61.0,62.0,63.0,64.0,65.0,66.0,67.0,68.0,69.0,70.0,71.0,72.0,73.0,74.0,75.0,76.0,77.0,78.0,79.0,80.0,81.0,82.0,83.0,84.0,85.0,86.0,87.0,88.0,89.0,90.0,91.0,92.0,93.0,94.0,95.0,96.0,97.0,98.0,99.0,100.0,101.0,102.0,103.0,104.0,105.0,106.0,107.0,108.0,109.0,110.0,111.0,112.0,113.0,114.0,115.0,116.0,117.0,118.0,119.0,120.0 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 60.0,61.0,62.0,63.0,64.0,65.0,66.0,67.0,68.0,69.0,70.0,71.0,72.0,73.0,74.0,75.0,76.0,77.0,78.0,79.0,80.0,81.0,82.0,83.0,84.0,85.0,86.0,87.0,88.0,89.0,90.0,91.0,92.0,93.0,94.0,95.0,96.0,97.0,98.0,99.0,100.0,101.0,102.0,103.0,104.0,105.0,106.0,107.0,108.0,109.0,110.0,111.0,112.0,113.0,114.0,115.0,116.0,117.0,118.0,119.0,120.0 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 60.0,61.0,62.0,63.0,64.0,65.0,66.0,67.0,68.0,69.0,70.0,71.0,72.0,73.0,74.0,75.0,76.0,77.0,78.0,79.0,80.0,81.0,82.0,83.0,84.0,85.0,86.0,87.0,88.0,89.0,90.0,91.0,92.0,93.0,94.0,95.0,96.0,97.0,98.0,99.0,100.0,101.0,102.0,103.0,104.0,105.0,106.0,107.0,108.0,109.0,110.0,111.0,112.0,113.0,114.0,115.0,116.0,117.0,118.0,119.0,120.0 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 60.0,61.0,62.0,63.0,64.0,65.0,66.0,67.0,68.0,69.0,70.0,71.0,72.0,73.0,74.0,75.0,76.0,77.0,78.0,79.0,80.0,81.0,82.0,83.0,84.0,85.0,86.0,87.0,88.0,89.0,90.0,91.0,92.0,93.0,94.0,95.0,96.0,97.0,98.0,99.0,100.0,101.0,102.0,103.0,104.0,105.0,106.0,107.0,108.0,109.0,110.0,111.0,112.0,113.0,114.0,115.0,116.0,117.0,118.0,119.0,120.0 #--no_decorations 
    
  fi
  if [ $var = "LepPt" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "LepEta" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "dPhiZ1Z2" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2017/${selection} -f ZZ4l2018NonPrompt -l 41.5 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  
done
