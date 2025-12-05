clear
set obs 200
set seed 41252

cd "E:\IU\TIME SERIES ECONOMETRICS\Assignment 4\MA(2)"

gen obs = _n
gen et = rnormal(0,0.1)
gen yt = et

replace yt = 0.4*et[1] + e[2] in 2

forvalues i = 3/200{
	quiet replace yt = 0.4*et[`i'-1] + 0.5*et[`i'-2] + et[`i'] in `i'
}

tsset obs

tsline yt
graph export yt.jpg, replace

ac yt
graph export ac_yt.jpg, replace

pac yt
graph export pac_yt.jpg, replace
