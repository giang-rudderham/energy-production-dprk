library(shiny)
library(rgdal) # for readOGR function
library(leaflet)
library(ggplot2) # for barplot
library(stringr) # for str_wrap function

# Version 2: electricity production of 4 countries
###############################
#read data
productDPRK <- read.csv(file = "electricity-production-northkorea.csv",
                        stringsAsFactors = F)
popDPRK <- read.csv(file = "population-northkorea.csv")

productSK <- read.csv(file = "electricity-production-southkorea.csv")
popSK <- read.csv(file = "population-southkorea.csv")

productUS <- read.csv(file = "electricity-production-us.csv")
popUS <- read.csv(file = "population-us.csv")

productChina <- read.csv(file = "electricity-production-china.csv")
popChina <- read.csv(file = "population-china.csv")

shinyServer(function(input, output) {
  
  output$barDPRK <- renderPlot({
    chosen_year <- paste0("X", input$yearProduction)
    
    ## change to production (in kWh) per capita
    productDPRK$kwhPerCapita = productDPRK[[chosen_year]] * 1000000 / popDPRK[[chosen_year]]
    ## round to 2 decimal places
    productDPRK$kwhPerCapita = round(productDPRK$kwhPerCapita, 2)
    
    ggplot(data = productDPRK, aes(x = Fuel, y = kwhPerCapita)) +
      geom_bar(stat = "identity", fill = "#8c564b") +
      geom_text(aes(label = productDPRK$kwhPerCapita), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production Per Capita by Fuel in DPRK, 1990-2014", 
           y = "Electricity Production (kWh) Per Capita") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, 8000) #so that all bar plots have the same y axis
    
  })
  
  output$barSK <- renderPlot({
    chosen_year <- paste0("X", input$yearProduction)
    
    ## change to production (in kWh) per capita
    productSK$kwhPerCapita = productSK[[chosen_year]] * 1000000 / popSK[[chosen_year]]
    ## round to 2 decimal places
    productSK$kwhPerCapita = round(productSK$kwhPerCapita, 2)
    
    
    ggplot(data = productSK, aes(x = Fuel, y = kwhPerCapita)) +
      geom_bar(stat = "identity", fill = "#595959") +
      geom_text(aes(label = productSK$kwhPerCapita), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production Per Capita by Fuel in South Korea, 1990-2014", 
           y = "Electricity Production (kWh) Per capita") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, 8000) #so that all bar plots have the same y axis
  })
  
  output$barUS <- renderPlot({
    chosen_year <- paste0("X", input$yearProduction)
    
    ## change to production (in kWh) per capita
    productUS$kwhPerCapita = productUS[[chosen_year]] * 1000000 / popUS[[chosen_year]]
    ## round to 2 decimal places
    productUS$kwhPerCapita = round(productUS$kwhPerCapita, 2)
    
    
    ggplot(data = productUS, aes(x = Fuel, y = kwhPerCapita)) +
      geom_bar(stat = "identity", fill = "#006ba4") +
      geom_text(aes(label = productUS$kwhPerCapita), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production Per Capita by Fuel in the U.S., 1990-2014", 
           y = "Electricity Production (kWh) Per capita") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, 8000) #so that all bar plots have the same y axis
  })
  
  output$barChina <- renderPlot({
    chosen_year <- paste0("X", input$yearProduction)
    
    ## change to production (in kWh) per capita
    productChina$kwhPerCapita = productChina[[chosen_year]] * 1000000 / popChina[[chosen_year]]
    ## round to 2 decimal places
    productChina$kwhPerCapita = round(productChina$kwhPerCapita, 2)
    
    
    ggplot(data = productChina, aes(x = Fuel, y = kwhPerCapita)) +
      geom_bar(stat = "identity", fill = "#c85200") +
      geom_text(aes(label = productChina$kwhPerCapita), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production Per Capita by Fuel in China, 1990-2014", 
           y = "Electricity Production (kWh) Per capita") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, 8000) #so that all bar plots have the same y axis
  })
  
})
#Version 1: electricity production and growth
##############################

