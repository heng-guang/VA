library(shiny)
library(tidyverse)
library(plotly)

exam <- read.csv("data/Exam_data.csv")

ui <- fluidPage(
  titlePanel("Subject Correlation Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "yvar",
                  label = "y Variable",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "MATHS"),
      selectInput(inputId = "xvar",
                  label = "x Variable",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "ENGLISH"),
    ),
    mainPanel(
      plotlyOutput("scatterPlot")
    )
  )


)


server <- function(input, output) {
  output$scatterPlot <- renderPlotly({
    p1 <- ggplot(data = exam,
           aes_string(y = input$yvar,
                      x = input$xvar)) +
      geom_point()
    ggplotly(p1)
  })
}




shinyApp(ui = ui, server = server)
