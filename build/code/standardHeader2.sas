******************************
**Macro variables
******************************;
/*Make sure that the path below points to the current version of code and data*/
%let trunk = /ssgprojects/project0002/coBPEA2015/brookings-sdl-2015;


/*Suffix for the raw QWI data we'll be using*/
%let suffix = wia_county_naicssec_pri;

/*Path to the QWI base for this run*/
%let qwibase=/data/clean/qwipu/state/data.R2013Q1;


/*Path to input data*/
%let inputPath = &trunk./&databranch./inputs;
%let outputPath = &trunk./&databranch./outputs;

******************************
**Libraries
******************************;
libname inputs "&trunk./data/input";
libname interwrk "&trunk./data/interwrk";
libname outputs "&trunk./data/output";

******************************
**Options
******************************;
options obs=max fullstimer symbolgen mprint LRECL=600;