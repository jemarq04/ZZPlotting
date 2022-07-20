import ROOT as r
import sys,json,os,subprocess

def getLumiTextBox():
    texS = r.TLatex(0.68,0.955, lumitext+" fb^{-1} (13 TeV)")
    texS.SetNDC()
    texS.SetTextFont(42)
    texS.SetTextSize(0.04) #0.045
    texS.SetTextColor(r.kBlack)
    texS.Draw()
    texS1 = r.TLatex(0.14,0.955,"#bf{CMS}")
    texS1.SetNDC()
    texS1.SetTextFont(42)
    texS1.SetTextColor(r.kBlack)
    texS1.SetTextSize(0.045)
    texS1.Draw()

    texS2 = r.TLatex(0.24,0.955,"Preliminary")
    texS2.SetNDC()
    texS2.SetTextFont(52)
    texS2.SetTextColor(r.kBlack)
    texS2.SetTextSize(0.04) #0.045
    texS2.Draw()
    return texS,texS1,texS2

pdfcommand=['convert']
vars = "nJets mjj dEtajj jetPt[0] jetPt[1] absjetEta[0] absjetEta[1] Mass Mass0j Mass1j Mass2j Mass3j Mass4j"
varlist = vars.split(" ")
fb = r.TFile(sys.argv[1]) #before SF
fa = r.TFile(sys.argv[2]) #after SF
for var in varlist:
    hname = var+"_jetPUSFtest"
    ha = fa.Get(hname)
    hb = fb.Get(hname)
    
    area_a = ha.Integral(1,ha.GetNbinsX())
    area_b = hb.Integral(1,hb.GetNbinsX())
    normfac = area_b/area_a #normalize events to before SF applied
    if var == "mjj":
        bincona = [ha.GetBinContent(i) for i in range(1,ha.GetNbinsX()+1)]
        
        binconb = [hb.GetBinContent(i) for i in range(1,hb.GetNbinsX()+1)]
        print(sum(binconb))
        print(sum(bincona))
        print(binconb)
        print(bincona)
    #    ha.Scale(normfac)
    hd = ha.Clone()
    hd.Add(hb,-1)
    diff = [abs(hd.GetBinContent(i)) for i in range(1,hd.GetNbinsX()+1) ]
    totdiff = sum(diff)
    change = totdiff/hb.Integral(1,hb.GetNbinsX())
    print("%s percentage change %s"%(var,round(change,3)*100))

    with open('varsFile.json') as var_json_file:
        myvar_dict = json.load(var_json_file)
    prettyVar = myvar_dict[var]["prettyVars"]
    maxs = []

    c1=r.TCanvas("canvas")
    c1.cd()
    
    r.gStyle.SetOptDate(0)
    
    hists = [ha,hb]
    labels = ["with SF","without SF"]
    colors = [2,4]
    for i in range(len(hists)):
        hists[i].SetLineColor(colors[i])
        maxs.append(hists[i].GetMaximum())
        hists[i].SetTitle("")
        hists[i].GetYaxis().SetTitle("Events") #yt
        hists[i].GetYaxis().SetTitleOffset(1)
        hists[i].GetXaxis().SetTitle(prettyVar)
        hists[i].GetXaxis().SetTitleSize(0.04)
        hists[i].GetXaxis().SetTitleOffset(1.3)
        hists[i].SetStats(0)
    
    nostat = False
    ymax = max(maxs)
    for i in range(len(hists)):
        hists[i].SetMaximum(1.2*ymax)
        #hists[i].SetMinimum(0.)
        hists[i].SetMarkerStyle(1)
        if i == 0:   
            #hists[i].Draw("HIST P")
            if nostat:
                hists[i].Draw("HIST")
            else:
                hists[i].Draw()
            r.gStyle.SetLegendFont(42)
            r.gStyle.SetLegendTextSize(0.03)
            
            legend = r.TLegend (0.7 ,0.7 ,0.85 ,0.8)
            legend.SetFillStyle(0)
        else:
            #hists[i].SetMarkerStyle(markers[i])
            #hists[i].Draw("HIST P SAME")
            if nostat:
                hists[i].Draw("HIST SAME")
            else:
                hists[i].Draw("SAME")
        legend.AddEntry(hists[i],labels[i])

    legend.SetLineWidth (0)
    legend.Draw("same")
    latex = r.TLatex()
    latex.SetNDC()
    latex.SetTextSize(0.04)
    #if 'nonreg' in sys.argv[1]:
    if '18' in sys.argv[1]:
        lumitext = '59.7'
    if '17' in sys.argv[1]:
        lumitext = '41.5'
    texS,texS1,texS2=getLumiTextBox()

    #latex.DrawLatex(0.74,0.83 ,"59.7fb^{-1}")
    dirName = 'PUSFPlots'
    if not os.path.isdir(dirName):
        os.mkdir(dirName)

    try:
        c1.SaveAs("%s/%s_PUSF.png"%(dirName,var))
    except:
        print("Problem saving plot.")
    c1.Clear()
    pdfcommand.append("%s/%s_PUSF.png"%(dirName,var))

pdfcommand.append('PUSFPlots/PUSF_plots.pdf')
subprocess.call(pdfcommand)
