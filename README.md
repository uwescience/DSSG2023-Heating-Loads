# DSSG2023-Heating-Loads

This branch contains exploratory analyses on using machine learning models to recover the data generating process (DGP) of the Heat Pump Calculator developed by Alan Mitchell. The core idea is that if we could recover the underlyign DGP from a sample of simulated results from the Calculator, we can turn the problem of _simulation_ into one of simple _prediction_. 

The motivation is that the simulation of individual scenarios using the Calculator takes a substantive amount of time, and it is inflexible in the following sense: say we have 3 factors we want to manipulate (each of which contains 3 unique values), we need to run the Calculator 3x3x3=27 times. This creates a bottleneck in computation quickly if we want to manipulate an arbitrary amount of factors. If we can recover the DGP using machine learning models, we can simply predict the estimates, which should be much faster in computation and more flexible. 

The `Code` folder contains two scripts. `prepareData.ipynb` prepares the data from the Calculator for modelling. `regression.ipynb` runs machine learning models such as Random Forest and Extreme Gradient Boosting (XGBoost) and implements random grid search for hyperparameters tuning. 
