# SaskRB_Hydro-Economic_Modelling
The hydro-economic modelling package for the Saskatchewan River Basin by Leila Eamen (leila.eamen@usask.ca)

Introduction:
---------------
This package includes codes for developing the Inter-Regional Supply-side Input-Output (ISIO) model, estimating crop evapotranspiration, crop yield, and the monatery production of the irrigation sector for the Saskatchewan River Basin in Canada.

The codes are written in R version 4.0.3. Required R packages: "Mass","Matrix","Metrics"

*************************************************************************************************************************************************************************
Methodology:
---------------
For the methodology and theoretical information on developing ISIO model, please see: Eamen, L., Brouwer, R., & Razavi, S. (2020). The Economic Impacts of Water Supply Restrictions due to Climate and Policy Change: A Transboundary River Basin Supply-side Input-Output Analysis. Ecological Economics, (172), 106532. https://doi.org/10.1016/j.ecolecon.2019.106532

For the methodology and theoretical information on estimating crop evapotranspiration, please see: Droogers, P., & Allen, R. G. (2002). Estimating reference evapotranspiration under inaccurate data conditions. Irrigation and drainage systems, 16(1), 33-45. https://doi.org/10.1023/A:1015508322413

For For the methodology and theoretical information on estimating crop yield, please see: FAO. (2012). Crop Yield Response to Water. FAO Irrigation and Drainage Paper 66. Food and Agriculture Organization of the United Nations, Rome, Italy. http://www.fao.org/3/i2800e/i2800e.pdf 

*************************************************************************************************************************************************************************
Data:
---------------
For developing the ISIO model the following data are required to be downloaded from the provided links:

1- Download Supply "V" and Use "U" tables from the Statistics Canada website for Alberta (AB), Saskatchewan (SK), and Manitoba (MB) for the year that you want to make the model for, in csv format from the link below: Statistics Canada. (2019). Catalogue 15-602-X. Supply and Use Tables, Summary Level. Ottawa, Canada. https://www150.statcan.gc.ca/n1/pub/15-602-x/15-602-x2017001-eng.htm.

2- Download labor force and population data from the link below: Statistics Canada. (2017). Catalogue 98-316-X2016001. 2016 Census of Population. Ottawa, Canada. https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/prof/details/download-telecharger/comp/page_dl-tc.cfm?Lang=E.

3- Download the Inter Sub-basin Trade Flow from the Statistics Canada website, in csv format from the link below: Statistics Canada. (2018a). Table 36-10-0455-01: Experimental domestic trade flow estimates within and between greater economic regions. https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3610045501.


Prices and costs for different crops in the Saskatchewan River Basin for the years 2014 and 2015 are required to be downloaded from the provided links:

1- ICDC, Irrigation Crop Diversification Corporation. (2014). Irrigation Economics and Agronomics. 
http://irrigationsaskatchewan.com/icdc/wp- content/uploads/2014/10/2014_Agronomics_and_Economics.pdf

2- ICDC, Irrigation Crop Diversification Corporation. (2015). Irrigation Economics and Agronomics. 
http://irrigationsaskatchewan.com/icdc/wp-content/uploads/2014/11/2015-Economics-Agronomics.pdf

*************************************************************************************************************************************************************************
