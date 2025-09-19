if [[ $# -lt 1 ]]; then
  echo "usage: $0 YEAR [INFILE]"
  exit 1
elif [[ ! $1 =~ ^202[2-3]$ ]]; then
  echo invalid year: $1
  exit 1
fi

if [[ $1 = 2022 ]]; then lumi=34.652;
elif [[ $1 = 2023 ]]; then lumi=27.76;
fi

analysis="ZZ4l$1"
filename="Hists-ZZ4l$1.root"
filepath="$CMSSW_BASE/src/Analysis/VVAnalysis/HistFiles/$filename"
[[ ! -z $2 ]] && filepath=$2
if [[ ! -f $filepath ]]; then
  echo invalid file: $filepath
  exit 1
fi

selection="ZZSelectionsTightLeps"
variables="Mass ZMass Z1Mass Z2Mass LepPt LepEta SIP3D LepIso" 
jetvariables="nJets nJets_central Mass0jFull Mass1jFull Mass2jFull Mass34jFull absjetEta[0] absjetEta[1] jetPt[0] jetPt[1]"
channels="eeee eemm mmee mmmm"
dochannels=true
dojetplots=true

opts="-s $analysis/$selection -l $lumi -u stat --latex --hist_file $filepath --preliminary --scaleymax 1.2 --scalelegx 1.2"

dir="output"
filelist="$analysis"
for var in $variables; do
  echo ${var}

  moreopts="-f $filelist -b ${var}"
  [[ $var = "Mass" ]] && moreopts="$moreopts --rebin 100.0,200.0,250.0,300.0,350.0,400.0,500.0,600.0,800.0,1000.0"
  [[ $var =~ ^Z[12]?Mass$ ]] && moreopts="$moreopts --legend_left"

  echo "All Channels"
  ./makeHistStack.py $opts $moreopts --folder_name ${dir}
  if $dochannels; then
    for ch in $channels; do
      echo "Plotting $ch channel"
      ./makeHistStack.py $opts $moreopts --folder_name ${dir}/$ch -c $ch
    done
    if [[ $channels = *eemm* ]] && [[ $channels = *mmee* ]]; then
      echo "Plotting 2e2mu channel"
      ./makeHistStack.py $opts $moreopts --folder_name ${dir}/2e2m -c eemm,mmee
    fi
  fi
done

if $dojetplots; then
  for var in $jetvariables; do
    echo ${var}

    moreopts="-f jetplot -b ${var}"

    echo "All Channels"
    ./makeHistStack.py $opts $moreopts --folder_name ${dir}
    if $dochannels; then
      for ch in $channels; do
        echo "Plotting $ch channel"
        ./makeHistStack.py $opts $moreopts --folder_name ${dir}/$ch -c $ch
      done
      if [[ $channels = *eemm* ]] && [[ $channels = *mmee* ]]; then
        echo "Plotting 2e2mu channel"
        ./makeHistStack.py $opts $moreopts --folder_name ${dir}/2e2m -c eemm,mmee
      fi
    fi
  done
fi
