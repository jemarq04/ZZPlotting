# ZZPlotting

## Basic Setup
The histograms produced with the ZZSelector codes in [**VVAnalysis**](https://github.com/jemarq04/VVAnalysis/tree/Run3Analysis) repository are by default not normalized to luminosity. To do the normalization and stack histograms from different samples, set the styles etc., we use this separate repository for plotting. 

 
Please fork this repository and clone it to the CMSSW_14_0_9/src directory which was set up for your [**VVAnalysis**](https://github.com/jemarq04/VVAnalysis/tree/Run3Analysis):

```
git clone https://github.com/YourGithubUsername/ZZPlotting/ 
cd ZZPlotting
```
 
**Modify a few paths:**

In Templates/, copy config.oldName to config.YourUsername, then modify the first 3 lines to your user name and data manager path, and modify the last 3 lines to point to your storage area, html area (where you want to store your results), and the "otherscripts" folder in your current repository properly. Also don't forget to modify the 'gituser' line.


## Style related:

For some style control, you need to fork the following repository: https://github.com/hhe62/CMSPlotDecorations
 

Then you will need to set up this repository:

https://github.com/nsmith-/.root

as by the instructions, clone it to ~ and edit ~/.rootlogon.C to include the line gROOT->ProcessLineSync(".x $HOME/.root/dotrootInit.C+");

 
### Plot group and cross sections for your sample(s)
In ZZ4lDatasetManager/PlotGroups/ZZ4l2022.json (same for other years), add a new plot group entry (e.g. "ZZ_EFT") like the following: (see existing entries for example)

 
```
"ZZ_EFT" : {

        "Name" : "Your custom legend label",

        "Style" : "fill-lightblue",

        "add_perc_error" : 0.0,

        "Members" : [

            "sample1",
            "sample2",
             ...

        ]

    },
```
 

and at the bottom of **Utilities/UserInput.py** under **elif "jetplot" in fileset_nc:**, add a line **filelist.append("ZZ_EFT")** corresponding to your plot group, and comment out the other lines of plot groups (you may need them later).

 

In Data_manager/ZZ4lDatasetManager/FileInfo/montecarlo/montecarlo_zzanalysis.json, add entries like

```
 "Sample1" : {

         "cross_section" : someValue,

    },
```
 
where you can read the cross section of your new sample in printouts like in the gridpack (may need sufficent events to evalue it precisely if it was not the case for the current value) or McM.

 

Finally you can modify **RunBash/template18.sh** as a starting example:

Change "filename" to the file stored in HistFiles/, replace "VVAnalysis_path" with your VVAnalysis path (probably using text editor commands or define a new variable), and replace "dir" with an arbitrary output directory name. 

 

And then run it in ZZPlotting/:

```
./RunBash/template18.sh
```
 
This will create a few selected plots in seprate channels and the sum of them, stored in your html folder, and the exact output paths will be indicated in the printouts. You can then put the whole folder to your public_html folder to browse them on your hep.wisc.edu/~username page.
