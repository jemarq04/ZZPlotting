import ROOT
import math
from ROOT import gROOT,gStyle
from array import array
from glob import glob
import os
from collections import OrderedDict

Date='2018-03-13'
analysis='ZZ4l2018'
selection='preselectionTo4lmass-v1'
#Dir = '/hdfs/store/user/uhussain/ZZAnalysisJobs_'+Date
Dir = '/data/uhussain/ZZAnalysis_2018-03-13/FinalSelection'
outDir = '/afs/cern.ch/user/u/uhussain/www/ZZ2018Plots/Mar7'
lumi = 41.79
#ZZ4l Selection 60 < mZ1 < 120
ZZ4lSelection=True
#If you want to plot m4l in the lowmass region
lowmassRegion=True
#Plot with equal bins from 60-1000 GeV
evenBins=False
if (lowmassRegion):
    lowmass=[70.0,72.0,74.0,76.0,78.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0]
    for i in range(35):
        lowmass.append(100.0+2*(i+1))
elif(evenBins):
    lowmass=[60.0]
    for i in range(22):
        lowmass.append(60.0+20*(i+1))
    for j in range(5):
        lowmass.append(500.0+100*(j+1))
else:
    lowmass=[70.0,80.0,82.0,84.0,86.0,88.0,90.0,92.0,94.0,96.0,98.0,100.0]
    for i in range(25):
        lowmass.append(100.0+4*(i+1))
    for j in range(10):
        lowmass.append(200.0+10*(j+1))
    for k in range(5):
        lowmass.append(300.0+20*(k+1))
    highmass=[450,500,600,800,1000]
    lowmass=lowmass+highmass

