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

vis_adopt_proj <- function(proj_rate, absolute = TRUE) {
  
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
      marker = list(symbol = 'square', size = 9.75),
      y = ~ (-row),
      x = ~ col,
      color = if (absolute == TRUE) as.formula(paste0("~", proj_rate)) else as.formula(paste0("~", paste0(proj_rate, "_prop_b"))),
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
      color = I("black"),
      hoverinfo = 'skip'
    ) %>%
    # customize legend 
    colorbar(
      limits = if (absolute == TRUE) c(0,7050) else c(0,0.5), 
      title = if (absolute == TRUE) "<b>No. of Heat Pumps</b>" else "<b>Prop. w/ Heat Pumps</b>",
      orientation = 'h',
      len = 0.85
    ) %>%
    # layout adjustments
    layout( 
      xaxis = list(title = ""),
      yaxis = list(title = "", fixedrange = FALSE, showgrid = FALSE, showline = FALSE, showticklabels = FALSE),
      showlegend = FALSE,
      autosize = TRUE,
      plot_bgcolor = '#D8DEE9',
      paper_bgcolor = '#D8DEE9',
      width = 650,
      height = 650,
      margin = list(l = 0, r = 0, b = 0, t = 0, pad = 0)
    )
  
  return(adopt_proj_plotly)
  
}

vis_adopt_proj(proj_rate = "hp_15p")
