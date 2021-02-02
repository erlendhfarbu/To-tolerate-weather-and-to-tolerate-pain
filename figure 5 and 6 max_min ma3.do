use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\tidsserie_t7.dta", clear
graph drop _all
cd "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3"

 
foreach var in sma_3ns_cpt_day ma_3ppt_day {
_pctile `var' , percentiles(90)
return list
scalar define `var'upctile=`r(r1)'
_pctile `var', percentiles(10)
return list
scalar define `var'lpctile=`r(r1)'

gen upctile`var' = 0 if date>td(01feb2015) & date<td(01dec2016)
replace upctile`var'=1 if `var'>=`=scalar(`var'upctile)' & `var'!=.
gen lpctile`var' = 0   if date>td(01feb2015) & date<td(01dec2016)
replace lpctile`var' = 1 if `var'<=`=scalar(`var'lpctile)' & `var'!=.

list date `var' if lpctile`var'==1

list date `var' if upctile`var'==1

tw (line `var' date, lcolor(black)) if date>=td(01jan2015) & date<=td(01nov2016), yline(`=scalar(`var'lpctile)', lcolor(blue) lpattern(dash) ) yline(`=scalar(`var'upctile)', lcolor(blue) lpattern(dash)) graphregion(color(white)) name(`var')


 
 }

 

 **** 
 /* 
  Manually finding locla minima for ppt
 06apr2015 	20184
 21jun2015 	20260
 23aug2015 	20323
 09sep2015	20340
 16sep2015 	20347
 28sep2015	20359
 05oct2015	20366
 14oct2015 	20375
 02nov2015	20394
 15nov2015	20407
 23jan2016	20476
 06feb2016 	20490
 28feb2016	20512
 14mar2016 	20527 
 14apr2016 	20558
 24apr2016	20568
 26may2016 	20600
 05jun2016 	20610
 17jun2016	20622
 02jul2016 	20637
 13aug2016 	20679 
 23oct2016	20750
 */
di	td(	06apr2015	)
di	td(	 21jun2015 	)
di	td(	 23aug2015 	)
di	td(	 09sep2015	)
di	td(	 16sep2015 	)
di	td(	 28sep2015	)
di	td(	 05oct2015	)
di	td(	 14oct2015 	)
di	td(	 02nov2015	)
di	td(	 15nov2015	)
di	td(	 23jan2016	)
di	td(	 06feb2016 	)
di	td(	 28feb2016	)
di	td(	 14mar2016 	)
di	td(	 14apr2016 	)
di	td(	 24apr2016	)
di	td(	 26may2016 	)
di	td(	 05jun2016 	)
di	td(	 17jun2016	)
di	td(	 02jul2016 	)
di	td(	 13aug2016 	)
di	td(	 23oct2016	)




/* 
 Manually finding locla maxima for ppt
 15mar2015 	20162
 24apr2015 	20202
 13may2015 	20221
 02jun2015 	20241
 13jun2015	20252
 27jun2015	20266
 05jul2015 	20274
 15aug2015 	20315
 07nov2015	20399
 21nov2015 	20413
 13dec2015 	20435
 23dec2015 	20445
 25jun2016	20630
 22aug2016 	20688
 03oct2016 	20730
 08oct2016	20735
 30oct2016  20757 
  */
di	td(	 15mar2015 	)
di	td(	 24apr2015 	)
di	td(	 13may2015 	)
di	td(	 02jun2015 	)
di	td(	 13jun2015	)
di	td(	 27jun2015	)
di	td(	 05jul2015 	)
di	td(	 15aug2015 	)
di	td(	 07nov2015	)
di	td(	 21nov2015 	)
di	td(	 13dec2015 	)
di	td(	 23dec2015 	)
di	td(	 25jun2016	)
di	td(	 22aug2016 	)
di	td(	 03oct2016 	)
di	td(	 8oct2016	)
di	td(	 30oct2016    	)



  
tw (line ppt_day date, lcolor(gs8) lwidth(medthin)) (line ma_3ppt_day date, lcolor(black) lwidth(medthin)) ,  /// 
xline(	20184	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20184	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20260	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20323	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20340	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20347	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20359	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20366	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20375	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20394	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20407	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20476	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20490	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20512	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20527	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20558	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20568	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20600	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20610	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20622	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20637	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20679	, lcolor(gs10%60) lwidth(vthin))	///
xline(	20750	, lcolor(gs10%60) lwidth(vthin))	///
	xline(	20162	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20202	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20221	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20241	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20252	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20266	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20274	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20315	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20399	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20413	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20435	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20445	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20630	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20688	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20730	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
	xline(	20735	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
					graphregion(color(white))     xtitle("")  ///
					legend( rows(2)  label( 1 "Daily means of PPT") label(2 "3 day moving average PPT")) ///
					tscale( range(15feb2015 15nov2016) titlegap(tiny)) ///
					tlabel( (01mar2015) (01jul2015) (01jan2016) (01jul2016) (01nov2016), format(%tdMY) labsize(small)) /// 
					ylabel(  , labsize(small)) ytitle("kPa", size(small)) ///
					xlabel(  , labsize(small))  name(max_min_ppt)



 graph export "Supplementary Figure18.eps", as(eps) name(max_min_ppt) replace
 graph export "Supplementary Figure18.png", as(png) name(max_min_ppt) replace
 graph export "Supplementary Figure18.emf", as(emf) name(max_min_ppt) replace

/* Finding local maxima cpt
 15mar2015	20162
 01may2015 	20209
 21jun2015	20260
 06sep2015 	20337
 03oct2015	20364
 29nov2015	20421
 13dec2015	20435
 03jan2016	20456
 09jan2016	20462
 31jan2016	20484
 13feb2016	20497
 09apr2016 	20553
 24apr2016 	20568
 05may2016	20579
 13may2016 	20587
 12jun2016 	20617
 21aug2016 	20687
 28aug2016	20694
 04sep2016	20701
 22sep2016	20719
 08oct2016 	20735
 21oct2016 	20748
*/
di	td(	 15mar2015	)
di	td(	 01may2015 	)
di	td(	 21jun2015	)
di	td(	 06sep2015 	)
di	td(	 03oct2015	)
di	td(	 29nov2015	)
di	td(	 13dec2015	)
di	td(	 03jan2016	)
di	td(	 09jan2016	)
di	td(	 31jan2016	)
di	td(	 13feb2016	)
di	td(	 09apr2016 	)
di	td(	 24apr2016 	)
di	td(	 05may2016	)
di	td(	 13may2016 	)
di	td(	 12jun2016 	)
di	td(	 21aug2016 	)
di	td(	 28aug2016	)
di	td(	 04sep2016	)
di	td(	 22sep2016	)
di	td(	 08oct2016 	)
di	td(	 21oct2016 	)



/* Finding local minima cpt
 10mar2015 	20157
 22mar2015 	20169
 29mar2015 	20176
 18apr2015	20196
 09may2015 	20217
 24may2015 	20232
 31may2015	20239
 28jun2015 	20267
 05jul2015 	20274
 03aug2015 	20303
 09aug2015	20309
 12sep2015 	20343
 20sep2015 	20351
 20dec2015 	20442
 15feb2016	20499
 28feb2016	20512
 20apr2016	20564
 26jun2016 	20631
 03jul2016 	20638
 14aug2016 	20680
 29sep2016 	20726

*/
di	td(	 10mar2015 	)
di	td(	 22mar2015 	)
di	td(	 29mar2015 	)
di	td(	 18apr2015	)
di	td(	 09may2015 	)
di	td(	 24may2015	)
di	td(	 31may2015	)
di	td(	 28jun2015 	)
di	td(	 05jul2015 	)
di	td(	 03aug2015 	)
di	td(	 09aug2015	)
di	td(	 12sep2015 	)
di	td(	 20sep2015	)
di	td(	 20dec2015 	)
di	td(	 15feb2016	)
di	td(	 28feb2016	)
di	td(	 20apr2016	)
di	td(	 26jun2016 	)
di	td(	 03jul2016 	)
di	td(	 14aug2016 	)
di	td(	 29sep2016 	)


  
tw  (line sns_cpt_day date, lcolor(gs8) lwidth(medthin)) (line sma_3ns_cpt_day date, lcolor(black) lwidth(medthin)) ,  /// 
xline(	20162	, lcolor(gs10%60)  lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20209	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20260	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20337	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20364	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20421	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20435	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20456	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20462	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20484	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20497	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20553	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20568	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20579	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20587	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20617	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20687	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20694	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20701	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20719	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20735	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	///
xline(	20748	, lcolor(gs10%60) lstyle(background) lpattern(dash) lwidth(vthin))	/// 
		xline(	20157	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20169	, lcolor(gs10%60) lstyle(background) lwidth(vthin) )	///
		xline(	20176	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20196	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20217	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20232	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20239	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20267	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20274	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20303	, lcolor(gs10%60) lstyle(background) lwidth(vthin) )	///
		xline(	20309	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20343	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20351	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20442	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20499	, lcolor(gs10%60) lstyle(background) lwidth(vthin) )	///
		xline(	20512	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20564	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20631	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20638	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20680	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
		xline(	20726	, lcolor(gs10%60) lstyle(background)  lwidth(vthin))	///
					graphregion(color(white))     ///
					legend( rows(2)  label( 1 "Standarized values of CPT, seasonality removed") label(2 "Standarized values of 3 day moving average CPT, seasonality removed") size(small)) ///
					tlabel( (01mar2015) (01jul2015) (01jan2016) (01jul2016) (01nov2016), format(%tdMY) labsize(small)) /// 
					ylabel(  , labsize(small)) ytitle("Standard deviation", size(small)) ///
					xlabel(  , labsize(small)) name(max_min_cpt) xtitle("")



graph export "Supplementary Figure19.eps", as(eps) name(max_min_cpt) replace
graph export "Supplementary Figure19.png", as(png) name(max_min_cpt) replace
graph export "Supplementary Figure19.emf", as(emf) name(max_min_cpt) replace

gen max_cpt=0
replace max_cpt=1 if ///
date	==	20162	 | 	///
date	==	20209	 | 	///
date	==	20260	 | 	///
date	==	20337	 | 	///
date	==	20364	 | 	///
date	==	20421	 | 	///
date	==	20435	 | 	///
date	==	20456	 | 	///
date	==	20462	 | 	///
date	==	20484	 | 	///
date	==	20497	 | 	///
date	==	20553	 | 	///
date	==	20568	 | 	///
date	==	20579	 | 	///
date	==	20587	 | 	///
date	==	20617	 | 	///
date	==	20687	 | 	///
date	==	20694	 | 	///
date	==	20701	 | 	///
date	==	20719	 | 	///
date	==	20738	 | 	///
date	==	20748	 
	 

mat define max_cpt =  (	20162	///
\	20209	///
\	20260	///
\	20337	///
\	20364	///
\	20421	///
\	20435	///
\	20456	///
\	20462	///
\	20484	///
\	20497	///
\	20553	///
\	20568	///
\	20579	///
\	20587	///
\	20617	///
\	20687	///
\	20694	///
\	20701	///
\	20719	///
\	20738	///
\	20748	///
)
mat list max_cpt

gen min_cpt=0
replace min_cpt=1 if ///
	date	==	20157	 | 	///
date	==	20169	 | 	///
date	==	20176	 | 	///
date	==	20196	 | 	///
date	==	20217	 | 	///
date	==	20232	 | 	///
date	==	20239	 | 	///
date	==	20267	 | 	///
date	==	20274	 | 	///
date	==	20303	 | 	///
date	==	20309	 | 	///
date	==	20343	 | 	///
date	==	20351	 | 	///
date	==	20442	 | 	///
date	==	20499	 | 	///
date	==	20512	 | 	///
date	==	20564	 | 	///
date	==	20631	 | 	///
date	==	20638	 | 	///
date	==	20680	 | 	///
date	==	20726	 


mat define min_cpt	= (	20157	///
\	20169	///
\	20176	///
\	20196	///
\	20217	///
\	20232	///
\	20239	///
\	20267	///
\	20274	///
\	20303	///
\	20309	///
\	20343	///
\	20351	///
\	20442	///
\	20499	///
\	20512	///
\	20564	///
\	20631	///
\	20638	///
\	20680	///
\	20726	///
)
mat list min_cpt

gen max_ppt=0
replace max_ppt=1 if /// 
	date	==	20162	 | 	///
date	==	20202	 | 	///
date	==	20221	 | 	///
date	==	20241	 | 	///
date	==	20252	 | 	///
date	==	20266	 | 	///
date	==	20274	 | 	///
date	==	20315	 | 	///
date	==	20399	 | 	///
date	==	20413	 | 	///
date	==	20435	 | 	///
date	==	20445	 | 	///
date	==	20630	 | 	///
date	==	20688	 | 	///
date	==	20730	 | 	///
date	==	20735	 


mat define max_ppt =  (	20162	///
\	20202	///
\	20221	///
\	20241	///
\	20252	///
\	20266	///
\	20274	///
\	20315	///
\	20399	///
\	20413	///
\	20435	///
\	20445	///
\	20630	///
\	20688	///
\	20730	///
\	20735	///
)
mat list max_ppt

gen min_ppt=0
replace min_ppt=1 if ///
	date	==	20184	 | 	///
date	==	20260	 | 	///
date	==	20323	 | 	///
date	==	20340	 | 	///
date	==	20347	 | 	///
date	==	20359	 | 	///
date	==	20366	 | 	///
date	==	20375	 | 	///
date	==	20394	 | 	///
date	==	20407	 | 	///
date	==	20476	 | 	///
date	==	20490	 | 	///
date	==	20512	 | 	///
date	==	20527	 | 	///
date	==	20558	 | 	///
date	==	20568	 | 	///
date	==	20600	 | 	///
date	==	20610	 | 	///
date	==	20622	 | 	///
date	==	20637	 | 	///
date	==	20679	 | 	///
date	==	20750	 


mat define min_ppt = (  	20184	///
\	20260	///
\	20323	///
\	20340	///
\	20347	///
\	20359	///
\	20366	///
\	20375	///
\	20394	///
\	20407	///
\	20476	///
\	20490	///
\	20512	///
\	20527	///
\	20558	///
\	20568	///
\	20600	///
\	20610	///
\	20622	///
\	20637	///
\	20679	///
\	20750	 )
mat list min_ppt

foreach var in max_ppt min_ppt max_cpt min_cpt     {
forvalues i=1(1)14{
gen dbf`i'`var'=0
forvalues m=1(1)40{

replace dbf`i'`var'=1 if date == (`var'[`m',1] - `i')
}
}
}


foreach var in max_ppt min_ppt max_cpt min_cpt     {
forvalues i=1(1)14{
gen daf`i'`var'=0
forvalues m=1(1)40{

replace daf`i'`var'=1 if date == (`var'[`m',1] + `i')
}
}
}




save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\forfigur.dta", replace


*** uten CI
forvalues i=1(2)3{ 
scalar define n = floor(`i'/2)
scalar define q = `i'
cd "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3"
use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\forfigur.dta", clear

postfile handle str25 name str14 weather sd sd1 sd2 se p_u p_l p t df mu_2 N_2 mu_1 N_1 using "ttest`i'.dta", replace

*maxima cpt
foreach exp in sma_`i'ns_cpt_day ma_`i'a_ffm ma_`i'a_pom ma_`i'a_rr ma_`i'a_tam ma_`i'a_td ma_`i'a_um {
forvalues p=14(-1)1 {
di "dbf`p'max_cpt"
ttest `exp', by(dbf`p'max_cpt) welch
post handle ("dbf`p'max_cpt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
}

ttest `exp', by(max_cpt) welch
post handle ("max_cpt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 

forvalues m=1(1)14 {
ttest `exp', by(daf`m'max_cpt)  welch
post handle ("daf`m'max_cpt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
}
} 


****minima cpt
foreach exp in sma_`i'ns_cpt_day ma_`i'a_ffm ma_`i'a_pom ma_`i'a_rr ma_`i'a_tam ma_`i'a_td ma_`i'a_um  {
forvalues p=14(-1)1 {
di "dbf`p'min_cpt"
ttest `exp', by(dbf`p'min_cpt) welch
post handle ("dbf`p'min_cpt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
}

ttest `exp', by(min_cpt) welch
post handle ("min_cpt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
forvalues m=1(1)14 {
ttest `exp', by(daf`m'min_cpt)  welch
post handle ("daf`m'min_cpt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
}
} 

*** maxima ppt 
foreach exp in ma_`i'ppt_day ma_`i'a_ffm ma_`i'a_pom ma_`i'a_rr ma_`i'a_tam ma_`i'a_td ma_`i'a_um {
forvalues p=14(-1)1 {
di "dbf`p'max_ppt"
ttest `exp', by(dbf`p'max_ppt) welch
post handle ("dbf`p'max_ppt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
}

ttest `exp', by(max_ppt) welch
post handle ("max_ppt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
forvalues m=1(1)14 {
ttest `exp', by(daf`m'max_ppt)  welch
post handle ("daf`m'max_ppt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
}
} 
***minima ppt
foreach exp in ma_`i'ppt_day ma_`i'a_ffm ma_`i'a_pom ma_`i'a_rr ma_`i'a_tam ma_`i'a_td ma_`i'a_um {
forvalues p=14(-1)1 {
di "dbf`p'min_ppt"
ttest `exp', by(dbf`p'min_ppt) welch
post handle ("dbf`p'min_ppt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
}

ttest `exp', by(min_ppt) welch
post handle ("min_ppt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
forvalues m=1(1)14 {
ttest `exp', by(daf`m'min_ppt)  welch
post handle ("daf`m'min_ppt") ("`exp'") (r(sd)) (r(sd_2))   (r(sd_1))  (r(se))   (r(p_u)) (r(p_l)) (r(p)) (r(t)) (r(df_t)) (r(mu_2))  (r(N_2)) (r(mu_1)) (r(N_1)) 
}
} 
postclose handle 

}

