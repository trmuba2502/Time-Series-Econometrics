cd "C:\Users\DELL\Downloads"
use "C:\Users\Nam\OneDrive - VietNam National University - HCM INTERNATIONAL UNIVERSITY\Year 3\Time Series\Assignment\final project\[Time series] Final project.dta" 

format time %ty
tsset time

tsline gini trade tbc, ///
    xtitle("Year") ytitle("%") ///
    legend(label(1 "Gini") ///
        label(2 "Trade openness") ///
        label(3 "Tax-based Consolidation"))

graph export lines.png, width(2000) height(1000) replace
	
dfuller gini
gen dgini = d.gini
dfuller dgini
dfuller trade
gen dtrade = d.trade
dfuller dtrade
dfuller def
gen ddef = d.def
dfuller ddef
// dfuller unem
// gen dunem = d.unem
// dfuller dunem


varsoc dgini dtrade dtbc
var gini trade tbc, lags(1(1)2)

irf create myirf, set(myirfs) replace
irf graph oirf, impulse(gini trade tbc) response(gini trade tbc)