require(dplyr)
require(stringr)
require(tidyr)
require(plotly)
require(raster)
require(sf)

##### For the three aggregate outcomes #####

## Get state-level aggregates
state_estimates <- read.csv("data/state_estimates.csv")

## Convert it to wide format
state_estimates_wide <- 
  state_estimates %>%
  filter(str_detect(X, "NPV|CO2|Covered")) %>%
  separate(X, into = c("total", "outcome", "proj_rate"), sep = "(?<=total)_|_(?=current|5|15)") %>%
  mutate(proj_rate = paste0("hp_", proj_rate)) %>%
  pivot_wider(names_from = outcome, values_from = estimate)

##### For tilegram visualization #####

## Read borough 
adopt_proj <- read.csv("data/adoption_scenarios_5_and_15.csv")
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
      marker = list(symbol = 'square', size = 9.25),
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
      xaxis = list(title = NULL),
      yaxis = list(title = NULL),
      showlegend = FALSE,
      autosize = FALSE,
      width = 625,
      height = 625,
      plot_bgcolor = '#D8DEE9',
      paper_bgcolor = '#D8DEE9'
      #margin = list(l = 0, r = 0, b = 0, t = 0, pad = 1)
    )
  
  return(adopt_proj_plotly)
  
}

# Write another function to subset data based on scenarios and create bar plots/tables
vis_state_barplot <- function(proj_rate) {
  
  ## Subset data based on projected rate
  selected_proj_rate <- 
    adopt_proj %>%
    dplyr::select(name, proj_rate) %>%
    mutate(name = str_trim(str_remove(name, "Borough|City and Borough|Census Area|Municipality")))

  ## Rank boroughs by outcome
  borough_projs_top5 <- 
    selected_proj_rate %>%
    mutate(name = fct_reorder(name, !!sym(proj_rate))) %>%
    arrange(desc(name)) %>%
    slice_head(n = 5)
  
  
  ## Plotly bar plot  
  plot_ly(
    data = borough_projs_top5,
    x = as.formula(paste0("~", proj_rate)),
    y = ~ name
  ) %>%
    layout( 
      yaxis = list(title = ""),
      height = 220
    )
  
}






