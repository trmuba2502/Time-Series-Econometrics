clear
set obs 200
set seed 41252

cd "E:\IU\TIME SERIES ECONOMETRICS\Assignment 4\AR(3)"

gen obs = _n
gen et = rnormal(0,0.1)
gen yt = et

//replace yt = 0.2 + e[1] in 1
//replace yt = 0.2 + 0.4*yt[1] + e[2] in 2
//replace yt = 0.2 + 0.4*yt[2] + 0.2*yt[1] + e[3] in 3

replace yt = 1 in 1
replace yt = 1 in 2
replace yt = 1 in 3

forvalues i = 4/200{
	quiet replace yt = 0.2 + 0.4*yt[`i' - 1] + 0.2*yt[`i' - 2] - 0.5*yt[`i' - 3] + et[`i'] in `i'
}

tsset obs

tsline yt
graph export yt.jpg, replace

ac yt
graph export ac_yt.jpg, replace

pac yt
graph export pac_yt.jpg, replace

