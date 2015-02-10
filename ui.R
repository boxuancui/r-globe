library(shiny)
library(shinythemes)
library(threejs)

shinyUI(
  fluidPage(
    titlePanel("Top 10000 Populated Cities"),
    tags$head(includeScript("google_analytics.js")),
    tags$style("body {background-color: black;} h2 {color: white;}"),
    theme=shinytheme("cosmo"),
    fluidRow(
      column(2, tags$a("Contact Author", href="mailto:cui.bo@bcg.com?Subject=r-globe app"))
    ),
    fluidRow(globeOutput("globe"))
  )
)
