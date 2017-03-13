/*
03.02.state_qcew_stack
Ian M. Schmutte
Assemble qcew data for merge to QWI.
*/

%include "standardHeader.sas";

data interwrk.qcew_extract_state;
	set 
		QCEWEX.bls_us_state (where=(aggregation_level="51" and ownership_code="5") 
			keep=state year quarter aggregation_level ownership_code emp_month1 emp_month3 total_wage n);
run;


proc contents data=interwrk.qcew_extract_state;
run;

proc print data=interwrk.qcew_extract_state (obs=10);
run;

proc freq data=interwrk.qcew_extract_state;
	tables state year;
run;

