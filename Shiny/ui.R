

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Iskalec pesmi"),
  
  sidebarLayout(
    
    # Sidebar with a slider input
    sidebarPanel(
      dateInput("date",
                  "Izberi datum:",
                  min = NULL,
                  max = NULL,
                  value = NULL)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tableOutput("hist")
    )
  )
))





#shinyUI(
 # fluidPage(
  #  (dateInput(inputId="date", label = "Izberi si datum, ki te zanima", value = NULL, min = NULL, max = NULL) 
   #  tableOutput("hist")))
  
  
  #shinyUI(
    
    # Use a fluid Bootstrap layout
    #fluidPage(    
      
      # Give the page a title
      #titlePanel("Companies by type"),
      
      # Generate a row with a sidebar
      #sidebarLayout(      
        
        # Define the sidebar with one input
       # sidebarPanel(
        #  selectInput("type", "Type:", 
                      #choices=c("All", "Energy","Finance","Technology")),
         # hr(),
          #helpText("Izbira tipa.")
        #),
        
        # Create a spot for the barplot
        #mainPanel(
         # plotOutput("company")  
        #)
        
      #)
    #)
  #)
  