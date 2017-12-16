ui <- fluidPage(
  
  titlePanel(h4("Application Shiny",align="center")),
  
  fixedRow(
    #On créer une liste déroulante qui s'appelle "patient"
    
    
    sidebarPanel(
    selectInput("patient", "selectionnez un patient", listeT),
    br(),
    actionButton("voirPatients", "Voir tous les patients")
    
  ),
  
 

# Main panel for displaying outputs ----
mainPanel(
  
  # Output: Tabset w/ plot, summary, and table ----
  tabsetPanel(type = "tabs",
              
              tabPanel("Table", tableOutput("table")),
              tabPanel("Plot", plotOutput("plot"))
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
  
  observeEvent(input$voirPatients, {
    hide("resultPatient")
    output$test <- DT::renderDataTable(patients %>% select(title, organism))
  })
  
  
}

shinyApp(ui = ui, server = server)