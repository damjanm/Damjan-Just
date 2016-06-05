library(shiny)

ui<-fluidPage(dateInput(inputId="date", label = "Izberi si datum, ki te zanima", value = NULL, min = NULL, max = NULL), 
              tableOutput("hist"))#plotoutput(doda mesto za plot)
              #input functions (poglej si)

server<-function(input, output){
  output$hist<-renderTable({filter(billboard,Date.Entered=="date"))})
                           #hist(rnorm(input$num), main=title)})
}

shinyApp(ui=ui, server = server)