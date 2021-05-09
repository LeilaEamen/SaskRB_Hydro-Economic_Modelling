#*********************************************************************************************************************************
#This is a code to estimate the crop yield for irrigated agriculture in the Saskatchewan River Basin in Canada.

#*********************************************************************************************************************************
#The code is developed by Leila Eamen. Contact: leila.eamen@usask.ca
#*********************************************************************************************************************************

#The hydro-economic regions of the Saskatchewan River Basin with irrigated agriculture are: North Saskatchewan in Alberta (AB-NSRB), 
#South Saskatchewan in Alberta (AB-SSRB), North Saskatchewan in Saskatchewan (SK-NSRB), South Saskatchewan in Saskatchewan (SK-SSRB),
#and Saskatchewan River in Saskatchewan (SK-SRB).
#*********************************************************************************************************************************

#Extract Ky (the yield response factor) for the crops in the SaskRB from the FAO publication below:
#FAO. (2012). Crop Yield Response to Water. FAO Irrigation and Drainage Paper 66. Food and Agriculture Organization 
#of the United Nations, Rome, Italy. http://www.fao.org/3/i2800e/i2800e.pdf

#*********************************************************************************************************************************

#Extract maximum yield for different crops in the Saskatchewan River Basin for the years 2014 and 2015 from the Irrigation Crop 
#Diversification Corporation (ICDC) publications below:

#ICDC, Irrigation Crop Diversification Corporation. (2015). Irrigation Economics and Agronomics. 
#http://irrigationsaskatchewan.com/icdc/wp-content/uploads/2014/11/2015-Economics-Agronomics.pdf
#ICDC, Irrigation Crop Diversification Corporation. (2014). Irrigation Economics and Agronomics. 
#http://irrigationsaskatchewan.com/icdc/wp- content/uploads/2014/10/2014_Agronomics_and_Economics.pdf

#*********************************************************************************************************************************
#The input data should be prepared for this code in the following order:

#The order of crops : Cereals (Wheat); Forages (Alfalfa); Oilseeds (Canola); Pulses (Peas); and
#Specialty Crops (Potato).
#The order of regions:  SK-NSRB, SK-SSRB, SK-SRB, AB-NSRB, and AB-SSRB.

#*********************************************************************************************************************************

#Input data:

Area<- read.csv("Area.csv", header = T, sep = ",")
Area<- data.matrix(Area, rownames.force = NA)
Ky<- read.csv("Ky.csv", header = T, sep = ",")
Ky<- data.matrix(Ky, rownames.force = NA)
Water_Supply<- read.csv("WaterSupply.csv", header = T, sep = ",")
Water_Supply<- data.matrix(Water_Supply, rownames.force = NA)
Water_Demand<- read.csv("WaterDemand.csv", header = T, sep = ",")
Water_Demand<- data.matrix(Water_Demand, rownames.force = NA)
Yield_Max<- read.csv("YieldMax.csv", header = T, sep = ",")
Yield_Max<- data.matrix(Yield_Max, rownames.force = NA)

#Calculate the water availability ratio:

Water_Availability<- Water_Supply/Water_Demand

#Estimate the crop yiled for the hydro-economic regions in the Saskatchewan River Basin (tonne/ha)
Crop_Yield<- Yield_Max * (1 - Ky * (1-(Water_Availability)))

#Crop yield in (tonne)
Crop_Yield<- Crop_Yield * Area
#*******************************************************************************************************************

#Read crop prices for the study year (i.e., 2014 or 2015):
#prices are in $/tonne

C_Price<- read.csv("Crop_Price.csv", header = T, sep = ",")
C_Price<- data.matrix(C_Price, rownames.force = NA)

#Estimate the irrigation output in $:
Irr_Output<- Crop_Yield * C_Price

#Read Irrigation costsfor the study year (i.e., 2014 or 2015):
#prices are in $/ha
Irr_Cost<- read.csv("Irr_Cost.csv", header = T, sep = ",")
Irr_Cost<- data.matrix(Irr_Cost, rownames.force = NA)

#Estimate the net benefit of irrigation:
Irr_Cost<- Irr_Cost * Area
Net_Benefit<- Irr_Output - Irr_Cost

#*******************************************************************************************************************
### End of the code.
#*******************************************************************************************************************