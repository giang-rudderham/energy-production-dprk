library(shiny)
library(rgdal) # for readOGR function
library(leaflet)
library(ggplot2) # for barplot
library(stringr) # for str_wrap function

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

source("helpers.R")

# calculate data on electricity production per capita
pcDPRK <- perCapita(productDPRK, popDPRK)
pcSK <- perCapita(productSK, popSK)
pcUS <- perCapita(productUS, popUS)
pcChina <- perCapita(productChina, popChina)

shinyServer(function(input, output) {
  
  chosen_year <- reactive({
    paste0("X", input$yearProduction)
  })
  
  output$barDPRK <- renderPlot({
    #chosen_year <- paste0("X", input$yearProduction)
  
    ggplot(data = pcDPRK, aes(x = Fuel, y = pcDPRK[[chosen_year()]])) +
      geom_bar(stat = "identity", fill = "#8c564b") +
      geom_text(aes(label = pcDPRK[[chosen_year()]]), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production Per Capita by Fuel in DPRK, 1990-2014", 
           y = "Electricity Production (kWh) Per Capita") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, 8000) #so that all bar plots have the same y axis
      
  })
  
  output$barSK <- renderPlot({
    #chosen_year <- paste0("X", input$yearProduction)
    
    ggplot(data = pcSK, aes(x = Fuel, y = pcSK[[chosen_year()]])) +
      geom_bar(stat = "identity", fill = "#595959") +
      geom_text(aes(label = pcSK[[chosen_year()]]), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production Per Capita by Fuel in South Korea, 1990-2014", 
           y = "Electricity Production (kWh) Per capita") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, 8000) #so that all bar plots have the same y axis
  })
  
  output$barUS <- renderPlot({
    #chosen_year <- paste0("X", input$yearProduction)
    
    ggplot(data = pcUS, aes(x = Fuel, y = pcUS[[chosen_year()]])) +
      geom_bar(stat = "identity", fill = "#006ba4") +
      geom_text(aes(label = pcUS[[chosen_year()]]), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production Per Capita by Fuel in the U.S., 1990-2014", 
           y = "Electricity Production (kWh) Per capita") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, 8000) #so that all bar plots have the same y axis
  })
  
  output$barChina <- renderPlot({
    #chosen_year <- paste0("X", input$yearProduction)
    
    ggplot(data = pcChina, aes(x = Fuel, y = pcChina[[chosen_year()]])) +
      geom_bar(stat = "identity", fill = "#c85200") +
      geom_text(aes(label = pcChina[[chosen_year()]]), vjust = -0.3, size = 3.5) + #display y values on bars
      labs(title = "Electricity Production Per Capita by Fuel in China, 1990-2014", 
           y = "Electricity Production (kWh) Per capita") +
      theme_minimal() +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) + #wrap x var names
      ylim(0, 8000) #so that all bar plots have the same y axis
  })
  
})
