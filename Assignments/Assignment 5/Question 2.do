clear
cd "C:\Users\DELL\Downloads"

import excel "Assignment 5.xlsx", sheet("PC") firstrow clear

replace date = qofd(date)
label var date "Quarterly"
label var CPI "CPI"
format date %tq

tsset date

rename unemployment unem

gen ifra = (CPI/l4.CPI-1)*100
label var ifra "inflation rate (%) annual"

gen infl = (ln(CPI) - ln(l4.CPI))*100
label var infl "inflation rate (%) annual"

tsline infl, ttitle("Quarter") ytitle("U.S. inflation rate") legend(label(1 "Inflation Rate"))
graph export infl.jpg, replace width(4000) height(3000)

ac infl
graph export ac_infl.jpg, replace width(4000) height(3000)

pac infl
graph export pac_infl.jpg, replace width(4000) height(3000)

dfuller infl, lags(10)

dfuller unem, lags(10)

reg infl l.unem

predict res, res
estat bgodfrey

reg infl l.unem, robust
estat dwatson

reg infl l(1/4).unem
estat bgodfrey

reg infl l(1/4).unem, robust
estat dwatson

reg infl l(1/6).unem
estat bgodfrey

//

reg l(0/1).infl l(1/1).unem 
est sto ADL11

reg l(0/2).infl l(1/1).unem
est sto ADL21

reg l(0/3).infl l(1/1).unem
est sto ADL31

reg l(0/4).infl l(1/1).unem
est sto ADL41

reg l(0/5).infl l(1/1).unem
est sto ADL51

reg l(0/6).infl l(1/1).unem
est sto ADL61

reg l(0/7).infl l(1/1).unem
est sto ADL71

reg l(0/8).infl l(1/1).unem
est sto ADL81

//
reg l(0/1).infl l(1/2).unem
est sto ADL12

reg l(0/2).infl l(1/2).unem
est sto ADL22

reg l(0/3).infl l(1/2).unem
est sto ADL32

reg l(0/4).infl l(1/2).unem
est sto ADL42

reg l(0/5).infl l(1/2).unem
est sto ADL52

reg l(0/6).infl l(1/2).unem
est sto ADL62

reg l(0/7).infl l(1/2).unem
est sto ADL72

reg l(0/8).infl l(1/2).unem
est sto ADL82

//
est stat ADL11 ADL21 ADL31 ADL41 ADL51 ADL61 ADL71 ADL81 ADL12 ADL22 ADL32 ADL42 ADL52 ADL62 ADL72 ADL82

reg l(0/6).infl l(1/2).unem
estat bgodfrey

reg l(0/8).infl l(1/2).unem
estat bgodfrey

estat hettest
predict ress
wntestq ress

// vii
reg l(0/1).infl l(1/1).unem if tin(1983q1,2019q4)
est sto ADL11a

reg l(0/2).infl l(1/1).unem if tin(1983q1,2019q4)
est sto ADL21a

reg l(0/3).infl l(1/1).unem if tin(1983q1,2019q4)
est sto ADL31a

reg l(0/4).infl l(1/1).unem if tin(1983q1,2019q4)
est sto ADL41a

reg l(0/5).infl l(1/1).unem if tin(1983q1,2019q4)
est sto ADL51a

reg l(0/6).infl l(1/1).unem if tin(1983q1,2019q4)
est sto ADL61a

reg l(0/7).infl l(1/1).unem if tin(1983q1,2019q4)
est sto ADL71a

reg l(0/8).infl l(1/1).unem if tin(1983q1,2019q4)
est sto ADL81a

//
reg l(0/1).infl l(1/2).unem if tin(1983q1,2019q4)
est sto ADL12a

reg l(0/2).infl l(1/2).unem if tin(1983q1,2019q4)
est sto ADL22a

reg l(0/3).infl l(1/2).unem if tin(1983q1,2019q4)
est sto ADL32a

reg l(0/4).infl l(1/2).unem if tin(1983q1,2019q4)
est sto ADL42a

reg l(0/5).infl l(1/2).unem if tin(1983q1,2019q4)
est sto ADL52a

reg l(0/6).infl l(1/2).unem if tin(1983q1,2019q4)
est sto ADL62a

reg l(0/7).infl l(1/2).unem if tin(1983q1,2019q4)
est sto ADL72a

reg l(0/8).infl l(1/2).unem if tin(1983q1,2019q4)
est sto ADL82a

//
est stat ADL11a ADL21a ADL31a ADL41a ADL51a ADL61a ADL71a ADL81a ADL12a ADL22a ADL32a ADL42a ADL52a ADL62a ADL72a ADL82a

reg l(0/8).infl l(1/2).unem
estat bgodfrey
estat hettest

eststo clear
eststo static: reg infl l.unem
eststo staticr: reg infl l.unem, robust
eststo DL4: reg infl l(1/4).unem
eststo DL4r: reg infl l(1/4).unem, robust
eststo ADL82: reg l(0/8).infl l(1/2).unem
eststo ADL62a: reg l(0/6).infl l(1/2).unem if tin(1983q1,2019q4)

esttab using result.csv, replace

// viii
reg infl l.unem
predict infl_static

reg infl l.unem, robust
predict infl_static_robust

reg infl l(1/4).unem
predict infl_DL4

reg infl l(1/4).unem, robust
predict infl_DL4_robust

reg l(0/8).infl l(1/2).unem
predict infl_VAR82

reg l(0/6).infl l(1/2).unem if tin(1983q1,2019q4)
predict infl_VAR62a if tin(1983q1,2019q4)