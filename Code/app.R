##### Heat Pump Adoption and Projection 
##### Visualization App
##### DSSG 2023 Team

## packages
if (!require(pacman)) {install.packages("pacman"); require(pacman)}
p_load(
  "ggplot2",
  "geofacet",
  "rnaturalearth",
  "raster",
  "useful",
  "plotly",
  "sf",
  "shiny",
  "shinydashboard",
  "shinyWidgets",
  "fresh"
)

## source functional R scripts
source('make_tilegram.R')
source('vis_state_data.R')
source('vis_borough_data.R')
source('www/theme.R')


## UI
ui <- dashboardPage(#skin = "blue",
                    dashboardHeader(title = HTML("<b>Heat Pump Adoption in Alaska</b>"), titleWidth = 540),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Motivation", tabName = "motivation", icon = icon("file")),      
                        menuItem("Adoption Rate Projections", tabName = "statewide", icon = icon("chart-line")),
                        menuItem("Projections", tabName = "proj", icon = icon("money-bill"),
                                 menuSubItem("Economic", tabName = "sub_ec"),
                                 menuSubItem("Feasibility", tabName = "sub_feas"), 
                                 menuSubItem("Environmental", tabName = "sub_env")),
                        menuItem("Case Studies", tabName = "case", icon = icon("map-marker")),
                        menuItem("Frequently Asked Questions", tabName = "faq", icon = icon("question-circle"))
                      )
                    ),
                    dashboardBody(
                      use_theme(mytheme),
                      includeCSS("www/styles.css"),
                      # Boxes need to be put in a row (or column)
                      tabItems(
                        tabItem(tabName = "motivation",
                                fluidRow(
                                  column(width = 12,
                                         titlePanel("An Interactive Visualization Tool to Explore Heat Pump Adoption in Alaska"),
                                         box(width = 6, title = HTML("<b>Why Study Heat Pumps?</b>"), "Replacing traditional heating sources with heat pumps can save money and carbon emissions across the state of Alaska. We aim to visualize where in Alaska heat pumps are likely to be most feasible, economic, and green. Read more about our project's motivation, aims, and methods on our website [embed link]."),
                                         box(width = 6, title = HTML("<b>Navigating the Dashboard</b>"), "In the 'Adoption Rate Projections' tab, explore how current and project heat pump adoption numbers will affect state-wide metrics. In the 'Projections' tab, explore how Boroughs across the state compare in heating feasibility, economic benefits, and carbon emission reduction."),
                                         box(width = 12, title = HTML("<b>Interacting with Our Maps</b>"),
                                             HTML("Many of our visualizations are <b>Tilegrams</b>. A Tilegram, short for <i>Tiled Cartogram</i>, is a map made up of tiles where regions are proportional to a dataset. In our plots, regions are Census Boroughs and they are proportional to the number of people in that Borough. Tilegrams can represent demographic data more accurately than traditional geographic maps, but still retain a familiar shape. You can read more about tilegrams here [embed link].")),
                                         HTML('<p><img src="map_comparison_image_option2.png" width="1000"/></p>'),
                                         )
                                )
                        ),
                        tabItem(tabName = "statewide",
                                fluidRow(
                                  column(width=4,
                                         box(title = HTML("<b>Projected Heat Pump Adoption Rates</b>"), solidHeader = TRUE,
                                             "Toggle between current heat pump estimates, moderate projections (2% of households), and aggressive projections (15% of households)", 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "adoption_button",
                                               label = NULL,
                                               choiceNames = c("Current", "2%", "15%"),
                                               choiceValues = c("hp_current", "hp_2p", "hp_15p"),
                                               status = "primary", size = 'normal', justified = TRUE), width = NULL), 
                                         valueBoxOutput("moneySavedBox", width = NULL),
                                         valueBoxOutput("co2SavedBox", width = NULL),
                                         valueBoxOutput("heatingDaysBox", width = NULL),
                                  ),
                                  column(width = 8,
                                         plotlyOutput("adop_proj_plot")
                                  )
                                )
                        ),
                        tabItem(tabName = "sub_ec",
                                fluidRow(
                                  column(width=4, 
                                         box(title = HTML("<b>Fuel Price Increase Projections</b>"), solidHeader = TRUE,
                                             "Toggle between current fuel prices, medium increases in projected fuel prices, and large increases in projected fuel prices", 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_fuel",
                                               label = "Level of increase:",
                                               choiceNames = c("Current", "Medium", "Large"),
                                               choiceValues = c("current", "mid", "high"),
                                               status = "primary", size = 'normal', justified = TRUE), width = NULL),
                                         box(title = HTML("<b>Rebate Projections</b>"), solidHeader = TRUE,
                                             "Toggle between currently provided rebates, moderate increases in projected rebates, and large increases in projected rebates", 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_rebate",
                                               label = "Level of increase:",
                                               choiceNames = c("Current", "Medium", "Large"),
                                               choiceValues = c("current", "mid", "high"),
                                               status = "primary", size = 'normal', justified = TRUE), width = NULL),
                                         box(title = HTML("<b>Climate Change Projections</b>"), solidHeader = TRUE,
                                             "Toggle between current climate conditions, moderate increases in projected temperature increases, and large increases in projected temperature increases", 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_climate",
                                               label = "Level of increase:",
                                               choiceNames = c("Current", "Medium", "Large"),
                                               choiceValues = c("current", "mid", "high"),
                                               status = "primary", size = 'normal', justified = TRUE), width = NULL),
                                  ),
                                  column(width = 8,
                                         plotlyOutput("borough_proj_NPV", height = 615),
                                         box(title = HTML("<b>What is Net Present Value?</b>"), 
                                             HTML("<b>Cost-effectiveness</b> is expressed as <b>Net Present Value</b>, or the sum of the benefits minus the costs of a project over the life of a project. For example, a NPV value of 10K means that an average household in that borough will save $10k from installing a heat pump over the life of a heat pump (~14 years)"),
                                             collapsible = TRUE, collapsed = TRUE)
                                  )
                                )
                        ),
                        tabItem(tabName = "sub_feas",
                                fluidRow(
                                  column(width=4, 
                                         box(title = HTML("<b>Climate Change Projections</b>"), solidHeader = TRUE,
                                             "Toggle between current climate conditions, moderate increases in projected temperature increases, and large increases in projected temperature increases", 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_climate",
                                               label = "Level of increase:",
                                               choiceNames = c("Current", "Medium", "Large"),
                                               choiceValues = c("current", "mid", "high"),
                                               status = "primary", size = 'normal', justified = TRUE), width = NULL),
                                  ),
                                  column(width = 8,
                                         plotlyOutput("borough_proj_HeatingDays", height = 615)
                                  )
                                )
                        ),
                        tabItem(tabName = "sub_env",
                                fluidRow(
                                  column(width = 4,
                                         box(width = 16, "Global energy-related carbon dioxide emissions rose by 6% in 2021 to 36.3 billion tonnes, their highest ever level, as the world economy rebounded strongly from the Covid-19 crisis and relied heavily on coal to power that growth, according to new IEA analysis released today. 
                                         The increase in global CO2 emissions of over 2 billion tonnes was the largest in history in absolute terms, more than offsetting the previous year’s pandemic-induced decline, the IEA analysis shows. The recovery of energy demand in 2021 was compounded by adverse weather and energy market conditions – notably the spikes in natural gas prices – which led to more coal being burned despite renewable power generation registering its largest ever growth.")
                                  ),
                                  column(width = 8,
                                         plotlyOutput("borough_proj_CO2")
                                  )
                                )
                                
                        ),
                        tabItem(tabName = "case",
                                h2("Census block visualizations in progress")
                        ),
                        tabItem(tabName = "faq",
                                box(width = NULL, title = HTML("<b>Q: How was the current number of heat pumps in Alaska estimated?</b>"), HTML("<b>A</b>: We created a dataset of the current (2023) number of heat pumps estimated to be in Alaska by borough. This data was crowdsourced from energy experts and Alaska Heat Smart. If we were unable to get estimates for a specific borough, we assumed there to be no heat pumps in that borough. The aim of this dataset was not to be as accurate as possible, but to capture the general distribution of heat pumps currently in Alaska and provide a starting point for the scenarios in which we imagine a larger percentage of the population has heat pumps.")),
                                box(width = NULL, title = HTML("<b>Q: How were heat pump adoption scenario projections structured / designed?</b>"), HTML("<b>A</b>: To imagine what heat pump distribution could look like across the state of Alaska, we needed an algorithm that allowed us to distribute heat pumps proportionally at the borough level. We believe that proportional distribution of heat pumps according to some measure is a more realistic scenario than equal distribution across all boroughs. The D’hondt method is an apportionment method developed to distribute seats in a legislative body proportionally to some measure, typically votes or population. Different apportionment methods have been developed because exact proportionally is often not possible due to the issue of fractional seats. These different methods have different properties, and empirical studies show that the D’hondt method is one of the least proportional apportionment methods, favoring large parties with the most votes. We determined that this property does not present concerns for our application, and may even be favorable. We used the D’hondt method to distribute heat pumps by borough in Alaska according to heat pump efficiency (a proxy for feasibility) and population. We recognize that there are many factors that contribute to whether or not a heat pump is installed, but we believe the most important factor is feasibility, or how well a heat pump can actually heat a space. After all, if a heat pump cannot be used as a primary heating source, the motivation to install one greatly decreases. We also wanted to incorporate population to a lesser degree given economies of scale; we believe that boroughs with larger populations will have an easier time working with installers and maintainers. To combine these two factors into one measure, we used the following formula: $rank(efficiency) * rank(efficiency) * rank(population)$. This priorities efficiency over population and addresses the problem that the distribution of heat pump efficiency across the boroughs is uniform.")),
                                box(width = NULL, title = HTML("<b>Q: How are estimates for the three dimensions calculated? <b/>"), HTML("<b>A<b/>:")),
                                box(width = NULL, title = HTML("<b>Q: How can I look at my specific neighborhood?<b/>"), HTML("<b>A<b/>:"))
                        )
                      ),
                    )
)

