ui <- fluidPage(
  
  title= "Application - Test",
  
  fixedRow(
    #On créer une liste déroulante qui s'appelle "patient"
    selectInput("patient", "selectionnez un patient", listeT),
    actionButton("voirPatients", "Voir tous les patients")
  ),
  
  fixedRow(
    #On créer un tableau qui contiendra nos résultats
    DT::dataTableOutput("resultPatient"),
    DT::dataTableOutput("test")
  )
)

server <- function(input, output) {
  
  #On complète la liste déroulante avec les patients.
  #output$table <- DT::renderDataTable(
   # getPatient(input$patient), options = list(lengthChange = FALSE)
  #)
  
  # Dans output$resultPaitent on va mettre un tableau.
  # getPatient retournera notre tableau.
  output$resultPatient <- DT::renderDataTable(
    getPatient(input$patient)
  )
  
  observeEvent(input$voirPatients, {
    hide("resultPatient")
    output$test <- DT::renderDataTable(Patients %>% select(title, organism))
  })
  
  
}

shinyApp(ui = ui, server = server)