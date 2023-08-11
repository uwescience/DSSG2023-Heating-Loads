require(dplyr)

## Load borough-level estimates
borough_projs <- read.csv("../DSSG2023-Heating-Loads-Data/heatPumpCal/results_BoroughProjs.csv")

## Generate a toy dataframe (simple average within boroughs); replace with real one later
borough_projs_toy <- 
  borough_projs %>%
  group_by(Census_Area, Rebate_dol, Fuel_Esc_Rate, Temp_Projection) %>%
  summarize(
    NPV = mean(NPV),
    CO2_lbs_saved = mean(CO2_lbs_saved),
    Heating_Days_Above5 = mean(Heating_Days_Above5),
    Heating_Days_Below5 = mean(Heating_Days_Below5)
  ) %>%
  ungroup() %>%
  rename(name = Census_Area) %>%
  mutate(
    name = case_when(name == "Wade Hampton Census Area" ~ "Kusilvak Census Area",
                     name == "Anchorage municipality" ~ "Anchorage Municipality",
                     TRUE ~ name),
    Rebate_dol = case_when(Rebate_dol == 0 ~ "current",
                           Rebate_dol == 2000 ~ "mid",
                           Rebate_dol == 4000 ~ "high"),
    Fuel_Esc_Rate = case_when(Fuel_Esc_Rate == 0.03 ~ "current",
                              Fuel_Esc_Rate == 0.06 ~ "mid",
                              Fuel_Esc_Rate == 0.09 ~ "high"),
    Temp_Projection = case_when(Temp_Projection == 0 ~ "current",
                                Temp_Projection == 1.5 ~ "mid",
                                Temp_Projection == 3 ~ "high")
  ) 

## Write a function to subset data based on scenarios and visualize tilegram
vis_borough_proj <- function(outcome = "NPV", 
                             Rebate_dol = "current", 
                             Fuel_Esc_Rate = "current", 
                             Temp_Projection = "current") {
  
  ## Subset data based on combination of 3x3x3 projections 
  borough_projs_subset <- 
    borough_projs_toy %>%
    filter(
      Rebate_dol == !!Rebate_dol &
      Fuel_Esc_Rate == !!Fuel_Esc_Rate &
      Temp_Projection == !!Temp_Projection
    )
  
  ## Merge adoption data w/ tilegram layout (from 'make_tilegram.R')
  borough_projs_df <- merge(borough_projs_subset, all_grids, by = 'name')
  
  ## Rasterize, then convert tile into polygon
  borough_projs_raster <- 
    borough_projs_df %>%
    mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
    mutate(row = -row) %>%
    dplyr::select(col, row, name2) %>%           # select X, Y (for coords), Z (for value)
    rasterFromXYZ()
  
  borough_projs_polygon <- 
    borough_projs_raster %>%
    rasterToPolygons(dissolve = TRUE) %>%
    st_as_sf()
  
  ## Make hover text and title depending on outcome 
  
  customize_input <- list()
  
  if (outcome == "NPV") {
    
      customize_input$hover_text <- ~ paste("Borough:", name, "<br>Net Present Value:", round(NPV))
      customize_input$main_title <- '<b>Average Cost Savings from Heat Pump Installation \nby Borough'
      customize_input$legend_title <- "<b>Cost-Effectiveness</b>\n<i>Net Present Value"
      customize_input$palette <- "Blues"
      customize_input$limit <- c(min(borough_projs_toy$NPV), max(borough_projs_toy$NPV))
      
    } else if (outcome == "CO2_lbs_saved") {
    
      customize_input$hover_text <- ~ paste("Borough:", name, "<br>CO2 Saved:", round(CO2_lbs_saved), "lbs")
      customize_input$main_title <- '<b>Average Pounds of Carbon Dioxide Saved from Heat Pumps \nPer Household'
      customize_input$legend_title <- "<b>CO2 Saved (lbs)"
      customize_input$palette <- "YlGn"
      customize_input$limit <- NULL
      
    } else if (outcome == "Heating_Days_Above5") {
      
      customize_input$hover_text <- ~ paste("Borough:", name, "<br>Heating Days Covered:", round(Heating_Days_Above5), "days")
      customize_input$main_title <- '<b>Average Heating Days Covered by Heat Pump \nby Borough'
      customize_input$legend_title <- '<b>Heating Days Covered'
      customize_input$palette <- "YlOrRd"
      customize_input$limit <- c(min(borough_projs_toy$Heating_Days_Above5), max(borough_projs_toy$Heating_Days_Above5))
      
    }
  
  ## Make tilegram
  borough_proj_plotly <- 
    # create a plotly object 
    plot_ly() %>%
    # add the scatter layer 
    add_trace(
      data = borough_projs_df,
      type = "scatter",
      mode = 'markers',
      marker = list(symbol = 'square', size = 9),
      y = ~ (-row),
      x = ~ col,
      color = as.formula(paste0("~", outcome)),
      colors = customize_input$palette,
      hoverinfo = "text",
      text = customize_input$hover_text
    ) %>%
    # add boundaries 
    add_sf( 
      data = borough_projs_polygon,
      size = I(1),
      fill = I("transparent"),
      color = I("black")
    ) %>%
    # customize legend 
    colorbar(
      limits = customize_input$limit,
      title = customize_input$legend_title,
      orientation = "h", 
      len = 1
    ) %>%
    # layout adjustments
    layout( 
      title = customize_input$main_title,
      xaxis = list(title = NULL),
      yaxis = list(title = NULL),
      showlegend = FALSE,
      autosize = F,
      width = 600,
      height = 680,
      margin = list(l = 30, r = 1, b = 1, t = 75, pad = 3)
    )
  
  return(borough_proj_plotly)
  
}

