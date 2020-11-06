import ROOT
from HistProducer import HistProducer
import logging,pdb
import math
from IPython import embed

class FromFileHistProducer(HistProducer):
    def __init__(self, weight_info, hist_file=None):
        super(FromFileHistProducer, self).__init__(weight_info)
        self.hist_file = hist_file

    def setHistFile(self, hist_file):
        self.hist_file = hist_file
        if not self.hist_file:
            raise ValueError("Invalid file " % file_name)

    def produce(self, hist_name, overflow=False, binning=0): 
        hist = self.hist_file.Get(hist_name)
        ROOT.SetOwnership(hist, False)
        if not hist:
            raise ValueError("Hist %s not found in file %s" % (hist_name, self.hist_file))
        if not hist.GetSumw2(): hist.Sumw2()
        #pdb.set_trace()
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
        return hist

