*******************************
* est_var_fuzz_me.do
* February 2015
* Ian Schmutte
*******************************

/*SPECIFY INPUT DATA SET AND LOGFILE*/
    local logfile "./est_var_fuzz_me.log" 
    capture log close
    log using `logfile', replace

    pause on
    set more off
    set linesize 200
    clear all
    #delimit ;
    set matsize 10000;

/*COUNTY-SECTOR*/
use "./qcew_qwi_cty_sec_pri.dta";
keep if quarter==1 & year>=2007 & year <= 2012;

egen fips_sec_cat = group(fips naics_sector);

xtset fips_sec_cat year;

mixed ln_cv_emp ln_num_estab || fips_sec_cat: ln_num_estab, covariance(unstructured);
mixed ln_cv_payroll ln_num_estab || fips_sec_cat: ln_num_estab, covariance(unstructured);

/*COUNTY*/
clear all;

use "./qcew_qwi_cty_pri.dta";

keep if quarter==1 & year>=2007 & year <= 2012;
egen fipscat=group(fips);

xtset fipscat year;

mixed ln_cv_emp ln_num_estab || fipscat: ln_num_estab, covariance(unstructured);
mixed ln_cv_payroll ln_num_estab || fipscat: ln_num_estab, covariance(unstructured);



/*STATE*/
clear all;    

use "./qcew_qwi_state_pri.dta";

keep if quarter==1 & year>=2007 & year <= 2012;
egen statecat=group(state);

mixed ln_cv_emp ln_num_estab ||statecat: ln_num_estab, covariance(unstructured);
mixed ln_cv_payroll ln_num_estab ||statecat: ln_num_estab, covariance(unstructured);


log close;
exit, clear STATA;
