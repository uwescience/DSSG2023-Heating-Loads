# DSSG2023-Heating-Loads

This branch is based on the [Heat Pump Calculator](https://heatpump.cf/) developed by Alan Mitchell at Analysis North and his publicly available repository named [`heat-pump-calc-engine`](https://github.com/alanmitchell/heat-pump-calc-engine). 

`city_model_runs.ipynb` is the main script that performs the scenario simulation for estimating energy and cost savings. We build on the original script and add simulations for different fuel price escalation rates, global warming, and government rebate levels. 

The `Code/heatpump/` folder contains key scripts that power the actual computation of the Calculator, which include `library.py` (loading data), `hp_model.py` (modeling heat pump's energy use and cost) and `home_heat_model.py` (modeling space heating energy use with or without a heap pump).  



