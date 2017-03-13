*******************************
* Ian M. Schmutte
* BPEA
* 03.01.state_qwi_extract.sas
* Current:  Feb 2015
******************************;
/*Load the standard header*/
%include "./standardHeader2.sas";
******************************;

************************
This program extracts private sector hires and separations from the QWI
database at the county level. The extracts are for all NAICS sectors, genders,
and age groups. THe output is a dataset with one record for every
county-year-quarter-sector
************************;

*******************************************************************************
*******BEGIN*PROGRAM***********************************************************
*******************************************************************************;
/*include macro to check for work directory and create if needed. Automated since each compute node has a different scratch area.*/

%include "./chk_dir.sas";

/*Load Lars' macros for accessing the national file as a view*/
%include "./mk_qwi_us.sas";
%include "./mk_qwi_view.sas";


/*
from http://www.vrdc.cornell.edu/news/qwipu-r2009q4-data-through-20091-available-for-local-processing/
%mk_qwi_us(states=all,qwibase=/ssgprojects/qwipu/data/);
%mk_qwi_view(states=all,qwilib=qwi_us,suffix=(SUFFIX),outlib=WORK,outname=qwi_us_&suffix.,keep=);

where SUFFIX is one of the QWI file suffixes, the KEEP= statement allows you to subset to select files, and of course OUTLIB and OUTNAME can be customized to your liking.
*/


%let keeplist=Emp Payroll sEmp sPayroll state county sex agegrp year quarter naicssec ownercode;

%mk_qwi_us(states=all,qwibase=&qwibase.);
%mk_qwi_view(states=all,
	qwilib=qwi_us,
	suffix=&suffix.,
	outlib=INTERWRK,
	outname=qwi_us_view,
	keep=&keeplist
	);

/*A little postprocessing to keep only variables of interest and define a concatenated FIPS county code*/
data INTERWRK.qwi_state (keep=state year quarter qwi_emp qwi_payroll
	);
      set 
	  INTERWRK.qwi_us_view
		(where=
		  	   (
				ownercode = "A05" and county = "000" and naicssec = "00" and sex="0" and agegrp="A00"
				)
			  );

 
/* this to fit with QWI/NAICS standard */
	
	
	/*define useful QWI variables here*/

	  
	  qwi_emp = .;
	  if sEmp not in (-1,-2) then qwi_emp = Emp;
	  qwi_payroll = .;
	  if sPayroll not in (-1,-2) then qwi_payroll = Payroll;
	  

	  
	  label         qwi_payroll = "Total Wage Bill"
			qwi_emp = "Employment: Counts"
			;
	  
run;

proc print data= INTERWRK.qwi_state (obs=100);
run;

proc contents data=INTERWRK.qwi_state;
run;

proc means data=INTERWRK.qwi_state;
	var _numeric_;
run;

