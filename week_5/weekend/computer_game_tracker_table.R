#Code for sshiny code for creating table

#Check out what the data looks like first
head(game_sales)
tail(game_sales)
dim(game_sales)
names(game_sales)
# Define UI for application that shows data of computer games
ui <- fluidPage(
  theme = shinytheme("darkly"),
  
  # Application title
  titlePanel(tags$b("Computer game tracker")),
  
  # Tabset panel
  fluidRow(
    column(3,
           selectInput("genre",
                       "Which genre?",
                       choices = unique(game_sales$genre))
    ),
    
    column(3,
           selectInput("year_of_release",
                       "Which year?",
                       choices = unique(game_sales$year_of_release))
    ),
    
    column(3,
           selectInput("sales",
                       "Total sales?",
                       choices = unique(game_sales$sales))  
    ),
    
    column(3,
           selectInput("platform",
                       "Which platform?",
                       choices = unique(game_sales$platform))
    ) 
  ),
  
  
  
  tableOutput("game_table")
  
)

# Server section
server <- function(input, output) {
  
  output$game_table <- renderTable({
    # generate table
    game_sales %>%
      filter(genre == input$genre) %>%
      filter(year_of_release == input$year_of_release) %>%
      filter(sales == input$sales) %>%
      filter(platform == input$platform)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
