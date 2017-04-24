library(shiny)
library(leaflet)
library(plotly) # for plotlyOutput

# version 5: modify v.4. to enable text when hovering on bar + panning + zoomming
# change plotOutput to plotlyOutput
#########################
shinyUI(navbarPage("Comparison of Energy Production in 4 Countries", id = "nav",
                   
                   tabPanel("Bar Plot",
                            div(class = "outer",
                                fluidRow(
                                  plotlyOutput("bar")
                                ) ,
                                
                                hr(),
                                
                                fluidRow(
                                  column(3, 
                                         checkboxGroupInput("checkGroup", 
                                                            label = "Choose countries to display:", 
                                                            # left side are values to display to users
                                                            # right side are values sent to input$checkGroup
                                                            choices = list("North Korea" = "North Korea", 
                                                                           "China" = "China",
                                                                           "South Korea" = "South Korea", 
                                                                           "U.S." = "U.S."
                                                            ),
                                                            selected = "North Korea")
                                  ),
                                  column(9, 
                                         sliderInput("year", "Choose a year:",
                                                     min = 1990, max = 2014, value = 2014,
                                                     animate = TRUE, sep = "")
                                  )
                                ) ,
                                
                                hr(),
                                
                                
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