arraylength=len(lowmass)-1
print("arraylength: ", arraylength)
#lowBin=lowmass[0]
#UpBin=lowmass[arraylength]
#nbins=int((UpBin-lowBin)/2.0)
#print "nbins: ",nbins," lowBin: ",lowBin, " UpBin: ",UpBin
print("lowmass: ",lowmass)
variables = ["e1_e2_Mass","m1_m2_Mass","Mass"]
channels = {"eeee":variables[2],"eemm":variables[2],"mmmm":variables[2]}
#channels = {"mmmm":variables[1]}
#mcDupCut = ROOT.TCut("duplicated==0")
Z_MASS = 91.1876
###################################################################
def createDataH1(channels):
    eras=['B','C','D','E','F']
    data = ['DoubleMuon','DoubleEG','MuonEG','SingleElectron','SingleMuon']
    dataFiles=[]
    for d in data:
        for era in eras:
            dataPath=Date+'-'+d+'_'+'Run2017'+era+'-17Nov2017-v1-'+analysis+'-'+selection
            dataDir=os.path.join(Dir,dataPath)
            #print 'dataDir: ',dataDir
            dataFiles+=glob(dataDir+"/*.root")
            #print 'dataFiles added'
    print('Length of dataFiles: ',len(dataFiles))
    for ch in channels:
        locals()['chain_{0}'.format(ch)] = ROOT.TChain(ch+"/ntuple")
    for f in dataFiles:
        for ch in channels:
            (locals()['chain_{0}'.format(ch)]).Add(f)
    #print "Chain was made"
    #print 'chain Entries: ',chain.GetEntries()
    #chain.ls()
        #chain.SetBranchStatus(variable,1)
    data_Sum = "m4l_AllChannels"
    hdataSum = ROOT.TH1F(data_Sum, data_Sum, arraylength, array('d',lowmass))
    ROOT.SetOwnership(hdataSum, False)
    for ch in channels:
        data_hist = "m4l_"+ch
        h1 = ROOT.TH1F(data_hist, data_hist, arraylength, array('d',lowmass))
    #print "can it draw"
        selvar = ["e1_e2_Mass","e3_e4_Mass","m1_m2_Mass","m3_m4_Mass"]
        if (ZZ4lSelection):
            if (ch=="eeee"):
                ZZ4lselection=selvar[0]+">60 &&"+selvar[0]+"<120 &&"+selvar[1]+">60 &&"+selvar[1]+"<120"
                (locals()['chain_{0}'.format(ch)]).Draw(channels[ch]+">>"+data_hist,"(nZZTightIsoElec+nZZTightIsoMu==4) && (Mass<115 || Mass>150) &&"+ZZ4lselection)
            elif (ch=="mmmm"):
                ZZ4lselection=selvar[2]+">60 &&"+selvar[2]+"<120 &&"+selvar[3]+">60 &&"+selvar[3]+"<120"
                (locals()['chain_{0}'.format(ch)]).Draw(channels[ch]+">>"+data_hist,"(nZZTightIsoElec+nZZTightIsoMu==4) && (Mass<115 || Mass>150) &&"+ZZ4lselection)
            else:
                ZZ4lselection=selvar[0]+">60 &&"+selvar[0]+"<120 &&"+selvar[2]+">60 &&"+selvar[2]+"<120"
                (locals()['chain_{0}'.format(ch)]).Draw(channels[ch]+">>"+data_hist,"(nZZTightIsoElec+nZZTightIsoMu==4) && (Mass<115 || Mass>150) &&"+ZZ4lselection)
        else:
            (locals()['chain_{0}'.format(ch)]).Draw(channels[ch]+">>"+data_hist,"(nZZTightIsoElec+nZZTightIsoMu==4) && (Mass<115 || Mass>150)")
            #(locals()['chain_{0}'.format(ch)]).Draw(channels[ch]+">>"+data_hist,"")
            #print "chain Draw Successful"
    #Function to retrieve mZ1 in ch=eemm
        #else:
        #    (locals()['chain_{0}'.format(ch)]).Draw("(( abs(e1_e2_Mass-91.1876)<abs(m1_m2_Mass-91.1876) ) ? e1_e2_Mass : m1_m2_Mass)>>"+data_hist, "(nZZTightIsoElec+nZZTightIsoMu==4)&&(Mass<115 || Mass>150)")
        #    #(locals()['chain_{0}'.format(ch)]).Draw("(( abs(e1_e2_Mass-91.1876)<abs(m1_m2_Mass-91.1876) ) ? e1_e2_Mass : m1_m2_Mass)>>"+data_hist, "")
        print("DataIntegral_",ch,": ",h1.Integral())
        hdataSum.Add(h1)
        h1.SetDirectory(0)

    #newBinning = map(float,lowmass)
    #newBinning = array('d',newBinning)
    #print "newBinning: ",newBinning
    #newHist = hdataSum.Rebin(len(newBinning) - 1, "RebinData", newBinning)
    #from IPython import embed
    #embed()
    #ROOT.SetOwnership(newHist, False)
    #addOverflowBinToLastBin(newHist)
    
    hdataSum.SetLineColor(ROOT.kWhite)
    hdataSum.SetLineWidth(2)
    hdataSum.SetStats(0)
    hdataSum.SetTitle("")
    hdataSum.GetXaxis().SetTitle("")
    hdataSum.GetXaxis().SetTickLength(0)
    hdataSum.GetXaxis().SetLabelOffset(999)
    hdataSum.GetYaxis().SetTitle("")
    hdataSum.GetYaxis().SetTickLength(0)
    hdataSum.GetYaxis().SetLabelOffset(999)
    return hdataSum

