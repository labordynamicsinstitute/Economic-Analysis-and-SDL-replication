*******************************
* Ian M. Schmutte
* BPEA
* 01.01.cty_sec_qwi_extract.sas
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
data INTERWRK.qwi_us_&suffix.(keep=fips state year quarter county naicssec naics_sector qwi_emp qwi_payroll
	);
      set 
	  INTERWRK.qwi_us_view
		(where=
		  	   (
				ownercode = "A05" and county ne "000" and naicssec ne "00" and sex="0" and agegrp="A00"
				)
			  );
	fips = state||county;
	naics2 = substr(naicssec,1,2);
	/*For consistency with QCEW. From Lars' bls_industry_recode macro (see qcew programs)*/
	select(naics2);
           when ('10') naics_sector =     "Z";  
	   when ('11') naics_sector =     "A";
	   when ('21') naics_sector =     "B";
	   when ('22') naics_sector =     "C";
	   when ('23') naics_sector =     "D";
	   when ('31') naics_sector =     "E";
	   when ('32') naics_sector =     "E";
	   when ('33') naics_sector =     "E";
	   when ('42') naics_sector =     "F";

	   when ('44') naics_sector =     "G";
	   when ('45') naics_sector =     "G";
	   when ('48') naics_sector =     "H";
	   when ('49')  naics_sector =     "H";

	   when ('51') naics_sector =     "I";
	   when ('52') naics_sector =     "J";
	   when ('53') naics_sector =     "K";
	   when ('54') naics_sector =     "L";
	   when ('55') naics_sector =     "M";
	   when ('56') naics_sector =     "N";
	   when ('61') naics_sector =     "O";
	   when ('62') naics_sector =     "P";
	   when ('71') naics_sector =     "Q";
	   when ('72') naics_sector =     "R";
	   when ('81') naics_sector =     "S";
	   when ('92') naics_sector =     "T";
	   when ('99') naics_sector =     "Y";
otherwise;
end;
if NAICS_SECTOR eq "Z"  then NAICS_SECTOR=" ";
      else if NAICS_SECTOR eq "Y" then NAICS_SECTOR ="Z";
 
/* this to fit with QWI/NAICS standard */
	
	
	/*define useful QWI variables here*/

	  
	  qwi_emp = .;
	  if sEmp not in (-1,-2) then qwi_emp = Emp;
	  qwi_payroll = .;
	  if sPayroll not in (-1,-2) then qwi_payroll = Payroll;
	  

	  
	  label fips = "5 digit FIPS county code."
			qwi_payroll = "Total Wage Bill"
			qwi_emp = "Employment: Counts"
			;
	  
run;

proc print data= INTERWRK.qwi_us_&suffix. (obs=100);
run;

proc contents data=INTERWRK.qwi_us_&suffix.;
run;

proc means data=INTERWRK.qwi_us_&suffix.;
	var _numeric_;
run;

