import ROOT
import glob
import os
import logging
import re
from IPython import embed

def getHistFromFile(root_file, name_in_file, rename, path_to_hist):
    if not root_file:
        print('Failed to open %s' % file)
        exit(0)
    hist = ROOT.TH1D()   
    if path_to_hist != "":
        name_in_file = path_to_hist.join(["/", name_in_file]) 
    hist = root_file.Get(name_in_file)
    if not hist:
        print('Failed to get hist %s from file' % name_in_file)
        exit(0)
    hist.SetDirectory(ROOT.gROOT) # detach "hist" from the file
    if rename != "":
        hist.SetName(rename)
    return hist
def loadHistFromChain(hist, file_list, path_to_tree, branch_name,
                     cut_string, max_entries, append=False):
    tree = ROOT.TChain(path_to_tree)
    for file_name in file_list:
        tree.Add(file_name)
    loadHist(hist, tree, branch_name, cut_string, max_entries, append)
def loadHistFromTree(hist, root_file, path_to_tree, branch_name, 
                     cut_string, max_entries, append=False):
    if not root_file:
        print('Failed to open %s' % root_file)
        exit(0)
    tree = root_file.Get(path_to_tree)
    loadHist(hist, tree, branch_name, cut_string, max_entries, append)
def loadHist(hist, tree, branch_name, cut_string, max_entries, append=False):
    if not tree:
        print('Failed to get tree from file')
        exit(0)
    hist.GetDirectory().cd() 
    hist_name = "".join(["+ " if append else "", hist.GetName()])
    print("name is %s" % hist_name)
    old_num = hist.GetEntries()
    num = tree.Draw(branch_name + ">>" + hist_name, 
            cut_string,
            "",
            max_entries if max_entries > 0 else 1000000000)
    print("Draw Comand is %s" % branch_name + ">>" + hist_name)
    print("With cut string %s" % cut_string)
    if append:
        if num < old_num:
            print("Failed to append to hist")
    #else:
    #    hist.SetDirectory(ROOT.gROOT) # detach "hist" from the file
    print(hist.GetEntries())
    return num
