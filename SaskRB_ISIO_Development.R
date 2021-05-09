#*********************************************************************************************************************************
#This is a code to Develop the Inter-Regional Supply-side Input-Output (ISIO) model including water supply data
#for the Saskatchewan River Basin in Canada.

#*********************************************************************************************************************************
#The code is developed by Leila Eamen. Contact: leila.eamen@usask.ca
#*********************************************************************************************************************************

#For the methodology and theoretical information on developing ISIO models please see:
#Eamen, L., Brouwer, R., & Razavi, S. (2020). The Economic Impacts of Water Supply Restrictions due to Climate 
#and Policy Change: A Transboundary River Basin Supply-side Input-Output Analysis. Ecological Economics, (172), 106532.
#https://doi.org/10.1016/j.ecolecon.2019.106532

#*********************************************************************************************************************************

#For developing the ISIO and IO models the following data are required to be downloaded from the provided links:

#Download Supply "V" and Use "U" tables from the Statistics Canada website for Alberta (AB), 
#Saskatchewan (SK), and Manitoba (MB) for the year that you want to make the model for, in csv format from the link below:
#Statistics Canada. (2019). Catalogue 15-602-X. Supply and Use Tables, Summary Level. Ottawa, Canada.
#https://www150.statcan.gc.ca/n1/pub/15-602-x/15-602-x2017001-eng.htm.

#Download the labor force coefficients for the hydro-economic regions in each province: 
#The hydro-economic regions are: North Saskatchewan in Alberta (AB-NSRB), South Saskatchewan in Alberta (AB-SSRB), 
#North Saskatchewan in Saskatchewan (SK-NSRB), South Saskatchewan in Saskatchewan (SK-SSRB),
#Saskatchewan River in Saskatchewan (SK-SRB), and  Saskatchewan River in Manitoba (MB-SRB), in csv format:

#The labor force data can be downloaded from the link below:
#Statistics Canada. (2017). Catalogue 98-316-X2016001. 2016 Census of Population. Ottawa, Canada.
#https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/prof/details/download-telecharger/comp/page_dl-tc.cfm?Lang=E.

#Download the Inter Sub-basin Trade Flow from the Statistics Canada website, in csv format from the link below:
#Statistics Canada. (2018a). Table 36-10-0455-01: Experimental domestic trade flow estimates within 
#and between greater economic regions. https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3610045501.

#call the required packages: 
#(Note: if the packages are already installed on your system, skip the first line below:

install.packages(c("Mass","Matrix","Metrics"))
library(MASS)
library(Matrix)
library(Metrics)

#Read Supply and Use tables of the entire Saskatchewan River Basin:

U<- read.csv("U.csv", header = F, sep = ",")
U<- data.matrix(U, rownames.force = NA)
V<- read.csv("V.csv", header = F, sep = ",")
V<- data.matrix(V, rownames.force = NA)

#Calculate the total industry output or the column sums of the supply table:

V_ColSum<- colSums(V)
V_ColSum<- data.matrix(V_ColSum, rownames.force = NA)

#Calculate the total commodity output or the row sums of the supply table:

V_RowSum<- rowSums(V)
V_RowSum<- data.matrix(V_RowSum, rownames.force = NA)

#*******************************************************************************************************************
#The Inter-Regional Supply-side Input-Output (ISIO) Model Calculations at the river basin scale:
#*******************************************************************************************************************

C<- V %*% ginv(diag(V_ColSum[,1]))
H<- ginv(diag(V_RowSum[,1])) %*% U

#Read the Value-added from the downloaded supply and use tables, in csv format:

VA<- read.csv("VA.csv", header = F, sep = ",")
VA<- data.matrix(VA, rownames.force = NA)

#Calculate the Ghosh Inverse:

HtC<- t(H) %*% C
I_Mtx<- diag(1,nrow = 315, ncol = 315)
GhoshInv<- solve(I_Mtx - HtC)

#Calculate the Output:

Output<- (GhoshInv) %*% VA[,1]

#*******************************************************************************************************************
#Including Water in the ISIO model:
#*******************************************************************************************************************

#Read the water use data in the model's base year (y1) coming from either the water resources system model simulations or
#downloaded from the Statistics Canada website, in csv format from the below link:
#Statistics Canada. (2018b). Table 38-10-0250-01: Physical flow account for water use. 
#https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3810025001.

Water_y1<- read.csv("Raw_Water_y1.csv", header = F, sep = ",")

#Calculate the water productivity in monetary unit:

Prod<- V_ColSum[,1]/Water_y1[,1]
Prod<- data.matrix(Prod, rownames.force = NA)
Prod[is.nan(Prod)]<-0
Productivity<- ifelse(Prod == Inf, 0, Prod)

#*******************************************************************************************************************
#Estimate changes in the sectoral output due to changes in water supply:
#*******************************************************************************************************************
#Changes in water supply:
Del_W_Suuply<- read.csv("Del_Water_Supply.csv", header = T, sep = ",")
Del_W_Suuply<- data.matrix(Del_W_Suuply, rownames.force = NA)

#Calculate the value of change:
Del_Value_W<- Del_W_Suuply * Productivity

#Changes in the sectoral output:
Del_Output<- (GhoshInv)%*%Del_Value_W

#*******************************************************************************************************************
### End of the code.
#*******************************************************************************************************************