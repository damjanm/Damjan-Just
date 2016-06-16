library(RPostgreSQL)
library(dplyr)

#Uvoz:
source("auth.r")
#source("Uvoz/uvoz.r")

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
    dbSendQuery(conn,build_sql("DROP TABLE IF EXISTS ranks"))
    
    
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

    #Glavne tabele:
    glasbeniki <- dbSendQuery(conn,build_sql("CREATE TABLE glasbeniki (
                                        id INTEGER PRIMARY KEY,
                                        Artist TEXT,
                                        Featured TEXT,
                                        UnFeatured TEXT,
                                        WrittenBy TEXT
                                        )"))

    ranks <- dbSendQuery(conn,build_sql("CREATE TABLE ranks (
                                        id INTEGER,
                                        week INTEGER,
                                        rank INTEGER
                                        )"))
    pesmi <- dbSendQuery(conn,build_sql("CREATE TABLE pesmi (
                                        id INTEGER PRIMARY KEY,
                                        Track TEXT,
                                        Album TEXT,                                        
                                        Year INTEGER,
                                        Media TEXT,
                                        Time TEXT,      
                                        DateEntered TEXT                                
                                        )"))
    
  dbSendQuery(conn, build_sql('GRANT SELECT ON ALL TABLES IN SCHEMA public TO javnost'))

  }, finally = {
    # Na koncu nujno prekinemo povezavo z bazo,
    # saj prevec odprtih povezav ne smemo imeti
    dbDisconnect(conn) #PREKINEMO POVEZAVO
    # Koda v finally bloku se izvede, preden program konca z napako
  })
}


#Uvoz podatkov:

# glasbeniki <-read.csv("Podatki/glasbeniki.csv",fileEncoding = "Windows-1252")
# pesmi <-read.csv("Podatki/pesmi.csv",fileEncoding = "Windows-1252")
# ranks <-read.csv("Podatki/ranks.csv",fileEncoding = "Windows-1252")
#billboard <- read.csv("Podatki/lestvica.csv",fileEncoding = "Windows-1252")

#Funcija, ki vstavi podatke
insert_data <- function(){
  tryCatch({
    conn <- dbConnect(drv, dbname = db, host = host,
                      user = user, password = password)
    
    dbWriteTable(conn, name="pesmi", pesmi, append=T, row.names=FALSE)
    dbWriteTable(conn, name="glasbeniki",glasbeniki,append=T, row.names=FALSE)
    dbWriteTable(conn, name="ranks",ranks,append=T, row.names=FALSE)
    
  }, finally = {
    dbDisconnect(conn) 
    
  })
}

delete_table()
create_table()
insert_data()

con <- src_postgres(dbname = db, host = host, user = user, password = password)
