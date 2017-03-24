library(shiny)
library(rgdal) # for readOGR function
library(leaflet)
library(ggplot2) # for barplot
library(stringr) # for str_wrap function

#Version 1: make bar plots, animated
##############################

#read data
electricityProduction <- read.csv(file = "electricity-production-by-fuel.csv",
                                  stringsAsFactors = F)

shinyServer(function(input, output) {


  output$bar <- renderPlot({
    chosen_year <- paste0("X", input$year)
    ggplot(data = electricityProduction, aes(x = Fuel, y = electricityProduction[[chosen_year]])) +
      geom_bar(stat = "identity", fill = "steelblue") +
      geom_text(aes(label = electricityProduction[[chosen_year]]), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production by Fuel in DPRK, 1990-2014", y = "Electricity Production (GWh)") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, max(electricityProduction[ , 2:26])) #so that all bar plots have the same y axis
    
  })

  
})