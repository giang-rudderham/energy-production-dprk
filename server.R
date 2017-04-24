library(shiny)
library(rgdal) # for readOGR function
library(leaflet)
library(ggplot2) # for barplot
library(stringr) # for str_wrap function
library(plotly) # for renderPlotly

# version 5: modify v.4. to enable text when hovering on bar + panning + zoomming
# change renderPlot to renderPlotly and use ggplotly function after calling ggplot
#########################
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
  
  output$bar <- renderPlotly({
    # aes(..., text =...) and later ggplotly(p, tooltip = "text") specify the text appears when hovering on the bars.
    # default texts are x, y and fill
    # can also use aes(..., text = paste("Value:", ...)) 
    p <- ggplot(data = df_reactive(), aes(x = Fuel, y = df_reactive()[[chosen_year()]], fill = country, 
                                     text = df_reactive()[[chosen_year()]])) +
      # position_dodge creates grouped bar plot instead of stacked bar plot
      geom_bar(stat = "identity", position = position_dodge(), width = 0.7) + 
      # specify colors for the "fill" variable earlier
      scale_fill_manual(values = c("North Korea" = "#ca0020", "South Korea" = "#92c5de",
                                   "China" = "#f4a582", "U.S." = "#0571b0")) +
      # display y values on bars
      # geom_text(aes(label = df_reactive()[[chosen_year()]]), vjust = -0.3, size = 3, position = position_dodge(0.7)) + 
      
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
        axis.text.x = element_text(size = 13, face = "bold"),
        #panel.grid = element_blank(),
        legend.title = element_text(size = 14, face = "bold"),
        legend.text = element_text(size = 13),
        plot.title = element_text(size = 16, face = "bold")
      )
    
    ggplotly(p, tooltip = "text")
  })
  
})
