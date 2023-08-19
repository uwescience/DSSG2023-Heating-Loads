---
layout: page
title: Data
---

Three primary sources of data were used: ERA5 datasets, Census data and shapefiles for Alaska, and expert knowledge of the current heat pump adoption within Alaska. 

## ERA5 data

The ERA5 data is a high-resolution, reanalyzed climate dataset developed by the European Centre for Medium-Range Weather Forecasts that provides estimates of a vast number of atmospheric, land, and oceanic climate variables at different time scales. The [ERA5-Land Daily Aggregated](https://developers.google.com/earth-engine/datasets/catalog/ECMWF_ERA5_LAND_DAILY_AGGR) and [ERA5 Daily Aggregates](https://developers.google.com/earth-engine/datasets/catalog/ECMWF_ERA5_DAILY) can be assessed via Google Earth Engine (read more in our [Tools](https://uwescience.github.io/DSSG2023-Heating-Loads/method2/) section). These data encompass global meteorological conditions from 1979 to near-real-time, providing granular temperature data at the daily level across the state of Alaska. Granular temperature data is crucial for our analysis because heat pump performance is closely related to temperature.

## Census data and shapefiles

To aggregate and communicate these climate data at a meaningful unit of analysis, we used data from Census and the associated shapefiles. These shapefiles offer the definition of administrative boundaries at various levels (e.g., from boroughs, places to blocks). They are known in geospatial analysis as vector data, specifically in the form of polygons. These files provide accurate, detailed outlines of regions at varying administrative levels. In this analysis, the Alaska specific shapefiles were produced by the US Census Bureau and maintained by Alaska’s [Department of Labor and Workforce Development, Research and Analysis](https://live.laborstats.alaska.gov/cen/maps-gis). We merged the ERA5 temperature data with the administrative boundary data to understand and visualize temperature at different units of analysis and perform a geo-referenced climate analysis.

Futhermore, Census data offer information such as numbers of population and houseunits associated with each community at different administrative levels. Meanwhile, the [American Community Survey](https://data.census.gov/all?q=B25040:+HOUSE+HEATING+FUEL) maintained by US Census Bureau provides us with data on the primary home heating fuel choice in Alaska at a borough level. These variables are essential for our downstream analyses when we have to aggreagte and weight the building-level estimates (from the Heat Pump Calculator) to borough-level ones (read more in our [Analyses](https://uwescience.github.io/DSSG2023-Heating-Loads/method3/) section). This is to ensure that our estimates reflect the facts that (1) the population are highly concentrated in a few places, and (2) some cities disproportionately rely on some particular heating fuels (e.g., natural gas).

## Heat pump adoption data

We created a dataset of the current (2023) number of heat pumps estimated to be in Alaska by borough. This data was crowdsourced from energy experts and Alaska Heat Smart. If we were unable to get numbers for a specific borough, we assumed there to be no heat pumps in that borough. The aim of this dataset was not to be as accurate as possible, but to capture the general distribution of heat pumps currently in Alaska and provide a starting point for the scenarios in which we imagine a larger percentage of the population has heat pumps.

