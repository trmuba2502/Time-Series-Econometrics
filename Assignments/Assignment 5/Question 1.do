clear
cd "C:\Users\DELL\Downloads"

import excel "Assignment 5.xlsx", sheet("CPI") firstrow clear

replace date = mofd(date)
label var date "Month"
label var CPI "CPI"
format date %tm

tsset date

gen dCPI = d.CPI

tsline CPI
tsline dCPI

ac d.CPI
graph export dCPI.jpg, replace width(4000) height(3000)

pac d.CPI
graph export pac_dCPI.jpg, replace width(4000) height(3000)

reg l(0/1).dCPI
est sto AR1

reg l(0/2).dCPI
est sto AR2

reg l(0/8).dCPI
est sto AR8

reg l(0/10).dCPI
est sto AR10

reg l(0/11).dCPI
est sto AR11

est stat AR1 AR2 AR8 AR10 AR11

eststo clear
eststo AR1: reg l(0/1).dCPI
eststo AR2: reg l(0/2).dCPI
eststo AR8: reg l(0/8).dCPI
eststo AR10: reg l(0/10).dCPI
eststo AR11: reg l(0/11).dCPI

esttab using result2.csv, replace

gen ldCPI = l.dCPI

rolling _b _se, window(60) clear:reg dCPI ldCPI
tsset end

tsline _b_ldCPI

gen ub = _b_ldCPI + 1.96*_se_ldCPI
gen lb = _b_ldCPI - 1.96*_se_ldCPI

tsline _b_ldCPI ub lb