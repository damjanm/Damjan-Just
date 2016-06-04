billboard <- read.csv("Podatki/lestvica.csv",header=TRUE,sep=";", fileEncoding = "Windows-1252")
billboard <- billboard[,1:125] # sicer je veliko praznih stolpcev

#Stolpci v razpredelnici ki so shranjeni kot Factor, jih spremenimo v character:
indx <- sapply(billboard, is.factor)
billboard[indx] <- lapply(billboard[indx], function(x) ifelse(!is.na(x),as.character(x),x))


#billboard[indx1] <- lapply(billboard[indx1], function(x) ifelse(!is.na(x) && !is.na(as.numeric(x)) && x!="",as.numeric(x),x))


pesmi <- billboard[,c("Prefix","Track","Album", "Year","Media","Time","Date.Entered","X1st.Week")]

glasbeniki <- billboard[,c("Artist","Featured","UnFeatured","Written.By")] 