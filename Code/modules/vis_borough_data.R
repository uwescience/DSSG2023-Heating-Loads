require(dplyr)
require(forcats)

## Load borough-level estimates
borough_projs <- read.csv("data/borough_estimates_weightedByHuFuel.csv")

## Generate a toy dataframe (simple average within boroughs); replace with real one later
borough_projs_final <- 
  borough_projs %>% 
  rename(name = census_area,
         NPV = NPV_weighted2,
         CO2_lbs_saved = CO2_lbs_saved_weighted2,
         CO2_driving_miles_saved = CO2_driving_miles_saved_weighted2) %>%
  mutate(name = case_when(name == "Wade Hampton Census Area" ~ "Kusilvak Census Area",
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
                                     Temp_Projection == 3 ~ "high")) 

## Write a function to subset data based on scenarios and visualize tilegram
vis_borough_proj <- function(outcome = "NPV", 
                             Rebate_dol = "current", 
                             Fuel_Esc_Rate = "current", 
                             Temp_Projection = "current") {
  
  ## Subset data based on combination of 3x3x3 projections 
  borough_projs_subset <- 
    borough_projs_final %>%
    filter(Rebate_dol == !!Rebate_dol &
             Fuel_Esc_Rate == !!Fuel_Esc_Rate &
              Temp_Projection == !!Temp_Projection)
  
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
      customize_input$legend_title <- "<b>Cost-Effectiveness</b>\n<i>Net Present Value</i>"
      customize_input$palette <- "RdBu"
      customize_input$limit <- c(-20000, 20000)
      
    } else if (outcome == "CO2_lbs_saved") {
    
      customize_input$hover_text <- ~ paste("Borough:", name, "<br>CO2 Saved:", round(CO2_lbs_saved), "lbs")
      customize_input$legend_title <- "<b>CO2 Saved<br>(lbs)</b>"
      customize_input$palette <- "YlGn"
      customize_input$limit <- NULL
    
    } else if (outcome == "CO2_driving_miles_saved") {
      
      customize_input$hover_text <- ~ paste("Borough:", name, "<br>CO2 Saved:", round(CO2_driving_miles_saved), "driving miles")
      customize_input$legend_title <- "<b>CO2 Saved<br>(in Driving Miles)</b>"
      customize_input$palette <- "BuGn"
      customize_input$limit <- NULL
      
    } else if (outcome == "Heating_Days_Covered") {
      
      customize_input$hover_text <- ~ paste0("Borough: ", name, "<br>Heating Days Covered: ", round(Heating_Days_Covered, 3)*100, "%")
      customize_input$legend_title <- '<b>% of Heating Days Covered</b>'
      customize_input$palette <- "YlOrRd"
      customize_input$limit <- c(min(borough_projs_final$Heating_Days_Covered), max(borough_projs_final$Heating_Days_Covered))
      
    }
  
  ## Make tilegram
  borough_proj_tilegram <- 
    # create a plotly object 
    plot_ly() %>%
    # add the scatter layer 
    add_trace(
      data = borough_projs_df,
      type = "scatter",
      mode = 'markers',
      marker = list(symbol = 'square', size = 9.25),
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
      color = I("black"),
      hoverinfo = 'skip'
    ) %>%
    # customize legend 
    colorbar(
      limits = customize_input$limit,
      title = customize_input$legend_title,
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
  
  return(borough_proj_tilegram)
  
}

# Write another function to subset data based on scenarios and create bar plots/tables
vis_borough_barplot <- function(outcome = "NPV",
                                 Rebate_dol = "current",
                                 Fuel_Esc_Rate = "current",
                                 Temp_Projection = "current") {

  ## Subset data based on combination of 3x3x3 projections
  borough_projs_subset <-
    borough_projs_final %>%
    filter(Rebate_dol == !!Rebate_dol &
             Fuel_Esc_Rate == !!Fuel_Esc_Rate &
              Temp_Projection == !!Temp_Projection) %>%
    mutate(name = str_trim(str_remove(name, "Borough|City and Borough|Census Area|Municipality")))
  
  ## customize data and input 
  customize_input <- list()
  
  ## Rank boroughs by outcome
  if (outcome == "Heating_Days_Covered") {
    
    ## for Heating_Days_Covered, get bottom 10 boroughs
    borough_projs_top <- 
      borough_projs_subset %>%
      mutate(name = fct_reorder(name, !!sym(outcome))) %>%
      arrange(desc(name)) %>%
      slice_tail(n = 10)
    
    customize_input$xaxis <- list(range = c(0.55, 0.95), title = "% of Heating Days Covered")
    customize_input$height <- 205
    
  } else if (outcome == "NPV") {
    
    borough_projs_top <- 
      borough_projs_subset %>%
      mutate(name = fct_reorder(name, !!sym(outcome))) %>%
      arrange(desc(name)) %>%
      slice_head(n = 10)
    
    customize_input$height <- 205
    
  } else if (outcome %in% c("CO2_lbs_saved", "CO2_driving_miles_saved")) {
    
    borough_projs_top <- 
      borough_projs_subset %>%
      mutate(name = fct_reorder(name, !!sym(outcome))) %>%
      arrange(desc(name)) 
    
    customize_input$xaxis <- list(title = ifelse(outcome == "CO2_lbs_saved", "CO2 saved (in lbs)", "CO2 saved (driving miles)"))
    customize_input$height <- 450
  }
  
  ## Plotly bar plot  
  borough_proj_barplot <- 
    plot_ly(
      data = borough_projs_top,
      x = as.formula(paste0("~", outcome)),
      y = ~ name
    ) %>%
    layout( 
      xaxis = customize_input$xaxis,
      yaxis = list(title = ""),
      height = customize_input$height,
      plot_bgcolor = '#D8DEE9',
      paper_bgcolor = '#D8DEE9',
      margin = list(l = 0, r = 0, b = 0, t = 0, pad = 0)
    )
  
  return(borough_proj_barplot)

}


