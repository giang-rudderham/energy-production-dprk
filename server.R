library(shiny)
library(rgdal) # for readOGR function
library(leaflet)
library(ggplot2) # for barplot
library(stringr) # for str_wrap function

#Version 1: make bar plots, animated
##############################

#read data
productDPRK <- read.csv(file = "electricity-production-northkorea.csv",
                                  stringsAsFactors = F)
popDPRK <- read.csv(file = "population-northkorea.csv")

productSK <- read.csv(file = "electricity-production-southkorea.csv")
popSK <- read.csv(file = "population-southkorea.csv")

shinyServer(function(input, output) {

  output$barDPRK <- renderPlot({
    chosen_year <- paste0("X", input$year)
    
    ## change to production (in kWh) per capita
    productDPRK$kwhPerCapita = productDPRK[[chosen_year]] * 1000000 / popDPRK[[chosen_year]]
    ## round to 2 decimal places
    productDPRK$kwhPerCapita = round(productDPRK$kwhPerCapita, 2)
    
    ggplot(data = productDPRK, aes(x = Fuel, y = kwhPerCapita)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      geom_text(aes(label = productDPRK$kwhPerCapita), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production Per Capita by Fuel in DPRK, 1990-2014", 
           y = "Electricity Production (kWh) Per Capita") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, 5000) #so that all bar plots have the same y axis
    
  })

  output$barSK <- renderPlot({
    chosen_year <- paste0("X", input$year)
    
    ## change to production (in kWh) per capita
    productSK$kwhPerCapita = productSK[[chosen_year]] * 1000000 / popSK[[chosen_year]]
    ## round to 2 decimal places
    productSK$kwhPerCapita = round(productSK$kwhPerCapita, 2)
    
    
    ggplot(data = productSK, aes(x = Fuel, y = kwhPerCapita)) +
      geom_bar(stat = "identity", fill = "green") +
      geom_text(aes(label = productSK$kwhPerCapita), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production Per Capita by Fuel in South Korea, 1990-2014", 
           y = "Electricity Production (kWh) Per capita") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, 5000) #so that all bar plots have the same y axis
    
  })
  
})