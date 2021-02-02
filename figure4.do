***XCORR****
**drop xday
use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\tidsserie_t7.dta", clear
cd "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3"
graph drop _all

gen xday= -21 + _n
replace xday=. if xday>20

foreach var in ma_3a_ffm ma_3a_pom ma_3a_rr ma_3a_tam ma_3a_td ma_3a_um {
xcorr ma_3ppt_day `var', gen(pptx`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3ppt_day `var' if periods==`i', gen(pptx`var'`i') noplot nodraw
}
}

graph drop _all
*******PPT
tw  (line pptxma_3a_tam xday) (line pptxma_3a_pom xday) (line pptxma_3a_rr xday)   (line pptxma_3a_um xday) (line pptxma_3a_ffm xday), name(xcor)  xtitle("Lags in days", size(vsmall))  xscale(range(-14 14)) xlabel(-14(7)14, labsize(vsmall))  fysize(35) fxsize(100) yscale(range(-0.4 0.6)) ylabel(-0.2(0.2)0.6, labsize(vsmall)) xline(-1, lcolor(gs10) lpattern(dash) lwidth(thin)) xline(1, lcolor(gs10) lpattern(dash) lwidth(thin)) legend(cols(1) position(2)label(1 "Anomaly temperature") label(2 "Anomaly barometric pressure") label(3 "Anomaly preciptiation") label(4 "Anomaly relative humidity") label(5 "Anomaly windspeed") size(small) ) graphregion(margin(l=22 r=22)) title("A: March 2015 to November 2016", size(small)) graphregion(color(white)) ytitle("Correlation coefficient", size(small))


tw  (line pptxma_3a_tam1 xday) (line pptxma_3a_pom1 xday) (line pptxma_3a_rr1 xday)  (line pptxma_3a_um1 xday) (line pptxma_3a_ffm1 xday), name(xcor1) legend(off) xtitle("Lags in days", size(vsmall)) xscale(range(-14 14))  xlabel(-14(7)14, labsize(small))   fysize(60) yscale(range(-0.4 0.6)) ylabel(-0.2(0.2)0.6, labsize(small)) xline(-1, lcolor(gs10) lpattern(dash) lwidth(thin)) xline(1, lcolor(gs10) lpattern(dash) lwidth(thin)) graphregion(margin(l=22 r=22)) title("B: March 2015 to June 2015", size(small)) graphregion(color(white)) ytitle("Correlation coefficient", size(small))


tw  (line pptxma_3a_tam2 xday) (line pptxma_3a_pom2 xday) (line pptxma_3a_rr2 xday)  (line pptxma_3a_um2 xday) (line pptxma_3a_ffm2 xday), name(xcor2) legend(off) xtitle("Lags in days", size(vsmall)) xscale(range(-14 14)) xlabel(-14(7)14, labsize(small))   fysize(60) yscale(range(-0.4 0.6)) ylabel(-0.2(0.2)0.6, labsize(small)) xline(-1, lcolor(gs10) lpattern(dash) lwidth(thin)) xline(1, lcolor(gs10) lpattern(dash) lwidth(thin)) graphregion(margin(l=22 r=22)) title("C: July 2015 to December 2015", size(small)) graphregion(color(white))

tw  (line pptxma_3a_tam3 xday) (line pptxma_3a_pom3 xday) (line pptxma_3a_rr3 xday)  (line pptxma_3a_um3 xday) (line pptxma_3a_ffm3 xday), name(xcor3) legend(off) xtitle("Lags in days", size(vsmall)) xscale(range(-14 14))  xlabel(-14(7)14, labsize(small))   fysize(60) yscale(range(-0.4 0.6)) ylabel(-0.2(0.2)0.6, labsize(small)) xline(-1, lcolor(gs10) lpattern(dash) lwidth(thin)) xline(1, lcolor(gs10) lpattern(dash) lwidth(thin)) graphregion(margin(l=22 r=22)) title("D: January 2016 to June 2016", size(small)) graphregion(color(white)) ytitle("Correlation coefficient", size(small))

tw (line pptxma_3a_tam4 xday) (line pptxma_3a_pom4 xday) (line pptxma_3a_rr4 xday)  (line pptxma_3a_um4 xday) (line pptxma_3a_ffm4 xday), name(xcor4) xtitle("Lags in days", size(vsmall)) xscale(range(-14 14))  xlabel(-14(7)14, labsize(small)) fysize(60) yscale(range(-0.4 0.6)) ylabel(-0.2(0.2)0.6, labsize(small))   xline(-1, lcolor(gs10) lpattern(dash) lwidth(thin)) xline(1, lcolor(gs10) lpattern(dash) lwidth(thin))  legend(off) graphregion(margin(l=22 r=22)) title("E: July 2016 to November 2016", size(small)) graphregion(color(white))

graph combine xcor1 xcor2 xcor3 xcor4, cols(2)  imargin(1 1 2 2) name(xcorrperioder)  graphregion(color(white))
graph combine xcor xcorrperioder, rows(2)  imargin(1 1 2 2)  graphregion(color(white)) name(xcorrppt) 
graph export "Figure4.emf", as(emf) name(xcorrppt) replace
graph export "Figure4.eps", as(eps) name(xcorrppt) replace
graph export "Figure4.png", as(png) name(xcorrppt) replace


************ CPT ************
foreach var in ma_3a_ffm ma_3a_pom ma_3a_rr ma_3a_tam ma_3a_td ma_3a_um {
xcorr ma_3ns_cpt_day `var', gen(cptx`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3ns_cpt_day `var' if periods==`i', gen(cptx`var'`i') noplot nodraw
}
}