## Write another function to subset data based on scenarios and create bar plots/tables
vis_borough_bartable <- function(outcome = "NPV", 
                             Rebate_dol = "current", 
                             Fuel_Esc_Rate = "current", 
                             Temp_Projection = "current") {
  
  ## Subset data based on combination of 3x3x3 projections 
  borough_projs_subset <- 
    borough_projs_toy %>%
    filter(
      Rebate_dol == !!Rebate_dol &
        Fuel_Esc_Rate == !!Fuel_Esc_Rate &
        Temp_Projection == !!Temp_Projection
    )
  
  ## Merge adoption data w/ tilegram layout (from 'make_tilegram.R')
  borough_projs_df <- merge(borough_projs_subset, all_grids, by = 'name')
  
  ## Rasterize, then convert tile into polygon
  borough_projs_raster <- 
    borough_projs_df %>%
    mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
    mutate(row = -row) %>%
    dplyr::select(col, row, name2) %>%           # select X, Y (for coords), Z (for value)
    rasterFromXYZ()
  
  borough_projs_polygon <- 
    borough_projs_raster %>%
    rasterToPolygons(dissolve = TRUE) %>%
    st_as_sf()
  
  ## Make hover text and title depending on outcome 
  
  customize_input <- list()
  
  if (outcome == "NPV") {
    
    customize_input$hover_text <- ~ paste("Borough:", name, "<br>Net Present Value:", round(NPV))
    customize_input$main_title <- '<b>Average Cost Savings from Heat Pump Installation \nby Borough'
    customize_input$legend_title <- "<b>Cost-Effectiveness</b>\n<i>Net Present Value"
    customize_input$palette <- "Blues"
    customize_input$limit <- c(min(borough_projs_toy$NPV), max(borough_projs_toy$NPV))
    
  } else if (outcome == "CO2_lbs_saved") {
    
    customize_input$hover_text <- ~ paste("Borough:", name, "<br>CO2 Saved:", round(CO2_lbs_saved), "lbs")
    customize_input$main_title <- '<b>Average Pounds of Carbon Dioxide Saved from Heat Pumps \nPer Household'
    customize_input$legend_title <- "<b>CO2 Saved (lbs)"
    customize_input$palette <- "YlGn"
    customize_input$limit <- NULL
    
  } else if (outcome == "Heating_Days_Above5") {
    
    customize_input$hover_text <- ~ paste("Borough:", name, "<br>Heating Days Covered:", round(Heating_Days_Above5), "days")
    customize_input$main_title <- '<b>Average Heating Days Covered by Heat Pump \nby Borough'
    customize_input$legend_title <- '<b>Heating Days Covered'
    customize_input$palette <- "YlOrRd"
    customize_input$limit <- c(min(borough_projs_toy$Heating_Days_Above5), max(borough_projs_toy$Heating_Days_Above5))
    
  }
  
  ## Make tilegram
  borough_proj_plotly <- 
    # create a plotly object 
    plot_ly() %>%
    # add the scatter layer 
    add_trace(
      data = borough_projs_df,
      type = "scatter",
      mode = 'markers',
      marker = list(symbol = 'square', size = 9),
      y = ~ (-row),
      x = ~ col,
      color = as.formula(paste0("~", outcome)),
      colors = customize_input$palette,
      hoverinfo = "text",
      text = customize_input$hover_text
    ) %>%
    # add boundaries 
    add_sf( 
      data = borough_projs_polygon,
      size = I(1),
      fill = I("transparent"),
      color = I("black")
    ) %>%
    # customize legend 
    colorbar(
      limits = customize_input$limit,
      title = customize_input$legend_title,
      orientation = "h", 
      len = 1
    ) %>%
    # layout adjustments
    layout( 
      title = customize_input$main_title,
      xaxis = list(title = NULL),
      yaxis = list(title = NULL),
      showlegend = FALSE,
      autosize = F,
      width = 600,
      height = 680,
      margin = list(l = 30, r = 1, b = 1, t = 75, pad = 3)
    )
  
  return(borough_proj_plotly)
  
}






