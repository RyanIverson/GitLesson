libname library '/folders/myfolders/Methods/';
libname in '/folders/myfolders/Methods/';
libname out '/folders/myfolders/Methods/';
  
proc format library=library;

data out.cchstemp (keep=CCC_101 CCCDDIA CCC_105 DIA_01 FSCDAFS2 dhhgage dhh_sex hwtgbmi gen_07 PACDTLE FVCDTOT SDCGCGT wts_m);
set in.cchs1314;
run;

proc contents;
run;

proc freq data=out.cchstemp;
table ccc_101 cccddia ccc_105 fscdafs2 dhh_sex dhhgage sdcgcgt gen_07;
run;

proc means data=out.cchstemp;
var hwtgbmi wts_m pacdtle fvcdtot;
run;

 
data recode;
set out.cchstemp;

*CCC_101;
if CCC_101>2 then hasdiabetes=.;
if CCC_101<=2 then hasdiabetes=CCC_101;

*CCCDDIA;
if CCCDDIA>3 then diabetestype=.;
if CCCDDIA<=3 then diabetestype=CCCDDIA;

*diabetes;
if diabetestype=2 then diabetes=1;
if hasdiabetes=2 then diabetes=0;

*CCC_105;
if CCC_105>2 then insulin=.;
if CCC_105=2 then insulin=0;
if CCC_105=1 then insulin=1;

*DIA_01;
if DIA_01>2 then hemoglobin=.;
if DIA_01=2 then hemoglobin=0;
if DIA_01=1 then hemoglobin=1;

*FSCDAFS2;
if FSCDAFS2>2 then foodsec=.;
if FSCDAFS2<=2 then foodsec=FSCDAFS2;

*DHHGAGE;
if DHHGAGE <=2 then age = 1;
if 3<= DHHGAGE <=4 then age = 2;
if 5<= DHHGAGE <=6 then age = 3;
if 7<= DHHGAGE <=8 then age = 4;
if 9<= DHHGAGE <=10 then age = 5;
if 11<= DHHGAGE <=12 then age = 6;
if DHHGAGE >=13 then age = 7;

*DHH_SEX;
if DHH_SEX=2 then sex=0;
if DHH_SEX=1 then sex=DHH_SEX;

*SDCGCGT;
if SDCGCGT>2 then race=.;
if SDCGCGT=1 then race=0;
if SDCGCGT=2 then race=1;

*GEN_07;
if GEN_07>5 then stress=.;
if GEN_07<=5 then stress=GEN_07;

*HWTGBMI;
if HWTGBMI>56.73 then bmi=.;
if HWTGBMI<=56.73 then bmi=HWTGBMI;

*PACDTLE;
if PACDTLE>42.2 then energy=.;
if PACDTLE<=42.2 then energy=PACDTLE;

*FVCDTOT;
if FVCDTOT>42.4 then fruitveg=.;
if FVCDTOT<=42.4 then fruitveg=FVCDTOT;

run;

proc freq data=recode;
table diabetes diabetestype insulin hemoglobin foodsec age sex race stress;
run;

proc means data=recode;
var bmi energy fruitveg wts_m;
run;



*////////////////////////////////////////////
 /										    /
 / 			  LOGISTIC REGRESSION		    /
 /											/
 ////////////////////////////////////////////;
 
 data logistic;
 set recode;
 if diabetes ne . and foodsec ne . and age ne . and sex ne . and bmi ne .; *keep only participants who are not
 missing data on any variables in our model; 
 run;
 
 *simple logistic regression;
 proc logistic data=logistic;
 class foodsec(ref='0')/param=ref;
 model diabetes(event='1')=foodsec; 
 run;
 
 *multiple logistic regression;
 proc logistic data=logistic;
 class foodsec(ref='0') age (ref='1') sex (ref='0')/param=ref;
 model diabetes(event='1')=foodsec age sex bmi; 
 run;
 
 data pval;
 Cval05=cinv(.95,4); *Critval is a new variable, which takes the value of cinv (a SAS function to obtain the 
 critical value for a given alpha and df), and the numbers in parentheses are 1-alpha and the df.;
 Cval01=cinv(.99,4); 
 Cval001=cinv(.999,4); 
 pvalue=1-probchi(796.589,9);  *pvalue is a new variable set to equal 1 - the probability of obeserving a chi-square
 at least as large as was observed for the given df).;
 run;

 proc print data=pval; *proc print is used to display contents of a data set. In this case, we only have 2 variables
 with one value each, so we simply want to print the entire data. You can print only sub-sets of cases or variables if you 
 need to;
 run;

















