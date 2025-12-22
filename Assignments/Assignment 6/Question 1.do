cd "D:\trang_github\Time Series Econometrics\Assignments\Assignment 6"

import  excel "Assignment 6.xlsx", sheet("macro model") firstrow clear

recast float date

gen quarter = qofd(date)
format quarter %tq

drop if (quarter < tq(1985q1) | quarter > tq(2019q4))

tsset quarter 

tsline ffr inflation unrate
graph export "line.png", replace

//VAR(5)
var ffr inflation unrate, lags(1(1)5)

//Impulse Response Function
irf create myirf, set(myirfs) replace
irf graph oirf, impulse(ffr inflation unrate) response(ffr inflation unrate)

predict res_ffr, res equation(#1)
ac res_ffr
graph export "res_ffr.png", replace

predict res_inflation, res equation(#2)
ac res_infl
graph export "res_infl.png", replace

predict res_unrate, res equation(#3)
ac res_unrate
graph export "res_unrate.png", replace

//Granger Causality test
quiet var ffr inflation unrate, lags(1(1)5)
vargranger