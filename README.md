# DSSG2023-Heating-Loads

## General info
This branch contains scripts to produce project visualizations, including the Alaska borough tilegram and Shiny dashboard.  

## Code files

* app.R: the Shiny app, constructs and starts a Shiny application from UI and server. Sources modules/make_tilegram.R, modules/vis_state_data.R, modules/vis_borough_data.R, and www/theme.R
* modules/make_tilegram.R: constructs the framework of the Alaska tilegram, where each borough is represented by a grid with the number of tiles corresponding to population 
* modules/vis_borough_data.R: creates tilegrams and bar charts for borough-level outcomes
* modules/vis_state_data.R: creates tilegram for state-level adoption outcomes
* www/theme.R: sets theme for Shiny app

## Supporting files

## Technologies

## Setup
