
* Load in data
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear
*Update this and all imports with your file path

**************************************************
* Estimate cumulative ATE for continuous variables, controlling for time 
** Parametric model, robust inference **
**************************************************

* Controlling for time
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_firewood_per_day cum_int_tr visit_number, cluster(hh_id) 

import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)

regress lead_total_kg_charcoal_per_day cum_int_tr visit_number , cluster(hh_id) 

*Q0/Q1 Low expenditure 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_firewood_per_day cum_int_tr visit_number if expenditure_per_capita<4666.67, cluster(hh_id) 

import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)


regress lead_total_kg_charcoal_per_day cum_int_tr visit_number if expenditure_per_capita<4666.67, cluster(hh_id) 


*Q1/Q3 Mid expenditure 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)


regress lead_total_kg_firewood_per_day cum_int_tr visit_number if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800, cluster(hh_id) 

import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)

regress lead_total_kg_charcoal_per_day cum_int_tr visit_number if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800, cluster(hh_id) 




*Q3/Q4 High expenditure 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)

regress lead_total_kg_firewood_per_day cum_int_tr visit_number if expenditure_per_capita>=9800, cluster(hh_id) 

import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)

regress lead_total_kg_charcoal_per_day cum_int_tr visit_number if expenditure_per_capita>=9800, cluster(hh_id) 


********************************************************************************
* Without controlling for time
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)


regress lead_total_kg_firewood_per_day cum_int_tr , cluster(hh_id) 

import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)



regress lead_total_kg_charcoal_per_day cum_int_tr , cluster(hh_id) 


*Q0/Q1
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)


regress lead_total_kg_firewood_per_day cum_int_tr if expenditure_per_capita<4666.67, cluster(hh_id) 

import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)


regress lead_total_kg_charcoal_per_day cum_int_tr if expenditure_per_capita<4666.67, cluster(hh_id) 



*Q1/Q3
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)


regress lead_total_kg_firewood_per_day cum_int_tr if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800, cluster(hh_id) 

import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)


regress lead_total_kg_charcoal_per_day cum_int_tr if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800, cluster(hh_id) 



*Q3/Q4
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)


regress lead_total_kg_firewood_per_day cum_int_tr if expenditure_per_capita>=9800, cluster(hh_id) 

import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)

regress lead_total_kg_charcoal_per_day cum_int_tr if expenditure_per_capita>=9800, cluster(hh_id) 
