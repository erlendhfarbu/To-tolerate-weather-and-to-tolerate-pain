



**** day for PPT
use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\tidsserie_t7.dta", clear
gen month7=month(date)

drop if ppt_day==.
gen n=_n
tsset n
**** Anomalies ***************
varsoc ppt_day a_tam a_pom  , maxlag(14)
**AIC suggest 2 lags
qui var ppt_day a_tam a_pom  , lags(1/2)
vargranger

*** LR suggest 13 lags
qui var ppt_day a_tam a_pom  , lags(1/13)
vargranger




************* Observed temperature and pressure

**** day for PPT
use "C:\Users\efa036\OneDrive - UiT Office 365\Statpaper3\tidsserie_t7.dta", clear

drop if ppt_day==.
gen n=_n
tsset n
varsoc ppt_day tam pom  , maxlag(14)
**AIC suggest 6 lags
qui var ppt_day tam pom  , lags(1/6)
vargranger

*** LR suggest 13 lags
qui var ppt_day tam pom  , lags(1/13)
vargranger





