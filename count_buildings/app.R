library(shiny)
library("EBImage")
library(glue)
library(shinyjs)
library(shinycssloaders)
library(magrittr)
# library("Bioconductor")

# Define UI for data upload app ----
ui <- fluidPage(# App title ----
                titlePanel(Sys.Date()),
                
                # Sidebar layout with input and output definitions ----
                sidebarLayout(
                    # Sidebar panel for inputs ----
                    sidebarPanel(
                        # Input: Select a file ----
                        fileInput(
                            "file1",
                            "Upload Google Map Screen Shot",
                            multiple = FALSE,
                            accept = c(".PNG", ".png", "JPG", "JPEG"),
                            placeholder = "Google Maps Screen Shot",
                            buttonLabel = "Browse..."
                        ),
                        
                        # Horizontal line ----
                        tags$hr(),
                        sliderInput(
                            "ImageofBuildingThreshol",
                            label = "Adjust Threshold for better Results",
                            min = 0.6,
                            max = 0.8,
                            step = 0.01,
                            value = 0.61
                        ),
                        tags$hr(),
                        actionButton(
                            "calc",
                            "Calculate",
                            icon = icon("calculator"),
                            class = "btn btn-success"
                        )
                        
                    ),
                    
                    # Main panel for displaying outputs ----
                    mainPanel(
                        titlePanel("Buildings in the Area"),
                        textOutput("buildings_count"),
                        tags$hr(),
                        displayOutput("img") %>%
                            withSpinner()
                        
                    )
                    
                ))

# Define server logic to read selected file ----
server <- function(input, output) {
    output$img <- renderDisplay({
        req(input$file1)
        tryCatch({
            city_image = readImage(input$file1$datapath)
            display(city_image)
            
        },
        error = function(e) {
            # return a safeError if a parsing error occurs
            stop(safeError(e))
        })
    })
    
    
    observeEvent(input$calc, {
        req(input$file1)
        tryCatch({
            city_image = readImage(input$file1$datapath)
            ImageofBuildingThreshol <- input$ImageofBuildingThreshol
            city_image_threshold <-
                city_image > ImageofBuildingThreshol
            building_count <- bwlabel(city_image_threshold)
            b_count_max <- max(building_count)
            # b_count_min <- min(building_count)
            # display(city_image)
            output$img <- renderDisplay({
                display(city_image_threshold)
            })
            output$buildings_count <- renderText({
                glue::glue("Approximatly ", {
                    b_count_max
                })
                # max(b_count_min)
            })
            
        },
        error = function(e) {
            # return a safeError if a parsing error occurs
            stop(safeError(e))
        })
    })
    
}

# Create Shiny app ----
shinyApp(ui, server)