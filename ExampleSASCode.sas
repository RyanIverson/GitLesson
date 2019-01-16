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

*add comment;