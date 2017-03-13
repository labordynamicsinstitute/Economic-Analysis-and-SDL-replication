/*
02.02.cty_qcew_stack.sas
Ian M. Schmutte
Assemble qcew data for merge to QWI.
*/

%include "standardHeader.sas";

%macro allqcew;

data interwrk.qcew_extract;
	set 
		%do yr = 1990 %to 2014;
		QCEW.bls_us_county_&yr.(where=(aggregation_level="71" and ownership_code="5") 
			keep=state county year quarter aggregation_level ownership_code emp_month1 emp_month3 total_wage n)
	    %end;
	    ;
	fips = state||county;
run;

%mend;
%allqcew;

proc contents data=interwrk.qcew_extract;
run;

