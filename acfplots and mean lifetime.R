library(readstata13)
library("astsa")


dataset <- read.dta13("for_r.dta")

#### ACF plot weekly averages of CPT ####
acf.cpt0 <- acf(dataset$ma_7ns_cpt_day0[complete.cases(dataset$ma_7ns_cpt_day0)])
acf.cpt1 <- acf(dataset$ma_7ns_cpt_day1[complete.cases(dataset$ma_7ns_cpt_day1)])
acf.cpt2 <- acf(dataset$ma_7ns_cpt_day2[complete.cases(dataset$ma_7ns_cpt_day2)])
acf.cpt3 <- acf(dataset$ma_7ns_cpt_day3[complete.cases(dataset$ma_7ns_cpt_day3)])
acf.cpt4 <- acf(dataset$ma_7ns_cpt_day4[complete.cases(dataset$ma_7ns_cpt_day4)])
acf.cpt5 <- acf(dataset$ma_7ns_cpt_day5[complete.cases(dataset$ma_7ns_cpt_day5)])
acf.cpt6 <- acf(dataset$ma_7ns_cpt_day6[complete.cases(dataset$ma_7ns_cpt_day6)])

plot(acf.cpt0$lag, acf.cpt0$acf, type = "l", xlab = "Lag in weeks", ylab = "Correlation coefficient", 
     cex.main = 0.8, cex.lab = 0.8)
lines(acf.cpt1$lag, acf.cpt1$acf)
lines(acf.cpt2$lag, acf.cpt2$acf)
lines(acf.cpt3$lag, acf.cpt3$acf)
lines(acf.cpt4$lag, acf.cpt4$acf)
lines(acf.cpt5$lag, acf.cpt5$acf)
lines(acf.cpt6$lag, acf.cpt6$acf)
abline(h=	0.22, lty=2, col = "gray85")

acf.cpt <- acf(dataset$ns_cpt_day, lag.max = 50, na.action = na.pass)
acf.ppt <- acf(dataset$ppt_day, lag.max = 50, na.action = na.pass)
acf.ppth <- acf(dataset$ppth, lag.max = 50, na.action = na.pass)
acf.a_tam <- acf(dataset$a_tam, lag.max = 50, na.action = na.pass)
acf.a_pom <- acf(dataset$a_pom, lag.max = 50, na.action = na.pass)
acf.a_um <- acf(dataset$a_um, lag.max = 50, na.action = na.pass)
acf.a_td <- acf(dataset$a_td, lag.max = 50, na.action = na.pass)


acf.cpt <- acf(dataset$ns_cpt_day, lag.max = 50, na.action = na.pass)
plot(acf.cpt$lag, acf.cpt$acf, type = "l", xlab = "Lag in days", ylab = "Correlation coefficient", main = "Autocorrelation for daily CPT, seasonality removed", ylim = c(-0.5, 1), xlim = c(0, 50))
abline(h=0)
abline(h=	0.098, lty=2, col = "gray85")

plot(acf.ppth$lag, acf.ppth$acf, type = "l", xlab = "Lag in days", ylab = "Correlation coefficient", main = "Autocorrelation for pressure pain threshold", ylim = c(-0.5, 1), xlim = c(0, 50))
abline(h=0)
abline(h=	0.098, lty=2, col = "gray85")


#### ACF plot PPT + weather ####
acf.ppt <- acf(dataset$ppt_day, lag.max = 50, na.action = na.pass)
acf.a_tam <- acf(dataset$a_tam,lag.max = 50, na.action = na.pass)
acf.a_pom <- acf(dataset$a_pom,lag.max = 50, na.action = na.pass)
acf.a_um <- acf(dataset$a_um, lag.max = 50, na.action = na.pass)
acf.a_td <- acf(dataset$a_td, lag.max = 50, na.action = na.pass)
acf.a_rr <- acf(dataset$a_rr, lag.max = 50, na.action = na.pass)

plot(acf.ppt$lag, acf.ppt$acf, type = "l", xlab = "Lag in days", ylab = "Correlation coefficient", ylim = c(-0.5, 1), xlim = c(0, 50), lwd = 2)

