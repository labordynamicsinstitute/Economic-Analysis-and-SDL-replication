/* $Id: mk_qwi_view.sas 519 2009-04-18 02:58:58Z vilhu001 $ */
/* $URL: https://repository.vrdc.cornell.edu/private/lv39_Papers/HRSGEO/programs/current/macros/mk_qwi_view.sas $ */

/* creates a composite QWI  view that has all files */

%macro mk_qwi_view(states=all,qwilib=,suffix=,outlib=WORK,outname=qwi_us_&suffix.,keep=);
%local state exist_states i;

/* the states for now are hard-coded. This shold be automated */
%if ( "&states" = "all" ) %then
  %let states=
ak al ar az ca co ct dc de fl ga hi ia id il in ks ky la md me mi mn
mo ms mt nc nd ne nh nj nm nv ny oh ok or pa ri sc sd tn tx ut va vt wa wi wv wy;

%if ( "&qwilib." = "" or "&suffix." = "" ) %then %do;
%put %upcase(error)::: you should define qwilib! ;
%put %upcase(error)::: you should define suffix! ;
data _null_;
call execute('endsas;');
run;
%end;


data &outlib..&outname. / view=&outlib..&outname.;
     set
/* collect individual files */
%let i=1 ;
%let exist_states=;
%do %while ("%scan(&states.,&i.)" ne "" ) ;
  %let state=%scan(&states.,&i.);
  %let file=qwi_&state._&suffix.;

  %if %sysfunc(exist(&qwilib..&file.)) %then %do;

        &qwilib..&file.(in=in_&state.
	%if ( "&keep." ne "" ) %then %do;
	 keep=&keep.
	%end;
	 )

  %end;
%let i=%eval(&i.+1);
%end;
;
run;



%mend;