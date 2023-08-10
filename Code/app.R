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
  "shinyWidgets"
)

## source functional R scripts
source('make_tilegram.R')
source('vis_state_data.R')

## UI
ui <- dashboardPage(skin = "blue",
                    dashboardHeader(title = HTML("<b>Heat Pump Adoption in Alaska: A Visualization Tool</b>"), titleWidth = 540),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Motivation", tabName = "motivation", icon = icon("file")),      
                        menuItem("Adoption Rate Projections", tabName = "statewide", icon = icon("chart-line")),
                        menuItem("Projections", tabName = "proj", icon = icon("money-bill"),
                                 menuSubItem("Feasibility", tabName = "sub_feas"), 
                                 menuSubItem("Economic", tabName = "sub_ec"),
                                 menuSubItem("Environmental", tabName = "sub_env")),
                        menuItem("Case Studies", tabName = "case", icon = icon("map-marker"))
                      )
                    ),
                    dashboardBody(
                      # Boxes need to be put in a row (or column)
                      tabItems(
                        tabItem(tabName = "motivation",
                                fluidRow(
                                  column(width = 12,
                                         titlePanel("Guide to Exploring the Visualizations on this Dashboard"),
                                         box(title = HTML(" Many of our visualizations are <b>Tilegrams</b>"),
                                             width = NULL,
                                             HTML("A Tilegram, short for <i>Tiled Cartogram</i>, is a map made up of tiles where regions are proportional to a dataset. In our plots, regions are Census Boroughs and they are proportional to the number of people in that Borough. Tilegrams can represent demographic data more accurately than traditional geographic maps, but still retain a familiar shape. You can read more about tilegrams here <insert a link?>")),
                                         imageOutput("image"))
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
                                               choices = c("Current", "Medium", "Large"),
                                               status = "primary", size = 'normal', justified = TRUE), width = NULL),
                                         box(title = HTML("<b>Rebate Projections</b>"), solidHeader = TRUE,
                                             "Toggle between currently provided rebates, moderate increases in projected rebates, and large increases in projected rebates", 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_rebate",
                                               label = "Level of increase:",
                                               choices = c("Current", "Medium", "Large"),
                                               status = "primary", size = 'normal', justified = TRUE), width = NULL),
                                         box(title = HTML("<b>Climate Change Projections</b>"), solidHeader = TRUE,
                                             "Toggle between current climate conditions, moderate increases in projected temperature increases, and large increases in projected temperature increases", 
                                             ticks = FALSE, radioGroupButtons(
                                               inputId = "buttons_climate",
                                               label = "Level of increase:",
                                               choices = c("Current", "Medium", "Large"),
                                               status = "primary", size = 'normal', justified = TRUE), width = NULL),
                                  ),
                                  column(width = 8,
                                         plotlyOutput("plot2", height = 615),
                                         box(title = HTML("<b>What is Net Present Value?</b>"), 
                                             HTML("<b>Cost-effectiveness</b> is expressed as <b>Net Present Value</b>, or the sum of the benefits minus the costs of a project over the life of a project. For example, a NPV value of 10K means that an average household in that borough will save $10k from installing a heat pump over the life of a heat pump (~14 years)"),
                                             collapsible = TRUE, collapsed = TRUE)
                                  )
                                )
                        ),
                        tabItem(tabName = "sub_env",
                                plotlyOutput("plot3")
                        ),
                        tabItem(tabName = "case",
                                h2("Census block visualizations in progress")
                        )
                      ),
                    )
)

## server
server <- function(input, output) {
  
  output$adop_proj_plot <- renderPlotly({
    vis_adopt_proj(input$adoption_button)
  })
  
  
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
  
  
  
}







## run app 
shinyApp(ui = ui, server = server)


