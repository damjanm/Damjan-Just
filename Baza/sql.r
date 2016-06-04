library(dplyr)
library(RPostgreSQL)

#Uvoz:
source("auth.R")
source("Uvoz/uvoz.r")

# Povezemo se z gonilnikom za PostgreSQL
drv <- dbDriver("PostgreSQL") 

#Funkcija, ki nam zbrise tabele, ce jih ze imamo:
delete_table <- function(){
  tryCatch({
    conn <- dbConnect(drv, dbname = db, host = host,
                      user = user, password = password)
    
    #Ce tabela obstaja jo zbrisemo, ter najprej zbrisemo tiste, 
    #ki se navezujejo na druge
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS pesmi"))
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS glasbeniki"))
    
    
  }, finally = {
    dbDisconnect(conn)
    
  })
}


#Funkcija, ki ustvari tabele
create_table <- function(){
  # Uporabimo tryCatch,(da se povezemo in bazo in odvezemo)
  # da prisilimo prekinitev povezave v primeru napake
  tryCatch({
    # Vzpostavimo povezavo
    conn <- dbConnect(drv, dbname = db, host = host,
                      user = user, password = password)
    
    #Glavne tabele
#     pesmi <- dbSendQuery(conn,build_sql("CREATE TABLE pesmi (
#                                         id TEXT PRIMARY KEY,
#                                         naslov_pesmi TEXT,
#                                         album TEXT,                                        zvrst TEXT,
#                                         letnica TEXT,
#                                         medij TEXT,
#                                         dolzina TEXT,      
#                                         datum_vstopa TEXT                                
#                                         )"))
    glasbeniki <- dbSendQuery(conn,build_sql("CREATE TABLE glasbeniki (
                                        Artist TEXT,
                                        Featured TEXT,
                                        UnFeatured TEXT,
                                        WrittenBy TEXT
                                        )"))
    
    
  }, finally = {
    # Na koncu nujno prekinemo povezavo z bazo,
    # saj prevec odprtih povezav ne smemo imeti
    dbDisconnect(conn) #PREKINEMO POVEZAVO
    # Koda v finally bloku se izvede, preden program konca z napako
  })
}


#Uvoz podatkov:

#billboard <- read.csv("Podatki/lestvica.csv",fileEncoding = "Windows-1252")

#Funcija, ki vstavi podatke
insert_data <- function(){
  tryCatch({
    conn <- dbConnect(drv, dbname = db, host = host,
                      user = user, password = password)
    
    dbWriteTable(conn, name="pesmi", pesmi, append=T, row.names=FALSE)
    dbWriteTable(conn, name="glasbeniki",glasbeniki,append=T, row.names=FALSE)
    
  }, finally = {
    dbDisconnect(conn) 
    
  })
}

delete_table()
create_table()
insert_data()

con <- src_postgres(dbname = db, host = host, user = user, password = password)
