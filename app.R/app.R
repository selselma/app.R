library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)
library(shinydashboard)
library(gplots)

ui <- fluidPage(
  
  titlePanel(h4("Application Shiny",align="center")),
  
  fixedRow(
    #On créer une liste déroulante qui s'appelle "patient"
    
    
    sidebarPanel(
    selectInput("patient", "selectionnez un patient", patients$title),
    br(),
    actionButton("voirPatients", "Voir tous les patients")
    
  ),
  
 

# Main panel for displaying outputs ----
mainPanel(
  
  # Output: Tabset w/ plot, summary, and table ----
  tabsetPanel(type = "tabs",
              
              tabPanel("Table", tableOutput("table")),
              tabPanel("Plot", plotOutput("Plot"))
  )
  
),
fixedRow(
  #On créer un tableau qui contiendra nos résultats
  DT::dataTableOutput("test")
)


)
)


server <- function(input, output) {
  
  #On complète la liste déroulante avec les patients.
  #output$table <- DT::renderDataTable(
   # getPatient(input$patient), options = list(lengthChange = FALSE)
  #)
  
  # Dans output$resultPaitent on va mettre un tableau.
  # getPatient retournera notre tableau.
  output$table <- renderTable({
    getPatient(input$patient)
  })
  output$Plot <- renderPlot({
    p1a= ggplot(patients, aes(x=characteristics.tag.tumor.size.maximumdiameter, y=characteristics.tag.grade))
    p2c=p1a+geom_point(aes(col=characteristics.tag.gender))
    plot(p2c)
  })
  
  observeEvent(input$voirPatients, {
   
    output$test <- DT::renderDataTable(patients %>% select(title, organism, CEL.file, characteristics.tag.histology))
  })
  
  
}

shinyApp(ui = ui, server = server)