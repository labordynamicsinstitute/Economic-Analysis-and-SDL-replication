Programs and data needed to reproduce tables in ``Economic Analysis and Statistical Disclosure Limitation'' by Abowd and Schmutte (2015) 
2015-August-07
Questions should be directed to Ian M. Schmutte (schmutte@uga.edu)


To reproduce Table 1, run est_var_fuzz.do
To reproduce Table 2, run est_var_fuzz_me.do

Both programs call the same three data files:
	qcew_qwi_cty_sec_pri.dta
	qcew_qwi_cty_pri.dta
	qcew_qwi_state_pri.dta


The code used to build the analysis data from raw input is included with this archive, under ../build/.