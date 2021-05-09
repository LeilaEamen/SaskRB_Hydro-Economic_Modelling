####################################################################################################################################################
### This is a code tp calculate Irrigation Water Demand for the Saskatchewan River Basin (SaskRB) in Western Canada.
### Reference evapotranspiration is calculated using Modified Hargreaves method and calibrated for the SakRB.
####################################################################################################################################################

#The code is developed by Leila Eamen. Contact: leila.eamen@usask.ca
#*********************************************************************************************************************************

library(Metrics)
library(MASS)
library(Matrix)

#####################   ALBERTA:  ##################################################
### Tmax and Tmin: mean maximum and mean minimum temperature in (degree Centigrade); 
### PcP: precipitation in (mm);  Ra: extraterrestrial radiation in (MJ/m2).

Tmax_AB <- read.csv("Tmax_AB.csv", header = T, sep = ",")
Tmin_AB <- read.csv("Tmin_AB.csv", header = T, sep = ",")
Pcp_AB <- read.csv("Pcp_AB.csv", header = T, sep = ",")
Ra_AB <- read.csv("Ra_AB.csv", header = T, sep = ",")

Cal_Result_EtHM_AB<- matrix(0,nrow = 6120,ncol = 151)

for (i in 1:151) {
  Tmaxi_AB <- Tmax_AB[,i]
  Tmini_AB <- Tmin_AB[,i]
  Pcpi_AB <- Pcp_AB[,i]
  Rai_AB <- Ra_AB[,i]
  Tave_AB<- (Tmini_AB + Tmaxi_AB)/2
  Td_AB<- Tmaxi_AB - Tmini_AB
  Cal_EtHM_AB <- 0.35*(0.0013 * (0.408*Rai_AB) * (Tave_AB + 17) * (Td_AB - 0.0123*Pcpi_AB)^0.76)
  Cal_Result_EtHM_AB [,i] <- Cal_EtHM_AB
}

### ETc ###

Kc_AB<- read.csv("AB_Kc.csv", header = T, sep = ",")
AB_Irr_Area<- read.csv("AB_Irr_Area.csv", header = T, sep = ",")

AB_Et_Wheat<- Cal_Result_EtHM_AB * Kc_AB[,1]
AB_Et_Canola<- Cal_Result_EtHM_AB * Kc_AB[,2]
AB_Et_Alfalfa<- Cal_Result_EtHM_AB * Kc_AB[,3]
AB_Et_Potato<- Cal_Result_EtHM_AB * Kc_AB[,4]

ETc_AB<- matrix(0, nrow = 6120, ncol = 151)

### ETC in 'm3': Area in 'ha' and the Etc in 'mm'  

for (i in 1:151) {
  Etc_T<- 10*((AB_Et_Wheat[,i]*AB_Irr_Area[,i]*0.35)+(AB_Et_Canola[,i]*AB_Irr_Area[,i]*0.15)+(AB_Et_Alfalfa[,i]*AB_Irr_Area[,i]*0.3)+(AB_Et_Potato[,i]*AB_Irr_Area[,i]*0.2))
  ETc_AB[,i]<- Etc_T
}

### Calculating Irrigation Water Demand in (m3):

Irr_Efficiency_AB<- 0.75
AB_IWD<- matrix(0,nrow = 6120, ncol = 151)
AB_IWD<- ETc_AB / Irr_Efficiency_AB

write.table(AB_IWD, file = "AB_IWD.csv", sep = ",", col.names = T)

#################################################################################################################################################################
#################################################################################################################################################################

#####################   Saskatchewan:  #############################################
### Tmax and Tmin: mean maximum and mean minimum temperature in (degree Centigrade); 
### PcP: precipitation in (mm);  Ra: extraterrestrial radiation in (MJ/m2).

Tmax_SK <- read.csv("Tmax_SK.csv", header = T, sep = ",")
Tmin_SK <- read.csv("Tmin_SK.csv", header = T, sep = ",")
Pcp_SK <- read.csv("Pcp_SK.csv", header = T, sep = ",")
Ra_SK <- read.csv("Ra_SK.csv", header = T, sep = ",")

Cal_Result_EtHM_SK<- matrix(0,nrow = 6120,ncol = 24)

for (i in 1:24) {
  Tmaxi_SK <- Tmax_SK[,i]
  Tmini_SK <- Tmin_SK[,i]
  Pcpi_SK <- Pcp_SK[,i]
  Rai_SK <- Ra_SK[,i]
  Tave_SK<- (Tmini_SK + Tmaxi_SK)/2
  Td_SK<- Tmaxi_SK - Tmini_SK
  Cal_EtHM_SK <- 0.35*(0.0013 * (0.408*Rai_SK) * (Tave_SK + 17) * (Td_SK - 0.0123*Pcpi_SK)^0.76)
  Cal_Result_EtHM_SK [,i] <- Cal_EtHM_SK
}

### ETc ###
Kc_SK<- read.csv("SK_Kc.csv", header = T, sep = ",")
SK_Irr_Area<- read.csv("SK_Irr_Area.csv", header = T, sep = ",")

SK_Et_Wheat<- Cal_Result_EtHM_SK * Kc_SK[,1]
SK_Et_Canola<- Cal_Result_EtHM_SK * Kc_SK[,2]
SK_Et_Alfalfa<- Cal_Result_EtHM_SK * Kc_SK[,3]
SK_Et_Potato<- Cal_Result_EtHM_SK * Kc_SK[,4]
SK_Et_Peas<- Cal_Result_EtHM_SK * Kc_SK[,5]

ETc_SK<- matrix(0, nrow = 6120, ncol = 24)

### ETC in 'm3': Area in 'ha' and the Etc in 'mm'  

for (i in 1:24) {
  Etc_T<- 10* ((SK_Et_Wheat[,i]*SK_Irr_Area[,i]*0.34)+(SK_Et_Canola[,i]*SK_Irr_Area[,i]*0.32)+(SK_Et_Alfalfa[,i]*SK_Irr_Area[,i]*0.09)+(SK_Et_Potato[,i]*SK_Irr_Area[,i]*0.21)+(SK_Et_Peas[,i]*SK_Irr_Area[,i]*0.04))
  ETc_SK[,i]<- Etc_T
}


### Calculating Irrigation Water Demand in (m3):

Irr_Efficiency_SK<- 0.75
SK_IWD<- matrix(0,nrow = 6120, ncol = 24)
SK_IWD<- ETc_SK / Irr_Efficiency_SK

write.table(SK_IWD, file = "SK_IWD.csv", sep = ",", col.names = T)

#*******************************************************************************************************************
### End of the code.
#*******************************************************************************************************************
