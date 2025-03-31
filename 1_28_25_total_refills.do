import excel "/Users/annelisewiehl/Desktop/Deconstructing the (un)affordability/df_refill.xlsx", sheet("Sheet1") firstrow clear
set seed 123
gen expenditure_per_capita=hh_expend_week_combined_final/hh_cooking_size

#

gen refills_over_this_amount_of_time=time_treatment if intent_tr==1

replace refills_over_this_amount_of_time=time_control if intent_tr==0

gen offset_time=log(refills_over_this_amount_of_time)

gen offset_time_weeks=refills_over_this_amount_of_time*2

gen total_refills_rate=total_refills/refills_over_this_amount_of_time


teffects ra (total_refills_rate , poisson) (intent_tr), vce(cluster hh_id)

// low expenditure 


teffects ra (total_refills_rate , poisson) (intent_tr) if expenditure_per_capita<4666.7, vce(cluster hh_id)


// mid expenditure 

teffects ra (total_refills_rate , poisson) (intent_tr) if expenditure_per_capita>=4666.7 & expenditure_per_capita<9800 , vce(cluster hh_id)


// high expenditure 
teffects ra (total_refills_rate , poisson) (intent_tr) if expenditure_per_capita>=9800, vce(cluster hh_id)





