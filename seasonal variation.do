graph drop _all
use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\datasett.dta", clear
rename date pt_date_t7
cd "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3"
gen id=_n

****** PPT ****************
bys id: gen ppt = (pt_rp2_kpa_tol_t7+pt_rp3_kpa_tol_t7)/2
replace ppt=pt_rp2_kpa_tol_t7 if pt_rp3_kpa_tol_t7==.
replace ppt=pt_rp3_kpa_tol_t7 if pt_rp2_kpa_tol_t7==.

gen monthofyear=month(pt_date_t7)
gen month7=monthofyear if pt_date_t7>td(31dec2015)
replace month7=monthofyear-12 if pt_date_t7<=td(31dec2015)
replace month7=month7+10
replace month7=. if month7==21 | month7==22 | month7==-1 | month7==0

label define month ///
	1 "Mar" 2 "Apr" 3 "May" 4 "Jun" 5 "Jul" 6 "Aug" 7 "Sep" 8 "Oct" 9 "Nov" 10 "Dec" 11 "Jan" 12 "Feb" 13 "Mar" 14 "Apr" 15 "May" 16 "Jun" 17 "Jul" 18 "Aug" 19 "Sep" 20 "Oct" 
label values month7 month
tabstat ppt, by(month7) statistics(me p25 med p75)
drop if month7<1


gen fail=0 if pt_cpt_sec_tol_t7!=.
replace fail=1 if pt_cpt_sec_tol_t7<120

stset pt_cpt_sec_tol_t7, fail(fail) 

sts graph , by(month7) name(KM)
tabulate month7, generate(m)

xi:stcox m1 m2 m3 m4 m5 m6 m7 m8 m9 m10  m12 m13 m14 m15 m16 m17 m18 m19 m20 sex_t7 age_t7 
* identical to xi:stcox ib11.month7 sex_t7 age_t7
est store simple

estat phtest, rank detail

xi:stcox m1 m2 m3 m4 m5 m6 m7 m8 m9 m10  m12 m13 m14 m15 m16 m17 m18 m19 m20 sex_t7 age_t7 , schoenfeld(sch*) scaledsch(sca*)



foreach var in m1 m2 m3 m4 m5 m6 m7 m8 m9 m10  m12 m13 m14 m15 m16 m17 m18 m19 m20 sex_t7 age_t7 {
stphtest, plot(`var') name(`var') nodraw
}

graph combine m1 m2 m3 m4 m5 m6 m7 m8 m9 m10  m12 m13 m14 m15 m16 m17 m18 m19 m20 sex_t7 age_t7, name(schresiduals)
stphplot, by(sex_t7)

stcox m1 m2 m3 m4 m5 m6 m7 m8 m9 m10  m12 m13 m14 m15 m16 m17 m18 m19 m20 sex_t7 age_t7, tvc(sex_t7) texp(ln(_t)) 
est store tvc_ln_t
stcox m1 m2 m3 m4 m5 m6 m7 m8 m9 m10  m12 m13 m14 m15 m16 m17 m18 m19 m20 sex_t7 age_t7, tvc(sex_t7) texp(_t) 
est store tvc_t
stcox m1 m2 m3 m4 m5 m6 m7 m8 m9 m10  m12 m13 m14 m15 m16 m17 m18 m19 m20  age_t7, strata(sex_t7) 
est store stratified
est stats tvc_t tvc_ln_t simple stratified
est table tvc_t tvc_ln_t simple stratified

*Interaction between age and month
stcox ib11.month7##c.age_t7 sex_t7
testparm ib11.month7*#c.age_t7 

*Interaction between sex and month
stcox ib11.month7##i.sex_t7 age_t7
testparm ib11.month7*#i.sex_t7

*Acclimatization time

gen double first_exam= clock(attendance_time_d1_t7, "h m")
format first_exam %tc
tab first_exam
list first_exam 
gen double pain_testing= clock(pt_time_t7, "h m s")
format pain_testing %tc

gen time_between= (pain_testing - first_exam)/60000
hist time_between
replace time_between=0 if time_between<0
list first_exam pain_testing time_between in 4100/4110

stcox ib11.month7##c.time_between sex_t7 age_t7
testparm ib11.month7*#c.time_between

stcox ib11.month7 sex_t7 age_t7 if time_between>60
est store coefplot60min

coefplot coefplot60min, drop(sex_t7 age_t7 _cons) graphregion(color(white)) eform vertical mcolor(black) yscale(log)   msymbol(triangle) ciopts(lcolor(gs10))  yline(1, lcolor(black)) xscale(range(1(1)12)) name(coefplot60min) baselevels  ytitle("Hazard Ratio", size(vsmall)) ylabel(, labsize(vsmall)) xlabel( ,labsize(vsmall))
graph export Supplementary1.png, name(coefplot60min) as(png) replace
graph export Supplementary1.pdf, name(coefplot60min) as(pdf) replace
graph export Supplementary1.emf, name(coefplot60min) as(emf) replace

*** Figure 1
stcox ib11.month7 age_t7 sex_t7
est store coefplot

graph drop _all
coefplot coefplot, drop(sex_t7 age_t7) graphregion(color(white)) eform vertical mcolor(black) yscale(log)   msymbol(triangle) ciopts(lcolor(gs10))  yline(1, lcolor(black)) xscale(range(1(1)12)) name(coefplot) baselevels title("C: CPT as hazard ratios from a Cox Proportional Hazard Model", size(vsmall)) ytitle("Hazard Ratio", size(vsmall)) ylabel(, labsize(vsmall)) fysize(37) nodraw

graph box pt_cpt_sec_tol_t7, over(month7, label(nolabel)) graphregion(color(white)) name(CPT) title("B: CPT", size(vsmall)) ytitle("Seconds", size(vsmall)) box(1, lcolor(black)) intensity(0) medtype(cline) medline(lcolor(black)) yscale(range(0 130)) ylabel(0 40 80 120, labsize(vsmall)) fysize(31.5) nodraw


graph box ppt, over(month7, label(nolabel))  graphregion(color(white)) name(PPT) title("A: PPT", size(vsmall)) ytitle("kPa", size(vsmall)) box(1, lcolor(black)) intensity(0) medtype(cline) medline(lcolor(black)) xlabel() ylabel(0 25 50 75 100, labsize(vsmall))  fysize(31.5)


graph combine PPT CPT coefplot, rows(4) graphregion(color(white)) xcommon name(Figure1)
graph export Figure1.pdf, name(Figure1) as(pdf) replace
graph export Figure1.png, name(Figure1) as(png) replace
graph export Figure1.emf, name(Figure1) as(emf) replace