def createMCStack(channels,leg):
    mcSamples = {"WZTo3LNu":[4.430,"WZ3LNu"],"TTJets-amcatnlo":[815.96,"top"],"TTTo2L2Nu-powheg":[87.31,"top"],"DYJetsToLL_M10to50":[18610,"dy-jets"],
            "DYJetsToLLM-50_ext1":[6104,"dy-jets"], 
            "GluGluZZTo2e2mu":[0.00319,"ggZZ"],"GluGluZZTo2e2tau":[0.00319,"ggZZ"],"GluGluZZTo2mu2tau":[0.00319,"ggZZ"],
            "GluGluZZTo4e":[0.00159,"ggZZ"],"GluGluZZTo4mu":[0.00159,"ggZZ"],"ZZTo4L-powheg_ext1":[1.256,"qqZZ-powheg"],
            "ttH_HToZZ_4L_ext1":[0.000393,"HZZ-signal"], "WminusHToZZ_ext1":[0.000147,"HZZ-signal"],"ggHZZ_ext1":[0.01218,"HZZ-signal"],
            "WplusHToZZ_ext1":[0.000232,"HZZ-signal"],"ZHToZZ_4L":[0.000668,"HZZ-signal"]}
    plotgroups=OrderedDict([
            ("WZ3LNu",{"Name": "WZ","Style": "fill-lightpurple","Members": ["WZTo3LNu"]}),
            ("top" , {"Name" : "ttbar","Style" : "fill-yellow","Members" : ["TTJets-amcatnlo","TTTo2L2Nu-powheg"]}),
            ("HZZ-signal" , {"Name" : "HZZ","Style" : "fill-lightred","Members" : ["ggHZZ_ext1","ttH_HToZZ_4L_ext1","WminusHToZZ_ext1","WplusHToZZ_ext1","ZHToZZ_4L"]}),
            ("ggZZ", {"Name" : "ggZZ", "Style" : "fill-blue","Members" : ["GluGluZZTo4e","GluGluZZTo4mu","GluGluZZTo2e2mu","GluGluZZTo2e2tau","GluGluZZTo2mu2tau"]}),
            ("dy-jets" , {"Name" : "Drell-Yan","Style" : "fill-green","Members" : ["DYJetsToLL_M10to50","DYJetsToLLM-50_ext1"]}),
            ("qqZZ-powheg" , {"Name" : "qqZZ","Style" : "fill-lightblue","Members" : ["ZZTo4L-powheg_ext1"]}) 
            ])

    styles={"fill-lightpurple" : {"SetFillColor": ROOT.TColor.GetColor("#cab2d6"),"SetLineColor": ROOT.TColor.GetColor("#7E668A")},
            "fill-green" : {"SetFillColor": ROOT.TColor.GetColor("#4daf4a"),"SetLineColor": ROOT.TColor.GetColor("#016300")},
            "fill-yellow" : {"SetFillColor": ROOT.TColor.GetColor("#ffff33"),"SetLineColor": ROOT.TColor.GetColor("#B3B300")},
            "fill-blue" : {"SetFillColor": ROOT.kBlue,"SetLineColor": ROOT.TColor.GetColor("#00326C")},
            "fill-lightblue" : {"SetFillColor":ROOT.TColor.GetColor("#00bfff") ,"SetLineColor": ROOT.TColor.GetColor("#377eb8")},
            "fill-lightred" : {"SetFillColor":ROOT.TColor.GetColor("#ffa07a") ,"SetLineColor": ROOT.TColor.GetColor("#e41a1c")}}
    #channels = ["eeee/ntuple","eemm/ntuple", "eeee/ntuple"]  
    MCStack = ROOT.THStack("stack", "stack")
    ROOT.SetOwnership(MCStack, False)
    print(list(plotgroups.keys()))
    for plotgroup in list(plotgroups.keys()):
        members=plotgroups[plotgroup]["Members"]
        mc_Group = "m4l_AllChannels_"+plotgroup
        hmcGroup = ROOT.TH1F(mc_Group, mc_Group, arraylength, array('d',lowmass))
        for mc_Sample in members:
            #print "mcSample is: ", mc_Sample
            mcPath = Date+'-'+mc_Sample+'-'+analysis+'-'+selection
            mcDir = os.path.join(Dir,mcPath)
            #print 'mcDir: ',mcDir
            mcFiles=glob(mcDir+"/*.root")
            MetaChain = ROOT.TChain("metaInfo/metaInfo")
            
            for ch in channels:
                locals()['MCchain_{0}'.format(ch)] = ROOT.TChain(ch+"/ntuple")
            
            for g in mcFiles:
                for ch in channels:
                    (locals()['MCchain_{0}'.format(ch)]).Add(g)
                MetaChain.Add(g)

            mc_Sum = "m4l_AllChannels_"+mc_Sample
            hmcSum = ROOT.TH1F(mc_Sum, mc_Sum, arraylength, array('d',lowmass))
            for ch in channels:
                hist_name = "m4l_"+mc_Sample+"_"+ch
                hist = ROOT.TH1F(hist_name, hist_name, arraylength, array('d',lowmass))

                selvar = ["e1_e2_Mass","e3_e4_Mass","m1_m2_Mass","m3_m4_Mass"]
                if (ZZ4lSelection):
                    if (ch=="eeee"):
                        ZZ4lselection=selvar[0]+">60 &&"+selvar[0]+"<120 &&"+selvar[1]+">60 &&"+selvar[1]+"<120)"
                        (locals()['MCchain_{0}'.format(ch)]).Draw(channels[ch]+">>"+hist_name,"genWeight*((nZZTightIsoElec+nZZTightIsoMu==4) &&"+ZZ4lselection)
                    elif (ch=="mmmm"):
                        ZZ4lselection=selvar[2]+">60 &&"+selvar[2]+"<120 &&"+selvar[3]+">60 &&"+selvar[3]+"<120)"
                        (locals()['MCchain_{0}'.format(ch)]).Draw(channels[ch]+">>"+hist_name,"genWeight*((nZZTightIsoElec+nZZTightIsoMu==4) &&"+ZZ4lselection)
                    else:
                        ZZ4lselection=selvar[0]+">60 &&"+selvar[0]+"<120 &&"+selvar[2]+">60 &&"+selvar[2]+"<120)"
                        (locals()['MCchain_{0}'.format(ch)]).Draw(channels[ch]+">>"+hist_name,"genWeight*((nZZTightIsoElec+nZZTightIsoMu==4) &&"+ZZ4lselection)
                else:
                    (locals()['MCchain_{0}'.format(ch)]).Draw(channels[ch]+">>"+hist_name,"genWeight*(nZZTightIsoElec+nZZTightIsoMu==4)")
            #ROOT.SetOwnership(hist, False)
                #if (ch=="eeee" or ch=="mmmm"):
                    #(locals()['MCchain_{0}'.format(ch)]).Draw(channels[ch]+">>"+hist_name,"genWeight*(duplicated==0)")
            #Function to retrieve mZ1 in ch=eemm
                #else:
                #    (locals()['MCchain_{0}'.format(ch)]).Draw("(( abs(e1_e2_Mass-91.1876)<abs(m1_m2_Mass-91.1876) ) ? e1_e2_Mass : m1_m2_Mass)>>"+hist_name, "genWeight*(nZZTightIsoElec+nZZTightIsoMu==4)")
                #    #(locals()['MCchain_{0}'.format(ch)]).Draw("(( abs(e1_e2_Mass-91.1876)<abs(m1_m2_Mass-91.1876) ) ? e1_e2_Mass : m1_m2_Mass)>>"+hist_name, "genWeight*(duplicated==0)")
                sumweights_hist = ROOT.TH1D("sumweights", "sumweights", 1,0,100)
                MetaChain.Draw("1>>sumweights","summedWeights")
                sumweights = sumweights_hist.Integral()
                #Scale with k_NNLO = 1.1 for qqZZ and k_NNLO=1.7 for ggZZ
                if (plotgroup=="qqZZ-powheg"):
                    xsec = mcSamples[mc_Sample][0]*1000*1.1
                elif(plotgroup=="ggZZ"):
                    xsec = mcSamples[mc_Sample][0]*1000*1.7
                else:
                    xsec = mcSamples[mc_Sample][0]*1000
                hist.Scale((xsec*lumi)/sumweights)
                #Adding all the channels together for each member in a PlotGroup
                hmcSum.Add(hist)
                sumweights_hist.SetDirectory(0)
                hist.SetDirectory(0)
            #Adding all the members in a PlotGroup
            hmcGroup.Add(hmcSum)
            hmcSum.SetDirectory(0)
        #plotgroup = mcSamples[mc_Sample][1]
        style = plotgroups[plotgroup]["Style"]
        color=styles[style]["SetFillColor"]
        hmcGroup.SetFillColor(styles[style]["SetFillColor"])
        hmcGroup.SetLineColor(styles[style]["SetLineColor"])
        hmcGroup.SetLineStyle(1)
        hmcGroup.SetLineWidth(1)
        hmcGroup.SetMarkerSize(0)
        gROOT.cd()

        #newBinning = map(float,lowmass)
        #newBinning = array('d',newBinning)
        #newMcHist = hmcGroup.Rebin(len(newBinning) - 1, "RebinMC", newBinning)
        #addOverflowBinToLastBin(newMcHist)
        
        hnew = hmcGroup.Clone()
    
        #if MCStack.GetHists():
        #    print "Before length is", len(MCStack.GetHists())
        MCStack.Add(hnew)
        leg.AddEntry(hnew,plotgroups[plotgroup]["Name"],"F")
        hnew.SetDirectory(0)
        #print "length is", len(MCStack.GetHists())
        #print hist.Integral()
    #ROOT.SetOwnership(MCStack, False)
    for i in MCStack.GetHists(): print(i.GetName(), "Integral is", i.Integral())
    return MCStack
