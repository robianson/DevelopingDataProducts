#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)
mydata <- read.csv('data/Filtered Seattle Energy Data.csv') 

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$map <- renderLeaflet({

        # generate top 10 data based on user input property type
        top10 <- filter(mydata,PrimaryPropertyType==input$proptype)
        df <- data.frame(lat=top10$Latitude,lng=top10$Longitude)
        extras <- data.frame(energy=top10$SiteEnergyUse.kBtu., 
                             site = paste('<p>',top10$PropertyName,'</p>'),
                             type = as.factor(top10$PrimaryPropertyType))
        my_map <- df %>% 
            leaflet() %>% 
            addTiles() %>%
            addCircleMarkers(weight = 1, radius = sqrt(extras$energy) / 600,popup = extras$site)
        
    })
    output$propType <- renderText({ 
        paste('Top 10 ',input$proptype,' Energy Users in Seattle')
    })

})
