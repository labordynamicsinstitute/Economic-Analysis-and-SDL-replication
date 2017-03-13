/*
03.03.state_merge_and_export.sas
Ian M. Schmutte
Assemble qcew data for merge to QWI.
*/

%include "standardHeader.sas";

proc contents data=interwrk.qcew_extract_state;
run;

proc contents data=interwrk.qwi_state;
run;

proc sort data=interwrk.qcew_extract_state;
    by state year quarter;
run;

proc sort data=interwrk.qwi_state;
    by state year quarter;
run;


data outputs.qcew_qwi_state_pri;
    merge interwrk.qcew_extract_state (in=qcew)
          interwrk.qwi_state (in=qwi);
    by state year quarter;
    in_qwi = qwi;
    in_qcew = qcew;
    cv_emp     = sqrt(((qwi_emp - emp_month1)/emp_month1)**2);
    cv_payroll = sqrt(((qwi_payroll - total_wage)/total_wage)**2);
    ln_cv_emp  = log(cv_emp);
    ln_cv_payroll = log(cv_payroll);
    ln_num_estab  = log(n);
run;

proc contents data=outputs.qcew_qwi_state_pri;
run;

proc freq data=outputs.qcew_qwi_state_pri;
    tables year quarter state in_qwi*in_qcew;
run;

proc corr data=outputs.qcew_qwi_state_pri;
     var qwi_emp emp_month1 vt_emp_sum;
run;

proc means data=outputs.qcew_qwi_state_pri;
    var _numeric_;
run;

proc univariate data=outputs.qcew_qwi_state_pri;
    var cv_emp cv_payroll;
run;

proc export data=outputs.qcew_qwi_state_pri file="/ssgprojects/project0002/coBPEA2015/brookings-sdl-2015/data/output/qcew_qwi_state_pri.dta" DBMS=DTA replace;
run;