def createRatio(h1, h2):
    Nbins = h1.GetNbinsX()
    print("Nbins: ", Nbins)
    Ratio = h1.Clone("Ratio")
    hStackLast = h2.Clone("hStackLast")
    for i in range(Nbins):
        stackcontent = hStackLast.GetBinContent(i)
        print("(", hStackLast.GetXaxis().GetBinLowEdge(i),",",hStackLast.GetXaxis().GetBinUpEdge(i), ") :" ,hStackLast.GetBinWidth(i))
        if stackcontent<0:
            print("stackcontent: ", stackcontent, "and bin: ",i)
        stackerror = hStackLast.GetBinError(i)
        datacontent = h1.GetBinContent(i)
        dataerror = h1.GetBinError(i)
        #print "stackerror: ",stackerror, " and data error: ",dataerror
        #print "stackcontent: ",stackcontent," and data content: ",datacontent
        ratiocontent=0
        if(datacontent!=0):
            ratiocontent = datacontent/stackcontent
        if(datacontent!=0):
            error = ratiocontent*(math.sqrt(math.pow((dataerror/datacontent),2) + math.pow((stackerror/stackcontent),2)))
        else:
            error = 2.07
        #print "ratio content: ",ratiocontent," and error: ",error
        if(ratiocontent!=0):
            Ratio.SetBinContent(i,ratiocontent)
            Ratio.SetBinError(i,error)

    Ratio.GetYaxis().SetRangeUser(0.0,2.2)
    Ratio.SetStats(0)
    Ratio.GetYaxis().CenterTitle()
    Ratio.SetMarkerStyle(20)
    Ratio.SetMarkerSize(0.7)
    xaxis=Ratio.GetXaxis()
    line = ROOT.TLine(xaxis.GetBinLowEdge(xaxis.GetFirst()), 1.,xaxis.GetBinUpEdge(xaxis.GetLast()), 1.)
    line.SetLineStyle(ROOT.kDotted)

    Ratio.GetYaxis().SetLabelSize(0.14)
    Ratio.GetYaxis().SetTitleSize(0.12)
    Ratio.GetYaxis().SetLabelFont(42)
    Ratio.GetYaxis().SetTitleFont(42)
    Ratio.GetYaxis().SetTitleOffset(0.25)
    Ratio.GetYaxis().SetNdivisions(100)
    Ratio.GetYaxis().SetTickLength(0.05)

    Ratio.GetXaxis().SetLabelSize(0.15)
    Ratio.GetXaxis().SetTitleSize(0.12)
    Ratio.GetXaxis().SetLabelFont(42)
    Ratio.GetXaxis().SetTitleFont(42)
    Ratio.GetXaxis().SetTitleOffset(0.90)
    Ratio.GetXaxis().SetTickLength(0.05)
    #Ratio.Draw("pex0")
    #line.SetLineColor(kBlack)
    #line.Draw("same");

    return Ratio,line

