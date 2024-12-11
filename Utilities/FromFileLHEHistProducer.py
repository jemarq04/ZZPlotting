import ROOT
from .HistProducer import HistProducer
import logging,pdb
import math
from IPython import embed
import re

class FromFileLHEHistProducer(HistProducer):
    def __init__(self, weight_info, lhe_weight_id, hist_file=None):
        super(FromFileLHEHistProducer, self).__init__(weight_info)
        self.hist_file = hist_file
        self.lhe_weight_id = lhe_weight_id

    def setHistFile(self, hist_file):
        self.hist_file = hist_file
        if not self.hist_file:
            raise ValueError("Invalid file " % file_name)

    def produce(self, hist_name, overflow=False, binning=None): 
        if "_" in hist_name:
            subnames = re.findall(r"(.*)_(.*)", hist_name)[0]
            whist_name = "_".join([subnames[0], "lheWeights", subnames[1]])
        else:
            whist_name = hist_name + "_lheWeights"
        if "/" in hist_name:
            subnames = re.findall(r"(.*)/(.*)_(.*)", hist_name)[0]
            widhist_name = "%s/scaleWeightIDs_%s" % (subnames[0], subnames[2])
        else:
            subnames = re.findall(r"(.*)/(.*)_(.*)", hist_name)[0]
            widhist_name = "_".join(["scaleWeightIDs", subnames[2]])
        #print("NOTE: %s -> %s, %s" % (hist_name, whist_name, widhist_name))
        whist = self.hist_file.Get(whist_name)
        widhist = self.hist_file.Get(widhist_name)
        if not whist or not widhist:
            #print("NOTE: No weight plots found for %s!" % hist_name)
            hist = self.hist_file.Get(hist_name)
        else:
            if whist.GetEntries() == 0 or widhist.GetEntries() == 0:
                #print("NOTE: Empty weight plot. Using default histogram")
                hist = self.hist_file.Get(hist_name)
            else:
                weight_idx = 0
                for i in range(1, widhist.GetNbinsX()+1):
                    if abs(self.lhe_weight_id - widhist.GetBinContent(i)) <= 0.0001:
                        weight_idx = i
                        break
                hist = whist.ProjectionX(hist_name + "%.03f" % self.lhe_weight_id, weight_idx, weight_idx)
                #print("NOTE: Made a slice at bin %i for weight %.03f. (%s)" % (weight_idx, self.lhe_weight_id, hist_name))
                #hist = self.hist_file.Get(hist_name)
        ROOT.SetOwnership(hist, False)
        if not hist:
            raise ValueError("Hist %s not found in file %s" % (hist_name, self.hist_file))
        
        #Calling Sumw2 below just in case, but using the conditional to avoid a Warning on failures
        if not (hist.GetSumw2N() == hist.GetNcells() and not hist.GetDefaultSumw2()): hist.Sumw2()
        #pdb.set_trace()
        #print("NOTE: ==> Scale factor = %s" % self.getHistScaleFactor())
        #print("NOTE: ==> Xsec, WgtSum = %s, %s" % (self.getCrossSection('fb'), self.getSumOfWeights()))
        #print("NOTE: ==> Lumi: %s" % self.lumi)
        hist.Scale(self.getHistScaleFactor())
        # This causes GetEntries() to return 1 greater than the "actual"
        # number of entries in the hist
        hist = self.rebin(hist, binning)
        #pdb.set_trace()
        if overflow:
            num_bins = hist.GetSize() - 2
            add_overflow = hist.GetBinContent(num_bins) + hist.GetBinContent(num_bins + 1)
            add_error = math.sqrt(math.pow(hist.GetBinError(num_bins),2)+math.pow(hist.GetBinError(num_bins+1),2))
            hist.SetBinContent(num_bins, add_overflow)
            hist.SetBinError(num_bins, add_error)
        
        if "Mass" in hist_name and "Full" in hist_name:
            #pdb.set_trace()
            hist.Sumw2()
            normBW = True #Set False when printing table and don't want to normalize by BW
            if normBW:
                for ib in range(1,hist.GetNbinsX()+1):
                    width = hist.GetBinWidth(ib)
                    hist.SetBinContent(ib, hist.GetBinContent(ib)/width)
                    hist.SetBinError(ib, hist.GetBinError(ib)/ width)
                    if hist.GetBinError(ib) > hist.GetBinContent(ib):
                        hist.SetBinError(ib, hist.GetBinContent(ib))
            hist.Sumw2() #This doesn't seem to overwrite error? What's its function?
        
        return hist

