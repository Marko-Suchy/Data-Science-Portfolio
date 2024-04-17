/****************************
Marko Suchy, Mary Kate Richards, Jackson Stokes
Empirical project

Data wrangling script
****************************/
capture log close
clear all

cd "C:\Users\stokesj25\Box\Econometrics\DATASETS_FOR_EMPIRICAL_GROUP_PROJECT_export\General Social Survey 2018 (US)"

//initilize log
log using "log.log", replace

//get data
use "GSS2018_only2018vars.dta"

//response variables: question abany
//summarize abany

//Explanatory Variables: Education Level, Marital Status, Gender, Religion, Age, Rural/Urban
/*
summarize degree if abany == 1 | abany == 2 //education! This will need to be turned into a dummy var but its fine for now.
summarize marital if abany == 1 | abany == 2 //will need to be coded as dummy
summarize sex if abany == 1 | abany == 2 
summarize relig if abany == 1 | abany == 2 
summarize age if abany == 1 | abany == 2  //numerical. nice.
summarize region if abany == 1 | abany == 2 
*/

//Now make a new dataset that only looks at relevants columns, and breaks them out into dummys if needed
keep abany degree marital sex relig age region 
keep if abany == 1 | abany == 2

tabulate abany, generate(abany_dummy_)
tabulate degree, generate(degree_dummy_)
tabulate sex, generate(sex_dummy_)
tabulate relig, generate(relig_dummy_)
tabulate region, generate(region_dummy_)
tabulate marital, generate(marital_dummy_)

//get rid of non-dummys
keep age abany_dummy_1 abany_dummy_2 degree_dummy_1 degree_dummy_2 degree_dummy_3 degree_dummy_4 degree_dummy_5 sex_dummy_1 sex_dummy_2 relig_dummy_1 relig_dummy_2 relig_dummy_3 relig_dummy_4 relig_dummy_5 relig_dummy_6 relig_dummy_7 relig_dummy_8 relig_dummy_9 relig_dummy_10 region_dummy_1 region_dummy_2 region_dummy_3 region_dummy_4 region_dummy_5 region_dummy_6 region_dummy_7 region_dummy_8 region_dummy_9 marital_dummy_1 marital_dummy_2 marital_dummy_3 marital_dummy_4 marital_dummy_5

//rename dummys
rename abany_dummy_1 abYes
rename abany_dummy_2 abNo

rename degree_dummy_1 LessThanHS
rename degree_dummy_2 HS
rename degree_dummy_3 Assoc
rename degree_dummy_4 Bach
rename degree_dummy_5 Grad
rename sex_dummy_1 Male
rename sex_dummy_2 Female
rename relig_dummy_1 Protestant
rename relig_dummy_2 Catholic
rename relig_dummy_3 Jewish
rename relig_dummy_4 None
rename relig_dummy_5 Other
rename relig_dummy_6 Buddhism
rename relig_dummy_7 Hinduism
rename relig_dummy_8 MuslimOrIslam
rename relig_dummy_9 OrthodoxChristian
rename relig_dummy_10 Christian
rename region_dummy_1 NewEngland
rename region_dummy_2 MiddleAtlantic
rename region_dummy_3 EastNorthCentral
rename region_dummy_4 WestNorthCentral
rename region_dummy_5 SouthAtlantic
rename region_dummy_6 EastSouthAtlantic
rename region_dummy_7 WestSouthCentral
rename region_dummy_8 Mountain
rename region_dummy_9 Pacific
rename marital_dummy_1 Married
rename marital_dummy_2 Widowed
rename marital_dummy_3 Divorced
rename marital_dummy_4 Separated
rename marital_dummy_5 NeverMarried

//summarize stuff
summarize abYes
summarize abNo
sum LessThanHS
sum HS
sum Assoc
sum Bach
sum Grad
sum Male
sum Female
sum Protestant
sum Catholic
sum Jewish
sum None
sum Other
sum Buddhism
sum Hinduism
sum MuslimOrIslam
sum OrthodoxChristian
sum Christian
sum NewEngland
sum MiddleAtlantic
sum EastNorthCentral
sum WestNorthCentral
sum SouthAtlantic
sum EastSouthAtlantic
sum WestSouthCentral
sum Mountain
sum Pacific
sum age
sum Married
sum Widowed
sum Divorced
sum Separated
sum NeverMarried

//save the data!
save "regression_data.dta", replace 


log close




