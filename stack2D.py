import ROOT as r
import pdb,subprocess,math,array
import sys,json,os
from optparse import OptionParser

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

    texS2 = r.TLatex(0.21,0.955,"Preliminary")
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
    return hist

hname = sys.argv[2] #"jetPtN1_vsJetEta_"    
nj = hname.replace("jetPtN",'').replace('_vsJetEta_','')
fullsamples = ['zz4l-amcatnlo','ggZZ4e','ggZZ4m','ggZZ4t','ggZZ2e2mu','ggZZ2e2tau']
fullkfac = [1.0835,1.7,1.7,1.7,1.7,1.7]
fullxsec = [1.218, 0.001586, 0.001586, 0.001586,0.003194,0.003194]
lumi = 59.7*1000 #name by format
lumitext = '59.7'
if '16Jet' in sys.argv[1]:
    lumi = 35.9*1000
    lumitext = '35.9'
if '17Jet' in sys.argv[1]:
    lumi = 41.5*1000
    lumitext = '41.5'
fullfac = []

fa=r.TFile(sys.argv[1])
r.SetOwnership(fa,False)


# MC samples
for s,sample in enumerate(fullsamples):
    swgt_hist = fa.Get(str("/".join([fullsamples[s], "sumweights"])))
    r.SetOwnership(swgt_hist, False)
    swgt = swgt_hist.Integral(0,swgt_hist.GetNbinsX()+1)
    sfac = fullxsec[s]*fullkfac[s]* lumi/swgt
    fullfac.append(sfac)

fullhistsa = []
            
for s,sample in enumerate(fullsamples):
    hunfat = fa.Get(fullsamples[s]+"/"+hname+'eeee').Clone()
    for channel in ['eemm','mmee','mmmm']:
        htmpat = fa.Get(fullsamples[s]+"/"+hname+channel).Clone()
        hunfat.Add(htmpat)
    
    fullhistsa.append(hunfat)

hqqZZ = fullhistsa[0]
hqqZZ.Scale(fullfac[0])
hggZZ = fullhistsa[1]
hggZZ.Scale(fullfac[1])
for s in range(2,len(fullsamples)):
    h_tmpa = fullhistsa[s]
    h_tmpa.Scale(fullfac[s])
    hggZZ.Add(h_tmpa)
   

hqqZZ = rebin2D(hqqZZ,10,10)
hqqZZ.SetFillColor(4)
hggZZ = rebin2D(hggZZ,10,10)
hggZZ.SetFillColor(2)
hMC = hqqZZ.Clone()
hMC.Add(hggZZ)

# data
hData = fa.Get("AllData/"+hname+'eeee').Clone()
for channel in ['eemm','mmee','mmmm']:
    hDatatmp = fa.Get("AllData/"+hname+channel).Clone()
    hData.Add(hDatatmp)

hData = rebin2D(hData,10,10)

c1=r.TCanvas("c",'c1',1200,800)
#c1.SetCanvasSize(960,720)
r.gPad.SetLeftMargin(0.1)
r.gPad.SetRightMargin(0.1)
c1.cd()

r.gStyle.SetOptDate(0)

hist_stack = r.THStack("qqZZ+ggZZ", "")
r.SetOwnership(hist_stack, False)
r.SetOwnership(c1, False)

r.gStyle.SetLegendFont(42)
r.gStyle.SetLegendTextSize(0.03)

phrases = ['','Subleading','Lowest']
phrase = phrases[int(nj)-1]

hMmD = hMC.Clone()
hMmD.Add(hData,-1)
hMmD.GetYaxis().SetTitle('|#eta_{j}|')
hMmD.GetXaxis().SetTitle('%s p_{T}^{j} with %s-jet Evt.'%(phrase,nj))
hMmD.GetXaxis().SetTitleOffset(1.)
hMmD.GetYaxis().SetTitleOffset(0.8)

hMmD.Draw("COL Z same")

r.gStyle.SetPaintTextFormat(".2f")
r.gStyle.SetHistMinimumZero()
hist_stack.Add(hqqZZ)
hist_stack.Add(hggZZ)
#hist_stack.Draw()
hMC.SetLineColor(4)
hData.SetBarOffset(-0.2)
#hData.SetMarkerColor(2)
hData.Draw('TEXT same')
#hData.SetLineColor(3)
hMC.SetBarOffset(0.2)

hMC.Draw("TEXT same")

texS,texS1,texS2=getLumiTextBox()


legend = r.TLegend (0.7 ,0.3 ,0.85 ,0.4)
legend.SetFillStyle(0)
legend.AddEntry(hqqZZ,"qqZZ",'f')
legend.AddEntry(hggZZ,"ggZZ",'f')
legend.AddEntry(hData,"Data")
legend.SetLineWidth (0)
#legend.Draw("same")
c1.SaveAs(hname+"full.png")