lines(acf.a_tam$lag, acf.a_tam$acf, col="red")
lines(acf.a_pom$lag, acf.a_pom$acf, col="blue")
lines(acf.a_um$lag, acf.a_um$acf, col="green")
lines(acf.a_rr$lag, acf.a_rr$acf, col="snow4")
abline(h=0)
abline(h=	0.098, lty=2, col = "gray85")
legend('topright',  legend = c( "Daily mean PPT", "Anomaly temperature", "Anomaly barometric pressure", "Anomaly relative humidity", "Anomaly precipitation"), 
       fill = c('black', 'red', 'blue', 'green', "snow4") )

#### GLM ####

acf.ppt$acf <- acf.ppt$acf[1:14] 
acf.ppt$lag <- acf.ppt$lag[1:14]
glmppt <- glm(acf.ppt$acf~acf.ppt$lag,   family = Gamma(link = "log")) # sjekk i stata om det blir det samme, kode glm y x, family(gamma) link(log) scale(1) eform 
plot(glmppt$fitted.values, ylim = c(0,1), type = "l")
lines(acf.ppt$acf)
ci <- confint(glmppt)
timeppt <- c(-1/glmppt$coefficients[2], -1/ci[2,1], -1/ci[2,2])
summary(glmppt, dispersion = 1)
glmppt2 <- glm(acf.ppt$acf~acf.ppt$lag,   family = Gamma(link = "log")) 

print(acf.a_tam$acf)
acf.a_tam$acf <- acf.a_tam$acf[1:12] 
acf.a_tam$lag <- acf.a_tam$lag[1:12]
glma_tam <-  glm(acf.a_tam$acf~acf.a_tam$lag,  family = Gamma(link = "log"))
plot(glma_tam$fitted.values)
lines(acf.a_tam$acf)
ci <- confint(glma_tam)
timea_tam <- c(-1/glma_tam$coefficients[2], -1/ci[2,1], -1/ci[2,2])

print(acf.a_pom$acf)
acf.a_pom$acf <- acf.a_pom$acf[1:18]  
acf.a_pom$lag <- acf.a_pom$lag[1:18]
glma_pom<-  glm(acf.a_pom$acf~acf.a_pom$lag  , family = Gamma(link = "log"))
plot(glma_pom$fitted.values)
lines(acf.a_pom$acf)
ci <- confint(glma_pom)
timea_pom <- c(-1/glma_pom$coefficients[2], -1/ci[2,1], -1/ci[2,2])

print(acf.a_um$acf)
acf.a_um$acf <- acf.a_um$acf[1:7]  
acf.a_um$lag <- acf.a_um$lag[1:7]
glma_um <-  glm(acf.a_um$acf~acf.a_um$lag,  family = Gamma(link = "log"))
plot(glma_um$fitted.values)
lines(acf.a_um$acf)
ci <- confint(glma_um)
timea_um <- c(-1/glma_um$coefficients[2], -1/ci[2,1], -1/ci[2,2])

print(acf.a_td$acf)
acf.a_td$acf <- acf.a_td$acf[1:13]  
acf.a_td$lag <- acf.a_td$lag[1:13]
glma_td <-  glm( acf.a_td$acf~acf.a_td$lag, family = Gamma(link = "log"))
plot(glma_td$fitted.values)
lines(acf.a_td$acf)
ci <- confint(glma_td)
timea_td <- c(-1/glma_td$coefficients[2], -1/ci[2,1], -1/ci[2,2])

print(acf.a_rr$acf)
acf.a_rr$acf <- acf.a_rr$acf[1:8]  
acf.a_rr$lag <- acf.a_rr$lag[1:8]
glma_rr <-  glm( acf.a_rr$acf~acf.a_rr$lag, family = Gamma(link = "log"))
plot(glma_rr$fitted.values)
lines(acf.a_rr$acf)
ci <- confint(glma_rr)
timea_rr <- c(-1/glma_rr$coefficients[2], -1/ci[2,1], -1/ci[2,2])


dimnames <- list("PPT", "Anomaly temperature", "Anomaly barometric pressure", "Anomaly relative humidity", "Anomaly temperature dew point", "Anomaly precipitation")
dimnames2 <- list("Mean lifetime", " CI", " CI" )
timescales <- array(NA, dim = c(6,3), dimnames = list(dimnames, dimnames2 ))
timescales[1, 1:3] <- timeppt
timescales[2, 1:3] <- timea_tam
timescales[3, 1:3] <- timea_pom
timescales[4, 1:3] <- timea_um
timescales[5, 1:3] <- timea_td
timescales[6, 1:3] <- timea_rr


print(timescales)

