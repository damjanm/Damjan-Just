library(reshape2)
library(dplyr)

billboard <- read.csv("Podatki/lestvica.csv",header=TRUE,sep=";", fileEncoding = "Windows-1252")
billboard <- billboard[,1:125] # sicer je veliko praznih stolpcev
billboard$Date.Entered<-as.Date(billboard$Date.Entered, "%d/%m/%Y") #spremenil sem v datume


#Stolpci v razpredelnici ki so shranjeni kot Factor, jih spremenimo v character:
indx <- sapply(billboard, is.factor)
billboard[indx] <- lapply(billboard[indx], function(x) ifelse(!is.na(x),as.character(x),x))

colnames(billboard)[4] <- "id"
billboard[,4] <- 1:nrow(billboard)


pesmi <- billboard[,c("id","Track","Album", "Year","Media","Time","Date.Entered","Genre","CH")]
pesmi$Media <- sapply(pesmi$Media, function(x) ifelse(x %in% c("45s", "10\"", "12", "45","EP-12","45m","44","45m*", "45m/s","78","45/78","78/45m","LP/EP"), "LP/EP", x))
pesmi$Media <- sapply(pesmi$Media, function(x) ifelse(x %in% c("SC","CS/45","CS/45s","CSM","45/CS","C S","45s/CS"),"CS",x))
pesmi$Media <- sapply(pesmi$Media, function(x) ifelse(x %in% c("DVD","PCD","12/CD","CDM","CD/12","CD/CS","CS/CD","CD/45s"),"CD",x))
pesmi$Media <- sapply(pesmi$Media, function(x) ifelse(x %in% c("DD","CD","CS","LP/EP"),x,NA))
pesmi$CH<-as.numeric(pesmi$CH)
pesmi$CH <- sapply(pesmi$CH, function(x) ifelse(x == 0,NA,x))
pesmi$Genre <- sapply(pesmi$Genre, function(x) ifelse(x == "",NA,x))
                                                      
glasbeniki <- billboard[,c("id","Artist","Featured","UnFeatured","Written.By")] 

#Tabelo, kjer hranimo uvrstitev:
ranks <- data.frame(id = 1:nrow(billboard), billboard[35:125]) %>%  melt("id", variable.name = "week", value.name = "rank")
ranks$week <- as.numeric(ranks$week)


#Nekateri vrednosti so v cudni obliki, npr B12, namesto 12. Tega popravimo.
ranks$rank <- sapply(ranks$rank, function(x) ifelse("B" == strsplit(x,"")[[1]][1],strsplit(x,"B")[[1]][2],x))
ranks$rank <- as.numeric(ranks$rank)

ranks$rank[ranks$rank %in% c(""," ","?")] <- NA

as.Date(billboard$Date.Entered, "%d/%m/%Y")

# write.table(pesmi,file="Podatki/pesmi.csv",sep=";")
# write.table(glasbeniki,file="Podatki/glasbeniki.csv",sep=";")
# write.table(ranks,file="Podatki/ranks.csv",sep=";")

############urejanje glasbeniki###########################
sezglas<-billboard$Artist[duplicated(billboard$Artist)==FALSE]
m<-data.frame(sezglas)

urej<-function(x){
  c<-billboard$Artist==x
return(pesmi$id[c])}

#seznam idjev, ne vem kako to popraviti

c<-lapply(m$sezglas,function(x) urej(x))
m$id<-c

billboard$CH<-as.numeric(billboard$CH)
leto<-c(1890:2016)
povprecja<-data.frame(leto)
povprecja$pov<-lapply(povprecja$leto, function(x) mean(billboard$CH[billboard$Year==x]))
