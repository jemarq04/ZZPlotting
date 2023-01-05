import pdb
import math

#fins = ["16Info.txt","17Info.txt","18Info.txt"]
years = ["16","17","18"]
#years = []
MC = ["VVV","nonprompt","qqZZ-amcnlo","zzjj4l-ewk","ggZZ","HZZ-signal"]+["signalSum","totexp"]
MC2 = ["VVV","nonprompt","qqZZ-amcnlo","zzjj4l-ewk","ggZZ","HZZ-signal"]
MC_print = ["VVV","Nonprompt","qqZZ","ZZEWK","ggZZ","HZZ"] + ["Total signal", "Total expected"]

def sumlist(l1,l2):
    list = [a+b for (a,b) in zip(l1,l2)]
    return list

def roundlist(l,x):
    return [round(a,x) for a in l]

#return a list containing corresponding rounded numbers according to number of significant digits
def sigRound(cent,stat,up,dn=None): #central, stat. unc., syst up and dn

    sigDigit = 2
    if dn:
        cand = max(abs(up),abs(dn),abs(stat))
    else:
        cand = max(abs(up),abs(stat))

    intDigit = int(math.floor(math.log10(abs(cand))))+1 #number of integer digit, 123.4 gives 3
    num = sigDigit-intDigit

    #assume up and down have similar size, and cent always larger than up/dn
    up_r = round(up,num)
    cent_r = round(cent,num)

    
    stat_r1 = round(stat,num)
    stat_r2 = round(stat)

    if abs(stat-stat_r1) < abs(stat-stat_r2):
        stat_r = stat_r1
    else:
        stat_r = stat_r2

    list = [cent_r,stat_r,up_r]
    listf = []
    if dn:
        dn_r = round(dn,num)
        list.append(dn_r)
    
    for i in list:
        if cand >=10 and math.floor(i) == i: #turn 123.0 into 123
            listf.append(int(i))
        else:
            listf.append(i)

    return listf

    



def readSysDic(fin): # run this function for two files, one with fake rate syst, one without
    start = False
    var = ""
    dict = {}
    for jm in ["allj","0j","1j","2j","3j","4j"]:
        dict[jm] = {}
        for chan in ["allchan","eeee","eemm","mmmm"]:
            dict[jm][chan] = {}

            
            dict[jm][chan]["signal"] = [] #list of syst unc. in order [on-shell u/d Z u/d, H u/d]
            

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
            nerr = 0.
        
        if start:
            if "Channels: " in line:
                chans = line.strip().split("Channels: ")[1]
                #pdb.set_trace()
                if chans == "eeee,eemm,mmmm":
                    channel = "allchan"
                else:
                    channel = chans

            #nevt and nerr are just from previous naming for convenience, not the same meaning
            if "sys" in line:
                if not isFull: 
                    if "sys up" in line:
                        mcstr = "sys up: " 
                        nevt = float(line.strip().split(mcstr)[1])
                    #pdb.set_trace()
                        dict[nj][channel]["signal"].append(nevt)
                    else:
                        mcestr = "sys dn: " 
                        nerr= float(line.strip().split(mcestr)[1])
                        dict[nj][channel]["signal"].append(nerr)

                if isFull:
                    #this should append in correct order since first process Massxj then MassxjFull
                    if " 80-100 GeV " in line:
                        if "sys up" in line:
                            nevt = float(line.strip().split(" 80-100 GeV ")[1])
                            dict[nj][channel]["signal"].append(nevt) 
                        else:
                            nerr= float(line.strip().split(" 80-100 GeV ")[1])
                            dict[nj][channel]["signal"].append(nerr) 
                    if " 120-130 GeV " in line:
                        if "sys up" in line:
                            nevt = float(line.strip().split(" 120-130 GeV ")[1])
                            dict[nj][channel]["signal"].append(nevt) 
                        else:
                            nerr = float(line.strip().split(" 120-130 GeV ")[1])
                            dict[nj][channel]["signal"].append(nerr) 


    return dict

