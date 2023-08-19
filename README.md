# DSSG2023-Heating-Loads
This consists of 3 folders that describe the process in our workflow shown in the blueprint below:

![Blueprint_icons](https://github.com/uwescience/DSSG2023-Heating-Loads/assets/64672391/744471be-d3cb-468a-9b9c-b3bf924cc12e)

1. Borough Potential
2. Statewide Adoption
3. Visualization

## Borough Potential
* `exploreClimateChange.ipynb`: Notebook contains code for explring temperature data
* HeatPumpCalculator: This is the main engine of our project. The folder contains all codes on how our estimates are gotten
* `weightBoroughEstimates.ipynb`: The estimates gotten from the heatpump calculator after several simulations are weighted by Borough here

## Statewide Adoption
* `exploreDistributionOfHP.ipynb`: This contain codes and method we used to distribute the heatpumps in Alaska
* `getStateEstimates.ipynb`: The estimates from the heatpump calculator simulations can be found here

## Visualization

This folder contains all code needed to make the tilegram in our app https://dssg2023heatpump.shinyapps.io/VisApp/

Note: Visualizations are done in RShiny and notebooks are numbered in order