# Modified from Nick Smith, U-Wisconsin
# https://gitlab.cern.ch/ncsmith/monoZ/blob/master/plotter/plotting/splitCanvas.py
def splitCanvas(oldcanvas, dimensions, ratio_text, ratio_range):
    stacks = [p for p in oldcanvas.GetListOfPrimitives() if type(p) is ROOT.THStack and "signal" not in p.GetName()]
    signal_stacks = [p for p in oldcanvas.GetListOfPrimitives() if type(p) is ROOT.THStack and "signal" in p.GetName()]
    data_list = [p for p in oldcanvas.GetListOfPrimitives() if type(p) is ROOT.TH1D and 'data' in p.GetName().lower()]
    compareData = True
    stack_hists = [i for s in stacks for i in s.GetHists()]
    signal_hists = [i for s in signal_stacks for i in s.GetHists()]
    if len(data_list) == 0:
        compareData = False
    elif len(stack_hists) < 2:
        print("Can't form ratio from < 2 histograms")
        return oldcanvas
    name = oldcanvas.GetName()
    canvas = ROOT.TCanvas(name+'__new', name, *dimensions)
    ratioPad = ROOT.TPad('ratioPad', 'ratioPad', 0., 0., 1., .3)
    #ratioPad.SetLogx()
    ratioPad.Draw()
    stackPad = ROOT.TPad('stackPad', 'stackPad', 0., 0.3, 1., 1.)
    #stackPad.SetLogx()
    stackPad.Draw()
    stackPad.cd()
    #oldcanvas.SetLogx()
    oldcanvas.DrawClonePad()
    del oldcanvas
    oldBottomMargin = stackPad.GetBottomMargin()
    stackPad.SetBottomMargin(0.)
    stackPad.SetTopMargin(stackPad.GetTopMargin()/0.7)
    canvas.SetName(name)
    ratioPad.cd()
    ratioPad.SetBottomMargin(oldBottomMargin/.3)
    #ratioPad.SetTopMargin(0.03)
    ratioPad.SetTopMargin(0.05)
    ratioHists = data_list if compareData else (stack_hists+signal_hists)[1:]
    ratioHists = [h.Clone(h.GetName()+"_ratioHist") for h in ratioHists]
    centralRatioHist = stack_hists[0].Clone(name+'_central_ratioHist')
    if compareData:
        errors = 0
        for primitive in stackPad.GetListOfPrimitives():
            if "errors" in primitive.GetName() and primitive.InheritsFrom("TH1"):
                errors = primitive
        if errors:
            centralRatioHist = errors.Clone(centralRatioHist.GetName())
        elif len(stack_hists) > 1:
            list(map(centralRatioHist.Add, stack_hists[1:]))
    centralHist = centralRatioHist.Clone("temp")
    centralRatioHist.SetFillColor(ROOT.TColor.GetColor("#828282"))
    #centralRatioHist.SetFillStyle(1001)
    centralRatioHist.SetFillStyle(3345)
    centralRatioHist.SetMarkerSize(0)
    if compareData:
        ratioHist = ratioHists[0]
        tmpData = ratioHist.Clone("tmp")
        ratioHist.Divide(centralHist)
        ratioGraph = ROOT.TGraphAsymmErrors(ratioHist)
        ratioHists = [ratioGraph]
        for i in range(1, tmpData.GetNbinsX()+2):
            if centralRatioHist.GetBinContent(i) == 0: 
                continue
            errorUp = (tmpData.GetBinContent(i)+tmpData.GetBinErrorUp(i))/centralRatioHist.GetBinContent(i)
            errorUp -= ratioHist.GetBinContent(i) 
            errorDown = (tmpData.GetBinContent(i)-tmpData.GetBinErrorLow(i))/centralRatioHist.GetBinContent(i)
            errorDown = ratioHist.GetBinContent(i) - errorDown
            ratioGraph.SetPointEYhigh(i-1, errorUp)
            ratioGraph.SetPointEYlow(i-1, errorDown)
    else:
        for ratioHist in ratioHists:
            tmpRatio = ratioHist.Clone("tempRatio")
            ratioHist.Divide(centralHist)
            for i in range(ratioHist.GetNbinsX()+2):
                denom = tmpRatio.GetBinContent(i)
                if denom == 0: continue
                ratioHist.SetBinError(i, tmpRatio.GetBinError(i)/denom)
            ratioHist.Sumw2()
            del tmpRatio
    for i in range(centralRatioHist.GetNbinsX()+2):
        denom = centralHist.GetBinContent(i)
        if denom == 0: continue
        centralRatioHist.SetBinError(i, centralHist.GetBinError(i)/denom)
        centralRatioHist.SetBinContent(i, 1.)
    stack_hists[0].GetXaxis().Copy(centralRatioHist.GetXaxis())
    stack_hists[0].GetXaxis().Copy(centralRatioHist.GetXaxis())
    if len(signal_stacks) > 0:
        signal_stacks[0].GetXaxis().Copy(centralRatioHist.GetXaxis())
        signal_stacks[0].GetXaxis().Copy(centralRatioHist.GetXaxis())
    centralRatioHist.GetYaxis().SetTitle(ratio_text)
    centralRatioHist.GetXaxis().SetLabelOffset(0.03)
    centralRatioHist.GetYaxis().CenterTitle()
    centralRatioHist.GetYaxis().SetRangeUser(*ratio_range)
    centralRatioHist.GetYaxis().SetNdivisions(3)
    centralRatioHist.GetYaxis().SetTitleSize(centralRatioHist.GetYaxis().GetTitleSize()*0.8)
    centralRatioHist.GetYaxis().SetLabelSize(centralRatioHist.GetYaxis().GetLabelSize()*0.8)
    centralRatioHist.Draw("E2")
    #centralRatioHist.Draw()
    for ratioHist in ratioHists:
        drawOpt = "same"
        if not compareData:
            ratioHist.SetMarkerSize(0)
            ratioHist.SetMarkerColor(ratioHist.GetLineColor())
            ratioHist.SetFillColor(ratioHist.GetLineColor())
            ratioHist.SetLineStyle(1)
            #drawOpt += " E2"
            #drawOpt += " hist"
        else:
            drawOpt += " PZE0"
        ratioHist.Draw(drawOpt)
    stacks = [p for p in stackPad.GetListOfPrimitives() if type(p) is ROOT.THStack]
    for stack in stacks:
        stack.GetXaxis().SetTitle("")
        stack.GetXaxis().SetLabelOffset(999)
    xaxis = centralRatioHist.GetXaxis()
    line = ROOT.TLine(xaxis.GetBinLowEdge(xaxis.GetFirst()), 1, xaxis.GetBinUpEdge(xaxis.GetLast()), 1)
    #line = ROOT.TLine(xaxis.GetBinLowEdge(4), 1, xaxis.GetBinUpEdge(26), 1)
    line.SetLineStyle(ROOT.kDotted)
    line.Draw()
    recursePrimitives(stackPad, fixFontSize, 1/0.7)
    stackPad.Modified()
    isLong = stackPad.GetWw()/stackPad.GetWh() > 1.1
    recursePrimitives(ratioPad, fixFontSize, 1/0.27, 0.85 if isLong else 1.15)
    yaxis_ratio = centralRatioHist.GetYaxis()
    #yaxis_ratio.SetTitleOffset(.3) 
    if "unrolled" in name:
        xaxis.SetLabelSize(0.172)
        xaxis.SetLabelOffset(0.027)
        xaxis.SetTitleOffset(1.07)
    ratioPad.Modified()
    canvas.Update()
    ROOT.SetOwnership(stackPad, False)
    # stackPad already owns primitives
    ROOT.SetOwnership(ratioPad, False)
    for obj in ratioPad.GetListOfPrimitives():
        ROOT.SetOwnership(obj, False)
    ratioPad.GetListOfPrimitives().SetOwner(True)
    ratioPad.RedrawAxis()
    canvas.cd()
    canvas.GetListOfPrimitives().SetOwner(True)
    return canvas
