#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

  plot_data_func <- reactive({
    
    plot_data <- Burglaries2023
    
    if (input$incident_status_description != "All"){
      plot_data <- plot_data |> 
        filter(incident_status_description == input$incident_status_description)
    }
    
    if (input$victim_description != "All"){
      plot_data <- plot_data |> 
        filter(victim_description == input$victim_description)
    }
    
    plot_data <- plot_data |> 
      filter(
        incident_occurred_date >= input$date_range[1], incident_occurred_date <= input$date_range[2], victim_number >= input$victims, offense_number >= input$offense_number, 
      )
    
    return(plot_data)
    
  })
   
  output$map <- leaflet::renderLeaflet({
     
    plot_data_func() |> leaflet()  |> 
    setView( -86.52, 36.20, zoom = 10)  |> 
    addTiles()   |>  
  addCircleMarkers(
    label = ~ weapon_description, popup = ~ as.character(incident_number), radius = ~ sqrt(victim_number)*3,    
    fillColor = 'red', color = 'red', weight = 5
   )
                                      })
                                    } 







# 
# output$distPlot <- renderPlot({
#   
#   plot_data <- Burglaries2023
#   
#   if (input$investigation_status != "All"){
#     plot_data <- plot_data |> 
#       filter(investigation_status == input$investigation_status)
#     
#     #    title <- glue("Distribution of Body Mass for {input$island} Island")
#   }
#   
#   plot_data |> 
#     ggplot(aes(x=body_mass_g)) +
#     geom_histogram(bins = input$bins) +
#     labs(
#       title = "Distribution of Body Mass",
#       x = "body mass (g)"
#     )
#   



  # generate bins based on input$bins from ui.R
  # x    <- faithful[, 2]
  # bins <- seq(min(x), max(x), length.out = input$bins + 1)
  # 
  # # draw the histogram with the specified number of bins
  # hist(x, breaks = bins, col = 'darkgray', border = 'white',
  #      xlab = 'Waiting time to next eruption (in mins)',
  #      main = 'Histogram of waiting times')
  
# })
# 
# }

