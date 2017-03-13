# Programs to build the analysis files from raw input data 

Programs used to generate empirical results in ``Economic Analysis and Statistical Disclosure Limitation'' by Abowd and Schmutte (2015) 

Questions should be directed to Ian M. Schmutte (schmutte@uga.edu)

On *nix systems, the code can be executed by executing "sas runall.sas" from the command line.

Upon completion, the code will place three Stata-formatted files in the output directory designated in StandardHeader.sas. qcew_qwi_cty_sec_pri qcew_qwi_cty_pri qcew_qwi_state_pri (.dta)

We have not included the raw input data with this archive, due to their large size and complexity. They are available by request.


## Input Data Sources

### QCEW
We use the NAICS-based legacy flat files from the Quarterly Census of Employment and Wages (QCEW) version 2014Q2, as retrieved on 12 December 2014 from http://www.bls.gov/cew/data/files. See http://www.bls.gov/cew/datatoc.htm for a description of the input data. 

The QCEW files were cleaned in a step prior to this code, which builds our analysis files, using code prepared by Lars Vilhuber. The files containing the code to read in the raw are included for reference in ./qcew_readin. From the raw input data, this code produces a set of SAS-formatted datafiles: bls_us_county_&yr..sas7bdat and bls_us_state.sas7bdat for years &yr=1990-2014


### QWI

We use the R2013Q1 version of the Quarterly Workforce Indicators, which were available from http://download.vrdc.cornell.edu/qwipu/ as of 2015-August-07. Our extracts are from the wia_county_naicssec_pri files.


## CODE

To build the analysis files, the code in this folder must be run against the input data. The locations of input data must be set in the files StandardHeader.sas and StandardHeader2.sas.

For ease of replicability, we have included a file, runall.sas. On *nix systems, the build can be completed by executing "sas runall.sas" from the command line. Upon completion, the code will place three Stata-formatted files in the output directory designated in StandardHeader.sas. qcew_qwi_cty_sec_pri qcew_qwi_cty_pri qcew_qwi_state_pri (.dta).


./code [to be run in the following order]

	01.01.cty_sec_qwi_extract.sas
	01.02.cty_sec_qcew_stack.sas
	01.03.cty_sec_merge_and_export.sas
	02.01.cty_qwi_extract.sas
	02.02.cty_qcew_stack.sas
	02.03.cty_merge_and_export.sas
	03.01.state_qwi_extract.sas
	03.02.state_qcew_stack.sas
	03.03.state_merge_and_export.sas

	StandardHeader.sas
		- supplemental file
	StandardHeader2.sas
		- supplemental file
	runall.sas
		-script to run all programs in sequence

	**macros used to read in raw QWI**
		chk_dir.sas
		mk_qwi_us.sas
		mk_qwi_view.sas