forvalues i=1(2)3{ 
scalar define n = floor(`i'/2)
scalar define q = `i'
use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\ttest`i'.dta", clear

 
 
gen diff=mu_2-mu_1
gen u_ci=diff + se*invttail(df, 0.025)
gen l_ci=diff - se*invttail(df, 0.025)

gen id=_n
gen last=_n==29
gen kat_ttest=.
forvalues k=29(29)812 {
replace kat_ttest=`k'/29 if id<=`k' & id>`k'-29
}
bys kat_ttest: gen day=-15 + _n
save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\ttest`i'.dta", replace

graph drop _all

tw (line mu_2 day, lcolor(black))  if kat_ttest==1, graphregion(color(white)) legend(off) name(figur1) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  xtitle("") xlabel(none) title("CPT", size(vsmall)) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("Standard deviation", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==2, graphregion(color(white)) legend(off) name(figur2) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly windspeed", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)  ytitle("m/s", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==3, graphregion(color(white)) legend(off) name(figur3) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly barometric pressure", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("hPa", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==4, graphregion(color(white)) legend(off) name(figur4) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly precipitation", size(vsmall)) xtitle("") xlabel(none)  ylabel(  , labsize(vsmall)) xscale(range( -14 14))   nodraw fysize(31.5)  ytitle("mm", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==5, graphregion(color(white)) legend(off) name(figur5) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly temperature", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("°C", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==6, graphregion(color(white)) legend(off) name(figur6) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly dew point", size(vsmall))  xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14))   nodraw fysize(31.5)   ytitle("°C", size(vsmall))

tw (line mu_2 day, lcolor(black)) if kat_ttest==7, graphregion(color(white)) legend(off) name(figur7) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly relative humidity", size(vsmall)) xtitle("Day", size(vsmall))  ylabel(  , labsize(vsmall)) xscale(range( -14 14)) xlabel(-14(7)14, labsize(vsmall)) nodraw fysize(37)   ytitle("%", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==8, graphregion(color(white)) legend(off) name(figur8) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  xtitle("") xlabel(none) title("CPT", size(vsmall))  ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("Standard deviation", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==9, graphregion(color(white)) legend(off) name(figur9) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly windspeed", size(vsmall)) xtitle("") xlabel(none)  ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5) ytitle("m/s", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==10, graphregion(color(white)) legend(off) name(figur10) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly barometric pressure", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("hPa", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==11, graphregion(color(white)) legend(off) name(figur11) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly precipitation", size(vsmall)) xtitle("") xlabel(none)  ylabel(  , labsize(vsmall)) xscale(range( -14 14))   nodraw fysize(31.5)   ytitle("mm", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==12, graphregion(color(white)) legend(off) name(figur12) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly temperature", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)    ytitle("°C", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==13, graphregion(color(white)) legend(off) name(figur13) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly dew point", size(vsmall)) xtitle("") xlabel(none)  ylabel(  , labsize(vsmall)) xscale(range( -14 14))   nodraw fysize(31.5)  ytitle("°C", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==14, graphregion(color(white)) legend(off) name(figur14) yline(0, lcolor(black) lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly relative humidity", size(vsmall)) xtitle("Day", size(vsmall))  ylabel(  , labsize(vsmall)) xscale(range( -14 14)) xlabel(-14(7)14, labsize(vsmall)) nodraw fysize(37)  ytitle("%", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==15, graphregion(color(white)) legend(off) name(figur15) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) xtitle("") xlabel(none) title("PPT", size(vsmall)) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)  ytitle("kPa", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==16, graphregion(color(white)) legend(off) name(figur16) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) title("Anomaly windspeed", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)  ytitle("m/s", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==17, graphregion(color(white)) legend(off) name(figur17) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) title("Anomaly barometric pressure", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("hPa", size(vsmall)) 

tw (line mu_2 day, lcolor(black))if kat_ttest==18, graphregion(color(white)) legend(off) name(figur18) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) title("Anomaly precipitation", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14))  nodraw fysize(31.5)   ytitle("mm", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==19, graphregion(color(white)) legend(off) name(figur19) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) title("Anomaly temperature", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("°C", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==20, graphregion(color(white)) legend(off) name(figur20) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly dew point", size(vsmall)) xtitle("") xlabel(none)  ylabel(  , labsize(vsmall)) xscale(range( -14 14))   nodraw fysize(31.5)   ytitle("°C", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==21, graphregion(color(white)) legend(off) name(figur21) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) title("Anomaly relative humidity", size(vsmall)) xtitle("Day", size(vsmall))  ylabel(  , labsize(vsmall)) xscale(range( -14 14)) xlabel(-14(7)14, labsize(vsmall)) nodraw fysize(37)   ytitle("%", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==22, graphregion(color(white)) legend(off) name(figur22) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) xtitle("") xlabel(none) title("PPT", size(vsmall)) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("kPa", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==23, graphregion(color(white)) legend(off) name(figur23) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) title("Anomaly  windspeed", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("m/s", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==24, graphregion(color(white)) legend(off) name(figur24) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) title("Anomaly barometric pressure", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("hPa", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==25, graphregion(color(white)) legend(off) name(figur25) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) title("Anomaly precipitation", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14))  nodraw fysize(31.5)   ytitle("mm", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==26, graphregion(color(white)) legend(off) name(figur26) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) title("Anomaly temperature", size(vsmall)) xtitle("") xlabel(none) ylabel(  , labsize(vsmall)) xscale(range( -14 14)) nodraw fysize(31.5)   ytitle("°C", size(vsmall)) 

tw (line mu_2 day, lcolor(black)) if kat_ttest==27, graphregion(color(white)) legend(off) name(figur27) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin))  title("Anomaly dew point", size(vsmall)) xtitle("") xlabel(none)  ylabel(  , labsize(vsmall)) xscale(range( -14 14))   nodraw fysize(31.5)   ytitle("°C", size(vsmall)) 

tw (line mu_2 day, lcolor(black))  if kat_ttest==28, graphregion(color(white)) legend(off) name(figur28) yline(0, lcolor(black)  lw(vthin)) xline(0, lcolor(black) lw(vthin)) title("Anomaly relative humidity", size(vsmall)) xtitle("Day", size(vsmall))  ylabel(  , labsize(vsmall)) xscale(range( -14 14)) xlabel(-14(7)14, labsize(vsmall)) nodraw fysize(37)  ytitle("%", size(vsmall))



graph combine figur1  figur5 figur3 figur4 figur2 figur7 , col(1) graphregion(color(white)) xcommon  name(cptupctile) nodraw  imargin(0 0 0 0) fxsize(70)
graph combine figur8  figur12 figur10  figur11 figur9 figur14 , col(1) graphregion(color(white)) xcommon name(cptlpctile) nodraw  imargin(0 0 0 0) fxsize(70)

graph combine cptlpctile cptupctile,  graphregion(color(white)) col(2) name("CPTnoCIma`=scalar(q)'") 
graph export "CPTnoCIma`=scalar(q)'.png", as(png) name("CPTnoCIma`=scalar(q)'") replace
graph save CPTnoCIma`=scalar(q)' CPTnoCIma`=scalar(q)', replace 
graph combine figur15  figur19 figur17 figur18 figur16 figur21 , col(1) graphregion(color(white)) xcommon  name(pptupctile) nodraw  imargin(0 0 0 0) fxsize(70)
graph combine figur22  figur26 figur24 figur25 figur23 figur28 , col(1) graphregion(color(white)) xcommon  name(pptlpctile) nodraw  imargin(0 0 0 0) fxsize(70)
graph combine pptlpctile pptupctile, graphregion(color(white)) col(2) name("PPTnoCIma`=scalar(q)'")  
graph export "PPTnoCIma`=scalar(q)'.png", as(png) name("PPTnoCIma`=scalar(q)'") replace
graph save PPTnoCIma`=scalar(q)' , replace

 
}




graph use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\PPTnoCIma3.gph"
graph export "Figure5.png", as(png) name("PPTnoCIma3") replace
graph export "Figure5.emf", as(emf) name("PPTnoCIma3") replace
graph export "Figure5.eps", as(eps) name("PPTnoCIma3") replace


graph use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\CPTnoCIma3.gph"
graph export "Figure6.png", as(png) name("CPTnoCIma3") replace
graph export "Figure6.emf", as(emf) name("PPTnoCIma3") replace
graph export "Figure6.eps", as(eps) name("PPTnoCIma3") replace