# Also from Nick Smith
def recursePrimitives(tobject, function, *fargs) :
    function(tobject, *fargs)
    if hasattr(tobject, 'GetListOfPrimitives') :
        primitives = tobject.GetListOfPrimitives()
        if primitives :
            for item in primitives :
                recursePrimitives(item, function, *fargs)
    other_children = ['Xaxis', 'Yaxis']#, 'Zaxis']
    for child in other_children :
        if hasattr(tobject, 'Get'+child) :
            childCall = getattr(tobject, 'Get'+child)
            recursePrimitives(childCall(), function, *fargs)
    checkForZ = not 'TH1' in tobject.ClassName() and not \
        (type(tobject) is ROOT.THStack and tobject.GetHistogram().GetDimension()==1)
    if hasattr(tobject, 'GetZaxis') and checkForZ:
        childCall = getattr(tobject, 'GetZaxis')
        recursePrimitives(childCall(), function, *fargs)
        
def fixFontSize(item, scale, axisOffsetScale=1) :
    if 'TH' in item.ClassName() :
        return
    if item.GetName() == 'yaxis' :
        item.SetTitleOffset(item.GetTitleOffset()/scale*axisOffsetScale)
    sizeFunctions = ['LabelSize', 'TextSize', 'TitleSize']
    for fun in sizeFunctions :
        if hasattr(item, 'Set'+fun) :
            getattr(item, 'Set'+fun)(getattr(item, 'Get'+fun)()*scale)

def readStyle(canvas) :
    style = ROOT.TStyle(canvas.GetName()+"_style", "Read style")
    style.cd()
    style.SetIsReading()
    canvas.UseCurrentStyle()
    style.SetIsReading(False)
    return style
def getHistErrors(hist):
    histErrors = hist.Clone()
    histErrors.SetName(hist.GetName() + "_errors")
    histErrors.SetDirectory(0)
    setErrorsStyle(histErrors)
    if not histErrors.GetSumw2(): histErrors.Sumw2()
    histErrors.SetFillStyle(3345)
    histErrors.SetFillColor(ROOT.TColor.GetColor("#a8a8a8"))
    histErrors.SetLineColor(ROOT.TColor.GetColor("#a8a8a8"))
    histErrors.SetLineWidth(1)
    ROOT.gStyle.SetHatchesLineWidth(1)
    ROOT.gStyle.SetHatchesSpacing(0.75)
    return histErrors
