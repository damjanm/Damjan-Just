library(shiny)
library(dplyr)
library(RPostgreSQL)


if ("server.R" %in% dir()) {
  setwd("..")
}
source("auth.R",encoding='UTF-8')

# library(datasets)

# Define a server for the Shiny app
shinyServer(function(input, output) {
  conn <- src_postgres(dbname = db, host = host,
                       user = user, password = password)
  y <- data.frame(tbl(conn, "pesmi"))
  y$dateentered<-as.Date(y$dateentered,"%d/%m/%Y")
  output$hist <- renderTable({filter(y,dateentered==as.Date(input$date,"%d/%m/%Y"))
    
  })
  
})