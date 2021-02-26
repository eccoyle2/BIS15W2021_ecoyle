if (!require("tidyverse")) install.packages('tidyverse')



library(tidyverse)
library(shiny)
library(shinydashboard)
library(naniar)
library(janitor)



UC_admit <- readr::read_csv("data/UC_admit.csv")%>%
  clean_names()

UC_admit$academic_yr<-as.character(UC_admit$academic_yr)

ui <- dashboardPage(
  dashboardHeader(title = "UC Ethnic Information"),
  dashboardSidebar(disable = T),
  dashboardBody(
    fluidRow(
      box(title = "Plot Options", width = 3,
          selectInput("x", "Select Admission details", choices = c("campus", "academic_yr", "category"), 
                      selected = "campus"),
          hr(),
          helpText("Source: (https://www.universityofcalifornia.edu/infocenter). Admissions data were collected for the years 2010-2019 for each UC campus.")
      ),
      box(title = "Ethnicity", width = 6,
          plotOutput("plot", width = "600px", height = "500px")
      ) 
    )
  )
)

server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
    UC_admit %>% 
      ggplot(aes_string(x = input$x,y="filtered_count_fr",fill="ethnicity"))+
      geom_col(position = "dodge")+
      scale_fill_brewer(palette = "Set1")+
      theme_light(base_size = 18)+
      theme(axis.text.x = element_text(angle = 60, hjust = 1))+
      labs(title = "UC Admission Information",x=NULL,y="Number of Indivicuals")
  })
  
  
  session$onSessionEnded(stopApp)
}
shinyApp(ui, server)