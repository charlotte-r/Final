

#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(spData)
library(dplyr)
library(sf)
library(rgdal)
library(spDataLarge)
library(raster)
library(ggplot2)

COL_i <- shapefile("COL_i.shp")

# Define UI for application that draws a histogram
ui <- fluidPage(


  # Application title
  titlePanel("Traffic Crashes In Chicago"),
  hr(),
  fluidRow(
    column(3,
           numericInput("fatalities",
                        label = "Fatalities: (Red)",
                        min = 1,
                        max = 3,
                        value = 1,
                        step = 1)
    ),
    column(4,
           sliderInput("hour",
                       "Hour: (Black)",
                       min = 0,
                       max = 24,
                       value = 12,
                       step = 1,
                       sep= "")
    )
  ),
  # Sidebar


  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Maps",
               fluidRow(
                 helpText("Collisions 2015- May 2019 resulting in at least one reported injury.
                          Data Source: Chicago Data Portal. Adjust the slider to see crashes by hour and view
                          fatal crashes by number of fatalities. Switch tabs to see plots."),
                 column(6,
                        leafletOutput("map2")
                 ),
                 column(6,
                        leafletOutput("map")
                 )
               ) ),
      tabPanel("Plots", plotOutput("speed"), plotOutput("month")))

  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {

  myicon <- makeIcon(
    iconUrl = "http://pngimg.com/uploads/dot/dot_PNG33.png",
    iconWidth = 6, iconHeight = 6,
    iconAnchorX = 22, iconAnchorY = 94)

  myicon2 <- makeIcon(
    iconUrl = "https://png.pngtree.com/svg/20170331/92e8cc0f9c.svg",
    iconWidth = 6, iconHeight = 6,
    iconAnchorX = 22, iconAnchorY = 94)
  COL_i <- st_as_sf(COL_i)
  COL_i <- st_transform(COL_i, 4326)

  output$map <- renderLeaflet({
    filter(COL_i, crash_hour == input$hour) %>%  # subset by hour
      leaflet() %>%
      addTiles() %>%
      setView(-87.6293, 41.9094, zoom=10) %>%
      addMarkers(icon=myicon)
  })

  output$map2 <- renderLeaflet({
    filter(COL_i, injuries_f >= input$fatalities) %>%
      leaflet() %>%
      addTiles() %>%
      setView(-87.6293, 41.9094, zoom=10) %>%
      addMarkers(icon=myicon2)

  })

  output$speed <- renderPlot({
    COL_k <- filter(COL_i, posted_spe > 0)
    ggplot(COL_k, aes(posted_spe, injuries_t))+
      geom_jitter()+
      labs(title = "Speed versus injuries", x="Posted Speed Limit", y = "Total injuries")
  })

  output$month <- renderPlot({
    ggplot(COL_i, aes(x=crash_mont))+
      geom_bar(fill="blue", color="black", alpha=0.5)+
      labs(title = "Count by Month", x="Month")+
      scale_x_discrete("Month", limits=c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" ))
  })

}

# Run the application
shinyApp(ui = ui, server = server)

