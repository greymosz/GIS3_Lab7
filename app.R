# Lab 7 - R Shiny App

library(shiny)
library(leaflet)
library(tidyverse)
setwd("~/Documents/University of Chicago/Fourth Year/GIS III/Final")

# Load Data ----
aa <- read_sf("aa.gpkg")


ui <- fluidPage(
  titlePanel("Anti-Air Events in Ukraine"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Anti-Air by Month"),
      radioButtons("month", "Incident Month", 
                   choices = list("February" = 1, "March" = 2, "April" = 3))
    ), 
    
    mainPanel(
      leafletOutput(outputId = "mymap")
    )
  )
)

server <- function(input, output) {
  
  output$mymap <- renderLeaflet({
    leaflet(aa) %>% addTiles() %>% addMarkers()
  })
  
}

shinyApp(ui, server)