tw  (line cptxma_3a_tam xday) (line cptxma_3a_pom xday) (line cptxma_3a_rr xday)   (line cptxma_3a_um xday) (line cptxma_3a_ffm xday), name(xcorcpt)  xtitle("Lags in days", size(vsmall))   xlabel(-14(7)14, labsize(vsmall))  fysize(35) fxsize(100) yscale(range(-0.4 0.6)) ylabel(-0.2(0.2)0.6, labsize(vsmall)) xline(-1, lcolor(gs10) lpattern(dash) lwidth(thin)) xline(1, lcolor(gs10) lpattern(dash) lwidth(thin)) legend(cols(1) position(2)label(1 "Anomaly Temperature") label(2 "Anomaly Barometric pressure") label(3 "Anomaly preciptiation") label(4 "Anomaly relative humidity") label(5 "Anomaly windspeed") size(small) ) graphregion(margin(l=22 r=22)) title("A: March 2015 to November 2016", size(small)) graphregion(color(white)) ytitle("Correlation coefficient", size(small))


tw  (line cptxma_3a_tam1 xday) (line cptxma_3a_pom1 xday) (line cptxma_3a_rr1 xday)  (line cptxma_3a_um1 xday) (line cptxma_3a_ffm1 xday), name(xcor1cpt) legend(off) xtitle("Lags in days", size(vsmall))   xlabel(-14(7)14, labsize(small))   fysize(60) yscale(range(-0.4 0.6)) ylabel(-0.2(0.2)0.6, labsize(small)) xline(-1, lcolor(gs10) lpattern(dash) lwidth(thin)) xline(1, lcolor(gs10) lpattern(dash) lwidth(thin)) graphregion(margin(l=22 r=22)) title("B: March 2015 to June 2015", size(small)) graphregion(color(white)) ytitle("Correlation coefficient", size(small))


tw  (line cptxma_3a_tam2 xday) (line cptxma_3a_pom2 xday) (line cptxma_3a_rr2 xday)  (line cptxma_3a_um2 xday) (line cptxma_3a_ffm2 xday), name(xcor2cpt) legend(off) xtitle("Lags in days", size(vsmall))  xlabel(-14(7)14, labsize(small))   fysize(60) yscale(range(-0.4 0.6)) ylabel(-0.2(0.2)0.6, labsize(small)) xline(-1, lcolor(gs10) lpattern(dash) lwidth(thin)) xline(1, lcolor(gs10) lpattern(dash) lwidth(thin)) graphregion(margin(l=22 r=22)) title("C: July 2015 to December 2015", size(small)) graphregion(color(white))

tw  (line cptxma_3a_tam3 xday) (line cptxma_3a_pom3 xday) (line cptxma_3a_rr3 xday)  (line cptxma_3a_um3 xday) (line cptxma_3a_ffm3 xday), name(xcor3cpt) legend(off) xtitle("Lags in days", size(vsmall))   xlabel(-14(7)14, labsize(small))   fysize(60) yscale(range(-0.4 0.6)) ylabel(-0.2(0.2)0.6, labsize(small)) xline(-1, lcolor(gs10) lpattern(dash) lwidth(thin)) xline(1, lcolor(gs10) lpattern(dash) lwidth(thin)) graphregion(margin(l=22 r=22)) title("D: January 2016 to June 2016", size(small)) graphregion(color(white)) ytitle("Correlation coefficient", size(small))

tw (line cptxma_3a_tam4 xday) (line cptxma_3a_pom4 xday) (line cptxma_3a_rr4 xday)  (line cptxma_3a_um4 xday) (line cptxma_3a_ffm4 xday), name(xcor4cpt) xtitle("Lags in days", size(vsmall))   xlabel(-14(7)14, labsize(small)) fysize(60) yscale(range(-0.4 0.6)) ylabel(-0.2(0.2)0.6, labsize(small))   xline(-1, lcolor(gs10) lpattern(dash) lwidth(thin)) xline(1, lcolor(gs10) lpattern(dash) lwidth(thin))  legend(off) graphregion(margin(l=22 r=22)) title("E: July 2016 to November 2016", size(small)) graphregion(color(white))

graph combine xcor1cpt xcor2cpt xcor3cpt xcor4cpt, cols(2)  imargin(1 1 2 2) name(xcorrperiodercpt)  graphregion(color(white))
graph combine xcorcpt xcorrperiodercpt, rows(2)  imargin(1 1 2 2)  graphregion(color(white)) name(xcorrcpt) title("Cross-correlations between cold pain tolerance (CPT) and weather anomalies", size(small))



