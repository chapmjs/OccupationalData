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
# library(readxl)


# occ_data <- read_excel("~/R/OccupationalData/Occupational-Data.xlsx")
# occ_data <- read_excel("Occupational-Data.xlsx")
occ_data <- read.csv("Occupational-Data.csv", header = TRUE, stringsAsFactors = TRUE)

# remove extra column (this import method results in extra column)
occ_data <- occ_data[-c(14)]

# rename column names
names.col <- c("occupation","occ_code","occ_type","2014employment","2024employment","numIncrease","perInc","selfEmpl","growRep","medWage","entryEd","exper","ojt")
names(occ_data) <- names.col

# remove extra rows - only include line item rows
occ_data_li <- occ_data %>% filter(occ_type == "Line item")

# get factors of EntryEd for filter
# levels(factor(occ_data_li$entryEd))
entryEdList <- levels(factor(occ_data$entryEd,ordered = TRUE, levels = c(
                            "No formal educational credential", 
                            "High school diploma or equivalent", 
                            "Some college, no degree", 
                            "Postsecondary nondegree award", 
                            "Associate's degree",
                            "Bachelor's degree",
                            "Master's degree",
                            "Doctoral or professional degree")))


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Occupational Data"),

    # Sidebar with a slider input to choose an order by field 
    sidebarLayout(
        sidebarPanel(
            selectInput("entryEdFilter",
                        "Select Entry Education:",
                        choices = c("",entryEdList),
                        selected = ""),
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
        if (input$entryEdFilter == "") {
            occ_data_li %>% arrange(occ_code) 
        }
        else {
        occ_data_li %>% filter(entryEd == input$entryEdFilter) %>% arrange(occ_code)
        }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
