require(dplyr)
require(stringr)
require(tidyr)
require(plotly)
require(raster)
require(sf)

##### For the three aggregate outcomes #####

## Get state-level aggregates
state_estimates <- read.csv("../DSSG2023-Heating-Loads-Data/state-borough-aggregates/state_estimates.csv")

## Convert it to wide format
state_estimates_wide <- 
  state_estimates %>%
  separate(X, into = c("total", "outcome", "proj_rate"), sep = "(?<!CO2)_") %>%
  mutate(proj_rate = paste0("hp_", proj_rate)) %>%
  pivot_wider(names_from = outcome, values_from = estimate)

##### For tilegram visualization #####

## Read borough 
adopt_proj <- read.csv("../DSSG2023-Heating-Loads-Data/state-borough-aggregates/adoption_scenarios_by_cop_and_pop_max_50p_sat_pretty.csv")
names(adopt_proj)[2] <- 'name' 

## Merge adoption data w/ tilegram layout (from 'make_tilegram.R')
adopt_proj_df <- merge(adopt_proj, all_grids, by = 'name')

## Rasterize, then convert tile into polygon
adopt_proj_raster <- 
  adopt_proj_df %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2) %>%           # select X, Y (for coords), Z (for value)
  rasterFromXYZ()

adopt_proj_polygon <- 
  adopt_proj_raster %>%
  rasterToPolygons(dissolve = TRUE) %>%
  st_as_sf()

## Write a function to visualize adoption rates

vis_adopt_proj <- function(proj_rate) {
  
  ## Get absolute and relative numbers of HP
  hp_absolute <- 
    adopt_proj_df %>% 
    pull(proj_rate)
  
  hp_percentage <- 
    adopt_proj_df %>% 
    pull(!!sym(paste0(proj_rate, "_prop_b"))) %>% 
    round(2) * 100
  
  ## Visualize adoption projection
  adopt_proj_plotly <- 
    # create a plotly object 
    plot_ly() %>%
    # add the scatter layer 
    add_trace(
      data = adopt_proj_df,
      type = "scatter",
      mode = 'markers',
      marker = list(symbol = 'square', size = 9),
      y = ~ (-row),
      x = ~ col,
      color = as.formula(paste0("~", proj_rate)),
      colors = "YlOrRd",
      hoverinfo = "text",
      text = ~ paste0("Borough: ", name, "<br>", 
                      "Number of heat pumps: ", hp_absolute, "<br>", 
                      "Percentage out of households in borough: ", hp_percentage, "%")
    ) %>%
    # add boundaries 
    add_sf( 
      data = adopt_proj_polygon,
      size = I(1),
      fill = I("transparent"),
      color = I("black")
    ) %>%
    # customize legend 
    colorbar(
      limits = c(0,7050), 
      title = "<b>No. of Heat Pumps",
      orientation = "h", 
      len = 1
    ) %>%
    # layout adjustments
    layout( 
      title = '<b>Number of Heat Pumps Installed \nby Borough',
      xaxis = list(title = NULL),
      yaxis = list(title = NULL),
      showlegend = FALSE,
      autosize = F,
      width = 600,
      height = 680,
      margin = list(l = 30, r = 1, b = 1, t = 75, pad = 3)
    )
  
  return(adopt_proj_plotly)
  
}

## Testing the function
# vis_adopt_proj(proj_rate = "hp_current")
# vis_adopt_proj(proj_rate = "hp_2p")
# vis_adopt_proj(proj_rate = "hp_15p")