def createCanvasPads():
    c = ROOT.TCanvas("c", "canvas", 800, 800)
    gStyle.SetOptStat(0)
    gStyle.SetLegendBorderSize(0)
    # Upper histogram plot is pad1
    pad1 = ROOT.TPad("pad1", "pad1", 0.01, 0.25, 0.99, 0.99)
    pad1.Draw()
    pad1.cd()
    pad1.SetFillColor(0)
    pad1.SetFrameBorderMode(0)
    pad1.SetBorderMode(0)
    pad1.SetBottomMargin(0)  # joins upper and lower plot
    return c,pad1

def createPad2(canvas):
    texS = ROOT.TLatex(0.20,0.837173,"#sqrt{s} = 13 TeV, 41.8 fb^{-1}")
    texS.SetNDC()
    texS.SetTextFont(42)
    texS.SetTextSize(0.040)
    texS.Draw()
    texS1 = ROOT.TLatex(0.12092,0.907173,"#bf{UW} #it{Internal}")
    texS1.SetNDC()
    texS1.SetTextFont(42)
    texS1.SetTextSize(0.040)
    texS1.Draw()
    # Lower ratio plot is pad2
    canvas.cd()  # returns to main canvas before defining pad2
    pad2 = ROOT.TPad("pad2", "pad2", 0.01, 0.01, 0.99, 0.25)
    pad2.Draw()
    pad2.cd()
    pad2.SetFillColor(0)
    pad2.SetFrameBorderMode(0)
    pad2.SetBorderMode(0)
    pad2.SetTopMargin(0)  # joins upper and lower plot
    pad2.SetBottomMargin(0.2)
    #pad2.SetGridx()
    #pad2.Draw()
    return texS,texS1,pad2

