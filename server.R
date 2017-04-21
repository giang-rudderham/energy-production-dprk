library(shiny)
library(rgdal) # for readOGR function
library(leaflet)
library(ggplot2) # for barplot
library(stringr) # for str_wrap function

# Version 3: allow choosing countries to display
###############################
#read data
productDPRK <- read.csv(file = "electricity-production-northkorea.csv", stringsAsFactors = F)
popDPRK <- read.csv(file = "population-northkorea.csv")

productSK <- read.csv(file = "electricity-production-southkorea.csv")
popSK <- read.csv(file = "population-southkorea.csv")

productUS <- read.csv(file = "electricity-production-us.csv")
popUS <- read.csv(file = "population-us.csv")

productChina <- read.csv(file = "electricity-production-china.csv")
popChina <- read.csv(file = "population-china.csv")

source("helpers.R")

# calculate data on electricity production per capita. Add a column for country names
pcDPRK <- cbind(country = "North Korea", perCapita(productDPRK, popDPRK))
pcSK <- cbind(country = "South Korea", perCapita(productSK, popSK))
pcUS <- cbind(country = "U.S.", perCapita(productUS, popUS))
pcChina <- cbind(country = "China", perCapita(productChina, popChina))

# merge data of all 4 countries
merged_data <- rbind(pcDPRK, pcChina, pcSK, pcUS)

shinyServer(function(input, output) {
  
  chosen_year <- reactive({
    paste0("X", input$year)
  })
  
  df_reactive <- eventReactive(input$checkGroup, {
    merged_data[merged_data$country %in% input$checkGroup, ]
  }) 
  
  output$bar <- renderPlot({
    ggplot(data = df_reactive(), aes(x = Fuel, y = df_reactive()[[chosen_year()]], fill = country)) +
      # position_dodge creates grouped bar plot instead of stacked bar plot
      geom_bar(stat = "identity", position = position_dodge(), width = 0.7) + 
      # specify colors for the "fill" variable earlier
      scale_fill_manual(values = c("North Korea" = "#ca0020", "South Korea" = "#92c5de",
                                   "China" = "#f4a582", "U.S." = "#0571b0")) +
      # wrap x var names
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
      # specify legend title, given by "fill" variable earlier
      labs(title = "Electricity Production (kWh) Per Capita by Fuel, 1990-2014",
           fill = "Country") +
      # make sure all plots for all years have the same y axis scale
      ylim(0, max(df_reactive()[ , 3:ncol(df_reactive())])) +
      theme_minimal() + 
      # remove x axis title, grid lines and y axis. Change x axis text and legend title to bold.
      theme(#axis.line.y = element_blank(),
        #axis.ticks.y = element_blank(),
        axis.title.y = element_blank(),
        #axis.text.y = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_text(face = "bold"),
        #panel.grid = element_blank(),
        legend.title = element_text(size = 12, face = "bold"))
    
  })

  
})
