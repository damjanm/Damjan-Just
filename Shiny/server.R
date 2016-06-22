library(shiny)
library(dplyr)
library(RPostgreSQL)
library(ggplot2)


if ("server.R" %in% dir()) {
  setwd("..")
}
source("auth.R",encoding='UTF-8')


shinyServer(function(input,output){
  
  output$hist<-renderPlot({barplot(table(pesmi$Media[pesmi$Year==input$leto]),main="Medij na katerem je bila pesem izdana", 
                                   xlab="Medij",col=c("blue","red"))
                           })
  #################################################################################################################
  
  
  output$bla<-renderPlot({
                          leto<-c(input$leto1:input$leto2)
                          povprecja<-data.frame(leto)
                          povprecja$pov<-lapply(povprecja$leto, function(x) mean(billboard$CH[billboard$Year==x]))
                          povprecja$pov<-unlist(povprecja$pov)
                          qplot(x=povprecja$leto, y=povprecja$pov,geom="smooth", method="lm", formula=y~x,ylab="koliko tedno v povprecju je pesem ostala na lestvici", xlab="leto")
                          })
  ##################################################################################################################
  output$heh<-renderPlot({ c<-data.frame(table(billboard$Year[billboard$Genre==input$zvrst]))
                           plot(x=c$Var1, y=c$Freq,xlab="leto",ylab="število pesmi")})
  ##################################################################################################################
  output$mah<-renderPlot({d<-data.frame(table(billboard$Year[billboard$CH==input$stt]))
                          plot(x=d$Var1,y=d$Freq,xlab="leto", ylab="število pesmi")})
})