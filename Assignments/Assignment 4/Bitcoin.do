clear
cd "E:\IU\TIME SERIES ECONOMETRICS\Assignment 4\Bitcoin"

import excel "Assignment 4.xlsx", sheet("Bitcoin") firstrow clear

keep if Date >= td(1/1/2023) 

tsset Date

ac Bitcoin
graph export ac_Bitcoin.jpg, replace width(4000) height(3000)

pac Bitcoin
graph export pac_Bitcoin.jpg, replace width(4000) height(3000)

gen d1Bitcoin = d1.Bitcoin

dfuller Bitcoin, lags(7)
dfuller d1Bitcoin, lags(7)

tsline d1Bitcoin
graph export d1Bitcoin.jpg, replace width(4000) height(3000)

ac d1Bitcoin
graph export ac_d1Bitcoin.jpg, replace width(4000) height(3000)

pac d1Bitcoin
graph export pac_d1Bitcoin.jpg, replace width(4000) height(3000)

arima Bitcoin, arima(0,1,0)
est sto arima_010
predict resid_arima_010, resid
wntestq resid_arima_010

arima Bitcoin, arima(1,1,0)
est sto arima_110
predict resid_arima_110, resid
wntestq resid_arima_110

arima Bitcoin, arima(0,1,1)
est sto arima_011
predict resid_arima_011, resid
wntestq resid_arima_011

est stat arima_010 arima_110 arima_011

tsappend, add(60)

arima Bitcoin, arima(1,1,0)
predict Bitcoin_hat, y dyn(td(10/10/2025)) // y: vì muốn tính Bitcoin_hat, còn nếu muốn tính residual thì tính thay y bằng resid

twoway ///
    (tsline Bitcoin if Date >= td(1/9/2025), recast(line) ytitle("Bitcoin price") lcolor(blue)) ///
    (tsline Bitcoin_hat if Date >= td(1/9/2025), recast(line) lcolor(red)) ///
    , legend(label(1 "Bitcoin price") label(2 "Forecasting using ARIMA(1,1,0)"))

graph export "Bitcoin_forecast.png", replace width(4000) height(3000)

