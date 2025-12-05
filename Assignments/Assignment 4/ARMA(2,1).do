clear
set obs 200
set seed 41252

cd "E:\IU\TIME SERIES ECONOMETRICS\Assignment 4\ARMA(2,1)"

gen obs = _n

sim_arma yt, nobs(200) ar(0.5 0.3) ma(0.8)

tsset obs

tsline yt
graph export yt.jpg, replace

ac yt
graph export ac_yt.jpg, replace

pac yt
graph export pac_yt.jpg, replace


