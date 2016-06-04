library(reshape2)
library(dplyr)

billboard <- read.csv("Podatki/lestvica.csv",header=TRUE,sep=";", fileEncoding = "Windows-1252")
billboard <- billboard[,1:125] # sicer je veliko praznih stolpcev

#Stolpci v razpredelnici ki so shranjeni kot Factor, jih spremenimo v character:
indx <- sapply(billboard, is.factor)
billboard[indx] <- lapply(billboard[indx], function(x) ifelse(!is.na(x),as.character(x),x))

colnames(billboard)[4] <- "id"
billboard[,4] <- 1:nrow(billboard)


pesmi <- billboard[,c("id","Track","Album", "Year","Media","Time","Date.Entered")]

glasbeniki <- billboard[,c("id","Artist","Featured","UnFeatured","Written.By")] 

#Tabelo, kjer hranimo uvrstitev:
ranks <- data.frame(id = 1:nrow(billboard), billboard[35:125]) %>%  melt("id", variable.name = "week", value.name = "rank")
ranks$week <- as.numeric(ranks$week)


#Nekateri vrednosti so v cudni obliki, npr B12, namesto 12. Tega popravimo.
ranks$rank <- sapply(ranks$rank, function(x) ifelse("B" == strsplit(x,"")[[1]][1],strsplit(x,"B")[[1]][2],x))
ranks$rank <- as.numeric(ranks$rank)

ranks$rank[ranks$rank %in% c(""," ","?")] <- NA

# write.table(pesmi,file="Podatki/pesmi.csv",sep=";")
# write.table(glasbeniki,file="Podatki/glasbeniki.csv",sep=";")
# write.table(ranks,file="Podatki/ranks.csv",sep=";")