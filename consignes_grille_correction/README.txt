Information on data files - Carrier et al.

FIRST FILE "mass_data.txt"
1. year = year (time t) for which the masses were measured.

2. npi = the November-March anomalies of the North Pacific Index (NPI; Trenberth and  Hurrell, 1994). NPI correspond to the Winter conditions preceding year (t) likely to influence the mass of marmots in spring. Example: to see the effect of winter 2003-2004 on mass in spring 2004, the value of NPI in 2004 (containing November-December 2003 and January to March 2004) was used.
3. id = unique identity number for each marmot.
4. repro = reproductive status at year (t). Yes = breeder, No = non-breeder. 
5. sex = sex of each marmot, M = male, F = female.

6. rday = Julian days starting on 1 June. Example: 31 May is rday 0 while 12 June is rday 12. 

7. weight = weight measured during the capture of an individual marmot.
8. AUC = cumulative summer temperatures at year (t). We used the area under the curve for the maximum temperatures (°C) recorded between 1 June and 15 September recorded at Hendrickson Creek meteorological station. 
9. ratio = the ratio of the number of days of rain or snow on the total number of days local precipitations were recorded in the field for year (t).
10. AUCprin = cumulative spring temperatures at year (t). We used the area under the curve for the maximum temperatures (°C) recorded between 1 April and 31 May at Hendrickson Creek meteorological station. 
11. snow = percentage of snow observed on the ground on May 16 (near the time of emergence) at year t. The values were computed with MODIS snow data (MOD10A2; Hall and Riggs ,2016). Images were available every 8 days with a spatial resolution of 500 m. The area occupied by marmots included 42 pixels and we used the maximum extent of snow cover during an eight-day period by coding 1 if a pixel was covered by snow and 0 if not. 
12. maxslope = rate of spring green-up at year (t). We used the normalized Difference Vegetation Index (NDVI) computed from images of the MODIS satellite (MOD13Q1; Didan, 2015). Images were available every 16 days with a spatial resolution of 250 m. For each year, we computed the rate of spring green-up as the maximum slope between two consecutive NDVI values between 9 May and the date at which the maximum value of NDVI was recorded (Pettorelli et al., Pelletier, Hardenberg, Festa-Bianchet, & Côté, 2007). Higher slope values indicate faster changes in vegetation growth associated with a shorter period when high-quality forage is available.


SECOND FILE "survival_data.txt"

1. ch = encounter histories for a total of 132 adult marmots of known sex (females: n=69; males: n=63) over 14 years (k=14 occasions). The encounter histories included both physical captures and visual resightings at year t.  0 = the individual was not seen or captured and 1 = the individual was seen, captured or both.2. sex = sex of each marmot, M = male, F = female.THIRD FILE "environ_data.txt"1. year = capture year (time t).

2. survival_from_to = time range for which survival is estimated. Example: 2004-2005 is survival from summer 2004 to summer 2005.

3. time t+1 = year after hibernation.

4. eff_t = capture effort at year (t) defined as the number of days for which there have been sightings or captures of marmots that year.

5. npi_t = NPI during hibernation in winter, i.e. the November-March anomalies of the North Pacific Index (NPI; Trenberth and  Hurrell, 1994). Example: the value in 2005 includes anomalies of November and December 2004 and January to March 2005, and was used to test the effects of winter conditions 2004-2005 on survival between 2004 and 2005.

6. AUC_t = cumulative summer temperatures at year (t). We used the area under the curve for the maximum temperatures (°C) recorded between 1 June and 15 September recorded at Hendrickson Creek meteorological station. 

7. ratio_t = the ratio of the number of days of rain or snow on the total number of days local precipitations were recorded in the field for year (t).

8. AUCprin_t = cumulative spring temperatures at year (t). We used the area under the curve for the maximum temperatures (°C) recorded between 1 April and 31 May at Hendrickson Creek meteorological station.
 
9. AUCprin_t+1 = cumulative spring temperatures at year (t+1). We used the area under the curve for the maximum temperatures (°C) recorded between 1 April and 31 May at Hendrickson Creek meteorological station. 10. snow_t = percentage of snow observed on the ground on May 16 (near the time of emergence) at year t. 

11. snow_t+1 = percentage of snow observed on the ground on May 16 (near the time of emergence) at year t+1. 

12. maxslope_t = rate of spring green-up at year (t).

13. maxslope_t+1 = rate of spring green-up at year (t+1).