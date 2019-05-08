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

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Occupational Data"),

    # Sidebar with a slider input to choose an order by field 
    sidebarLayout(
        sidebarPanel(
            selectInput("orderby",
                        "Order by:",
                        factor(names(occ_data)))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            DT::renderDataTable(occ_data)
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$dataTableOutput <- DT::renderDataTable({
        occ_data
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
