#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(leaflet)

mydata <- read.csv('data/Filtered Seattle Energy Data.csv') 
mydata$PrimaryPropertyType <- as.factor(mydata$PrimaryPropertyType)
# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Seattle Energy Usage Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("proptype", "Select Property Type:", 
                        choices=levels(mydata$PrimaryPropertyType),selected='High-Rise Multifamily'),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h4(textOutput('propType')),
            leafletOutput("map")
        )
    )
))
