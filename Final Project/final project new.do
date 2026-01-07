clear
cd "C:\Users\DELL\Downloads"
use "D:\trang_github\Time Series Econometrics\Final Project\inequality.dta" 

format time %ty
tsset time

tsline gini trade tbc, ///
    xtitle("Year") ytitle("%") ///
    legend(label(1 "Gini") ///
        label(2 "Trade openness") ///
        label(3 "Tax-based Consolidation"))

graph export lines.png, width(2000) height(1000) replace
	
dfuller gini
dfuller dgini
dfuller trade
dfuller dtrade
dfuller tbc
// dfuller unem
// gen dunem = d.unem
// dfuller dunem


varsoc dgini dtrade dtbc
var gini trade tbc, lags(1(1)2)

irf create myirf, set(myirfs) replace
irf graph oirf, impulse(gini trade tbc) response(gini trade tbc)

irf graph oirf, impulse(gini trade tbc) response(gini) level(90)

irf graph oirf, impulse(gini trade tbc) response(trade) level(90)

irf graph oirf, impulse(gini trade tbc) response(tbc) level(90)
