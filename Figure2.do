 use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\tidsserie_t7.dta", replace
cd "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3"
graph drop _all
foreach var in ffm pom pon pox prm prn prx rr sa sd  tam tan tax td um un ux {
tssmooth ma ma5_`var'=`var', window( 2 1 2)
}

gen ma_7cpt_day=. 
forvalues i = 20089(1)20759 {
egen ma_7cpt_day`i'=mean(propover100) if date>`i'-4 & date<`i'+4
replace  ma_7cpt_day=ma_7cpt_day`i' if date==`i'
drop ma_7cpt_day`i'
 }
 

foreach var in ma_7cpt_day ma7_tam  ma_7ppt_day {
egen s`var'=std(`var')
}
 

 drop if date>td(15nov2016)
 drop if date<td(15feb2015)

*** PPT og CPT i samme figur
graph drop _all
tw    (tsline ma_7cpt_day if sma_7cpt_day>-4 & tin(1feb2015, 1dec2016),  color(black%90) cmissing(n) yaxis(1)) /// 
(tsline ma_7ppt_day if tin(1feb2015, 1dec2016),  color(red) cmissing(n) yaxis(4) ) /// 
(tsline ma7_tam if tin(1feb2015, 1dec2016),  yaxis(2) color(midblue%50)) /// 
(tsline ma7_pom if tin(1feb2015, 1dec2016),  yaxis(3) color(gs7%60)) ,  graphregion(color(white))  ///
yscale(axis(2) reverse range(-14 22) alt titlegap(tiny)) ///
yscale(axis(3)  range(953 1036) titlegap(tiny)) ///
yscale(axis(1) range(0.2 0.5) titlegap(tiny)) ///
yscale(axis(4) alt range(55 75)) ///
tscale( range(15feb2015 15nov2016) titlegap(tiny)) ///
ytitle("Barometric Pressure, hPa", size (tiny) axis(3)) ///
 ytitle("CPT, proportion holding their hand in cold water >100s", size (tiny) axis(1) xoffset(0.5)) ///
 ytitle("Temperature, °C", size (tiny) axis(2) xoffset(-1)) ///
 ytitle("PPT, kPa", size (tiny) axis(4)) ///
 legend(rows(1) label(1 "CPT") label(3 "Temperature") label(4 "Barometric pressure")  label(2 "PPT") symxsize(6) rowgap(0.6) size(vsmall) region(lstyle(none))) ///
 ylabel( 0.2 0.3 0.4 0.5 0.6, labsize(tiny) axis(1) tstyle(minor)) ///
 ylabel(-10 -5 0 5 10 15, labsize(tiny) axis(2) tstyle(minor)) ///
 ylabel( 950 970 990 1010 1030, labsize(tiny) axis(3) tstyle(minor)) ///
 ylabel( 60 70 80 , labsize(tiny) axis(4) tstyle(minor)) ///
 tlabel(, format(%tdMY) labsize(vsmall)) /// 
  xtitle("") name(ma7cptogppt)

graph export "Figure2.png", as(png) name(ma7cptogppt) replace
graph export "Figure2.emf", as(emf) name(ma7cptogppt) replace
graph export "Figure2.eps", as(eps) name(ma7cptogppt) replace





