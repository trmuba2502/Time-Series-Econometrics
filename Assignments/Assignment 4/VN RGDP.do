clear
cd "E:\IU\TIME SERIES ECONOMETRICS\Assignment 4\VN RGDP"

import excel "Assignment 4.xlsx", sheet("VN RGDP") firstrow clear

tsset Year

//Check stationary

gen d1RGDP = d1.RGDP
gen lnRGDP = ln(RGDP)
gen d1lnRGDP = d1.lnRGDP

dfuller RGDP
dfuller d1RGDP
dfuller lnRGDP
dfuller d1lnRGDP

//Draw ACF and PACF

tsline d1lnRGDP
graph export d1lnRGDP.jpg, replace width(4000) height(2500)

ac d1lnRGDP
graph export ac_d1lnRGDP.jpg, replace width(4000) height(2500)

pac d1lnRGDP
graph export pac_d1lnRGDP.jpg, replace width(4000) height(2500)

//From ACF and PACF => choose ARIMA(1,1,0) ARIMA(0,1,1) ARIMA(1,1,1) 

arima lnRGDP, arima(1,1,0)
est sto arima_110

arima lnRGDP, arima(0,1,1)
est sto arima_011

arima lnRGDP, arima(1,1,1)
est sto arima_111

//Compare AIC and BIC => choose ARIMA(1,1,0)

est stat arima_110 arima_011 arima_111

//White noise test for residuals

arima lnRGDP, arima(1,1,0)

predict resid, resid
ac resid
graph export ac_resid.jpg, replace
pac resid
graph export pac_resid.jpg, replace

dfuller resid

wntestq resid

//Forecast data for 10 years after

tsappend, add(10)

predict lnRGDP_hat, y dynamic(2024) //Calculate lnRGDP_hat using estimator from ARIMA(1,1,0)

gen RGDP_hat = exp(lnRGDP_hat) //Calculate RGDP_hat base on lnRGDP_hat

twoway ///
    (tsline RGDP, recast(line) ytitle("RGDP") lcolor(blue)) ///
    (tsline RGDP_hat, recast(line) lcolor(red)) ///
    , legend(label(1 "RGDP") label(2 "Forecasting using ARIMA(1,1,0)"))

graph export "RGDP_forecast.png", replace width(4000) height(3000)