library(shiny)
library(shinythemes)
library(threejs)

shinyUI(
  fluidPage(
    titlePanel("Top 10000 Populated Cities"),
    tags$style("body {background-color: black;} h2 {color: white;}"),
    theme=shinytheme("cosmo"),
    fluidRow(globeOutput("globe"))
  )
)
