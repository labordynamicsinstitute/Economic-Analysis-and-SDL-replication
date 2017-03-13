******************************
**Macro variables
******************************;
/*Make sure that the path below points to the current version of code and data*/
%let trunk = /ssgprojects/project0002/coBPEA2015/brookings-sdl-2015;
%let codebranch = /code/current;
%let databranch = /data/current;

/*Path to QCEW input data*/
%let qcewPath = /data/clean/qcew;

******************************
**Libraries
******************************;
libname QWI "/ssgprojects/project0002/coBPEA2015/brookings-sdl-2015/data/input";
libname interwrk "/ssgprojects/project0002/coBPEA2015/brookings-sdl-2015/data/interwrk";
libname outputs "/ssgprojects/project0002/coBPEA2015/brookings-sdl-2015/data/output";
libname QCEW "&qcewPath./yearly";
libname QCEWEX "&qcewPath./extra";


******************************
**Options
******************************;
options obs=max fullstimer symbolgen mprint LRECL=600;