def readDic(fin):
    start = False
    var = ""
    dict = {}
    for jm in ["allj","0j","1j","2j","3j","4j"]:
        dict[jm] = {}
        for chan in ["allchan","eeee","eemm","mmmm"]:
            dict[jm][chan] = {}

            for mc in MC:
                dict[jm][chan][mc] = [] #list of nevt in order [on-shell, on-shell err, Z, Z err, H, H err]
            dict[jm][chan]["data"] = []
            dict[jm][chan]["signal"] = []
            dict[jm][chan]["totexp"] = []

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
            nerr = 0.
        
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
                        if not "Error" in line:
                            mcstr = ": weighted events " 
                            nevt = float(line.strip().split(mcstr)[1])
                        #pdb.set_trace()
                            dict[nj][channel][mc].append(nevt)
                        else:
                            mcestr = ": weighted events Error " 
                            nerr= float(line.strip().split(mcestr)[1])
                            dict[nj][channel][mc].append(nerr)

                    if isFull:
                        #this should append in correct order since first process Massxj then MassxjFull
                        if " 80-100 GeV " in line:
                            if not "Error" in line:
                                nevt = float(line.strip().split(" 80-100 GeV ")[1])
                                dict[nj][channel][mc].append(nevt) 
                            else:
                                nerr= float(line.strip().split(" 80-100 GeV Error ")[1])
                                dict[nj][channel][mc].append(nerr) 
                        if " 120-130 GeV " in line:
                            if not "Error" in line:
                                nevt = float(line.strip().split(" 120-130 GeV ")[1])
                                dict[nj][channel][mc].append(nevt) 
                            else:
                                nerr = float(line.strip().split(" 120-130 GeV Error ")[1])
                                dict[nj][channel][mc].append(nerr) 

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

    if yr == "Run2":
        year = "Run2"
    else:
        year = "20"+yr

    fout.write("\\begin{table}[htbp]"+"\n") 
    fout.write("\\centering"+"\n")
    fout.write("\\topcaption{The observed and expected yields of %s $\cPZ\cPZ$ events in different mass ranges,\
    and estimated yields of background\
    events, shown for each final state and\
    the total. The statistical uncertainties are presented.\
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
        #eon_tot = 0.
        #eZ_tot = 0.
        #eH_tot = 0.

        for i,mc in enumerate(MC2):
            eon,eZ,eH = dic["allj"][chan][mc][0:6:2]
            erron,errZ,errH = dic["allj"][chan][mc][1:6:2]
            
            #eon_tot += eon
            #eZ_tot += eZ
            #eH_tot += eH

            eonP,eZP,eHP = [round(x,1) for x in [eon,eZ,eH]]
            erronP,errZP,errHP = [round(x,1) for x in [erron,errZ,errH]]

            fout.write("         %s       &  %s $\\pm$ %s          &  %s $\\pm$ %s             &  %s $\\pm$ %s            \\\\"%(MC_print[i],eZP,errZP, eonP,erronP,eHP,errHP)+"\n")

            if i ==1 or mc == MC2[-1]:
                fout.write("\\hline"+"\n")
        
        #Adjust order to Z,on-shell,H, slicing last index not included
        totexplist = dic["allj"][chan]['totexp'][2:4] + dic["allj"][chan]['totexp'][0:2] + dic["allj"][chan]['totexp'][4:]
        totexplist = [round(x,1) for x in totexplist]
        fout.write("  Total expected       &  {} $\\pm$ {}            &  {} $\\pm$ {}            &  {} $\\pm$ {}            \\\\".format(*totexplist)+"\n")

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
    events, shown for each jet multiplicity. The statistical uncertainties are presented.\
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
            
            if nj==4:
                jmP = "$\\geq$%s jet"%nj
            elif nj>1:
                jmP = "%s jets"%nj
            else:
                jmP = "%s jet"%nj

        fout2.write("\multicolumn{4}{|c|}{%s} \\\\"%jmP+"\n")
        fout2.write("\\hline"+"\n")
        #eon_tot = 0.
        #eZ_tot = 0.
        #eH_tot = 0.

        for i,mc in enumerate(MC2):
            #eon,eZ,eH = dic[jm]["allchan"][mc]
            elistmc = dic[jm]["allchan"][mc][2:4] + dic[jm]["allchan"][mc][0:2] + dic[jm]["allchan"][mc][4:]
            #eon_tot += eon
            #eZ_tot += eZ
            #eH_tot += eH
            elistmc = [round(x,1) for x in elistmc]
            #eonP,eZP,eHP = [round(x,1) for x in [eon,eZ,eH]]

            fout2.write("         {}       &  {} $\\pm$ {}            &  {} $\\pm$ {}             &  {} $\\pm$ {}            \\\\".format(MC_print[i],*elistmc)+"\n")

            if i ==1 or mc == MC2[-1]:
                fout2.write("\\hline"+"\n")
        
        totexplist= dic[jm]["allchan"]["totexp"][2:4] + dic[jm]["allchan"]["totexp"][0:2] + dic[jm]["allchan"]["totexp"][4:]
        totexplist = [round(x,1) for x in totexplist]
        #eon_tot,eZ_tot,eH_tot = [round(x,1) for x in [eon_tot,eZ_tot,eH_tot]]
        fout2.write("  Total expected       &  {} $\\pm$ {}            &  {} $\\pm$ {}             &  {} $\\pm$ {}            \\\\".format(*totexplist)+"\n")

        eond,eZd,eHd = dic[jm]["allchan"]["data"]

        fout2.write("         data       &  %s            &  %s             &  %s            \\\\"%(eZd,eond,eHd)+"\n")
        fout2.write("\\hline"+"\n")
    fout2.write("\\end{tabular}"+"\n")
    fout2.write("\\label{table:resultsByJetMul_%s}"%yr+"\n")
    fout2.write("\\end{table}"+"\n")

def printTableRun2(fout,fout2,dic,dicWF,dicWOF,dicts):

    fout.write("\\begin{table}[htbp]"+"\n") 
    fout.write("\\centering"+"\n")
    fout.write("\\topcaption{The observed and expected yields of %s $\cPZ\cPZ$ events in different mass ranges,\
    and estimated yields of background\
    events, shown for each final state and\
    the total. The statistical (first) and systematic (second) uncertainties are presented.\
    }"%"Run2"+"\n")


    #Table 1, split by channels and mass range
    fout.write("\\begin{tabular}{ |l|c|c|c|c| } "+"\n")
    fout.write("\\hline"+"\n")         
    fout.write("       Process       & $\Pe\Pe\Pe\Pe$  & $\Pe\Pe\Pgm\Pgm$  & $\Pgm\Pgm\Pgm\Pgm$ & $2\ell2\ell'$  \\\\"+"\n")
    fout.write("\\hline"+"\n")  

    for zin in [2,0]: #Z range index, currently look at Z [index 2,3] and on-shell region [index 0,1], provided each list has 6 numbers version
        if zin == 0:
            fout.write("\multicolumn{5}{|c|}{$60<m_{\cPZ_1},m_{\cPZ_2}<120 GeV$} \\\\"+"\n")
            fout.write("\\hline"+"\n")
            #fout.write("                             $60<m_{\cPZ_1},m_{\cPZ_2}<120 GeV$\n")
        elif zin == 2:
            fout.write("\multicolumn{5}{|c|}{$80< m_{4\\ell} < 100 GeV$} \\\\"+"\n")
            fout.write("\\hline"+"\n")
            #fout.write("                             $80< m_{4\\ell} < 100 GeV$\n")
        bkgPstr = "         Background       "
        signalPstr = "         Signal       "
        expPstr = "         Total expected       "
        dataPstr = "         Data       "
        for chan in ["eeee","eemm","mmmm","allchan"]:
            
            #Background
            for din,d in enumerate(dicts): #Sum the event numbers for 3 years
                #if zin == 0:
                #    pdb.set_trace()
                tmpZXlist = d["allj"][chan]["nonprompt"][zin]
                tmpbkglist = sumlist(d["allj"][chan]["VVV"], d["allj"][chan]["nonprompt"])[zin]
                tmpSignal = d["allj"][chan]["signalSum"][zin]
                tmptotexp = d["allj"][chan]["totexp"][zin]
                if din == 0: #only number in current version, not list
                    bkglist = tmpbkglist
                    ZXlist = tmpZXlist
                    signalist = tmpSignal
                    totexplist = tmptotexp
                else:
                    bkglist += tmpbkglist
                    ZXlist += tmpZXlist
                    signalist +=tmpSignal
                    totexplist+=tmptotexp

            bkgsyslist = round(ZXlist*0.4,1)
            bkglist = round(bkglist,1)
            bkgerrlist = round(dic["allj"][chan]["nonprompt"][zin+1],1)
            #stands for "place holder"
            #pdb.set_trace()
            ph1,ph2,ph3 = sigRound(bkglist,bkgerrlist,bkgsyslist)
            bkgstr = "&  {} $\\pm$ {} $\\pm$ {}".format(ph1,ph2,ph3)
            bkgPstr+= bkgstr

            signalsys = dicWOF["allj"][chan]["signal"][zin:zin+2]
            signalsys = roundlist(signalsys,1)
            signalist = round(signalist,1)
            signalerr = round(dic["allj"][chan]["signalSum"][zin+1],1)
            ph1,ph2,ph3,ph4 = sigRound(signalist,signalerr,signalsys[0],signalsys[1])
            signalstr = "&  %s $\\pm$ %s $^{+%s}_{-%s}$"%(ph1,ph2,ph3,ph4)
            signalPstr += signalstr

            expsys = dicWF["allj"][chan]["signal"][zin:zin+2]
            expsys = roundlist(expsys,1)
            explist = round(totexplist,1)
            experr = round(dic["allj"][chan]["totexp"][zin+1],1)
            ph1,ph2,ph3,ph4 = sigRound(explist,experr,expsys[0],expsys[1])
            expstr = "&  %s $\\pm$ %s $^{+%s}_{-%s}$"%(ph1,ph2,ph3,ph4)
            expPstr +=expstr
        

            datalist = dic["allj"][chan]["data"][int(zin/2.)]
            datastr = "&  %s"%datalist
            dataPstr += datastr

        for x in [bkgPstr,signalPstr,expPstr,dataPstr]:
            fout.write(x+"\\\\"+"\n")
        fout.write("\\hline"+"\n") 
        #if zin == 0:
        #    fout.write(""+"\n")
    fout.write("\\end{tabular}"+"\n")
    fout.write("\\label{table:resultsByChannel_%s}"%"Run2"+"\n")
    fout.write("\\end{table}"+"\n")

    #Table 2, split by jet mult and mass range
    #print("======================================================")
    #print("")
    fout2.write("\\begin{table}[htbp]"+"\n")
    fout2.write("\\centering"+"\n")
    fout2.write("\\topcaption{The observed and expected yields of %s $\cPZ\cPZ$ events in different mass ranges,\
    and estimated yields of background\
    events, shown for each jet multiplicity. The statistical (first) and systematic (second) uncertainties are presented.\
    }"%"Run2"+"\n")

    fout2.write("\\resizebox{\\columnwidth}{!}{"+"\n")
    fout2.write("\\begin{tabular}{ |l|c|c|c|c|c| } "+"\n")
    fout2.write("\\hline"+"\n")         
    fout2.write("       Process       & 0 jet  & 1 jet & 2 jets & 3 jets & $\\geq$4 jets \\\\"+"\n")
    fout2.write("\\hline"+"\n")  

    for zin in [2,0]: #Z range index, currently look at Z [index 2,3] and on-shell region [index 0,1], provided each list has 6 numbers version
        if zin == 0:
            fout2.write("\multicolumn{6}{|c|}{$60<m_{\cPZ_1},m_{\cPZ_2}<120 GeV$} \\\\"+"\n")
            fout2.write("\\hline"+"\n")
            #fout.write("                             $60<m_{\cPZ_1},m_{\cPZ_2}<120 GeV$\n")
        elif zin == 2:
            fout2.write("\multicolumn{6}{|c|}{$80< m_{4\\ell} < 100 GeV$} \\\\"+"\n")
            fout2.write("\\hline"+"\n")
            #fout.write("                             $80< m_{4\\ell} < 100 GeV$\n")
        bkgPstr = "         Background       "
        signalPstr = "         Signal       "
        expPstr = "         Total expected       "
        dataPstr = "         Data       "
        
        for jm in ["0j","1j","2j","3j","4j"]: #allj included in 4l case
            for din,d in enumerate(dicts): #Sum the event numbers for 3 years
                tmpZXlist = d[jm]["allchan"]["nonprompt"][zin]
                tmpbkglist = sumlist(d[jm]["allchan"]["VVV"], d[jm]["allchan"]["nonprompt"])[zin]
                tmpSignal = d[jm]["allchan"]["signalSum"][zin]
                tmptotexp = d[jm]["allchan"]["totexp"][zin]
                if din == 0: #only number in current version, not list
                    bkglist = tmpbkglist
                    ZXlist = tmpZXlist
                    signalist = tmpSignal
                    totexplist = tmptotexp
                else:
                    bkglist += tmpbkglist
                    ZXlist += tmpZXlist
                    signalist +=tmpSignal
                    totexplist+=tmptotexp

            bkgsyslist = round(ZXlist*0.4,1)
            bkglist = round(bkglist,1)
            bkgerrlist = round(dic[jm]["allchan"]["nonprompt"][zin+1],1)
            ph1,ph2,ph3 = sigRound(bkglist,bkgerrlist,bkgsyslist)
            bkgstr = "&  {} $\\pm$ {} $\\pm$ {}".format(ph1,ph2,ph3)
            bkgPstr+= bkgstr

            signalsys = dicWOF[jm]["allchan"]["signal"][zin:zin+2]
            signalsys = roundlist(signalsys,1)
            signalist = round(signalist,1)
            signalerr = round(dic[jm]["allchan"]["signalSum"][zin+1],1)
            ph1,ph2,ph3,ph4 = sigRound(signalist,signalerr,signalsys[0],signalsys[1])
            signalstr = "&  %s $\\pm$ %s $^{+%s}_{-%s}$"%(ph1,ph2,ph3,ph4)
            signalPstr += signalstr

            expsys = dicWF[jm]["allchan"]["signal"][zin:zin+2]
            expsys = roundlist(expsys,1)
            explist = round(totexplist,1)
            experr = round(dic[jm]["allchan"]["totexp"][zin+1],1)
            ph1,ph2,ph3,ph4 = sigRound(explist,experr,expsys[0],expsys[1])
            expstr = "&  %s $\\pm$ %s $^{+%s}_{-%s}$"%(ph1,ph2,ph3,ph4)
            expPstr +=expstr
        

            datalist = dic[jm]["allchan"]["data"][int(zin/2.)]
            datastr = "&  %s"%datalist
            dataPstr += datastr     
        for x in [bkgPstr,signalPstr,expPstr,dataPstr]:
            fout2.write(x+"\\\\"+"\n")
        #if zin == 0:
        #    fout2.write(""+"\n")  
        fout2.write("\\hline"+"\n") 
    fout2.write("\\end{tabular}}"+"\n")
    fout2.write("\\label{table:resultsByJetMul_%s}"%"Run2"+"\n")
    fout2.write("\\end{table}"+"\n")







#Main
dicts=[]
#This works even with old 16,17,18Info.txt, but event list has 3 instead of 6 entries, and printTable won't work,
#but this can be used for first testing
for yr in years:
    with open(yr+"Info2.txt") as fin:
        with open(yr+".tex","w") as fout1:
            with open(yr+"_2.tex","w") as fout2:
                dicyr = readDic(fin) 
                dicts.append(dicyr)
                printTable(fout1,fout2,dicyr,yr)

with open("Run2Info.txt") as fin:
    with open("Run2SysWithFake.txt") as fin2:
        with open("Run2SysWithoutFake.txt") as fin3:
            with open("Run2.tex","w") as fout1:
                with open("Run2_2.tex","w") as fout2:
                    dicyr = readDic(fin) 
                    dicWF = readSysDic(fin2)
                    dicWOF = readSysDic(fin3)
                    
                    printTableRun2(fout1,fout2,dicyr,dicWF,dicWOF,dicts)
#print(dicts)



 
