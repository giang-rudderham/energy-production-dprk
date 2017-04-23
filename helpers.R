library(RColorBrewer) # for colorRampPalette

# function to calculate electricity production per capita
# df1 has electricity production, df2 has population data

perCapita <- function(df1, df2){
  # reorder df2 so that columns in two data frames match
  df2 <- df2[ , ncol(df2) : 1]
  
  # get the only row in df2 as vector (column vector by default)
  vec <- as.numeric(df2[1, ])
  
  # get only numeric columns in df1
  df1Num <- df1[-1]
  
  # calculate production (in kWh) per capita
  df3 <- t(t(df1Num) * 1000000 / vec)
  
  # round to 1 decimal place
  df3 <- round(df3, 1)
  
  # put the first column back
  df3 <- cbind(df1[1], df3)
  
  df3
}

# function to build palettes with arbitrary number of colors, based on 8 colors of palette Set1
get_palette <- colorRampPalette(brewer.pal(8, "Set1"))
