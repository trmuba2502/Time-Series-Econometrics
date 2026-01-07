clear
cd "D:\trang_github\Time Series Econometrics\Final Project"
use "inequality.dta" 

format time %ty
tsset time

tsline gini trade tax spend, ///
    xtitle("Year") ytitle("%") ///
    legend(label(1 "Gini") ///
        label(2 "Trade openness") ///
        label(3 "Tax-based Consolidation") ///
		label(4 "Spending-based Consolidation"))

graph export lines.png, width(2000) height(1000) replace
	
dfuller gini
dfuller dgini
dfuller trade
dfuller dtrade
dfuller tax
dfuller dtax
dfuller spend
dfuller dspend

varsoc gini trade tax spend
var gini trade tax spend, lags(1(1)3)

varlmar
vargranger
varstable, graph

vecrank gini trade tax spend, lags(3)

irf create myirf, set(myirfs) replace
irf graph oirf, impulse(gini trade tax spend) response(gini trade tax spend)

irf graph oirf, impulse(trade) response(gini trade tax spend) byopts(rows(1)) xsize(12) ysize(4)
irf graph oirf, impulse(tax) response(gini trade tax spend) byopts(rows(1)) xsize(12) ysize(4)
irf graph oirf, impulse(spend) response(gini trade tax spend) byopts(rows(1)) xsize(12) ysize(4)
irf graph oirf, impulse(gini) response(gini trade tax spend) byopts(rows(1)) xsize(12) ysize(4)
	
irf table oirf, impulse(trade) response(gini trade tax spend)
irf table oirf, impulse(tax) response(gini trade tax spend)
irf table oirf, impulse(spend) response(gini trade tax spend)
irf table oirf, impulse(gini) response(gini trade tax spend)