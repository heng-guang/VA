library(shiny)
library(tidyverse)
library(plotly)

exam <- read.csv("data/Exam_data.csv")

ui <- fluidPage(
  navlistPanel(
    id = "tabset",
    "Data Preparation",
    tabPanel("Data Import", 
             "View table"),
    tabPanel("Data transformation", 
             "Output table"),
    "IDEA",
    tabPanel("Univariate analysis", 
             "Distribution plot"),
    tabPanel("Bivariate analysis", 
             "Correlation matrix")
  )
)


server <- function(input, output) {

}




shinyApp(ui = ui, server = server)
