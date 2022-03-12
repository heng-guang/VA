library(shiny)
library(tidyverse)
library(tools)

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
      textInput(
        inputId = "plot_title",
        label = "Plot Title",
        placeholder = "Enter text to be used as plot title"),
      actionButton(inputId = "goButton", 
                   label = "Go!")
    ),
    mainPanel(
      plotOutput("scatterPlot")
    )
  )


)


server <- function(input, output) {
  output$scatterPlot <- renderPlot({
    input$goButton
    ggplot(data = exam,
           aes_string(y = input$yvar,
                      x = input$xvar)) +
      geom_point() +
      labs(title = isolate({
        toTitleCase(input$plot_title)}),
        caption = paste0(input$xvar, " vs ", input$yvar)
      )
  })
}

shinyApp(ui = ui, server = server)
