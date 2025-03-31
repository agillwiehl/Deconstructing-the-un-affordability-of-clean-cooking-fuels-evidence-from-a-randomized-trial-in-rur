

* Load in data
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear
*Update this and all imports with your file path

**************************************************
* Estimate immediate ATE, controlling for time 
** Parametric model, boostraped inference **
**************************************************
* Step 1: Define a program for ATE estimation
capture program drop ate_estimation
program define ate_estimation, rclass
		drop if missing(`2')
        logit `2' `1' `3', cluster(hh_id)
        
        * Create treatment variable safely
        tempvar tx_2
        gen `tx_2' = `1'
        
        * Predict probabilities
        tempvar Y0 Y1
        replace `1' = 0 
        predict `Y0', p
        
        replace `1' = 1
        predict `Y1', p
        * Calculate ATE
        sum `Y0'
        scalar EY0 = r(mean)
        sum `Y1'
        scalar EY1 = r(mean)
		scalar ATE = EY1 - EY0
		 * Restore original treatment variable
        replace `1' = `tx_2'
    
    return scalar ate = ATE
	display ATE
end


* Step 2: Run bootstrap to estimate inference for ATE
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_exclusive_lpg_user visit_number
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_habitual_lpg_user visit_number
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_ocassional_lpg_user visit_number
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_no_lpg_user visit_number


* Step 3: Run regressions for continuous outcomes
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252

drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_firewood_per_day intent_tr visit_number, cluster(hh_id)

import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_charcoal_per_day intent_tr visit_number, cluster(hh_id)


* Step 4: Repeat for different expenditure groups 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252

* Q0/Q1 Binary outcomes
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_exclusive_lpg_user visit_number if expenditure_per_capita<4666.67
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_habitual_lpg_user visit_number if expenditure_per_capita<4666.67
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_ocassional_lpg_user visit_number if expenditure_per_capita<4666.67
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_no_lpg_user visit_number if expenditure_per_capita<4666.67

*Q1/Q3 Binary outcomes
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_exclusive_lpg_user visit_number if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_habitual_lpg_user visit_number if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_ocassional_lpg_user visit_number if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_no_lpg_user visit_number if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800

*Q3/Q4 Binary outcomes
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_exclusive_lpg_user visit_number if expenditure_per_capita>=9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_habitual_lpg_user visit_number if expenditure_per_capita>=9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_ocassional_lpg_user visit_number if expenditure_per_capita>=9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation intent_tr lead_no_lpg_user visit_number if expenditure_per_capita>=9800

*Q0/Q1 Continuous outcomes 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252

drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_firewood_per_day intent_tr visit_number if expenditure_per_capita<4666.67, cluster(hh_id)


import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_charcoal_per_day intent_tr visit_number if expenditure_per_capita<4666.67, cluster(hh_id)

*Q1/Q3 Continuous outcomes 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252

drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_firewood_per_day intent_tr visit_number if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800, cluster(hh_id)


import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_charcoal_per_day intent_tr visit_numberif expenditure_per_capita>=4666.67 & expenditure_per_capita<9800, cluster(hh_id)


*Q3/Q4 Continuous outcomes 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252

drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_firewood_per_day intent_tr visit_number if expenditure_per_capita>=9800, cluster(hh_id)


import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_charcoal_per_day intent_tr visit_number if expenditure_per_capita>=9800, cluster(hh_id)


* Load in data
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

**************************************************
* Estimate immediate ATE, not controlling for time
** Parametric model, boostraped inference **
**************************************************
* Step 1: Define a program for ATE estimation
capture program drop ate_estimation_nt
program define ate_estimation_nt, rclass
		drop if missing(`2')
        logit `2' `1' , cluster(hh_id)
        
        * Create treatment variable safely
        tempvar tx_2
        gen `tx_2' = `1'
        
        * Predict probabilities
        tempvar Y0 Y1
        replace `1' = 0 
        predict `Y0', p
        
        replace `1' = 1
        predict `Y1', p
        * Calculate ATE
        sum `Y0'
        scalar EY0 = r(mean)
        sum `Y1'
        scalar EY1 = r(mean)
		scalar ATE = EY1 - EY0
		 * Restore original treatment variable
        replace `1' = `tx_2'
    
    return scalar ate = ATE
	display ATE
end


* Step 2: Run bootstrap to estimate inference for ATE
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_exclusive_lpg_user 
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_habitual_lpg_user 
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_ocassional_lpg_user 
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_no_lpg_user 


* Step 3: Run regressions for continuous outcomes
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252

drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
regress lead_total_kg_firewood_per_day intent_tr , cluster(hh_id)


import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
regress lead_total_kg_charcoal_per_day intent_tr , cluster(hh_id)

* Step 4: Repeat for different expenditure groups 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252

* Q0/Q1 Binary outcomes
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_exclusive_lpg_user if expenditure_per_capita<4666.67
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_habitual_lpg_user  if expenditure_per_capita<4666.67
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_ocassional_lpg_user if expenditure_per_capita<4666.67
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_no_lpg_user if expenditure_per_capita<4666.67

*Q1/Q3 Binary outcomes
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_exclusive_lpg_user if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_habitual_lpg_user if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_ocassional_lpg_user if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_no_lpg_user if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800

*Q3/Q4 Binary outcomes
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_exclusive_lpg_user  if expenditure_per_capita>=9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_habitual_lpg_user if expenditure_per_capita>=9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_ocassional_lpg_user if expenditure_per_capita>=9800
bootstrap r(ate), reps(10000) seed(12345) cluster(hh_id): ate_estimation_nt intent_tr lead_no_lpg_user if expenditure_per_capita>=9800

*Q0/Q1 Continuous outcomes 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252

drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
regress lead_total_kg_firewood_per_day intent_tr if expenditure_per_capita<4666.67, cluster(hh_id)


import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)

regress lead_total_kg_charcoal_per_day intent_tr  if expenditure_per_capita<4666.67, cluster(hh_id)

*Q1/Q3 Continuous outcomes 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252

drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_firewood_per_day intent_tr if expenditure_per_capita>=4666.67 & expenditure_per_capita<9800, cluster(hh_id)


import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_charcoal_per_day intent_tr  expenditure_per_capita>=4666.67 & expenditure_per_capita<9800, cluster(hh_id)


*Q3/Q4 Continuous outcomes 
import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252

drop if missing(lead_total_kg_firewood_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_firewood_per_day intent_tr if expenditure_per_capita>=9800, cluster(hh_id)


import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_all.xlsx", sheet("Sheet1") firstrow clear

set seed 252
drop if missing(lead_total_kg_charcoal_per_day)
drop if missing(intent_tr)
drop if missing(visit_number)
regress lead_total_kg_charcoal_per_day intent_tr  if expenditure_per_capita>=9800 , cluster(hh_id)


