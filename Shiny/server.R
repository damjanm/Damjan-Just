library(shiny)
library(dplyr)
library(RPostgreSQL)
library(ggplot2)
library(chron)


if ("server.R" %in% dir()) {
  setwd("..")
}
source("auth_public.r",encoding='UTF-8')


shinyServer(function(input,output){
  conn <- src_postgres(dbname = db, host = host,
                       user = user, password = password)
  pes <- (tbl(conn, "pesmi"))
  glas <-(tbl(conn, "glasbeniki"))
  ran <-(tbl(conn, "ranks"))
  output$hist<-renderPlot({a<-filter(pes,year==input$leto)
                           pesmi<-data.frame(a)
                           k<-data.frame(table(c(pesmi$media,"DD","LP/EP","CD",NA, "CS")))
                           k$Freq<-k$Freq-c(1,1,1,1)
                           barplot(k$Freq,names.arg=k$Var1, main="Medij na katerem je bila pesem izdana",
                                   col=c("blue","red"))
                           })
  #################################################################################################################
  
  
  output$bla<-renderPlot({b<-filter(pes, year>=input$leto1[1], year<=input$leto1[2])
                          pesm<-data.frame(b)
                          leta<-c(input$leto1[1]:input$leto1[2])
                          povprecja<-data.frame(leta)
                          povprecja$pov<-lapply(povprecja$leta, function(x) mean(pesm$ch[pesm$year==x]))
                          povprecja$pov<-unlist(povprecja$pov)
                          qplot(x=povprecja$leta, y=povprecja$pov,geom="smooth", method="lm", formula=y~x,ylab="koliko tedno v povprecju je pesem ostala na lestvici", xlab="leto")
                          })
  ##################################################################################################################
  output$heh<-renderPlot({a <-filter(pes,genre==input$zvrst) %>% group_by(year) %>%
                          summarise(Freq = n()) %>% data.frame()
                          validate(need(nrow(a) > 0, "Izberi zvrst!"))
                          plot(x=a$year, y=a$Freq,xlab="leto",ylab="število pesmi")})
  ##################################################################################################################
  output$mah<-renderPlot({e<-filter(pes,ch==input$stt)
                          f<-data.frame(e)
                          d<-data.frame(table(f$year))
                          plot(x=d$Var1,y=d$Freq,type="l",xlab="leto", ylab="število pesmi")})
  ##################################################################################################################
  output$dolz<-renderPlot({time1 <- filter(pes,ch <= input$povp_dolz)
                          time <- data.frame(time1)
                          time$time_1 <- sapply(strsplit(time$time,":"),
                                  function(x) {
                                    if(is.character(x)){
                                      x <- as.numeric(x)
                                      x[1]+x[2]/60
                                  }})
                          povp <- sapply(1944:2016, function(x){
                              mean(time$time_1[time$year == x],na.rm=TRUE) })
                          
                          # povp_1 <- sapply(povp, function(x){
                          #   paste(trunc(x), 60*(x - trunc(x)),sep=":")
                          # })
                          plot(1944:2016,povp,type="l",xlab="Leto",ylab="Povprečna dolžina pesmi (v minutah)")
                          #tt <- seq(times("00:00:00"), times("00:09:59"), times("00:00:10"))
                          #axis(2, tt, sub(":00$", "", times(tt)))
                            })
})

#"DD"    "LP/EP" "CD"    NA      "CS"