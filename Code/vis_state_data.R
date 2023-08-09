# FINAL ONES
first_proj <- read.csv('adoption_scenarios_by_cop_and_pop_max_50p_sat_pretty.csv')
head(first_proj)
names(first_proj)[2] <- 'name'
proj_df <- merge(first_proj, merged_basedf, by = 'name')
proj_df_raster <- 
  proj_df %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)

proj_df_raster <- rasterFromXYZ(proj_df_raster)       # turn to raster 
proj_df_polygon <- rasterToPolygons(proj_df_raster, dissolve = TRUE)  # turn to polygon 
proj_df_polygonSF <- st_as_sf(proj_df_polygon)                        # turn to sf object


# Current HP adoption rates
current_adoptrate <- plot_ly() # create a plotly object
current_adoptrate <- add_trace( # add the scatter layer
  current_adoptrate,
  data = proj_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9),
  y = ~(-row),
  x = ~col,
  text = ~paste("Borough:", name, "<br>", "Number of heat pumps:", hp_current, "<br>", "Percentage out of households in borough:", round(hp_current_prop_b*100, 2), "%"),
  #text = sprintf("Borough: %s<br>Number of Heat Pumps: %s<br>", name, hp_current),
  text = ~name,
  #hovertemplate = paste('<b>Borough</b>: %{text}<br>', '<b>Number of Heat Pumps</b>: %{marker.color}<br>'),
  color = ~hp_current,
  colors = "YlOrRd",
  hoverinfo = "text"
)
current_adoptrate <- add_sf( # add the geom_sf layer
  current_adoptrate, 
  data = proj_df_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
current_adoptrate <- current_adoptrate %>% colorbar(limits = c(0,7050), title = "<b>No. of Heat Pumps",
                                                    orientation = "h", len = 1)
current_adoptrate <- layout( # set the labels and axis titles
  current_adoptrate,
  title = '<b>Number of Heat Pumps Installed \nby Borough',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
current_adoptrate <- current_adoptrate %>% layout(autosize = F, width = 600, height = 680, margin = m)
current_adoptrate # show plot

# 2% HP adoption rates
two_adoptrate <- plot_ly() # create a plotly object
two_adoptrate <- add_trace( # add the scatter layer
  two_adoptrate,
  data = proj_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9),
  y = ~(-row),
  x = ~col,
  text = ~paste("Borough:", name, "<br>", "Number of heat pumps:", hp_2p, "<br>", "Percentage out of households in borough:", round(hp_2p_prop_b*100, 2), "%"),
  #text = sprintf("Borough: %s<br>Number of Heat Pumps: %s<br>", name, hp_current),
  text = ~name,
  #hovertemplate = paste('<b>Borough</b>: %{text}<br>', '<b>Number of Heat Pumps</b>: %{marker.color}<br>'),
  color = ~hp_2p,
  colors = "YlOrRd",
  hoverinfo = "text"
)
two_adoptrate <- add_sf( # add the geom_sf layer
  two_adoptrate, 
  data = proj_df_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
two_adoptrate <- two_adoptrate %>% colorbar(limits = c(0,7050), title = "<b>No. of Heat Pumps",
                                            orientation = "h", len = 1)
two_adoptrate <- layout( # set the labels and axis titles
  two_adoptrate,
  title = '<b>Number of Heat Pumps Installed \nby Borough',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
two_adoptrate <- two_adoptrate %>% layout(autosize = F, width = 600, height = 680, margin = m)
two_adoptrate # show plot


# 15% HP adoption rates
fifteen_adoptrate <- plot_ly() # create a plotly object
fifteen_adoptrate <- add_trace( # add the scatter layer
  fifteen_adoptrate,
  data = proj_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9),
  y = ~(-row),
  x = ~col,
  text = ~paste("Borough:", name, "<br>", "Number of heat pumps:", hp_15p, "<br>", "Percentage out of households in borough:", round(hp_15p_prop_b*100, 2), "%"),
  #text = sprintf("Borough: %s<br>Number of Heat Pumps: %s<br>", name, hp_current),
  text = ~name,
  #hovertemplate = paste('<b>Borough</b>: %{text}<br>', '<b>Number of Heat Pumps</b>: %{marker.color}<br>'),
  color = ~hp_15p,
  colors = "YlOrRd",
  hoverinfo = "text"
)
fifteen_adoptrate <- add_sf( # add the geom_sf layer
  fifteen_adoptrate, 
  data = proj_df_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
fifteen_adoptrate <- fifteen_adoptrate %>% colorbar(limits = c(0,7050), title = "<b>No. of Heat Pumps",
                                                    orientation = "h", len = 1)
fifteen_adoptrate <- layout( # set the labels and axis titles
  fifteen_adoptrate,
  title = '<b>Number of Heat Pumps Installed \nby Borough',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
fifteen_adoptrate <- fifteen_adoptrate %>% layout(autosize = F, width = 600, height = 680, margin = m)
fifteen_adoptrate # show plot


# 15% HP adoption rates - percentages
fifteen_adoptrate_perc <- plot_ly() # create a plotly object
fifteen_adoptrate_perc <- add_trace( # add the scatter layer
  fifteen_adoptrate_perc,
  data = proj_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9),
  y = ~(-row),
  x = ~col,
  text = ~paste("Borough:", name, "<br>", "Number of heat pumps:", hp_15p, "<br>", "Percentage out of households in borough:", round(hp_15p_prop_b*100, 2), "%"),
  #text = sprintf("Borough: %s<br>Number of Heat Pumps: %s<br>", name, hp_current),
  text = ~name,
  #hovertemplate = paste('<b>Borough</b>: %{text}<br>', '<b>Number of Heat Pumps</b>: %{marker.color}<br>'),
  color = ~hp_15p_prop_b,
  colors = "YlOrRd",
  hoverinfo = "text"
)
fifteen_adoptrate_perc <- add_sf( # add the geom_sf layer
  fifteen_adoptrate_perc, 
  data = proj_df_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
fifteen_adoptrate_perc <- fifteen_adoptrate_perc %>% colorbar(limits = c(0,.5), title = "<b>No. of Heat Pumps",
                                                              orientation = "h", len = 1)
fifteen_adoptrate_perc <- layout( # set the labels and axis titles
  fifteen_adoptrate_perc,
  title = '<b>Number of Heat Pumps Installed \nby Borough',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
fifteen_adoptrate_perc <- fifteen_adoptrate_perc %>% layout(autosize = F, width = 600, height = 680, margin = m)
fifteen_adoptrate_perc # show plot


# Plain tilegram for first page of dashboard
plain_plot <- plot_ly() # create a plotly object
plain_plot <- add_trace( # add the scatter layer
  plain_plot,
  data = proj_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9, color = 'rgb(230,230,230)'),
  text = ~paste("Borough:", name, "<br>", "Value of interest:", hp_15p),
  hoverinfo = "text",
  y = ~(-row),
  x = ~col
)
plain_plot <- add_sf( # add the geom_sf layer
  plain_plot, 
  data = proj_df_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
plain_plot <- layout( # set the labels and axis titles
  plain_plot,
  title = '',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
plain_plot <- plain_plot %>% layout(autosize = F, width = 600, height = 680, margin = m)
plain_plot # show plot



