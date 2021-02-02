use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\tidsserie_t7.dta", clear
cd "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3"
graph drop _all


foreach var in ffm pom pon pox prm prn prx rr sa sd  tam tan tax td um un ux {
tssmooth ma ma_3`var'=`var', window( 1 1 1)
}

gen nonmissing=0
replace nonmissing=1 if ppt!=.
gen xday= -21 + _n
replace xday=. if xday>20





forvalues d=1(1)500{
set seed 1`d'
gen ppt_day`d'=ppt_day 
shufflevar ppt_day`d', cluster(nonmissing) 
gen ma_3ppt_day`d'=. 
forvalues i = 20089(1)20759 {
egen ma_3ppt_day`i'=mean(ppt_day`d'_shuffled) if date>`i'-2 & date<`i'+2
replace  ma_3ppt_day`d'=ma_3ppt_day`i' if date==`i'
drop ma_3ppt_day`i' 
 }
drop ppt_day`d' ppt_day`d' ppt_day`d'_shuffled 
 }

forvalues d=1(1)500{
foreach var in ma_3ffm ma_3pom ma_3rr ma_3tam ma_3td ma_3um {
xcorr ma_3ppt_day`d' `var', gen(ppt`d'x`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3ppt_day`d' `var' if periods==`i', gen(ppt`d'x`var'`i') noplot nodraw
}
}
}
forvalues d=1(1)500{
foreach var in ma_3a_ffm ma_3a_pom ma_3a_rr ma_3a_tam ma_3a_td ma_3a_um {
xcorr ma_3ppt_day`d' `var', gen(ppt`d'x`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3ppt_day`d' `var' if periods==`i', gen(ppt`d'x`var'`i') noplot nodraw
}
}
}
foreach var in ma_3ffm ma_3pom ma_3rr ma_3tam ma_3td ma_3um {
xcorr ma_3ppt_day `var', gen(pptx`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3ppt_day `var' if periods==`i', gen(pptx`var'`i') noplot nodraw
}
}

foreach var in ma_3a_ffm ma_3a_pom ma_3a_rr ma_3a_tam ma_3a_td ma_3a_um {
xcorr ma_3ppt_day `var', gen(pptx`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3ppt_day `var' if periods==`i', gen(pptx`var'`i') noplot nodraw
}
}

drop nonmissing
gen nonmissing=0
replace nonmissing=1 if ns_cpt_day!=.






forvalues d=1(1)500{
set seed 1`d'
gen cpt_day`d'= ns_cpt_day
shufflevar cpt_day`d', cluster(nonmissing) 
gen ma_3cpt_day`d'=. 
forvalues i = 20089(1)20759 {
egen ma_3cpt_day`i'=mean(cpt_day`d'_shuffled) if date>`i'-2 & date<`i'+2
replace  ma_3cpt_day`d'=ma_3cpt_day`i' if date==`i'
drop ma_3cpt_day`i' 
 }
drop cpt_day`d' cpt_day`d' cpt_day`d'_shuffled 
 }
save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\bootstrapped2.dta", replace


forvalues d=1(1)500{
foreach var in ma_3ffm ma_3pom ma_3rr {
xcorr ma_3cpt_day`d' `var', gen(cpt`d'x`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3cpt_day`d' `var' if periods==`i', gen(cpt`d'x`var'`i') noplot nodraw
}
}
}
save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\bootstrapped2.dta", replace

forvalues d=1(1)500{
foreach var in ma_3tam ma_3td ma_3um {
xcorr ma_3cpt_day`d' `var', gen(cpt`d'x`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3cpt_day`d' `var' if periods==`i', gen(cpt`d'x`var'`i') noplot nodraw
}
}
}
save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\bootstrapped2.dta", replace

forvalues d=1(1)500{
foreach var in ma_3a_ffm ma_3a_pom ma_3a_rr  {
xcorr ma_3cpt_day`d' `var', gen(cpt`d'x`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3cpt_day`d' `var' if periods==`i', gen(cpt`d'x`var'`i') noplot nodraw
}
}
}
save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\bootstrapped2.dta", replace

forvalues d=1(1)487{
foreach var in ma_3a_tam ma_3a_td ma_3a_um {
xcorr ma_3cpt_day`d' `var', gen(cpt`d'x`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3cpt_day`d' `var' if periods==`i', gen(cpt`d'x`var'`i') noplot nodraw
}
}
save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\bootstrapped2.dta", replace
}

