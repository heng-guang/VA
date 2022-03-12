library(shiny)
library(tidyverse)
library(plotly)

exam <- read.csv("data/Exam_data.csv")

ui <- fluidPage(
  titlePanel("Multi-pages Layout"),
  tabsetPanel(
    tabPanel("Import data", 
             fileInput("file", "Data", 
                       buttonLabel = "Upload..."),
             textInput("delim", 
                       "Delimiter (leave blank to guess)",
                       ""),
             numericInput("skip", "Rows to skip", 
                          0, min = 0),
             numericInput("rows", "Rows to preview", 
                          10, min = 1)
    ),
    tabPanel("Variable Selection"),
    tabPanel("Model Calibration"),
    tabPanel("Model Evaluation")
  )
)


server <- function(input, output) {

}




shinyApp(ui = ui, server = server)
