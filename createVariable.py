import json

outputname = "varsFile.json"

dict = {}
# Mass variables===================================================================
varlist0 = ["Mass"]
varlist = []
varlistFull = []

for var in varlist0:
    for j in range(0, 5):
        varlist.append(var + "%sj" % j)

varlist.append("MassAllj")  # for comparison check with original Mass variable
varlist.append("Mass34j")  # >=3j

for var in varlist0:
    for j in range(0, 5):
        varlistFull.append(var + "%sj" % j + "Full")

varlistFull.append("MassFull")  # for comparison check with original Mass variable
varlistFull.append("Mass34jFull")  # >=3j

print(varlist)
print(varlistFull)

for var in varlist:
    dict[var] = {}
    nj = var.replace("j", "").replace("Mass", "")
    if var == "MassAllj":
        nj = "All"
    if var == "Mass4j":
        nj = ">=4"
    if var == "Mass34j":
        nj = ">=3"
    dict[var]["units"] = "[GeV]"
    if nj in ["All", "0", "1"]:
        dict[var]["_binning"] = [100.0] + [200.0 + 50.0 * i for i in range(5)] + [500.0, 600.0, 800.0, 1000.0]
    else:
        dict[var]["_binning"] = [100.0] + [200.0 + 50.0 * i for i in range(5)] + [500.0, 600.0, 800.0, 1000.0]
        # dict[var]["_binning"] = [100.,200.,400.,600.,1000.]
    dict[var]["prettyVars"] = "m_{4\\ell}" + "(%s jets)" % nj
    dict[var]["responseClassNames"] = "testJet"

for var in varlistFull:
    dict[var] = {}
    nj = var.replace("jFull", "").replace("Mass", "")
    if var == "MassFull":
        nj = "All"
    if var == "Mass4jFull":
        nj = ">=4"
    if var == "Mass34jFull":
        nj = ">=3"
    dict[var]["units"] = "[GeV]"
    if nj in ["All", "0", "1"]:
        dict[var]["_binning"] = [80.0, 100.0, 120.0, 130.0, 180.0, 230.0, 300.0, 450.0, 600.0, 800.0, 1300.0]
    else:
        dict[var]["_binning"] = [80.0, 100.0, 120.0, 130.0, 180.0, 230.0, 300.0, 450.0, 600.0, 800.0, 1300.0]
    dict[var]["prettyVars"] = "m_{4\\ell}" + "(%s jets)" % nj
    dict[var]["responseClassNames"] = "testJet"
# ====================================================================================

# jet variables=======================================================================
var2 = "nJets"
dict[var2] = {}
dict[var2]["units"] = ""
dict[var2]["_binning"] = [0.0, 1.0, 2.0, 3.0, 4.0]
dict[var2]["prettyVars"] = "N_{jets}"
dict[var2]["responseClassNames"] = "testJet"

var3 = "mjj"
dict[var3] = {}
dict[var3]["units"] = "[GeV]"
dict[var3]["_binning"] = [0.0, 200.0, 400.0, 600.0, 1000.0]  # [100.+40.*i for i in range(31)]
dict[var3]["prettyVars"] = "Di-jet Mass"
dict[var3]["responseClassNames"] = "testJet"

var4 = "dEtajj"
dict[var4] = {}
dict[var4]["units"] = ""
dict[var4]["_binning"] = [0.0, 1.2, 2.4, 3.6, 4.7]
dict[var4]["prettyVars"] = "#Delta#eta(j_{1}, j_{2})"
dict[var4]["responseClassNames"] = "testJet"

for i, var in enumerate(["jetPt[0]", "jetPt[1]", "absjetEta[0]", "absjetEta[1]"]):
    dict[var] = {}
    if "Pt" in var:
        dict[var]["units"] = "[GeV]"
    else:
        dict[var]["units"] = ""
    if i == 0:
        dict[var]["_binning"] = [30.0, 50.0, 100.0, 200.0, 300.0, 500.0]
        dict[var]["prettyVars"] = "p_{T}^{j1}"
    if i == 1:
        dict[var]["_binning"] = [30.0, 50.0, 100.0, 170.0, 300.0]
        dict[var]["prettyVars"] = "p_{T}^{j2}"
    if i == 2:
        dict[var]["_binning"] = [0.0, 1.5, 2.4, 3.2, 4.7]
        dict[var]["prettyVars"] = "|#eta_{j1}|"
    if i == 3:
        dict[var]["_binning"] = [0.0, 1.5, 3.0, 4.7]
        dict[var]["prettyVars"] = "|#eta_{j2}|"

    dict[var]["responseClassNames"] = "testJet"

