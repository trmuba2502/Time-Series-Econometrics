clear
cd "D:\trang_github\Time-Series-Econometrics\Final Project"

import delimited ""D:\GlobalLandTemperaturesByCity.csv""

gen time = mofd(date(dt, "YMD"))
format time %tm

keep if country == "Vietnam" 

// 1863m4 - 2013m8 Baclieu
// city list

encode city, generate(city_id)
xtset city_id time

rename averagetemperature avetem

tsline avetem if city == "Bac Lieu" & time >= tm(1863m4)
ac avetem if city == "Bac Lieu" & time >= tm(1863m4)
pac avetem if city == "Bac Lieu" & time >= tm(1863m4)
dfuller avetem if city == "Bac Lieu" & time >= tm(1863m4)
kpss avetem if city == "Bac Lieu" & time >= tm(1863m4)

summarize avetem if city == "Bac Lieu" & time >= tm(1863m4)
drop rescale_avetem
gen rescale_avetem = (avetem - r(min))/(r(max) - r(min)) if city == "Bac Lieu" & time >= tm(1863m4)

ac rescale_avetem if city == "Bac Lieu" & time >= tm(1863m4)
pac rescale_avetem if city == "Bac Lieu" & time >= tm(1863m4)

gen savetem = avetem - l12.avetem
ac savetem if city == "Bac Lieu" & time >= tm(1863m4)
pac savetem if city == "Bac Lieu" & time >= tm(1863m4)
dfuller savetem if city == "Bac Lieu" & time >= tm(1863m4)
kpss savetem if city == "Bac Lieu" & time >= tm(1863m4)


//Test AIC and BIC
arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(0,0,0) sarima(1,1,1,12)
est sto s000_111_12

arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(0,0,0) sarima(1,1,2,12)
est sto s000_112_12

arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(1,1,1) sarima(1,1,1,12)
est sto s111_111_12

arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(1,1,1) sarima(1,1,2,12)
est sto s111_112_12

arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(0,0,0) sarima(0,1,1,12)
est sto s000_011_12

arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(0,0,0) sarima(0,1,2,12)
est sto s000_012_12

arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(0,0,0) sarima(1,1,0,12)
est sto s000_110_12

arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(1,1,1) sarima(0,1,1,12)
est sto s111_011_12

arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(1,1,1) sarima(0,1,2,12)
est sto s111_012_12

arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(1,1,1) sarima(1,1,0,12)
est sto s111_110_12

//Compare AIC and BIC => choose SARIMA(1,1,1)(0,1,1)12
est stat s000_111_12 s000_112_12 s111_111_12 s111_112_12 s000_011_12 s000_012_12 s000_110_12 s111_011_12 s111_012_12 s111_110_12

//Check white noise
arima avetem if city == "Bac Lieu" & time >= tm(1863m4), arima(1,1,1) sarima(0,1,2,12)
predict resid if city == "Bac Lieu" & time >= tm(1863m4), resid
wntestq resid if city == "Bac Lieu" & time >= tm(1863m4)
	



