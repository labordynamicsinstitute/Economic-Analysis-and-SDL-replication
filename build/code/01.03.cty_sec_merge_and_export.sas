/*
01.03.cty_sec_merge_and_export.sas
Ian M. Schmutte
Assemble qcew data for merge to QWI.
*/

%include "standardHeader.sas";

proc contents data=interwrk.qcew_extract_cty_sector;
run;

proc contents data=interwrk.qwi_us_wia_county_naicssec_pri;
run;

proc sort data=interwrk.qcew_extract_cty_sector;
    by fips naics_sector year quarter;
run;

proc sort data=interwrk.qwi_us_wia_county_naicssec_pri;
    by fips naics_sector year quarter;
run;


data outputs.qcew_qwi_cty_sec_pri;
    merge interwrk.qcew_extract_cty_sector (in=qcew)
          interwrk.qwi_us_wia_county_naicssec_pri (in=qwi);
    by fips naics_sector year quarter;
    in_qwi = qwi;
    in_qcew = qcew;
    cv_emp     = sqrt(((qwi_emp - emp_month1)/emp_month1)**2);
    cv_payroll = sqrt(((qwi_payroll - total_wage)/total_wage)**2);
    ln_cv_emp  = log(cv_emp);
    ln_cv_payroll = log(cv_payroll);
    ln_num_estab  = log(n);
run;

proc contents data=outputs.qcew_qwi_cty_sec_pri;
run;

proc freq data=outputs.qcew_qwi_cty_sec_pri;
    tables naics_sector year quarter state in_qwi*in_qcew;
run;

proc corr data=outputs.qcew_qwi_cty_sec_pri;
     var qwi_emp emp_month1;
run;

proc means data=outputs.qcew_qwi_cty_sec_pri;
    var _numeric_;
run;

proc univariate data=outputs.qcew_qwi_cty_sec_pri;
    var cv_emp cv_payroll;
run;

proc export data=outputs.qcew_qwi_cty_sec_pri file="/ssgprojects/project0002/coBPEA2015/brookings-sdl-2015/data/output/qcew_qwi_cty_sec_pri.dta" DBMS=DTA replace;
run;


