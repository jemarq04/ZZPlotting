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
    print("Total number of jets: %s"%printsum)
    return hist

hname = "GennJets_"
suffix = "Gen"
 
foldername = "zz4l-amcatnlo/"#"AllData/"

fa=r.TFile(sys.argv[1])
fb=r.TFile(sys.argv[2])
r.SetOwnership(fa,False)
r.SetOwnership(fb,False)
histList = []

if foldername == "zz4l-amcatnlo/":
    swgt_hist = fa.Get(str("/".join([foldername, "sumweights"])))
    r.SetOwnership(swgt_hist, False)
    swgt = swgt_hist.Integral(0,swgt_hist.GetNbinsX()+1)
    sfac = 1.218*1.0835* 59.7*1000/swgt
else:
    sfac = 1.

# originally for data, but can also apply for MC
for fs in [fa,fb]:
    hData = fs.Get(foldername+hname+'eeee'+suffix).Clone()
  
    for channel in ['eemm'+suffix,'mmee'+suffix,'mmmm'+suffix]:
        hDatatmp = fs.Get(foldername+hname+channel).Clone()
        hData.Add(hDatatmp)

    hData.Scale(sfac)
    contents =[hData.GetBinContent(i) for i in range(1,hData.GetNbinsX()+1)]
    print(contents)


