library(shiny)
library(leaflet)

# Version 3: bar plots of productions of 4 countries
shinyUI(navbarPage("Comparison of Energy Production in 4 Countries", id = "nav",
                   
                   tabPanel("Bar Plot",
                            div(class = "outer",
                                fluidRow(
                                  column(6,
                                         plotOutput("barDPRK", height = 275),
                                         br(),
                                         br()),
                                  column(6,
                                         plotOutput("barSK", height = 275),
                                         br(),
                                         br())
                                ) ,
                                
                                fluidRow(
                                  column(6,
                                         plotOutput("barUS", height = 275),
                                         br(),
                                         br()) ,
                                  column(6,
                                         plotOutput("barChina", height = 275),
                                         br(),
                                         br())
                                ) ,
                                
                                fluidRow(
                                  column(3, 
                                         checkboxGroupInput("checkGroup", 
                                                            label = "Choose countries to display", 
                                                            choices = list("DPRK" = 1, 
                                                                          "South Korea" = 2, 
                                                                          "U.S." = 3,
                                                                          "China" = 4),
                                                            selected = 1
                                                )),
                                  column(9, 
                                         sliderInput("yearProduction", "Choose a year:",
                                                     min = 1990, max = 2014, value = 2014,
                                                     animate = TRUE, sep = "")
                                  )
                                ),
                                
                                tags$div(id = "cite",
                                         strong("Data source:"),
                                         tags$em("International Energy Agency (http://www.iea.org/statistics/) and 
                                                 World Development Indicators (data.worldbank.org).",
                                                 "Please send questions and comments to author Giang Rudderham (giang.rudderham@gmail.com)")
                                )
                                )
                            )
                   )
)
