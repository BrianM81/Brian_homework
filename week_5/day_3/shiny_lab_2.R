#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#2 Create two sets of radio buttons, one with ID “season” the other with ID “medal”, that lets you pick between the two seasons and the three medal types.
library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinythemes)

ui <- fluidPage(
    theme = shinytheme("cyborg"),
    titlePanel("Five Country Medal Comparison"),
    
    fluidRow(
     #Splitting radio buttons across half the screen   
        column(6,
            radioButtons("season",
                         "Summer or Winter Olympics?",
                         choices = c("Summer", "Winter")
            )
        ),
          column(6, 
            radioButtons("medal",
                         "Compare Which Medals?",
                         choices = c("Gold", "Silver", "Bronze")
            )
          ),
        
        #Creating a link to the Olympics website below
        tabPanel("Link to Olympics site",
                 
                 tags$a("The Olympics website",
                        href = "https://www.olympic.org/"),
    
            plotOutput("medal_plot")
        )
    )
,
)

server <- function(input, output) {
    
    
    output$medal_plot <- renderPlot({
        olympics_overall_medals %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(medal == input$medal) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = team, y = count, fill = team) +
            geom_col()
        
        
    })
}

shinyApp(ui = ui, server = server)



