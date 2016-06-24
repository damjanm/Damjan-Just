library(shiny)
library(dplyr)
library(RPostgreSQL)
library(ggplot2)


if ("server.R" %in% dir()) {
  setwd("..")
}
source("auth.R",encoding='UTF-8')


shinyServer(function(input,output){
  conn <- src_postgres(dbname = db, host = host,
                       user = user, password = password)
  pes <- (tbl(conn, "pesmi"))
  glas <-(tbl(conn, "glasbeniki"))
  ran <-(tbl(conn, "ranks"))
  
  output$hist<-renderPlot({a<-filter(pes,year==input$leto)
                           pesmi<-data.frame(a)
                           barplot(table(pesmi$media),main="Medij na katerem je bila pesem izdana", 
                                   xlab="Medij",col=c("blue","red"))
                           })
  #################################################################################################################
  
  
  output$bla<-renderPlot({
                          b<-filter(pes,year<=input$leto2 & year>=input$leto1)
                          pesm<-data.frame(b)
                          leta<-c(input$leto1:input$leto2)
                          povprecja<-data.frame(leta)
                          povprecja$pov<-lapply(povprecja$leta, function(x) mean(pesm$ch[pesm$year==x]))
                          povprecja$pov<-unlist(povprecja$pov)
                          qplot(x=povprecja$leta, y=povprecja$pov,geom="smooth", method="lm", formula=y~x,ylab="koliko tedno v povprecju je pesem ostala na lestvici", xlab="leto")
                          })
  ##################################################################################################################
  output$heh<-renderPlot({a<-filter(pes,genre==input$zvrst)
                          b<-data.frame(a)
                          c<-data.frame(table((b$year)))
                           plot(x=c$Var1, y=c$Freq,xlab="leto",ylab="število pesmi")})
  ##################################################################################################################
  output$mah<-renderPlot({e<-filter(pes,ch==input$stt)
                          f<-data.frame(e)
                          d<-data.frame(table(f$year))
                          plot(x=d$Var1,y=d$Freq,xlab="leto", ylab="število pesmi")})
})