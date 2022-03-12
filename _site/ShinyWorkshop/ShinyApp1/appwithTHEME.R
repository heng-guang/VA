library(shiny)
library(tidyverse)
library(bslib)
library(rsconnect)


thematic::thematic_shiny()

exam <- read_csv("data/Exam_data.csv")

ui <- fluidPage(
#  theme = bs_theme(version = 4, bootswatch = "flatly"),
#  theme = bs_theme(bg = "#0b3d91",
#                   fg = "white",
#                   primary = "#FCC780",
#                   base_font = font_google("Roboto"),
#                   code_font = font_google("Roboto")),
  titlePanel("Pupils Examination Results Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "variable",
                  label = "Subject:",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "ENGLISH"),
      sliderInput(inputId = "bins",
                  label = "Number of Bins",
                  min = 5,
                  max = 20,
                  value = 10),
      checkboxInput(inputId = "show_data",
                    label = "Show data table",
                    value = TRUE)
    ),
    mainPanel(
      plotOutput("distPlot"),
      DT::dataTableOutput(outputId = "examtable")
    )
  )
)

server <- function(input, output){
  output$distPlot <- renderPlot({
    x <- unlist(exam[,input$variable])
    
    ggplot(exam, aes_string("x")) + 
      geom_histogram(bins = input$bins,
                     color = "black",
                     fill = "light blue") +
      labs(x = input$variable,
           y = "Number of Students",
           Title = "Distribution of Scores")
  })
  
  output$examtable <- DT::renderDataTable({
    if(input$show_data){
      DT::datatable(data = exam %>% select(1:7),
                    options = list(pageLength = 10),
                    rownames = FALSE)
    }
  })
  
}

shinyApp(ui=ui, server=server)