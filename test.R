library(shiny)
library(dplyr)
library(RPostgreSQL)
library(ggplot2)

if ("server.R" %in% dir()) {
  setwd("..")
}
source("auth_public.R",encoding='UTF-8')


conn <- src_postgres(dbname = db, host = host,
                     user = user, password = password)
pesmi <- data.frame(tbl(conn, "pesmi"))
glasbeniki <-data.frame(tbl(conn, "glasbeniki"))
ranks <-data.frame(tbl(conn, "ranks"))