forvalues d=488(1)500{
foreach var in ma_3a_tam ma_3a_td ma_3a_um {
xcorr ma_3cpt_day`d' `var', gen(cpt`d'x`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3cpt_day`d' `var' if periods==`i', gen(cpt`d'x`var'`i') noplot nodraw
}
}
save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\bootstrapped2.dta", replace
}

foreach var in ma_3ffm ma_3pom ma_3rr ma_3tam ma_3td ma_3um {
xcorr ma_3cpt_day `var', gen(cptx`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3cpt_day `var' if periods==`i', gen(cptx`var'`i') noplot nodraw
}
}
save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\bootstrapped2.dta", replace

foreach var in ma_3a_ffm ma_3a_pom ma_3a_rr ma_3a_tam ma_3a_td ma_3a_um {
xcorr ma_3cpt_day `var', gen(cptx`var') noplot nodraw
forvalues i = 1(1)4 {
xcorr ma_3cpt_day `var' if periods==`i', gen(cptx`var'`i') noplot nodraw
}
}
save "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\bootstrapped2.dta", replace

use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\bootstrapped2.dta", clear


cd "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\shuffled\temp"

global fig_specification `"xtitle("Lags in days", size(vsmall)) xscale(range(-14 14)) xlabel(-14(7)14, labsize(vsmall))   fysize(60) yscale(range(-0.6 0.6)) ylabel(-0.6(0.2)0.6, labsize(tiny)) xline(-1, lcolor(black) lpattern(dot) lwidth(thin)) xline(1, lcolor(black) lpattern(dot) lwidth(thin)) graphregion(margin(vsmall))  graphregion(color(white)) ytitle("Correlation coefficient", size(vsmall)) nodraw"'

do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr windspeed.do"
graph drop _all
do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr ppt RH.do"
do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr ppt tam.do"
do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr ppt pom.do"
do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr ppt td.do"
do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr ppt rr.do"


graph drop _all

do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr cpt windspeed.do"
do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr cpt RH.do"
do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr cpt tam.do"
do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr cpt pom.do"
do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr cpt td.do"
do "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\xcorr cpt rr.do"
graph drop _all

graph combine Observedtam.gph Observedpom.gph Observedwindspeed.gph ObservedRH.gph Observedrr.gph , graphregion(color(white)) col(1)  saving(observedpptA, replace) nodraw title("Pressure pain tolerance", size(small)) graphregion(margin(l=18 r=18))
graph combine Observedtam1.gph Observedpom1.gph Observedwindspeed1.gph ObservedRH1.gph Observedrr1.gph , graphregion(color(white)) col(1) saving(ObservedpptB, replace) nodraw title("Pressure pain tolerance", size(small)) graphregion(margin(l=18 r=18))
graph combine Observedtam2.gph Observedpom2.gph Observedwindspeed2.gph ObservedRH2.gph Observedrr2.gph , graphregion(color(white)) col(1) saving(ObservedpptC, replace) nodraw title("Pressure pain tolerance", size(small)) graphregion(margin(l=18 r=18))
graph combine Observedtam3.gph Observedpom3.gph Observedwindspeed3.gph ObservedRH3.gph Observedrr3.gph , graphregion(color(white)) col(1) saving(ObservedpptD, replace) nodraw title("Pressure pain tolerance", size(small)) graphregion(margin(l=18 r=18))
graph combine Observedtam4.gph Observedpom4.gph Observedwindspeed4.gph ObservedRH4.gph Observedrr4.gph , graphregion(color(white)) col(1) saving(ObservedpptE, replace) nodraw title("Pressure pain tolerance", size(small)) graphregion(margin(l=18 r=18))

graph combine Anomalytam.gph Anomalypom.gph Anomalywindspeed.gph AnomalyRH.gph Anomalyrr.gph , graphregion(color(white)) col(1)  saving(AnomalypptA, replace) nodraw title("Pressure pain tolerance", size(small)) graphregion(margin(l=18 r=18))
graph combine Anomalytam1.gph Anomalypom1.gph Anomalywindspeed1.gph AnomalyRH1.gph Anomalyrr1.gph , graphregion(color(white)) col(1) saving(AnomalypptB, replace) nodraw title("Pressure pain tolerance", size(small)) graphregion(margin(l=18 r=18))
graph combine Anomalytam2.gph Anomalypom2.gph Anomalywindspeed2.gph AnomalyRH2.gph Anomalyrr2.gph , graphregion(color(white)) col(1) saving(AnomalypptC, replace) nodraw title("Pressure pain tolerance", size(small)) graphregion(margin(l=18 r=18))
graph combine Anomalytam3.gph Anomalypom3.gph Anomalywindspeed3.gph AnomalyRH3.gph Anomalyrr3.gph , graphregion(color(white)) col(1) saving(AnomalypptD, replace) nodraw title("Pressure pain tolerance", size(small)) graphregion(margin(l=18 r=18))
graph combine Anomalytam4.gph Anomalypom4.gph Anomalywindspeed4.gph AnomalyRH4.gph Anomalyrr4.gph , graphregion(color(white)) col(1) saving(AnomalypptE, replace) nodraw title("Pressure pain tolerance", size(small)) graphregion(margin(l=18 r=18))


graph combine  cptObservedtam.gph  cptObservedpom.gph  cptObservedwindspeed.gph  cptObservedRH.gph  cptObservedrr.gph  , graphregion(color(white)) col(1)  saving(ObservedcptA, replace) nodraw title("Cold pain tolerance, seasonality removed", size(small)) graphregion(margin(l=18 r=18))
graph combine  cptObservedtam1.gph  cptObservedpom1.gph  cptObservedwindspeed1.gph  cptObservedRH1.gph  cptObservedrr1.gph  , graphregion(color(white)) col(1) saving(ObservedcptB, replace) nodraw title("Cold pain tolerance, seasonality removed", size(small)) graphregion(margin(l=18 r=18))
graph combine  cptObservedtam2.gph  cptObservedpom2.gph  cptObservedwindspeed2.gph  cptObservedRH2.gph  cptObservedrr2.gph  , graphregion(color(white)) col(1) saving(ObservedcptC, replace) nodraw title("Cold pain tolerance, seasonality removed", size(small)) graphregion(margin(l=18 r=18))
graph combine  cptObservedtam3.gph  cptObservedpom3.gph  cptObservedwindspeed3.gph  cptObservedRH3.gph  cptObservedrr3.gph  , graphregion(color(white)) col(1) saving(ObservedcptD, replace) nodraw title("Cold pain tolerance, seasonality removed", size(small)) graphregion(margin(l=18 r=18))
graph combine  cptObservedtam4.gph  cptObservedpom4.gph  cptObservedwindspeed4.gph  cptObservedRH4.gph  cptObservedrr4.gph  , graphregion(color(white)) col(1) saving(ObservedcptE, replace) nodraw title("Cold pain tolerance, seasonality removed", size(small)) graphregion(margin(l=18 r=18))

graph combine  cptAnomalytam.gph  cptAnomalypom.gph  cptAnomalywindspeed.gph  cptAnomalyRH.gph  cptAnomalyrr.gph  , graphregion(color(white)) col(1)  saving(AnomalycptA, replace) nodraw title("Cold pain tolerance, seasonality removed", size(small)) graphregion(margin(l=18 r=18))
graph combine  cptAnomalytam1.gph  cptAnomalypom1.gph  cptAnomalywindspeed1.gph  cptAnomalyRH1.gph  cptAnomalyrr1.gph , graphregion(color(white)) col(1) saving(AnomalycptB, replace) nodraw title("Cold pain tolerance, seasonality removed", size(small)) graphregion(margin(l=18 r=18))
graph combine  cptAnomalytam2.gph  cptAnomalypom2.gph  cptAnomalywindspeed2.gph  cptAnomalyRH2.gph  cptAnomalyrr2.gph  , graphregion(color(white)) col(1) saving(AnomalycptC, replace) nodraw title("Cold pain tolerance, seasonality removed", size(small)) graphregion(margin(l=18 r=18))
graph combine  cptAnomalytam3.gph  cptAnomalypom3.gph  cptAnomalywindspeed3.gph  cptAnomalyRH3.gph  cptAnomalyrr3.gph , graphregion(color(white)) col(1) saving(AnomalycptD, replace) nodraw title("Cold pain tolerance, seasonality removed", size(small)) graphregion(margin(l=18 r=18))
graph combine  cptAnomalytam4.gph  cptAnomalypom4.gph  cptAnomalywindspeed4.gph  cptAnomalyRH4.gph  cptAnomalyrr4.gph , graphregion(color(white)) col(1) saving(AnomalycptE, replace) nodraw title("Cold pain tolerance, seasonality removed", size(small)) graphregion(margin(l=18 r=18))



graph combine ObservedpptA.gph ObservedcptA.gph, cols(2) graphregion(color(white)) title("Cross-correlation between pain tolerance and observed weather" "A: March 2015 to November 2016", size(small))	name(ObservedA)	saving(ObservedA, replace)
graph export ObservedA.png, as(png) name(ObservedA) replace
graph drop _all
graph combine ObservedpptB.gph ObservedcptB.gph, cols(2) graphregion(color(white)) title("Cross-correlation between pain tolerance and observed weather" "B: March 2015 to June 2015", size(small))	name(	ObservedB	)	saving(ObservedB, replace)
graph export ObservedB.png, as(png) name(ObservedB) replace
graph drop _all
graph combine ObservedpptC.gph ObservedcptC.gph, cols(2) graphregion(color(white)) title("Cross-correlation between pain tolerance and observed weather" "C: July 2015 to December 2015", size(small))	name(	ObservedC	)	saving(	ObservedC, replace	)
graph export ObservedC.png, as(png) name(ObservedC) replace
graph drop _all
graph combine ObservedpptD.gph ObservedcptD.gph, cols(2) graphregion(color(white)) title("Cross-correlation between pain tolerance and observed weather" "D: January 2016 to June 2016", size(small))	name(	ObservedD	)	saving(	ObservedD, replace	)
graph export ObservedD.png, as(png) name(ObservedD) replace
graph drop _all
graph combine ObservedpptE.gph ObservedcptE.gph, cols(2) graphregion(color(white)) title("Cross-correlation between pain tolerance and observed weather" "E: July 2016 to November 2016", size(small))	name(	ObservedE	)	saving(	ObservedE, replace	)
graph export ObservedE.png, as(png) name(ObservedE) replace
graph drop _all


graph combine  AnomalypptA.gph  AnomalycptA.gph, cols(2) graphregion(color(white)) title("Cross-correlation between pain tolerance and meteorological anomalies" "A: March 2015 to November 2016", size(small)) name(AnomalyA)	saving(AnomalyA, replace)
graph export AnomalyA.png, as(png) name(AnomalyA) replace
graph drop _all
graph combine  AnomalypptB.gph  AnomalycptB.gph, cols(2) graphregion(color(white)) title("Cross-correlation between pain tolerance and meteorological anomalies" "B: March 2015 to June 2015", size(small))  name(AnomalyB)	saving(AnomalyB, replace)
graph export AnomalyB.png, as(png) name(AnomalyB) replace
graph drop _all
graph combine  AnomalypptC.gph  AnomalycptC.gph, cols(2) graphregion(color(white)) title("Cross-correlation between pain tolerance and meteorological anomalies" "C: July 2015 to December 2015", size(small))  name(AnomalyC)	saving(AnomalyC, replace)
graph export AnomalyC.png, as(png) name(AnomalyC) replace
graph drop _all
graph combine  AnomalypptD.gph  AnomalycptD.gph, cols(2) graphregion(color(white)) title("Cross-correlation between pain tolerance and meteorological anomalies" "D: January 2016 to June 2016", size(small))  name(AnomalyD)	saving(AnomalyD, replace)
graph export AnomalyD.png, as(png) name(AnomalyD) replace
graph drop _all
graph combine  AnomalypptE.gph  AnomalycptE.gph, cols(2) graphregion(color(white)) title("Cross-correlation between pain tolerance and meteorological anomalies" "E: July 2016 to November 2016", size(small))  name(AnomalyE)	saving(AnomalyE, replace)
graph export AnomalyE.png, as(png) name(AnomalyE) replace
graph drop _all

