# #read data
# productDPRK <- read.csv(file = "electricity-production-northkorea.csv",
#                                   stringsAsFactors = F)
# popDPRK <- read.csv(file = "population-northkorea.csv")
# growthDPRK <- read.csv(file = "growth-electricity-production-dprk.csv")
# 
# productSK <- read.csv(file = "electricity-production-southkorea.csv")
# popSK <- read.csv(file = "population-southkorea.csv")
# growthSK <- read.csv(file = "growth-electricity-production-sk.csv")
# 
# shinyServer(function(input, output) {
# 
#   output$barDPRK <- renderPlot({
#     chosen_year <- paste0("X", input$yearProduction)
#     
#     ## change to production (in kWh) per capita
#     productDPRK$kwhPerCapita = productDPRK[[chosen_year]] * 1000000 / popDPRK[[chosen_year]]
#     ## round to 2 decimal places
#     productDPRK$kwhPerCapita = round(productDPRK$kwhPerCapita, 2)
#     
#     ggplot(data = productDPRK, aes(x = Fuel, y = kwhPerCapita)) +
#       geom_bar(stat = "identity", fill = "steelblue") +
#       geom_text(aes(label = productDPRK$kwhPerCapita), vjust = -0.3, size = 3.5) + #display y values on bars
#       labs(title = "Electricity Production Per Capita by Fuel in DPRK, 1990-2014", 
#            y = "Electricity Production (kWh) Per Capita") +
#       theme_minimal() +
#       scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
#       ylim(0, 5000) #so that all bar plots have the same y axis
#     
#   })
# 
#   output$barSK <- renderPlot({
#     chosen_year <- paste0("X", input$yearProduction)
#     
#     ## change to production (in kWh) per capita
#     productSK$kwhPerCapita = productSK[[chosen_year]] * 1000000 / popSK[[chosen_year]]
#     ## round to 2 decimal places
#     productSK$kwhPerCapita = round(productSK$kwhPerCapita, 2)
#     
#     
#     ggplot(data = productSK, aes(x = Fuel, y = kwhPerCapita)) +
#       geom_bar(stat = "identity", fill = "green") +
#       geom_text(aes(label = productSK$kwhPerCapita), vjust = -0.3, size = 3.5) + #display y values on bars
#       labs(title = "Electricity Production Per Capita by Fuel in South Korea, 1990-2014", 
#            y = "Electricity Production (kWh) Per capita") +
#       theme_minimal() +
#       scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
#       ylim(0, 5000) #so that all bar plots have the same y axis
#   })
#   
#   output$growthDPRK <- renderPlot({
#     chosen_year <- paste0("X", input$yearGrowth)
#     
#     ## change to growth in kWh per capita
#     growthDPRK$growthPerCapita = growthDPRK[[chosen_year]] * 1000000 / popDPRK[[chosen_year]]
#     ## round to 2 decimal places
#     growthDPRK$growthPerCapita = round(growthDPRK$growthPerCapita, 2)
#     
#     ggplot(data = growthDPRK, aes(x = Fuel, y = growthPerCapita)) +
#       geom_bar(stat = "identity", fill = "steelblue") +
#       geom_text(aes(label = growthDPRK$growthPerCapita), vjust = -0.3, size = 3.5) + #display y values on bars
#       labs(title = "Growth in Electricity Production Per Capita by Fuel in North Korea, 1991-2014", 
#            y = "Growth in Electricity Production (kWh) Per capita") +
#       theme_minimal() +
#       scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
#       ylim(-700, 700) #so that all bar plots have the same y axis
#   })
#   
#   output$growthSK <- renderPlot({
#     chosen_year <- paste0("X", input$yearGrowth)
#     
#     ## change to growth in kWh per capita
#     growthSK$growthPerCapita = growthSK[[chosen_year]] * 1000000 / popSK[[chosen_year]]
#     ## round to 2 decimal places
#     growthSK$growthPerCapita = round(growthSK$growthPerCapita, 2)
#     
#     ggplot(data = growthSK, aes(x = Fuel, y = growthPerCapita)) +
#       geom_bar(stat = "identity", fill = "green") +
#       geom_text(aes(label = growthSK$growthPerCapita), vjust = -0.3, size = 3.5) + #display y values on bars
#       labs(title = "Growth in Electricity Production Per Capita by Fuel in South Korea, 1991-2014", 
#            y = "Growth in Electricity Production (kWh) Per capita") +
#       theme_minimal() +
#       scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
#       ylim(-700, 700) #so that all bar plots have the same y axis
#   })
#   
# })