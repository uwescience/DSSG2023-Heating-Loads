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
source('modules/make_tilegram.R')
source('modules/vis_state_data.R')
source('modules/vis_borough_data.R')
source('www/theme.R')

## UI
ui <- dashboardPage(dashboardHeader(title = "Heat Pumps in Alaska", 
                                    tags$li(a(href = 'https://escience.washington.edu/using-data-science/data-science-for-social-good/',
                                              img(src = 'DataScienceForSocialGood-white.png',
                                                  title = "DSSG, eScience Institute, UW", height = "45px"),
                                              style = "padding-top:5px; padding-bottom:0px;"),
                                            class = "dropdown"),
                                    tags$li(a(href = 'https://github.com/uwescience/DSSG2023-Heating-Loads',
                                              img(src = 'GitHub_Logo_White.png',
                                                  title = "GitHub", height = "30px"),
                                              style = "padding-top:10px; padding-bottom:10px;"),
                                            class = "dropdown")
                                    ),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Motivation", tabName = "motivation", icon = icon("file")),      
                        menuItem("Statewide Adoption", tabName = "statewide", icon = icon("chart-line")),
                        menuItem("Borough Potential", tabName = "proj", icon = icon("money-bill"),
                                 menuSubItem("Feasibility", tabName = "sub_feas"), 
                                 menuSubItem("Economic", tabName = "sub_ec"),
                                 menuSubItem("Environmental", tabName = "sub_env")),
                        #menuItem("Case Studies", tabName = "case", icon = icon("map-marker")),
                        menuItem("Frequently Asked Questions", tabName = "faq", icon = icon("question-circle"))
                      )
                    ),
                    dashboardBody(
                      
                      # style for group buttons
                      tags$style(HTML(
                      ".btn-custom.active{
                        color: #fff;
                        background-color: #FFB612;
                        border-color: #FFB612;
                      }
                      
                      .btn-custom{
                        color: #fff;
                        background-color: #0F204B;
                        border-color: #0F204B;
                      } ")),
                      
                      # style customization
                      use_theme(mytheme),
                      includeCSS("www/styles.css"),
                      
                      # Boxes need to be put in a row (or column)
                      tabItems(
                        tabItem(tabName = "motivation",
                                fluidRow(
                                  column(width = 12,
                                         titlePanel("An Interactive Visualization Tool to Explore Heat Pump Adoption in Alaska"),
                                         box(width = 6, title = HTML("<b>Why Study Heat Pumps?</b>"), HTML("Replacing traditional heating sources with heat pumps can save money and carbon emissions across the state of Alaska. We aim to visualize where in Alaska heat pumps are likely to be most feasible, economic, and green. Read more about our project's motivation, aims, and methods on our <a href='https://uwescience.github.io/DSSG2023-Heating-Loads/'>website</a>.")),
                                         box(width = 6, title = HTML("<b>Navigating the Dashboard</b>"), HTML("In the <i>Statewide Adoption</i> tab, explore how current and project heat pump adoption numbers will affect state-wide metrics. In the <i>Borough Potential</i> tab, explore how Boroughs across the state compare in heating feasibility, economic benefits, and carbon emission reduction.")),
                                         box(width = 12, title = HTML("<b>Interacting with Our Maps</b>"),
                                             HTML("Many of our visualizations are <b>tilegrams</b>. A tilegram, short for <i>tiled cartogram</i>, is a map made up of tiles where regions are proportional to a variable other than geographical space. In our plots, regions are Census Boroughs and they are proportional to the number of people in that Borough. Tilegrams can represent demographic data more accurately than traditional geographic maps, but still retain a familiar shape. We demonstrate the two representations of Alaska below: "),
                                             br(),
                                             br(),
                                             splitLayout(cellWidths = c("50%", "50%"), 
                                                         HTML('<center><h4><b><i>Alaska in Traditional map</i></b></h4><img src="ak_normalmap.jpg" width="95%"/></center><br>'), 
                                                         HTML('<center><h4><b><i>Alaska in Tilegram</i></b></h4><img src="ak_tilegram.jpg" width="95%"/></center><br>'))
                                             )
                                         )
                                  )
                        ),
                        tabItem(tabName = "statewide",
                                fluidRow(
                                  column(width = 4,
                                         box(title = HTML("<b>Projected Heat Pump Adoption Rates</b>"), solidHeader = TRUE,
                                             HTML("<p>Toggle between current heat pump estimates, moderate projections (5% of households), and aggressive projections (15% of households)<br></p>"), 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "adoption_button",
                                               label = NULL,
                                               choiceNames = c("Current", "5%", "15%"),
                                               choiceValues = c("hp_current", "hp_5p", "hp_15p"),
                                               status = "custom", size = 'normal', justified = TRUE), width = NULL), 
                                         box(
                                           title = HTML("<b>Show absolute or relative numbers?</b>"),
                                           radioGroupButtons(
                                             inputId = "adoption_absolute",
                                             label = NULL,
                                             choiceNames = c("Absolute", "Relative"),
                                             choiceValues = c(TRUE, FALSE),
                                             status = "custom", size = 'normal', justified = TRUE), width = NULL),
                                         valueBoxOutput("heatingDaysBox", width = NULL),   
                                         valueBoxOutput("moneySavedBox", width = NULL),
                                         valueBoxOutput("co2SavedBox", width = NULL),
                                  ),
                                  column(width = 8,
                                         box(
                                           title = HTML("<b>Number of Heat Pumps Installed by Borough</b>"), solidHeader = TRUE,
                                           div(plotlyOutput("adop_proj_plot"), align = "center"), 
                                           width = NULL, 
                                           height = 700
                                         )
                                  )
                                )
                        ),
                        tabItem(tabName = "sub_feas",
                                fluidRow(
                                  column(width=4, 
                                         box(title = HTML("<b>Global Warming Projections</b>"), solidHeader = TRUE,
                                             HTML("<p>Toggle between current climate, and moderate and large increases in projected temperature<br></p>"), 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_climate",
                                               label = NULL,
                                               choiceNames = c("Current", "+1.5 °F", "+3 °F"),
                                               choiceValues = c("current", "mid", "high"),
                                               status = "custom", size = 'normal', justified = TRUE), width = NULL),
                                         box(
                                           title = HTML("<b>What is Percent of Heating Days Covered?</b>"),
                                           HTML("We assume heat pumps will be used when the temperature is between 65 °F and 5 °F. Heating days are all days where the daily average temperature is below 65 °F. So, we define"),
                                           withMathJax(helpText("% of Heating Days Covered = $$\\frac{\\text{No. of days below 65 °F but above 5 °F}}{\\text{Total no. of days below 65 °F}}$$")),
                                           width = NULL
                                         ),
                                         box(title = HTML("<b>Bottom-10 Boroughs by % of HDC</b>"), solidHeader = TRUE,
                                             plotlyOutput("borough_barplot_HeatingDays"), 
                                             width = NULL,
                                             height = 270
                                         )
                                  ),
                                  column(width = 8,
                                         box(
                                           title = HTML("<b>Average Percent of Heating Days Covered by Heat Pump by Borough</b>"), solidHeader = TRUE,
                                           div(plotlyOutput("borough_tilegram_HeatingDays"), align = "center"), 
                                           width = NULL, 
                                           height = 700,
                                         )
                                  )
                                )
                        ),
                        tabItem(tabName = "sub_ec",
                                fluidRow(
                                  column(width=4, 
                                         box(title = HTML("<b>Fuel Price Increase Projections</b>"), solidHeader = TRUE,
                                             HTML("<p>Toggle between annual fuel price (including electricity) escalation scenarios<br></p>"), 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_fuel",
                                               label = NULL,
                                               choiceNames = c("3% increase", "6% increase", "9% increase"),
                                               choiceValues = c("current", "mid", "high"),
                                               status = "custom", size = 'normal', justified = TRUE), 
                                             width = NULL),
                                         box(title = HTML("<b>Subsidy Projections</b>"), solidHeader = TRUE,
                                             HTML("<p>Toggle between scenarios with no, medium, or large subsidies (e.g., rebates, tax credits)<br></p>"), 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_rebate",
                                               label = NULL,
                                               choiceNames = c("None", "$2,000", "$4,000"),
                                               choiceValues = c("current", "mid", "high"),
                                               status = "custom", size = 'normal', justified = TRUE), 
                                             width = NULL),
                                         box(title = HTML("<b>What is Net Present Value (NPV)?</b>"), 
                                             width = NULL, 
                                             HTML("<b>Cost-effectiveness</b> is expressed as <b>Net Present Value</b>, or the sum of the benefits minus the costs of a project over the life of a project. For example, a NPV of 10k means that an average household in that borough will save $10k from installing a heat pump over the life of a heat pump (~14 years)"),
                                             collapsible = TRUE, collapsed = TRUE),
                                         box(title = HTML("<b>Top-10 Boroughs by average NPV</b>"), solidHeader = TRUE,
                                             plotlyOutput("borough_barplot_NPV"), 
                                             width = NULL,
                                             height = 270
                                         ),
                                         
                                  ),
                                  column(width = 8,
                                         box(
                                           title = HTML("<b>Average Cost Savings from Heat Pump Installation by Borough</b>"), solidHeader = TRUE,
                                           div(plotlyOutput("borough_tilegram_NPV"), align = "center"), 
                                           width = NULL, 
                                           height = 700,
                                         )
                                  )
                                )
                        ),
                        tabItem(tabName = "sub_env",
                                fluidRow(
                                  column(width = 4,
                                         box(title = HTML("<b>Converting units of CO2 reductions </b>"), solidHeader = TRUE,
                                             HTML("<p>Toggle between displaying CO2 reductions in pounds or in driving miles<br></p>"), 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_lbs_vs_miles",
                                               label = NULL,
                                               choiceNames = c("In pounds", "In driving miles"),
                                               choiceValues = c("CO2_lbs_saved", "CO2_driving_miles_saved"),
                                               status = "custom", size = 'normal', justified = TRUE), width = NULL),
                                         box(title = HTML("<b>All Boroughs ranked by CO2 reductions</b>"), solidHeader = TRUE,
                                             plotlyOutput("borough_barplot_CO2"), 
                                             width = NULL,
                                             height = 525
                                         )
                                  ),
                                  column(width = 8,
                                         box(
                                           title = HTML("<b>Average Carbon Dioxide Reductions from Heat Pump by Borough</b>"), solidHeader = TRUE,
                                           div(plotlyOutput("borough_tilegram_CO2"), align = "center"), 
                                           width = NULL, 
                                           height = 700,
                                         )
                                  )
                                )
                                
                        ),
                        tabItem(tabName = "case",
                                h2("Census block visualizations in progress")
                        ),
                        tabItem(tabName = "faq",
                                box(width = NULL, title = HTML("<b>Q: How was the current number of heat pumps in Alaska estimated?</b>"), HTML("<b>A</b>: We created a dataset of the current (2023) number of heat pumps estimated to be in Alaska by borough. This data was crowdsourced from energy/utility experts and Alaska Heat Smart. If we were unable to get estimates for a specific borough, we assumed there to be no heat pumps in that borough. The aim of this dataset was not to be as accurate as possible, but to capture the general distribution of heat pumps currently in Alaska and provide a starting point for the scenarios in which we imagine a larger percentage of the population has heat pumps.")),
                                box(width = NULL, title = HTML("<b>Q: How were heat pump adoption scenario projections structured and designed?</b>"), HTML("<b>A</b>: To imagine what heat pump distribution could look like across the state of Alaska, we needed an algorithm that allowed us to distribute heat pumps proportionally at the borough level. We believe that proportional distribution of heat pumps according to some measure is a more realistic scenario than equal distribution across all boroughs. The D’hondt method is an apportionment method developed to distribute seats in a legislative body proportionally to some measure, typically votes or population. Different apportionment methods have been developed because exact proportionally is often not possible due to the issue of fractional seats. These different methods have different properties, and empirical studies show that the D’hondt method is one of the least proportional apportionment methods, favoring large parties with the most votes. We determined that this property does not present concerns for our application, and may even be favorable. 
                                                                                                                                                           <br><br>We used the D’hondt method to distribute heat pumps by borough in Alaska according to heat pump efficiency (a proxy for feasibility) and population. We recognize that there are many factors that contribute to whether or not a heat pump is installed, but we believe the most important factor is feasibility, or how well a heat pump can actually heat a space. After all, if a heat pump cannot be used as a primary heating source, the motivation to install one greatly decreases. We also wanted to incorporate population to a lesser degree given economies of scale; we believe that boroughs with larger populations will have an easier time working with installers and maintainers. To combine these two factors into one measure, we used the following formula: $rank(efficiency) * rank(efficiency) * rank(population)$. This priorities efficiency over population and addresses the problem that the distribution of heat pump efficiency across the boroughs is uniform.")),
                                box(width = NULL, title = HTML("<b>Q: How are the feasibility, economic, and environmental estimates calculated? </b>"), HTML("<b>A<b/>: We derived estimates from the <a href='https://heatpump.cf/'>Heat Pump Calculator</a> developed by Alan Mitchell at Analysis North, simulating various scenarios by modifying variables such as “Fuel Escalation” and “Rebate amount.” We also adjusted the underlying temperature data to account for simple extrapolations of global warming. These estimates for single buildings were aggregated and scaled based on the number of households in each borough (from <a href='https://live.laborstats.alaska.gov/cen/maps-gis'>Census Data/Alaska's Department of Labor and Workforce Development</a>) and the percentage using different primary heating fuel sources (from <a href='https://data.census.gov/table?q=B25040:+HOUSE+HEATING+FUEL&tid=ACSDT1Y2021.B25040'>American Community Survey</a>). ")),
                                box(width = NULL, title = HTML("<b>Q: How were the “+1.5” and “+3.0” numbers determined for the climate change scenarios?</b>"), HTML("<b>A<b/>: These numbers provide two simple future scenarios for how climate might change over the lifetime of a heat pump. We used <a href='https://developers.google.com/earth-engine/datasets/catalog/ECMWF_ERA5_LAND_DAILY_AGGR'>the ERA-5 Land Daily Aggregate</a> dataset to compare the average temperature in each Alaskan borough from 1980-2009 with the temperature from 2010-2023. The difference in temperature over these two time periods ranged from 0.9 degrees F to 2.9 degrees F with the average just below 1.5 degrees F. Only three of the boroughs (Northwest Arctic Borough, North Slope Borough, and Nome Census Area) had a difference greater than 2 degrees F. Our choices of no change, +1.5 and +3.0 degrees Fahrenheit are simple extrapolations that show the difference between today’s climate, a climate that accelerates at the same rate it has been since 2010, and a doubled acceleration rate that is more reflective of the situation for the northernmost boroughs.  Our extrapolations are within the range proposed by other, more advanced <a href='https://www.pnas.org/doi/10.1073/pnas.2207183120'>research</a>.")),
                                box(width = NULL, title = HTML("<b>Q: How can I look at my specific neighborhood or house?</b>"), HTML("<b>A<b/>: This tool currently presents macro-trends at the Census Borough level only. If you are interested in evaluating the possible energy and cost savings from use of a heat pump in your Alaskan home or small building, we encourage you to explore the <a href='https://heatpump.cf/'>Heat Pump Calculator</a> tool. We believe that our “blueprint” for generating and visualizing Borough-level estimates can be easily expanded to explore heat pump feasibility and cost-effectiveness in smaller communities and neighborhoods, and hope that future work will extend the dashboard in this way. "))    
                        )
                      ),
                    )
)

