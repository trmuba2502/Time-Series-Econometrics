clear
cd "D:\trang_github\Time-Series-Econometrics\Assignments\Assignment 6"

import  excel "Assignment 6.xlsx", sheet("coffee weekly") firstrow clear

recast float Date
tsset Date, delta(7)

gen A_kg = A/(0.45359237*100)
label variable A_kg "USD/kg"

gen R_kg = R/1000
label variable R_kg "USD/kg"

tsline A_kg R_kg, ///
    ytitle("$/kg") ///
    xtitle("Time") ///
    title("Arabica & Robusta Price") ///
	xlabel(#4) ///
	graphregion(margin(r+5)) ///
    legend(label(1 "Price Arabica") label(2 "Price Robusta"))
graph export price.png, replace

*Stationary test
varsoc A_kg, maxlag(12)
dfuller A_kg, lags(12)

varsoc R_kg, maxlag(12)
dfuller R_kg, lags(12)

varsoc d.A_kg, maxlag(12)
dfuller d.A_kg, lags(12)

varsoc d.R_kg, maxlag(12)
dfuller d.R_kg, lags(12) 

* Johansen test for long-run relationship
varsoc A_kg R_kg, maxlag(12)

vecrank A_kg R_kg, trend(trend) lags(12) 
vecrank A_kg R_kg, trend(rtrend) lags(12) 
vecrank A_kg R_kg, trend(rconstant) lags(12) 
vecrank A_kg R_kg, ic lag(12) trend(trend)

*VAR for short-run relationship
varsoc d.A_kg d.R_kg, maxlag(12)
var d.A_kg d.R_kg, lags(1/12)
vargranger

// period 2008–2022

* Johansen test for long-run relationship
varsoc A_kg R_kg if tin(,25dec2022), maxlag(12)

vecrank A_kg R_kg if tin(,25dec2022), trend(trend) lags(4) 
vecrank A_kg R_kg if tin(,25dec2022), trend(rtrend) lags(4) 
vecrank A_kg R_kg if tin(,25dec2022), trend(rconstant) lags(4) 

*VAR for short-run relationship
varsoc d.A_kg d.R_kg if tin(,25dec2022), maxlag(12)
var d.A_kg d.R_kg if tin(,25dec2022), lags(1/4)
vargranger