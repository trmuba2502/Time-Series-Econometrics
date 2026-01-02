clear
cd "D:\trang_github\Time Series Econometrics\Final Project"
use "D:\trang_github\Time Series Econometrics\Final Project\VN.dta"

varsoc gini hdi KOF_trade_df KOF_trade_dj KOF_finance_df KOF_finance_dj, maxlag(10)

//VAR(5)
var gini KOF_trade_df KOF_trade_dj KOF_finance_df KOF_finance_dj, lags(1(1)7)

//Impulse Response Function
irf create myirf, set(myirfs) replace
irf graph oirf, impulse(gini KOF_trade_df KOF_trade_dj KOF_finance_df KOF_finance_dj) response(gini KOF_trade_df KOF_trade_dj KOF_finance_df KOF_finance_dj)
graph export irf.png, width(6000) heigh(4000) replace

vecrank gini KOF_trade_df KOF_trade_dj KOF_finance_df KOF_finance_dj

gen dlngini = d.lngini
gen dlntrade = d.lntrade

//VAR(5)
var dlngini dlntrade, lags(1(1)2)

//Impulse Response Function
irf create myirf, set(myirfs) replace
irf graph oirf, impulse(dlngini dlntrade) response(dlngini dlntrade)
graph export irf.png, width(6000) heigh(4000) replace

predict res_dlngini, res equation(#1)
ac res_dlngini

predict res_dlntrade, res equation(#2)
ac res_dlntrade

tsline dlngini dlntrade

//VAR(5)
var lngini lntrade, lags(1(1)2)

//Impulse Response Function
irf create myirf, set(myirfs) replace
irf graph oirf, impulse(lngini lntrade) response(lngini lntrade)
graph export irf.png, width(6000) heigh(4000) replace

predict res_lngini, res equation(#1)
ac res_lngini

predict res_lntrade, res equation(#2)
ac res_lntrade

tsline lngini lntrade