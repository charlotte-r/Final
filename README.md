# Chicago Collisions Shiny App

## Purpose
This app allows users to interact with data featuring collisions in the city of Chicago. The goal of this project is to allow users to visualize dangerous streets and patterns of serious accidents. The Vision Zero project has the goal of reducing pedestrian fatalities, through changing street architecture and reducing the danger of particular “high risk corridors.” 
## Methods
This app uses data from the Chicago Data Portal. The data were filtered to select only crashes with reported injuries, to serve as a proxy for serious accidents. To do this, rows with NA injuries were removed. Many of the NA rows were from hit-and-run crashes, where the injury of the driver or passengers is unknown. Filtering by crashes with injuries narrowed the dataset to about 35,000 crashes. These more serious crashes show a spatial distribution of more dangerous areas, times, and roads. When preparing the data, the choice of columns dictated the relationships and correlations I wished to explore visually. I decided to focus on some strong factors of traffic collisions including month, to capture possible effect of icy weather, hour of collision, to capture risk of night driving, and posted speed limit, to visualize the results of speed. The latitude and longitude of the crash were also included. 
## App Details
The app contains two interactive map in one tab and two static plots in another. The interactive maps are controlled by drop down menus and a slider to view the distribution of fatalities and crash hour, respectively.
The static plots asses the relationship of posted speed limit and crash month to the number of accidents. 
## To use this app
### This app is live at https://charlotte-r.shinyapps.io/Collisions/
To alter the app and run it locally.
Download the zip file and open it.
Set the working directory to the downloaded folder. Run the app.
## Directions for improvement
Projection issues causing some points to be displayed over the lake to be corrected.
Secondly, an apparent limitation of shiny is the inability to pin sidebar pieces to separate tabs, making the sidebar appear even with the static plots. This can be overcome by using shiny dashboard, or similar add ons, but the different syntax for these packages requires a complete overahul of the app.
