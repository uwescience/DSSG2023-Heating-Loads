# DSSG2023-Heating-Loads

This branch is based on the [Heat Pump Calculator](https://heatpump.cf/) developed by Alan Mitchell at Analysis North and his publicly available repository named [`heat-pump-calc-engine`](https://github.com/alanmitchell/heat-pump-calc-engine). 

`city_model_runs.ipynb` is the main script that performs the scenario simulation for estimating energy and cost savings. We build on the original script and add simulations for different fuel price escalation rates, global warming, and government rebate levels. 

The `Code/heatpump/` folder contains key scripts that power the actual computation of the Calculator, which include `library.py` (loading data), `hp_model.py` (modeling heat pump's energy use and cost) and `home_heat_model.py` (modeling space heating energy use with or without a heap pump).  

Below we document all changes we made to the underlying scripts to add the functionality of simulating global warming scenarios and other auxillary temperature variables: 

In `Code/heatpump/home_heat_model.py`, add: 

```
class HomeHeatModel(object):
def __init__(self, 
      ...
      temp_projection = 0, # initialize for temp projection
      ...
):
```

```
def calculate(self):
  ...
s.df_hourly = df_tmy[['db_temp']].copy() + s.temp_projection # adding temp projection to the TMY3 hourly data
  ...
```

In `Code/heatpump/hp_model.py`, add: 

```
class HP_model:
def __init__(self,
  ...
  temp_projection
):
```

```
def run(self):
  ...
sim = HomeHeatModel(
  ...
  temp_projection= s.temp_projection
)
```

```
s.summary['avg_temp_monthly'] = list(s.df_hourly.groupby(s.df_hourly.index.month)['db_temp'].mean())
avg_temp_daily = s.df_hourly.groupby([s.df_hourly.index.month, s.df_hourly.index.day])['db_temp'].mean()
s.summary['freezing_days_prop'] = np.mean(avg_temp_daily < 32)
s.summary['heating_days_above5'] = np.logical_and(avg_temp_daily < 65, avg_temp_daily > 5).sum()
s.summary['heating_days_below5'] = sum(avg_temp_daily < 5)
```
