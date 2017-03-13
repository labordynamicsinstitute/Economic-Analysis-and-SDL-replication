*******************************
* est_var_fuzz.do
* February 2015
* Ian Schmutte
*******************************

/*SPECIFY INPUT DATA SET AND LOGFILE*/
    local logfile "./est_var_fuzz.log" 
    capture log close
    log using `logfile', replace

    pause on
    set more off
    set linesize 200
    clear all
    #delimit ;
    set matsize 10000;

use "./qcew_qwi_cty_sec_pri.dta";

keep if year<=2011 & quarter ==1 & year>=2006;

reg ln_cv_emp ln_num_estab , rob;


reg ln_cv_payroll  ln_num_estab, rob;


clear all;

use "./qcew_qwi_cty_pri.dta";

keep if year<=2012 & quarter ==1 & year>=2007;


reg ln_cv_emp ln_num_estab , rob;



reg ln_cv_payroll  ln_num_estab, rob;


clear all;

use "./qcew_qwi_state_pri.dta";

keep if year<=2012 & quarter ==1 & year>=2007;


reg ln_cv_emp ln_num_estab , rob;


reg ln_cv_payroll  ln_num_estab, rob;


log close;

exit, clear STATA;
