clear
cd "E:\IU\TIME SERIES ECONOMETRICS\Assignment 4\NewCar"

import excel "Assignment 4.xlsx", sheet("NewCar") firstrow clear 

gen tm = mofd(Date)
label var tm "Month"
label var NewCar "NewCar"
format tm %tm
tsset tm

//Check stationary

tsline NewCar if tin(2010m1,2019m12)
graph export NewCar.jpg, replace width(4000) height(3000)

gen d1NewCar = d1.NewCar
gen dsNewCar = l12.NewCar - NewCar
gen d1dsNewCar = d1.dsNewCar

dfuller NewCar if tin(2010m1,2019m12)
dfuller d1NewCar if tin(2010m1,2019m12)
dfuller dsNewCar if tin(2010m1,2019m12)
dfuller d1dsNewCar if tin(2010m1,2019m12)

//Draw ACF and PACF NewCar

tsline NewCar if tin(2010m1,2019m12)
graph export NewCar.jpg, replace width(4000) height(3000)

ac NewCar if tin(2010m1,2019m12)
graph export ac_NewCar.jpg, replace width(4000) height(3000)

pac NewCar if tin(2010m1,2019m12)
graph export pac_NewCar.jpg, replace width(4000) height(3000)

//Draw ACF and PACF d1NewCar

tsline d1NewCar if tin(2010m1,2019m12)
graph export d1NewCar.jpg, replace width(4000) height(3000)

ac d1NewCar if tin(2010m1,2019m12)
graph export ac_d1NewCar.jpg, replace width(4000) height(3000)

pac d1NewCar if tin(2010m1,2019m12)
graph export pac_d1NewCar.jpg, replace width(4000) height(3000)

//Draw ACF and PACF dsNewCar

tsline dsNewCar if tin(2010m1,2019m12)
graph export dsNewCar.jpg, replace width(4000) height(3000)

ac dsNewCar if tin(2010m1,2019m12)
graph export ac_dsNewCar.jpg, replace width(4000) height(3000)

pac dsNewCar if tin(2010m1,2019m12)
graph export pac_dsNewCar.jpg, replace width(4000) height(3000)

//Draw ACF and PACF d1.dsNewCar

tsline d1.dsNewCar if tin(2010m1,2019m12)
graph export d1dsNewCar.jpg, replace width(4000) height(3000)

ac d1.dsNewCar if tin(2010m1,2019m12)
graph export ac_d1dsNewCar.jpg, replace width(4000) height(3000)

pac d1.dsNewCar if tin(2010m1,2019m12)
graph export pac_d1dsNewCar.jpg, replace width(4000) height(3000)

//From ACF and PACF => choose sarima(0,0,0)(1,1,1)12 sarima(0,0,0)(1,1,2)12 sarima(1,1,1)(1,1,1)12 sarima(1,1,1)(1,1,2)12 
// sarima(0,0,0)(0,1,1)12 sarima(0,0,0)(0,1,2)12 sarima(0,0,0)(1,1,0)12
// sarima(1,1,1)(0,1,1)12 sarima(1,1,1)(1,1,0)12 sarima(1,1,1)(0,1,2)12

arima NewCar if tin(2010m1,2019m12), arima(0,0,0) sarima(1,1,1,12)
est sto s000_111_12

arima NewCar if tin(2010m1,2019m12), arima(0,0,0) sarima(1,1,2,12)
est sto s000_112_12

arima NewCar if tin(2010m1,2019m12), arima(1,1,1) sarima(1,1,1,12)
est sto s111_111_12

arima NewCar if tin(2010m1,2019m12), arima(1,1,1) sarima(1,1,2,12)
est sto s111_112_12

arima NewCar if tin(2010m1,2019m12), arima(0,0,0) sarima(0,1,1,12)
est sto s000_011_12

arima NewCar if tin(2010m1,2019m12), arima(0,0,0) sarima(0,1,2,12)
est sto s000_012_12

arima NewCar if tin(2010m1,2019m12), arima(0,0,0) sarima(1,1,0,12)
est sto s000_110_12

arima NewCar if tin(2010m1,2019m12), arima(1,1,1) sarima(0,1,1,12)
est sto s111_011_12

arima NewCar if tin(2010m1,2019m12), arima(1,1,1) sarima(0,1,2,12)
est sto s111_012_12

arima NewCar if tin(2010m1,2019m12), arima(1,1,1) sarima(1,1,0,12)
est sto s111_110_12

//Compare AIC and BIC => choose SARIMA(1,1,1)(1,1,1)12

est stat s000_111_12 s000_112_12 s111_111_12 s111_112_12 s000_011_12 s000_012_12 s000_110_12 s111_011_12 s111_012_12 s111_110_12

//White noise test for residuals

arima NewCar if tin(2010m1,2019m12), arima(1,1,1) sarima(0,1,2,12)

predict resid if tin(2010m1,2019m12), resid

wntestq resid if tin(2010m1,2019m12)

//Forecast data for 3 years after with SARIMA(0,1,0)(0,1,2)12

predict NewCar_hat if tin(2010m1,2022m12), y dynamic(tm(2020m1)) //Calculate NewCar_hat using estimator from SARIMA(0,1,0)(0,1,2)12

twoway ///
    (tsline NewCar if tin(2010m1,2022m12), recast(line) ytitle("NewCar") lcolor(blue)) ///
    (tsline NewCar_hat if tin(2010m1,2022m12), recast(line) lcolor(red)) ///
    , legend(label(1 "NewCar") label(2 "Forecasting using SARIMA(0,1,0)(0,1,2)12"))

graph export "NewCar_forecast.png", replace width(4000) height(3000)