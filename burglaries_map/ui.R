#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
bootstrapPage(
    theme = shinythemes::shinytheme('simplex'),
    leaflet::leafletOutput('map', width = '100%' , height = '100%'),
    absolutePanel(top = 10, right = 10, id = 'controls',
                   sliderInput('victims', 'Victim Number', 1, 11, 1), 
                   sliderInput('offense_number', 'Offense Number', 1, 5, 1), 
                   dateRangeInput('date_range', 'Select Date', "2023-01-01", "2023-12-31"),
                   selectInput("incident_status_description", 
                        label = h3("Select Incident Status Description"),  # h3 is level 3 header
                        choices = c("All", Burglaries2023 |> distinct(incident_status_description) |> pull() |> sort()),
                        selected = "All"),
                   selectInput("victim_description", 
                              label = h3("Select Victim Description"),  # h3 is level 3 header
                              choices = c("All", Burglaries2023 |> distinct(victim_description) |> pull() |> sort()),
                              selected = "All")
                  ),
                   # CODE BELOW: Add an action button named show_about
        #           actionButton( 'show_about', 'About')
                   tags$style(type = "text/css", "
                      html, body {width:100%;height:100%}
                      #controls{background-color:white;padding:20px;}
                      ")
                    ) 

                   
      













      
      
    # Application title
   # titlePanel("Burglaries Data"),
# 
#     # Sidebar with a slider input for number of bins
#     sidebarLayout(
#         sidebarPanel(
#             sliderInput("bins",
#                         "Number of bins:",
#                         min = 1,
#                         max = 50,
#                         value = 30),
#             
#             selectInput("island", 
#                         label = h3("Select an Island"),  # h3 is level 3 header
#                         choices = c("All", penguins |> distinct(island) |>  pull() |> sort()), 
#                         selected = 1)
#         ),
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#             plotOutput("distPlot")
#         )
#     )
# )
# 
# 
