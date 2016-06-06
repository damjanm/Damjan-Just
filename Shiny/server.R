library(shiny)
library(dplyr)
library(RPostgreSQL)
library(ggplot2)

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
  output$hist <- renderTable({filter(y,Date.Entered==input$date)
    
  })
  
})