# Occupational Data Shiny App
# 2019 05 08 12:40 pm
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(dplyr)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Occupational Data"),

    # Sidebar with a slider input to choose an order by field 
    sidebarLayout(
        sidebarPanel(
            selectInput("filterby",
                        "Filter by:",
                        c("Line item","Summary"),selected = "Line item"),
            width = 3
        ),

        # Show a plot of the generated distribution
        mainPanel(
            DT::dataTableOutput("occupationalData")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$occupationalData = DT::renderDataTable({
        occ_data %>% filter(occ_type == input$filterby)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
