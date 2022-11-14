import pdb
#fins = ["16Info.txt","17Info.txt","18Info.txt"]
years = ["16","17"]
MC = ["VVV","nonprompt","qqZZ-amcnlo","zzjj4l-ewk","ggZZ","HZZ-signal"]
MC_print = ["VVV","Nonprompt","qqZZ","ZZEWK","ggZZ","HZZ"]

def readDic(fin):
    start = False
    var = ""
    dict = {}
    for jm in ["allj","0j","1j","2j","3j","4j"]:
        dict[jm] = {}
        for chan in ["allchan","eeee","eemm","mmmm"]:
            dict[jm][chan] = {}

            for mc in MC:
                dict[jm][chan][mc] = [] #list of nevt in order [on-shell, Z, H]
            dict[jm][chan]["data"] = []

    for line in fin:
        if "Plotting branch: " in line:
            start = True
            var = line.strip().split("Plotting branch: ")[1]
            channel = ""
            nj = var.replace("Mass","").replace("Full","")
            if nj == "":
                nj = "allj"
            isFull = "Full" in var
            nevt = 0.
        
        if start:
            if "Channels: " in line:
                chans = line.strip().split("Channels: ")[1]
                #pdb.set_trace()
                if chans == "eeee,eemm,mmee,mmmm":
                    channel = "allchan"
                elif chans == "eemm,mmee":
                    channel = "eemm"
                else:
                    channel = chans

            for mc in MC:
                if mc in line:
                    if not isFull: # only 1 line to read per MC
                        mcstr = ": weighted events" 
                        nevt = float(line.strip().split(mcstr)[1])
                        #pdb.set_trace()
                        dict[nj][channel][mc].append(nevt)

                    if isFull:
                        #this should append in correct order since first process Massxj then MassxjFull
                        if " 80-100 GeV " in line:
                            nevt = float(line.strip().split(" 80-100 GeV ")[1])
                            dict[nj][channel][mc].append(nevt) 
                        if " 120-130 GeV " in line:
                            nevt = float(line.strip().split(" 120-130 GeV ")[1])
                            dict[nj][channel][mc].append(nevt) 

            if "data" in line:
                if not isFull:
                    nevt = int(line.strip().split("Number of events in data: ")[1])
                    dict[nj][channel]["data"].append(nevt)
                    start = False

                if isFull:
                    if " 80-100 GeV" in line:
                        nevt = int(line.strip().split(" 80-100 GeV: ")[1])
                        dict[nj][channel]["data"].append(nevt) 
                    if " 120-130 GeV" in line:
                        nevt = int(line.strip().split(" 120-130 GeV: ")[1])
                        dict[nj][channel]["data"].append(nevt) 
                        start = False

    return dict

