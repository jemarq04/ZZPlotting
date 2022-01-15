filename="FullSyst.root" #"PUapplied_20Jul2020-ZZ4l2016_Moriond.root"
#filename="Hists17Oct2019-ZZ4l2017_specialCut.root"
#filename="Hists06Mar2019-ZZ4l2017dPhi.root"
selection="ZZSelectionsTightLeps"
dir="20220112_withNewqqZZMC_exploreJetsAllVar_60120_basic_PU_full_rebin17-005_oldPOWHEG_logy"
#variable="Mass Z1Mass Z2Mass ZMass ZPt Z1Pt Z2Pt ZZPt"
#variable="Mass ZMass ZPt ZZPt LepPt LepEta dPhiZ1Z2 nJets jetPt[0] jetPt[1] jetEta[0] jetEta[1] mjj dEtajj CosTheta zeppenfeld"
#variable="dEtajj mjj Mass dPhiZ1Z2 nJets jetPt[0] jetPt[1] jetEta[0] jetEta[1]"
variable="nJets mjj dEtajj jetPt[0] jetPt[1] absjetEta[0] absjetEta[1] Mass Mass0j Mass1j Mass2j Mass3j Mass4j" #"nJets" #mjj dEtajj jetEta[0] jetEta[1] jetEta[2] jetPt[0] jetPt[1] jetPt[2] jetPhi[0] jetPhi[1] jetPhi[2] Mass Mass0j Mass1j Mass2j Mass3j Mass4j"
#variable="ZMass Z1Mass Z2Mass Mass Mass0j Mass1j Mass2j Mass3j"
#variable="absJetEta[0]_refine absJetEta[1]_refine absJetEta[0]50_refine absJetEta[1]50_refine jetPt_refine jetPhi_refine"

for var in $variable
do
  if [ $var = "CosTheta" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "nJets" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --logy --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --logy --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --logy --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --logy --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --logy --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --logy --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations 
  fi
  if [ $var = "jetPt[0]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPt[01]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetEta[01]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPt[2]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPhi[0]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPhi[1]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPhi[2]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetEta[0]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "absjetEta[0]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "absjetEta[1]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetEta[2]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta50" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPt_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPhi_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta[0]_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta[1]_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta[0]50_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta[1]50_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPt[0]50" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "jetEta[0]50" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "jetPt[1]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --logy --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetEta[1]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "mjj" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex  --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations 
    
  fi
  if [ $var = "dEtajj" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 2 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 2 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 2 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0 --ratio_range -1.0 3.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 2 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0 --ratio_range -1.0 3.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 2 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 2 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0 --ratio_range -1.0 3.0 #--no_data #--no_decorations 
    
  fi
  if [ $var = "zeppenfeld" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass0j" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass1j" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass2j" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass3j" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass4j" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "ZPt" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "ZZPt" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations 
    
  fi
  if [ $var = "ZMass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 
    
  fi
  if [ $var = "ZMass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 
    
  fi
  if [ $var = "Z1Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 
    
  fi
  if [ $var = "Z2Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 
    
  fi
  if [ $var = "LepPt" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "LepEta" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "dPhiZ1Z2" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.1 -u stat --latex --hist_file /afs/cern.ch/user/h/hehe/new_ZZ_test_Sep9/CMSSW_10_3_1/src/Analysis/VVAnalysis/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1.2 --scalelegx 1.2 #--no_decorations 
    
  fi
  
done
