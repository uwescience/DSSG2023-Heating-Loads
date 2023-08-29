# DSSG2023-Heating-Loads

## General info
This branch contains scripts to produce project visualizations, including the Alaska borough tilegram and Shiny dashboard.  

## Code files

* app.R: the Shiny app, constructs and starts a Shiny application from UI and server. Sources modules/make_tilegram.R, modules/vis_state_data.R, modules/vis_borough_data.R, and www/theme.R
* modules/make_tilegram.R: constructs the framework of the Alaska tilegram, where each borough is represented by a grid with the number of tiles corresponding to population 
* modules/vis_borough_data.R: creates tilegrams and bar charts for borough-level outcomes
* modules/vis_state_data.R: creates tilegram for state-level adoption outcomes
* www/theme.R: sets theme for Shiny app

## Technologies

Visualizations were created in R with:
* dashboard: shinydashboard (version 0.7.2)
* tilegrams: geofacet (version 0.2.0), plotly (version 4.10.2)

## Setup

Required packages are included at the beginning of each code file.