## server
server <- function(input, output) {
  
  ## State-level adoption tilegram
  output$adop_proj_plot <- renderPlotly({
    
    vis_adopt_proj(input$adoption_button, absolute = input$adoption_absolute)
    
  })
  
  ## State-level aggregate outcomes
  output$moneySavedBox <- renderValueBox({
    
    money_saved <- 
      state_estimates_wide %>%
      filter(proj_rate == input$adoption_button) %>% 
      pull(NPV)
    
    valueBox(round(money_saved/10^6, 1), "Millions of $ Saved", 
             icon = icon("dollar-sign"), color = 'blue', width=NULL)
    
  })
  
  output$co2SavedBox <- renderValueBox({
    
    co2_saved <- 
      state_estimates_wide %>%
      filter(proj_rate == input$adoption_button) %>% 
      pull(CO2_lbs)
    
    valueBox(round(co2_saved/10^6, 1), "Millions lbs of CO2 Saved", 
             icon = icon("seedling"), color = 'green', width=NULL)
    
  })
  
  output$heatingDaysBox <- renderValueBox({
    
    heating_days_covered <- 
      state_estimates_wide %>%
      filter(proj_rate == input$adoption_button) %>% 
      pull(Heating_Days_Covered)
      
    valueBox(paste(round(heating_days_covered*100, 1), "%"), "of Heat Days Covered", 
             icon = icon("fire"), color = 'red', width=NULL)
    
  })
  
  
  output$state_barplot_adop <- renderPlotly({
    vis_state_barplot(proj_rate = input$adoption_button)  
    })
  
  
  ## Borough-level projections for NPV
  output$borough_tilegram_NPV <- renderPlotly({
    
    vis_borough_proj(outcome = "NPV", 
                     Rebate_dol = input$buttons_rebate, 
                     Fuel_Esc_Rate = input$buttons_fuel, 
                     Temp_Projection = input$buttons_climate)
    
  })
  
  output$borough_barplot_NPV <- renderPlotly({
    
    vis_borough_barplot(outcome = "NPV", 
                        Rebate_dol = input$buttons_rebate, 
                        Fuel_Esc_Rate = input$buttons_fuel, 
                        Temp_Projection = input$buttons_climate)
    
  })
  
  ## Borough-level projections for CO2
  output$borough_tilegram_CO2 <- renderPlotly({
    
    vis_borough_proj(outcome = input$buttons_lbs_vs_miles, 
                     Rebate_dol = input$buttons_rebate, 
                     Fuel_Esc_Rate = input$buttons_fuel, 
                     Temp_Projection = input$buttons_climate)
    
  })
  
  output$borough_barplot_CO2 <- renderPlotly({
    
    vis_borough_barplot(outcome = input$buttons_lbs_vs_miles, 
                        Rebate_dol = input$buttons_rebate, 
                        Fuel_Esc_Rate = input$buttons_fuel, 
                        Temp_Projection = input$buttons_climate)
    
  })
  
  ## Borough-level projections for Heating Days
  output$borough_tilegram_HeatingDays <- renderPlotly({
    
    vis_borough_proj(outcome = "Heating_Days_Covered", 
                     Rebate_dol = input$buttons_rebate, 
                     Fuel_Esc_Rate = input$buttons_fuel, 
                     Temp_Projection = input$buttons_climate)
    
  })
  
  output$borough_barplot_HeatingDays <- renderPlotly({
    
    vis_borough_barplot(outcome = "Heating_Days_Covered", 
                        Rebate_dol = input$buttons_rebate, 
                        Fuel_Esc_Rate = input$buttons_fuel, 
                        Temp_Projection = input$buttons_climate)
    
  })
  
}

## run app 
shinyApp(ui = ui, server = server)


