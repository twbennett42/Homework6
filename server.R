# server.R
library(shiny)
source("helpers.R")
counties <- readRDS("counties.rds")
library(maps)
library(mapproj)

shinyServer
(
  function(input, output){
    output$map <- renderPlot({
      
      data <- switch(input$var, 
                     "Percent White" = counties$white,
                     "Percent Black" = counties$black,
                     "Percent Hispanic" = counties$hispanic,
                     "Percent Asian" = counties$asian)
      
      color <- switch(input$var, 
                      "Percent White" = "red",
                      "Percent Black" = "blue",
                      "Percent Hispanic" = "green",
                      "Percent Asian" = "darkviolet")
      
      legend <- switch(input$var, 
                       "Percent White" = "Percent White",
                       "Percent Black" = "Percent Black",
                       "Percent Hispanic" = "Percent Hispanic",
                       "Percent Asian" = "Percent Asian")
      
      percent_map(var = data, 
                  color = color, 
                  legend.title = legend, 
                  max = input$range[2], 
                  min = input$range[1])
    })
  }
)