for i, var in enumerate(["jetPtN1", "absjetEtaN1", "absjetEtaN1_100"]):
    dict[var] = {}
    if "Pt" in var:
        dict[var]["units"] = "[GeV]"
    else:
        dict[var]["units"] = ""
    if i == 0:
        dict[var]["_binning"] = [30.0, 50.0, 100.0, 200.0, 300.0, 500.0]
        dict[var]["prettyVars"] = "p_{T}^{j1}"
    if i == 1:
        dict[var]["_binning"] = [0.0, 1.5, 2.4, 3.2, 4.7]
        dict[var]["prettyVars"] = "|#eta_{j1}|"
    if i == 2:
        dict[var]["_binning"] = [0.0, 1.5, 2.4, 3.2, 4.7]
        dict[var]["prettyVars"] = "|#eta_{j1}| with p_{T}<100"

    dict[var]["responseClassNames"] = "testJet"

for i, var in enumerate(["absjetEtaAllj", "jetEtaAllj"]):
    dict[var] = {}
    if "Pt" in var:
        dict[var]["units"] = "[GeV]"
    else:
        dict[var]["units"] = ""
    if i == 0:
        dict[var]["_binning"] = [0.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.7]
        dict[var]["prettyVars"] = "|#eta_{j}|"
    if i == 1:
        dict[var]["_binning"] = [-4.7, -4.0, -3.5, -3.0, -2.5, -2.0, -1.5, 0.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.7]
        dict[var]["prettyVars"] = "#eta_{j}"

    dict[var]["responseClassNames"] = "testJet"

# Other variables:
for i, var in enumerate(["LepPt", "ZMass", "Mass"]):
    dict[var] = {}
    if "Pt" in var or "Mass" in var:
        dict[var]["units"] = "[GeV]"
    else:
        dict[var]["units"] = ""
    if i == 0:
        dict[var]["_binning"] = [0.0, 30.0, 50.0, 100.0, 200.0]
        dict[var]["prettyVars"] = "Lep p_{T}"
    if i == 1:
        dict[var]["_binning"] = [10.0 * i for i in range(0, 13)]
        dict[var]["prettyVars"] = "Z Mass"
    if i == 2:
        dict[var]["_binning"] = [100.0] + [200.0 + 50.0 * i for i in range(5)] + [500.0, 600.0, 800.0, 1000.0]
        dict[var]["prettyVars"] = "m_{4\\ell}"

    dict[var]["responseClassNames"] = "testJet"

# change axis range and MC symbol location
for key in list(dict.keys()):
    dict[key]["top_xy"] = (0.2, 0.87)
    dict[key]["top_size"] = 0.1
    dict[key]["bottom_xy"] = (0.2, 0.91)  # top and bottom different pad settings
    dict[key]["bottom_size"] = 0.08
    dict[key]["ymax_fac"] = 1.0
    dict[key]["ymin_fac"] = 1.0
    dict[key]["ratio_max"] = 1.8
    dict[key]["ratio_min"] = 0.4

# Adjust settings for individual variables
dict["jetPt[0]"]["ratio_max"] = 2.99
dict["jetPt[0]"]["ratio_min"] = 0.4

dict["jetPt[1]"]["ymax_fac"] = 1.0
dict["jetPt[1]"]["ratio_max"] = 2.99
dict["jetPt[1]"]["ratio_min"] = 0.4
dict["jetPt[1]"]["top_xy"] = (0.6, 0.87)
dict["jetPt[1]"]["bottom_xy"] = (0.6, 0.91)
dict["jetPt[1]"]["ymin_fac"] = 1.3

# dict['Mass4j']['top_xy'] = (0.6,0.87)
# dict['Mass4j']['bottom_xy'] = (0.6,0.91)

dict["Mass1jFull"]["top_xy"] = (0.4, 0.87)
dict["Mass1jFull"]["bottom_xy"] = (0.4, 0.91)
dict["Mass2jFull"]["top_xy"] = (0.37, 0.87)
dict["Mass2jFull"]["bottom_xy"] = (0.37, 0.91)

with open(outputname, "w") as output_file:
    json.dump(dict, output_file, indent=4)
