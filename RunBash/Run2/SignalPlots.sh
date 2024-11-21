filename="TightHZZSelections_fourChan.root"
dir="AllLeptonsTight"
var="Mass"

echo "All Channels"

./makeHistStack.py -s ZZ4l2018/HZZSelections -f ZZ4l2018 -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name FakeRateControlRegionsHZZ/FourChannels/${dir} -b ${var} --preliminary --extra_text Signal_Region --scaleymax 1.2 --scalelegx 1.2

echo "Plotting 4e channel"

./makeHistStack.py -s ZZ4l2018/HZZSelections -f ZZ4l2018 -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name FakeRateControlRegionsHZZ/FourChannels/${dir}/eeee -b ${var} -c eeee --preliminary --extra_text Signal_Region --scaleymax 1.2 --scalelegx 1.2

echo "Plotting 4mu channel"

./makeHistStack.py -s ZZ4l2018/HZZSelections -f ZZ4l2018 -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name FakeRateControlRegionsHZZ/FourChannels/${dir}/mmmm -b ${var} -c mmmm --preliminary --extra_text Signal_Region --scaleymax 1.2 --scalelegx 1.2

echo "Plotting eemm channel"

./makeHistStack.py -s ZZ4l2018/HZZSelections -f ZZ4l2018 -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name FakeRateControlRegionsHZZ/FourChannels/${dir}/eemm -b ${var} -c eemm --preliminary --extra_text Signal_Region --scaleymax 1.2 --scalelegx 1.2

echo "Plotting mmee channel"

./makeHistStack.py -s ZZ4l2018/HZZSelections -f ZZ4l2018 -l 41.5 -u stat --hist_file /afs/cern.ch/user/u/uhussain/ZZ4lHistFiles/${filename} --folder_name FakeRateControlRegionsHZZ/FourChannels/${dir}/mmee -b ${var} -c mmee --preliminary --extra_text Signal_Region --scaleymax 1.2 --scalelegx 1.2