## server
server <- function(input, output) {
  
  ## State-level adoption tilegram
  output$adop_proj_plot <- renderPlotly({
    
    vis_adopt_proj(input$adoption_button)
    
  })
  
  ## State-level aggregate outcomes
  output$moneySavedBox <- renderValueBox({
    
    money_saved <- 
      state_estimates_wide %>%
      filter(proj_rate == input$adoption_button) %>% 
      pull(NPV)
    
    valueBox(round(money_saved/10^6, 1), "Millions of $ Saved", icon = icon("dollar-sign"), color = 'blue', width=NULL)
    
  })
  
  output$co2SavedBox <- renderValueBox({
    
    co2_saved <- 
      state_estimates_wide %>%
      filter(proj_rate == input$adoption_button) %>% 
      pull(CO2_lbs)
    
    valueBox(round(co2_saved/10^6, 1), "Millions of lbs CO2 Saved", icon = icon("seedling"), color = 'green', width=NULL)
    
  })
  
  output$heatingDaysBox <- renderValueBox({
    
    valueBox(100, "Thousands of Days of Heat Provided", icon = icon("fire"), color = 'red', width=NULL)
    
  })
  
  ## Borough-level projections for NPV
  output$borough_proj_NPV <- renderPlotly({
    
    vis_borough_proj(outcome = "NPV", 
                     Rebate_dol = input$buttons_fuel, 
                     Fuel_Esc_Rate = input$buttons_rebate, 
                     Temp_Projection = input$buttons_climate)
    
  })
  
  ## Borough-level projections for CO2
  output$borough_proj_CO2 <- renderPlotly({
    
    vis_borough_proj(outcome = "CO2_lbs_saved", 
                     Rebate_dol = input$buttons_fuel, 
                     Fuel_Esc_Rate = input$buttons_rebate, 
                     Temp_Projection = input$buttons_climate)
    
  })
  
  ## Borough-level projections for Heating Days
  output$borough_proj_HeatingDays <- renderPlotly({
    
    vis_borough_proj(outcome = "Heating_Days_Above5", 
                     Rebate_dol = input$buttons_fuel, 
                     Fuel_Esc_Rate = input$buttons_rebate, 
                     Temp_Projection = input$buttons_climate)
    
  })
  
}

## run app 
shinyApp(ui = ui, server = server)


