import ROOT as r
import pdb,subprocess,math,array
import sys,json,os
from optparse import OptionParser

def getTextBox(x,y,axisLabel,size=0.2,color=1,rotated=False):
    texS = r.TLatex(x,y,'#color[%s]{%s}'%(color,axisLabel))
    texS.SetNDC()
    #rotate for y-axis                                                                                                                                                                                             
    if rotated:
        texS.SetTextAngle(90)
    texS.SetTextFont(42)
    #texS.SetTextColor(ROOT.kBlack)                                                                                                                                                                                
    texS.SetTextSize(size)
    texS.Draw()
    return texS

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

def rebin2D(hist, nxg,nyg):        
    #Don't use rebin right now
    #hist = hist.Rebin2D(nxg,nyg) 
    #add overflow
    nx= hist.GetNbinsX()
    ny= hist.GetNbinsY()
    for y in range(1,ny+1):
        add_overflow = hist.GetBinContent(nx,y) + hist.GetBinContent(nx + 1,y)
        add_error = math.sqrt(math.pow(hist.GetBinError(nx,y),2)+math.pow(hist.GetBinError(nx+1,y),2))
        hist.SetBinContent(nx,y, add_overflow)
        hist.SetBinError(nx,y, add_error)
        hist.SetBinContent(nx+1,y, 0.)
        hist.SetBinError(nx+1,y, 0.)

    for x in range(1,nx+1):
        add_overflow = hist.GetBinContent(x,ny) + hist.GetBinContent(x,ny+1)
        add_error = math.sqrt(math.pow(hist.GetBinError(x,ny),2)+math.pow(hist.GetBinError(x,ny+1),2))
        hist.SetBinContent(x,ny, add_overflow)
        hist.SetBinError(x,ny, add_error)
        hist.SetBinContent(x,ny+1, 0.)
        hist.SetBinError(x,ny+1, 0.)

    printsum = 0.
    for x in range(1,nx+1):
        for y in range(1,ny+1):
            printsum += hist.GetBinContent(x,y)
    print("Total number of jets: %s"%(printsum*sfac))
    return hist

hname = "jetHEM_AB_JetEtaVsPhi_"
hname2 = "jetHEM_CD_JetEtaVsPhi_"  

hname3 = "jetHEM2_AB_JetEtaVsPhiFillPt_"
hname4 = "jetHEM2_CD_JetEtaVsPhiFillPt_" 

foldername = sys.argv[3]+"/"#"zz4l-amcatnlo/"#"AllData/"

fa=r.TFile(sys.argv[1])
r.SetOwnership(fa,False)
histList = []

if foldername == "zz4l-amcatnlo/":
    swgt_hist = fa.Get(str("/".join([foldername, "sumweights"])))
    r.SetOwnership(swgt_hist, False)
    swgt = swgt_hist.Integral(0,swgt_hist.GetNbinsX()+1)
    sfac = 1.218*1.0835* 59.7*1000/swgt
else:
    sfac = 1.

# originally for data, but can also apply for MC
for hn in [hname,hname2,hname3,hname4]:
    hData = fa.Get(foldername+hn+'eeee').Clone()
  
    for channel in ['eemm','mmee','mmmm']:
        hDatatmp = fa.Get(foldername+hn+channel).Clone()
        hData.Add(hDatatmp)


    hData = rebin2D(hData,10,10)
    histList.append(hData)

c1=r.TCanvas("c",'c1',1200,800)
#c1.SetCanvasSize(960,720)
r.gPad.SetLeftMargin(0.1)
r.gPad.SetRightMargin(0.1)
c1.cd()

r.gStyle.SetOptDate(0)

r.SetOwnership(c1, False)

r.gStyle.SetLegendFont(42)
r.gStyle.SetLegendTextSize(0.03)
r.gStyle.SetPaintTextFormat(".2f")
r.gStyle.SetHistMinimumZero()

if "ratio" in sys.argv[2]:
    hData = histList[2].Clone()
    hData.Divide(histList[0]) 
    hData2 = histList[3].Clone()
    hData2.Divide(histList[1]) 
else:
    hData = histList[0].Clone()
    hData.Scale(sfac)
    hData2 = histList[1].Clone()
    hData2.Scale(sfac)
    
c1.Divide(2,1)
c1.cd(1)

hData.GetYaxis().SetTitle('#eta_{j}')
hData.GetXaxis().SetTitle('#phi_{j}')
hData.GetXaxis().SetTitleOffset(1.)
hData.GetYaxis().SetTitleOffset(0.8)

hData.Draw("COL Z same")
hData.Draw('TEXT same')

lumitext = '59.7'
texS,texS1,texS2=getLumiTextBox()
textbox= getTextBox(0.35,0.03,"Run<319077",0.06)

c1.cd(2)
hData2.GetYaxis().SetTitle('#eta_{j}')
hData2.GetXaxis().SetTitle('#phi_{j}')
hData2.GetXaxis().SetTitleOffset(1.)
hData2.GetYaxis().SetTitleOffset(0.8)

hData2.Draw("COL Z same")
hData2.Draw('TEXT same')
textbox2= getTextBox(0.35,0.03,"Run #geq 319077",0.06)



#hist_stack.Draw()

#hData.SetMarkerColor(2)

#hData.SetLineColor(3)





legend = r.TLegend (0.7 ,0.3 ,0.85 ,0.4)
legend.SetFillStyle(0)
legend.AddEntry(hData,"Data")
legend.SetLineWidth (0)
#legend.Draw("same")
if "ratio" in sys.argv[2]:
    c1.SaveAs("averagePt_HEM_etaVsphi.png")
else:
    c1.SaveAs("nJets_HEM_etaVsphi.png")