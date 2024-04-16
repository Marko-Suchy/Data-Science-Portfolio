/****************************
Marko Suchy, Mary Kate Richards, Jackson Stokes
Empirical project

Regression Runing Script
****************************/

capture log close
clear all

cd "C:\Users\suchym24\Box\Econometrics\DATASETS_FOR_EMPIRICAL_GROUP_PROJECT_export\General Social Survey 2018 (US)"

//initilize log
log using "regress.log", replace

//get data
use "regression_data.dta"

//data manipulation
//this stuff needs to get filled in!
drop if missing(Catholic) //drops rows which don't have an answer for religion
gen age_str = string(age)
drop if age_str == "89 or older" //drops non-numeric age stuff
drop age_str

drop if missing(Married)

//run a probit regression
//Baseline dummys: LessThanHS, Female, None (religion), New England, Nevermarried, City_Gt_TwoFiftyK
probit abYes age HS Assoc Bach Grad Male Protestant Catholic Jewish Other Buddhism Hinduism MuslimOrIslam OrthodoxChristian Christian MiddleAtlantic EastNorthCentral WestNorthCentral SouthAtlantic EastSouthCentral WestSouthCentral Mountain Pacific Married Widowed Divorced Separated Country_Nonfarm Farm Town_Lt_FiftyK FiftyK_to_TwoFiftyK Big_City_Suburb

//look at predictive power
predict pred_probs, pr
gen pred_class = pred_probs >= 0.5
gen correct_pred = pred_class == abYes
sum correct_pred

//look at average marginal effects
margins, dydx(*) post


ssc install outreg2
outreg2 using probit_result.xls


log close