def setErrorsStyle(histErrors):
    histErrors.SetMarkerSize(0)
    histErrors.SetFillStyle(3345)
    histErrors.SetFillColor(ROOT.TColor.GetColor("#a8a8a8"))
    histErrors.SetLineColor(ROOT.TColor.GetColor("#a8a8a8"))


def splitCanvasWithSyst(ratioband,oldcanvas, dimensions, ratio_text, ratio_range,isMassFull,varname):
    stacks = [p for p in oldcanvas.GetListOfPrimitives() if type(p) is ROOT.THStack and "signal" not in p.GetName()]
    signal_stacks = [p for p in oldcanvas.GetListOfPrimitives() if type(p) is ROOT.THStack and "signal" in p.GetName()]
    data_list = [p for p in oldcanvas.GetListOfPrimitives() if type(p) is ROOT.TH1D and 'data' in p.GetName().lower()]
    compareData = True
    stack_hists = [i for s in stacks for i in s.GetHists()]
    signal_hists = [i for s in signal_stacks for i in s.GetHists()]
    if len(data_list) == 0:
        compareData = False
    elif len(stack_hists) < 2:
        print("Can't form ratio from < 2 histograms")
        return oldcanvas
    name = oldcanvas.GetName()
    #ROOT.gStyle.SetLineWidth(3)
    canvas = ROOT.TCanvas(name+'__new', name, *dimensions)
    ratioPad = ROOT.TPad('ratioPad', 'ratioPad', 0., 0., 1., .3)
    #ratioPad.SetFrameLineWidth(3)
    if isMassFull:
        ratioPad.SetLogx()
    ratioPad.Draw()
    stackPad = ROOT.TPad('stackPad', 'stackPad', 0., 0.3, 1., 1.)
    #stackPad.SetLogx()
    stackPad.Draw()
    stackPad.cd()
    if isMassFull:
        oldcanvas.SetLogx()
    oldcanvas.DrawClonePad()
    del oldcanvas
    oldBottomMargin = stackPad.GetBottomMargin()
    stackPad.SetBottomMargin(0.)
    stackPad.SetTopMargin(stackPad.GetTopMargin()/0.7)
    canvas.SetName(name)
    ratioPad.cd()
    ratioPad.SetBottomMargin(oldBottomMargin/.3)
    #ratioPad.SetTopMargin(0.03)
    ratioPad.SetTopMargin(0.05)
    ratioHists = data_list if compareData else (stack_hists+signal_hists)[1:]
    ratioHists = [h.Clone(h.GetName()+"_ratioHist") for h in ratioHists]
    centralRatioHist = stack_hists[0].Clone(name+'_central_ratioHist')
    #if compareData, centralRatioHist is the MC statck, otherwise it is just the first hist in the stackf for comparing with remaining ones
    if compareData:
        errors = 0
        for primitive in stackPad.GetListOfPrimitives():
            if "errors" in primitive.GetName() and primitive.InheritsFrom("TH1"):
                errors = primitive
        if errors:
            centralRatioHist = errors.Clone(centralRatioHist.GetName()) #stat error_hist is also just sum of MC stack
        elif len(stack_hists) > 1:
            list(map(centralRatioHist.Add, stack_hists[1:]))
    centralHist = centralRatioHist.Clone("temp") #just a copy of original centralratiohist for dividing
    centralHist2 = centralRatioHist.Clone("temp2")
    centralRatioHist.SetFillColor(ROOT.TColor.GetColor("#828282"))
    #centralRatioHist.SetFillStyle(1001)
    centralRatioHist.SetFillStyle(3345)
    centralRatioHist.SetFillColorAlpha(0,0.0)
    centralRatioHist.SetMarkerSize(0)

    #=================================
    #This part set up the main ratio 
    switch_ratio = False #if True, use prediction/data instead of data/prediciton like default
    pois_ratio = True
    if compareData:
        if switch_ratio:
            ratioHist = centralHist2
            tmpData = ratioHists[0].Clone("tmp")
            ratioHist.Divide(tmpData)
        else:
            ratioHist = ratioHists[0] #just data hist
            tmpData = ratioHist.Clone("tmp")
            if not pois_ratio: #if pois_ratio, divide with TGraphAsymmErrors::divide
                ratioHist.Divide(centralHist)

        #data/MC or MC/data, ratioHists will be updated to graph for compareData=True
        if not pois_ratio:
            ratioGraph = ROOT.TGraphAsymmErrors(ratioHist)
        else:
            ratioGraph = ROOT.TGraphAsymmErrors()
            ratioGraph.Divide(ratioHist,centralHist,"pois")

        ratioHists = [ratioGraph]
        for i in range(1, tmpData.GetNbinsX()+2): #don't understand the need for +2

            if not switch_ratio:
                if centralRatioHist.GetBinContent(i) == 0: 
                    continue
            if switch_ratio:
                if tmpData.GetBinContent(i) == 0: 
                    continue

            #Don't understand why not just extract errorUp/Down from ratio hist => to preserve poisson error in numerator

            if not switch_ratio:
                errorUp = (tmpData.GetBinContent(i)+tmpData.GetBinErrorUp(i))/centralRatioHist.GetBinContent(i)
                errorUp -= ratioHist.GetBinContent(i) 
                errorDown = (tmpData.GetBinContent(i)-tmpData.GetBinErrorLow(i))/centralRatioHist.GetBinContent(i)
                errorDown = ratioHist.GetBinContent(i) - errorDown

            if switch_ratio:
                errorUp = ratioHist.GetBinErrorUp(i)
                errorDown = ratioHist.GetBinErrorLow(i)

            if not pois_ratio:
                ratioGraph.SetPointEYhigh(i-1, errorUp)
                ratioGraph.SetPointEYlow(i-1, errorDown)
    #=====================================

    else:
        for ratioHist in ratioHists:
            tmpRatio = ratioHist.Clone("tempRatio")
            ratioHist.Divide(centralHist)
            for i in range(ratioHist.GetNbinsX()+2):
                denom = tmpRatio.GetBinContent(i)
                if denom == 0: continue
                ratioHist.SetBinError(i, tmpRatio.GetBinError(i)/denom)
            ratioHist.Sumw2()
            del tmpRatio
    
    #================================================
    #Set centralRaitoHist stat error and set value to 1., doesn't matter now since it is not drawn
    for i in range(centralRatioHist.GetNbinsX()+2):
        denom = centralHist.GetBinContent(i)
        if denom == 0: continue
        centralRatioHist.SetBinError(i, centralHist.GetBinError(i)/denom)
        centralRatioHist.SetBinContent(i, 1.)
    #================================================

    stack_hists[0].GetXaxis().Copy(centralRatioHist.GetXaxis())
    stack_hists[0].GetXaxis().Copy(centralRatioHist.GetXaxis())
    if len(signal_stacks) > 0:
        signal_stacks[0].GetXaxis().Copy(centralRatioHist.GetXaxis())
        signal_stacks[0].GetXaxis().Copy(centralRatioHist.GetXaxis())

    #==================================================
    #CentralRatioHist originally used to draw stat error band in ratio 
    centralRatioHist.GetYaxis().SetTitle(ratio_text)
    #centralRatioHist.GetYaxis().SetTitleOffset(2)
    centralRatioHist.GetXaxis().SetLabelOffset(0.03)
    if "Mass" in varname and "Full" in varname:
        centralRatioHist.GetXaxis().SetMoreLogLabels(True)
        centralRatioHist.GetXaxis().SetTickLength(0.07)
        centralRatioHist.GetXaxis().SetLabelSize(0.025)
        centralRatioHist.GetXaxis().ChangeLabel(1,-1,0.,-1,-1,-1,"")
    if "nJets" in varname:
        #centralRatioHist.GetXaxis().SetNdivisions(505)
        centralRatioHist.GetXaxis().CenterLabels(True)
        centralRatioHist.GetXaxis().ChangeLabel(4,-1,-1,-1,-1,-1,"#geq 3") #require higher CMSSW than current 8_0_26
        centralRatioHist.GetXaxis().SetTitle("Number of jets") # Fixed title, remove >30GeV text
        if "_central" in varname:
            centralRatioHist.GetXaxis().SetTitle("Number of central jets")
    if varname == "mjj":
        centralRatioHist.GetXaxis().SetTitle("Dijet mass [GeV]")
    if varname == "dEtajj":
        centralRatioHist.GetXaxis().SetTitle("|#Delta#eta(j_{1}, j_{2})|")
    if varname == "jetPt[0]":
        centralRatioHist.GetXaxis().SetTitle("p_{T}^{j1} [GeV]")
    if varname == "jetPt[1]":
        centralRatioHist.GetXaxis().SetTitle("p_{T}^{j2} [GeV]")
    if varname == "absjetEta[0]":
        centralRatioHist.GetXaxis().SetTitle("|#eta_{j1}|")
    if varname == "absjetEta[1]":
        centralRatioHist.GetXaxis().SetTitle("|#eta_{j2}|")
    
    centralRatioHist.GetYaxis().CenterTitle()
    centralRatioHist.GetYaxis().SetRangeUser(*ratio_range)
    centralRatioHist.GetYaxis().SetNdivisions(3)
    centralRatioHist.GetYaxis().SetTitleSize(centralRatioHist.GetYaxis().GetTitleSize()*0.8)
    centralRatioHist.GetYaxis().SetLabelSize(centralRatioHist.GetYaxis().GetLabelSize()*0.8)
    #shouldn't need to draw it now, but if don't draw it other objects won't show up unless define axis in draw option of TGraphAsymmErrors
    centralRatioHist.Draw("E2")
    #=========================================================

    #ratioband.GetYaxis().SetTitle(ratio_text)
    #ratioband.GetXaxis().SetLabelOffset(0.03)
    #ratioband.GetYaxis().CenterTitle()
    #ratioband.GetYaxis().SetRangeUser(*ratio_range)
    #ratioband.GetYaxis().SetNdivisions(3)
    #ratioband.GetYaxis().SetTitleSize(ratioband.GetYaxis().GetTitleSize()*0.8)
    #ratioband.GetYaxis().SetLabelSize(ratioband.GetYaxis().GetLabelSize()*0.8)
    if ratioband:
        ratioband.Draw("2")

    #centralRatioHist.Draw()
    #This part draws the main ratio results in crosses
    #================================================
    for ratioHist in ratioHists:
        drawOpt = "same"
        if not compareData:
            ratioHist.SetMarkerSize(0)
            ratioHist.SetMarkerColor(ratioHist.GetLineColor())
            ratioHist.SetFillColor(ratioHist.GetLineColor())
            ratioHist.SetLineStyle(1)
            #drawOpt += " E2"
            #drawOpt += " hist"
        else:
            drawOpt += " PZE0"
        ratioHist.Draw(drawOpt)
    #================================================

    stacks = [p for p in stackPad.GetListOfPrimitives() if type(p) is ROOT.THStack]
    for stack in stacks:
        stack.GetXaxis().SetTitle("")
        stack.GetXaxis().SetLabelOffset(999)
    xaxis = centralRatioHist.GetXaxis()
    line = ROOT.TLine(xaxis.GetBinLowEdge(xaxis.GetFirst()), 1, xaxis.GetBinUpEdge(xaxis.GetLast()), 1)
    #line = ROOT.TLine(xaxis.GetBinLowEdge(4), 1, xaxis.GetBinUpEdge(26), 1)
    line.SetLineStyle(ROOT.kDotted)
    line.Draw()
    recursePrimitives(stackPad, fixFontSize, 1/0.7)
    stackPad.Modified()
    isLong = stackPad.GetWw()/stackPad.GetWh() > 1.1
    recursePrimitives(ratioPad, fixFontSize, 1/0.27, 0.85 if isLong else 1.15)
    yaxis_ratio = centralRatioHist.GetYaxis()
    #yaxis_ratio.SetTitleOffset(.3) 
    if "unrolled" in name:
        xaxis.SetLabelSize(0.172)
        xaxis.SetLabelOffset(0.027)
        xaxis.SetTitleOffset(1.07)
    ratioPad.Modified()
    canvas.Update()
    ROOT.SetOwnership(stackPad, False)
    # stackPad already owns primitives
    ROOT.SetOwnership(ratioPad, False)
    for obj in ratioPad.GetListOfPrimitives():
        ROOT.SetOwnership(obj, False)
    #ratioPad.GetListOfPrimitives().SetOwner(True)
    ratioPad.RedrawAxis()
    canvas.cd()
    #canvas.GetListOfPrimitives().SetOwner(True)
    return canvas