def printTable(fout,fout2,dic,yr):

    if yr == "Full":
        year = "Run2"
    else:
        year = "20"+yr

    fout.write("\\begin{table}[htbp]"+"\n") 
    fout.write("\\centering"+"\n")
    fout.write("\\topcaption{The observed and expected yields of %s $\cPZ\cPZ$ events in different mass ranges,\
    and estimated yields of background\
    events, shown for each final state and\
    the total.\
    }"%year+"\n")


    #Table 1, split by channels and mass range
    fout.write("\\begin{tabular}{ |l|c|c|c| } "+"\n")
    fout.write("\\hline"+"\n")         
    fout.write("       Process       & $80< m_{4\\ell} < 100 GeV$  & $60<m_{\cPZ_1},m_{\cPZ_2}<120 GeV$  & $120< m_{4l} < 130 GeV$ \\\\"+"\n")
    fout.write("\\hline"+"\n")  

    
    for chan in ["eeee","eemm","mmmm","allchan"]:
        if chan =="allchan":
            chanPrint = "$4\\ell$"
        else:
            chanPrint = "$"+chan.replace("e","\\Pe").replace("m","\\Pgm")+"$"

        fout.write("\multicolumn{4}{|c|}{%s} \\\\"%chanPrint+"\n")
        fout.write("\\hline"+"\n")
        eon_tot = 0.
        eZ_tot = 0.
        eH_tot = 0.

        for i,mc in enumerate(MC):
            eon,eZ,eH = dic["allj"][chan][mc]
            
            eon_tot += eon
            eZ_tot += eZ
            eH_tot += eH

            eonP,eZP,eHP = [round(x,1) for x in [eon,eZ,eH]]

            fout.write("         %s       &  %s            &  %s             &  %s            \\\\"%(MC_print[i],eZP,eonP,eHP)+"\n")

            if i ==1 or mc == MC[-1]:
                fout.write("\\hline"+"\n")
        
        eon_tot,eZ_tot,eH_tot = [round(x,1) for x in [eon_tot,eZ_tot,eH_tot]]
        fout.write("  Total expected       &  %s            &  %s             &  %s            \\\\"%(eZ_tot,eon_tot,eH_tot)+"\n")

        eond,eZd,eHd = dic["allj"][chan]["data"]

        fout.write("         data       &  %s            &  %s             &  %s            \\\\"%(eZd,eond,eHd)+"\n")
        fout.write("\\hline"+"\n")
    fout.write("\\end{tabular}"+"\n")
    fout.write("\\label{table:resultsByChannel_%s}"%yr+"\n")
    fout.write("\\end{table}"+"\n")

    #Table 2, split by jet mult and mass range
    #print("======================================================")
    #print("")
    fout2.write("\\begin{table}[htbp]"+"\n")
    fout2.write("\\centering"+"\n")
    fout2.write("\\topcaption{The observed and expected yields of %s $\cPZ\cPZ$ events in different mass ranges,\
    and estimated yields of background\
    events, shown for each jet multiplicity.\
    }"%year+"\n")

    fout2.write("\\begin{tabular}{ |l|c|c|c| } "+"\n")
    fout2.write("\\hline"+"\n")         
    fout2.write("       Process       & $80< m_{4\\ell} < 100 GeV$  & $60<m_{\cPZ_1},m_{\cPZ_2}<120 GeV$  & $120< m_{4l} < 130 GeV$ \\\\"+"\n")
    fout2.write("\\hline"+"\n")  

    
    for jm in ["0j","1j","2j","3j","4j"]: #allj included in 4l case
        
        if jm == "allj":
            jmP = "All jets"
        else:
            nj = int(jm.replace("j",""))
            if nj>1:
                jmP = "%s jets"%nj
            else:
                jmP = "%s jet"%nj

        fout2.write("\multicolumn{4}{|c|}{%s} \\\\"%jmP+"\n")
        fout2.write("\\hline"+"\n")
        eon_tot = 0.
        eZ_tot = 0.
        eH_tot = 0.

        for i,mc in enumerate(MC):
            eon,eZ,eH = dic[jm]["allchan"][mc]
            
            eon_tot += eon
            eZ_tot += eZ
            eH_tot += eH

            eonP,eZP,eHP = [round(x,1) for x in [eon,eZ,eH]]

            fout2.write("         %s       &  %s            &  %s             &  %s            \\\\"%(MC_print[i],eZP,eonP,eHP)+"\n")

            if i ==1 or mc == MC[-1]:
                fout2.write("\\hline"+"\n")
        
        eon_tot,eZ_tot,eH_tot = [round(x,1) for x in [eon_tot,eZ_tot,eH_tot]]
        fout2.write("  Total expected       &  %s            &  %s             &  %s            \\\\"%(eZ_tot,eon_tot,eH_tot)+"\n")

        eond,eZd,eHd = dic[jm]["allchan"]["data"]

        fout2.write("         data       &  %s            &  %s             &  %s            \\\\"%(eZd,eond,eHd)+"\n")
        fout2.write("\\hline"+"\n")
    fout2.write("\\end{tabular}"+"\n")
    fout2.write("\\label{table:resultsByJetMul_%s}"%yr+"\n")
    fout2.write("\\end{table}"+"\n")
#Main
dicts=[]
for yr in years:
    with open(yr+"Info.txt") as fin:
        with open(yr+".tex","w") as fout1:
            with open(yr+"_2.tex","w") as fout2:
                dicyr = readDic(fin) 
                dicts.append(dicyr)
                printTable(fout1,fout2,dicyr,yr)
#print(dicts)



 