filename="RECO_hadd_recovered.root" #"PUapplied_20Jul2020-ZZ4l2016_Moriond.root"
#filename="Hists17Oct2019-ZZ4l2017_specialCut.root"
#filename="Hists06Mar2019-ZZ4l2017dPhi.root"
selection="ZZSelectionsTightLeps"
#dir="20221208Recovered_FullRun2_hadd_reco_WithBand_LogyAdjusted_withfake"
dir="20230111Recovered_FullRun2_hadd_reco_WithBand_LogyAdjusted_withfake"
variable="Mass4jFull" #"MassFull Mass0jFull Mass1jFull Mass2jFull Mass3jFull Mass4jFull"  #"nJets mjj dEtajj jetPt[0] jetPt[1] absjetEta[0] absjetEta[1]" #"nJets mjj dEtajj jetPt[0] jetPt[1] absjetEta[0] absjetEta[1] Mass Mass0j Mass1j Mass2j Mass3j Mass4j" #"nJets" #mjj dEtajj jetEta[0] jetEta[1] jetEta[2] jetPt[0] jetPt[1] jetPt[2] jetPhi[0] jetPhi[1] jetPhi[2] Mass Mass0j Mass1j Mass2j Mass3j Mass4j"
#variable="ZMass Z1Mass Z2Mass Mass Mass0j Mass1j Mass2j Mass3j"
#variable="absJetEta[0]_refine absJetEta[1]_refine absJetEta[0]50_refine absJetEta[1]50_refine jetPt_refine jetPhi_refine"

for var in $variable
do
  if [ $var = "CosTheta" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "nJets" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,1.0,2.0,3.0,4.0 #--no_data #--no_decorations 
  fi
  if [ $var = "jetPt[0]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPt[01]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetEta[01]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPt[2]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPhi[0]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPhi[1]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPhi[2]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetEta[0]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "absjetEta[0]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 30 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 30 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 30 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 30 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 30 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 30 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "absjetEta[1]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetEta[2]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta50" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPt_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPhi_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta[0]_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta[1]_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta[0]50_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "absJetEta[1]50_refine" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2   #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2  #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetPt[0]50" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "jetEta[0]50" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "jetPt[1]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 #--no_data #--no_decorations 
    
  fi
  if [ $var = "jetEta[1]" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_data #--no_decorations 
    
  fi
  if [ $var = "mjj" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy  --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--rebin 100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0,1100.0,1200.0,1300.0,1400.0,1500.0,1600.0 #--no_decorations 
    
  fi
  if [ $var = "dEtajj" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 20 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0  #--no_data #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 20 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0  #--no_data #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 20 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0  #--no_data #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 20 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0  #--no_data #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 20 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0  #--no_data #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 20 --scalelegx 1.2 --rebin 0.0,0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0,6.4,6.8,7.2,7.6,8.0  #--no_data #--no_decorations 
    
  fi
  if [ $var = "zeppenfeld" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass0j" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 250 --scalelegx 1.2 --extra_text "events with 0 jet" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 250 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 250 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 250 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 250 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 250 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass1j" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 400 --scalelegx 1.2 --extra_text "events with 1 jet" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 400 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 400 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 400 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 400 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 400 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass2j" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 50 --scalelegx 1.2 --extra_text "events with 2 jets" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 50 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass3j" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --extra_text "events with 3 jets" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass4j" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 --extra_text "events with #geq 4 jets" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "ZPt" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "ZZPt" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 --rebin 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0 #--no_decorations 
    
  fi
  if [ $var = "ZMass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 
    
  fi
  if [ $var = "ZMass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 
    
  fi
  if [ $var = "Z1Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 
    
  fi
  if [ $var = "Z2Mass" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 
    
  fi
  if [ $var = "LepPt" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "LepEta" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "dPhiZ1Z2" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations   
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 7 --scalelegx 1.2 #--no_decorations 
    
  fi
  if [ $var = "MassFull" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 500 --scaleymin 500 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 140 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 140 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 140 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 140 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 140 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass0jFull" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 250 --scalelegx 1.2 --extra_text "events with 0 jet" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 250 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 250 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 250 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 250 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 250 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass1jFull" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 400 --scalelegx 1.2 --extra_text "events with 1 jet" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 400 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 400 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 400 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 400 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 400 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass2jFull" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 1000 --scalelegx 1.2 --extra_text "events with 2 jets" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 1000 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 1000 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 1000 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 1000 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 1000 --scalelegx 1.2 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass3jFull" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 400 --scalelegx 1.2 --ratio_range 0.4 2.9 --extra_text "events with 3 jets" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 140 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  if [ $var = "Mass4jFull" ];
  then
    echo ${var}
    echo "All Channels"
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir} -b ${var} --preliminary --scaleymax 180 --scalelegx 1.2 --ratio_range 0.4 2.9 --extra_text "events with #geq 4 jets" --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4e channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eeee -b ${var} -c eeee --preliminary --scaleymax 180 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting 4mu channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmmm -b ${var} -c mmmm --preliminary --scaleymax 180 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
     
    echo "Plotting eemm channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/eemm -b ${var} -c eemm --preliminary --scaleymax 180 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    echo "Plotting mmee channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/mmee -b ${var} -c mmee --preliminary --scaleymax 180 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
    echo "Plotting 2e2m  channel"
    
    ./makeHistStack.py -s ZZ4l2016/${selection} -f jetPlot -l 137.58 -u stat --latex --logy --hist_file /home/user1/cms_analysis/new_ZZ/CMSSW_10_3_1/src/ZZPlotting/HistFiles/${filename} --folder_name ${dir}/2e2m -b ${var} -c eemm,mmee --preliminary --scaleymax 180 --scalelegx 1.2 --ratio_range 0.4 2.9 --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0 
    
  fi
  
done