def stackplot(channels):
    # create required parts

    c,pad1 = createCanvasPads()
    h1 = createDataH1(channels)
    print("Data Integral (AllChannels): ", h1.Integral())
    Datamaximum = h1.GetMaximum()
    leg = ROOT.TLegend(0.20,0.54,0.48,0.84,"")
    leg.AddEntry(h1,"Data")
    hStack = createMCStack(channels,leg)
    
    #Where is this negative stackContent coming from? its possible because of genWeight
    #for i in hStack.GetHists(): print i.GetName(), "BinContent(36) is: ", i.GetBinContent(36)
    h2 = hStack.GetStack().Last()
    #h2.SetFillColor(ROOT.kBlue)
    print("Total Stack Integral",h2.Integral())
    Stackmaximum = h2.GetMaximum()
    hStack.SetTitle("m4l_AllChannels")
    hStack.Draw("HIST")
    hStack.SetMinimum(0)
    if(Datamaximum > Stackmaximum):
        hStack.SetMaximum(Datamaximum*1.6)
    else:
        hStack.SetMaximum(Stackmaximum*1.6)


    if (lowmassRegion):
        hStack.GetYaxis().SetTitle("Events / 2 GeV")
    elif(evenBins): 
        hStack.GetYaxis().SetTitle("Events / 20 GeV")
    else:
        hStack.GetYaxis().SetTitle("Events / 2 GeV")
    hStack.GetYaxis().SetTitleOffset(1.0)
    hStack.Draw("HIST")
    h1.SetLineColor(ROOT.kBlack)
    h1.SetMarkerStyle(20)
    h1.SetMarkerSize(1.0)
    h1.Draw("pex0same")
    
    leg.SetFillColor(ROOT.kWhite)
    leg.SetFillStyle(0)
    leg.SetTextSize(0.025)
    leg.Draw()

    #SecondPad
    texS,texS1,pad2 = createPad2(c)
    #Starting the ratio proceedure
    Ratio,line = createRatio(h1, h2)
    Ratio.Draw("pex0")
    line.SetLineColor(ROOT.kBlack)
    line.Draw("same")

    #redraw axis
    Xaxis=h1.GetXaxis()
    xStart = Xaxis.GetBinLowEdge(Xaxis.GetFirst())
    xEnd = Xaxis.GetBinUpEdge(Xaxis.GetLast())
    xaxis = ROOT.TGaxis(xStart,0,xEnd,0,xStart,xEnd,510)
    xaxis.SetTitle("m_{4l} (GeV)")
    xaxis.SetLabelFont(42)
    xaxis.SetLabelSize(0.10)
    xaxis.SetTitleFont(42)
    xaxis.SetTitleSize(0.12)
    xaxis.SetTitleOffset(0.70)
    xaxis.Draw("SAME")

    yaxis = ROOT.TGaxis(xStart,0,xStart,2.2,0,2.2,6,"")
    yaxis.SetTitle("Data/MC")
    yaxis.SetLabelFont(42)
    yaxis.SetLabelSize(0.10)
    yaxis.SetTitleFont(42)
    yaxis.SetTitleSize(0.12)
    yaxis.SetTitleOffset(0.35)
    yaxis.Draw("SAME")

    c.Update()
    #print hStack.ls()
    #hStack.GetYaxis().SetTitle("Events / 2 GeV")
    #hStack.GetYaxis().SetTitleOffset(1.0)
    #c, pad1, pad2 = createCanvasPads()
    #c = createCanvasPads()
    # draw everything
    #pad1.cd()
    #c.cd()
    #h1.Draw("pex0")
    #hStack.Draw("HIST SAME")
    #h1.Draw("pex0same")
    # to avoid clipping the bottom zero, redraw a small axis
    #h1.GetYaxis().SetLabelSize(0.0)
    #maximum = h1.GetMaximum()
    #print "h1.GetMaximum(): ", maximum
    #axis = ROOT.TGaxis(0, 120, 0, maximum*1.2, 120, maximum*1.2, 510, "")
    #axis.SetLabelFont(43)
    #axis.SetLabelSize(15)
    #axis.Draw()
    #pad2.cd()
    #h3.Draw("ep")

    if (lowmassRegion):
        if (ZZ4lSelection): 
            c.SaveAs("DataMCPlots_Mar29/ZZ4l_AllChannels_blinded_lowmass_70-170"+Date+".pdf")  
        else:
            c.SaveAs("DataMCPlots_Mar29/FullSpectrum_AllChannels_blinded_lowmass_70-170"+Date+".pdf")  
        #c.SaveAs("DataMCPlots_Mar29/Mass4l_AllChannels_blinded_lowmass_70-170"+Date+".root")  
    elif (evenBins):
        if (ZZ4lSelection): 
            c.SaveAs("DataMCPlots_Mar29/ZZ4l_AllChannels_blinded_evenBinsTest_60-1000"+Date+".pdf")  
        else:
            c.SaveAs("DataMCPlots_Mar29/FullSpectrum_AllChannels_blinded_evenBinsTest_60-1000"+Date+".pdf")  
    else:
        if (ZZ4lSelection): 
            c.SaveAs("DataMCPlots_Mar29/ZZ4l_AllChannels_blinded_fullmass"+Date+".pdf")  
        else:
            c.SaveAs("DataMCPlots_Mar29/FullSpectrum_AllChannels_blinded_fullmass"+Date+".pdf")  
        #c.SaveAs("DataMCPlots_Mar29/Mass4l_AllChannels_blinded_fullmass"+Date+".root") 
    #text = raw_input()
    from IPython import embed
    embed()

if __name__ == "__main__":
    stackplot(channels)
