/*
01.02.cty_sec_qcew_stack.sas
Ian M. Schmutte
Assemble qcew data for merge to QWI.
*/

%include "standardHeader.sas";

%macro allqcew;

data interwrk.qcew_extract_cty_sector;
	set 
		%do yr = 1990 %to 2014;
		QCEW.bls_us_county_&yr.(where=(aggregation_level="74" and ownership_code="5") 
			keep=state county year quarter aggregation_level ownership_code emp_month1 emp_month2 emp_month3 total_wage n naics_sector)
	    %end;
	    ;
	fips = state||county;
run;

%mend;
%allqcew;

proc contents data=interwrk.qcew_extract_cty_sector;
run;

proc print data=interwrk.qcew_extract_cty_sector (obs=10);
run;

proc freq data=interwrk.qcew_extract_cty_sector;
	tabls naics_sector;
run;

