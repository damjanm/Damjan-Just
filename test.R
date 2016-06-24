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
pesmi <- (tbl(conn, "pesmi"))
glasbeniki <-(tbl(conn, "glasbeniki"))
ranks <-(tbl(conn, "ranks"))

