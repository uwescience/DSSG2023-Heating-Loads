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
                        menuItem("Adoption Rate Projections", tabName = "statewide", icon = icon("chart-line")),
                        menuItem("Scenario Projections", tabName = "proj", icon = icon("money-bill"),
                                 menuSubItem("Economic", tabName = "sub_ec"),
                                 menuSubItem("Feasibility", tabName = "sub_feas"), 
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
                                         box(width = 6, title = HTML("<b>Navigating the Dashboard</b>"), HTML("In the <i>Adoption Rate Projections</i> tab, explore how current and project heat pump adoption numbers will affect state-wide metrics. In the <i>Scenario Projections</i> tab, explore how Boroughs across the state compare in heating feasibility, economic benefits, and carbon emission reduction.")),
                                         box(width = 12, title = HTML("<b>Interacting with Our Maps</b>"),
                                             HTML("Many of our visualizations are <b>tilegrams</b>. A tilegram, short for <i>tiled cartogram</i>, is a map made up of tiles where regions are proportional to a variable other than geographical space. In our plots, regions are Census Boroughs and they are proportional to the number of people in that Borough. Tilegrams can represent demographic data more accurately than traditional geographic maps, but still retain a familiar shape."),
                                             br(),
                                             br(),
                                             splitLayout(cellWidths = c("50%", "50%"), 
                                                         HTML('<center><b<i>Alaska in Traditional map</i><br><img src="ak_normalmap.png" width="95%"/></center>'), 
                                                         HTML('<center><i>Alaska in Tilegram</i><br><img src="ak_tilegram.png" width="95%"/></center>'))
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
                                         valueBoxOutput("moneySavedBox", width = NULL),
                                         valueBoxOutput("co2SavedBox", width = NULL),
                                         valueBoxOutput("heatingDaysBox", width = NULL), 
                                  ),
                                  column(width = 8,
                                         box(
                                           title = HTML("<b>Number of Heat Pumps Installed by Borough</b>"), solidHeader = TRUE,
                                           div(plotlyOutput("adop_proj_plot"), align = "center"), 
                                           width = NULL, 
                                           height = 680
                                         )
                                  )
                                )
                        ),
                        tabItem(tabName = "sub_ec",
                                fluidRow(
                                  column(width=4, 
                                         box(title = HTML("<b>Fuel Price Increase Projections</b>"), solidHeader = TRUE,
                                             HTML("<p>Toggle between current, medium and large fuel price escalation (annual increase) scenarios<br></p>"), 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_fuel",
                                               label = NULL,
                                               choiceNames = c("3% increase", "6% increase", "9% increase"),
                                               choiceValues = c("current", "mid", "high"),
                                               status = "custom", size = 'normal', justified = TRUE), 
                                             width = NULL),
                                         box(title = HTML("<b>Rebate Projections</b>"), solidHeader = TRUE,
                                             HTML("<p>Toggle between scenarios with no, medium, or large government rebates<br></p>"), 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_rebate",
                                               label = NULL,
                                               choiceNames = c("None", "$2,000", "$4,000"),
                                               choiceValues = c("current", "mid", "high"),
                                               status = "custom", size = 'normal', justified = TRUE), 
                                             width = NULL),
                                         box(title = HTML("<b>What is Net Present Value (NPV)?</b>"), 
                                             width = NULL, 
                                             HTML("<b>Cost-effectiveness</b> is expressed as <b>Net Present Value</b>, or the sum of the benefits minus the costs of a project over the life of a project. For example, a NPV value of 10K means that an average household in that borough will save $10k from installing a heat pump over the life of a heat pump (~14 years)"),
                                             collapsible = TRUE, collapsed = TRUE),
                                         box(title = HTML("<b>Top-10 Boroughs by average NPV</b>"), solidHeader = TRUE,
                                             plotlyOutput("borough_barplot_NPV"), 
                                             width = NULL,
                                             height = 279
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
                        tabItem(tabName = "sub_feas",
                                fluidRow(
                                  column(width=4, 
                                         box(title = HTML("<b>Global Warming Projections</b>"), solidHeader = TRUE,
                                             HTML("<p>Toggle between current climate conditions, and moderate and large increases in projected temperature<br></p>"), 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_climate",
                                               label = NULL,
                                               choiceNames = c("Current", "+1.5 °F", "+3 °F"),
                                               choiceValues = c("current", "mid", "high"),
                                               status = "custom", size = 'normal', justified = TRUE), width = NULL),
                                         box(
                                           title = HTML("<b>What are % of Heating Days Covered?</b>"),
                                           HTML("We consider a user turns on a heat pump when the daily average temperature is below 65 °F, but switchs it off if the it drops below 5 °F. So, "),
                                           withMathJax(helpText("% of Heating Days Covered = $$\\frac{\\text{No. of days below 65 °F but above 5 °F}}{\\text{Total no. of days below 65 °F}}$$")),
                                           width = NULL
                                         ),
                                         box(title = HTML("<b>Bottom-10 Boroughs by % of HDC</b>"), solidHeader = TRUE,
                                             plotlyOutput("borough_barplot_HeatingDays"), 
                                             width = NULL,
                                             height = 264
                                         )
                                  ),
                                  column(width = 8,
                                         box(
                                           title = HTML("<b>Average % of Heating Days Covered by Heat Pump by Borough</b>"), solidHeader = TRUE,
                                           div(plotlyOutput("borough_tilegram_HeatingDays"), align = "center"), 
                                           width = NULL, 
                                           height = 700,
                                         )
                                  )
                                )
                        ),
                        tabItem(tabName = "sub_env",
                                fluidRow(
                                  column(width = 4,
                                         box(title = HTML("<b>Converting CO2 saved units</b>"), solidHeader = TRUE,
                                             HTML("<p>Toggle between displaying CO2 saved in pounds or driving miles<br></p>"), 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_lbs_vs_miles",
                                               label = NULL,
                                               choiceNames = c("In pounds", "In driving miles"),
                                               choiceValues = c("CO2_lbs_saved", "CO2_driving_miles_saved"),
                                               status = "custom", size = 'normal', justified = TRUE), width = NULL),
                                         box(title = HTML("<b>All Boroughs ranked by CO2 saved</b>"), solidHeader = TRUE,
                                             plotlyOutput("borough_barplot_CO2"), 
                                             width = NULL,
                                             height = 520
                                         )
                                  ),
                                  column(width = 8,
                                         box(
                                           title = HTML("<b>Average Carbon Dioxide Saved from Heat Pump by Borough</b>"), solidHeader = TRUE,
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
    
    valueBox(round(co2_saved/10^6, 1), "Millions of lbs CO2 Saved", 
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
                     Rebate_dol = input$buttons_fuel, 
                     Fuel_Esc_Rate = input$buttons_rebate, 
                     Temp_Projection = input$buttons_climate)
    
  })
  
  output$borough_barplot_NPV <- renderPlotly({
    
    vis_borough_barplot(outcome = "NPV", 
                        Rebate_dol = input$buttons_fuel, 
                        Fuel_Esc_Rate = input$buttons_rebate, 
                        Temp_Projection = input$buttons_climate)
    
  })
  
  ## Borough-level projections for CO2
  output$borough_tilegram_CO2 <- renderPlotly({
    
    vis_borough_proj(outcome = input$buttons_lbs_vs_miles, 
                     Rebate_dol = input$buttons_fuel, 
                     Fuel_Esc_Rate = input$buttons_rebate, 
                     Temp_Projection = input$buttons_climate)
    
  })
  
  output$borough_barplot_CO2 <- renderPlotly({
    
    vis_borough_barplot(outcome = input$buttons_lbs_vs_miles, 
                        Rebate_dol = input$buttons_fuel, 
                        Fuel_Esc_Rate = input$buttons_rebate, 
                        Temp_Projection = input$buttons_climate)
    
  })
  
  ## Borough-level projections for Heating Days
  output$borough_tilegram_HeatingDays <- renderPlotly({
    
    vis_borough_proj(outcome = "Heating_Days_Covered", 
                     Rebate_dol = input$buttons_fuel, 
                     Fuel_Esc_Rate = input$buttons_rebate, 
                     Temp_Projection = input$buttons_climate)
    
  })
  
  output$borough_barplot_HeatingDays <- renderPlotly({
    
    vis_borough_barplot(outcome = "Heating_Days_Covered", 
                        Rebate_dol = input$buttons_fuel, 
                        Fuel_Esc_Rate = input$buttons_rebate, 
                        Temp_Projection = input$buttons_climate)
    
  })
  
}

## run app 
shinyApp(ui = ui, server = server)


