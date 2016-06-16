

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Iskalec pesmi"),
  tabsetPanel(
    tabPanel(
      sidebarLayout(
    
    # Sidebar with a slider input
    sidebarPanel(
      dateInput("date",
                  "Izberi datum:",
                  min = NULL,
                  max = NULL,
                  format = "d/m/yyyy",
                  value = NULL)
  
      #dateInput("b",
                #"Izberi datum:",
                #min = NULL,
                #max = NULL,
                #value = NULL)
      
      ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      tableOutput("hist")
    )  
  )
)


  
  
)


))




