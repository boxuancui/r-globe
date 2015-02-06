library(shiny)
library(threejs)
library(maps)

earth_dark <- system.file("images/world.jpg", package="threejs")
moon <- system.file("images/moon.jpg", package="threejs")
mars <- system.file("images/mars.jpg", package="threejs")
jupiter <- system.file("images/jupiter.jpg", package="threejs")
col <- list(
  earth_dark=list(img=earth_dark,bodycolor="#0000ff",emissive="#0000ff",lightcolor="#9999ff"),
  moon=list(img=moon,bodycolor="#555555", emissive="#444444", lightcolor="#555555"),
  mars=list(img=mars,bodycolor="#aaaaaa", emissive="#000000", lightcolor="#aaaaaa"),
  jupiter=list(img=jupiter,bodycolor="#222222", emissive="#000000", lightcolor="#aaaaaa")
)

shinyServer(function(input, output) {
  h <- 100
  
  values <- reactive({
    cities <- data[1:10000, ]
    
    value <- h * cities$pop / max(cities$pop)
    # THREE.Color only accepts RGB form, drop the A value:
    col <- sapply(rainbow(sample(50, 1)), function(x) substr(x,1,7))
    names(col) <- c()
    # Extend palette to data values
    col <- col[floor(length(col)*(h-value)/h) + 1]
    list(value=value, color=col, cities=cities)
  })
  
  output$globe <- renderGlobe({
    v <- values()
    p <- "earth_dark"
    args = c(col$earth_dark, list(lat=v$cities$lat, long=v$cities$long, value=v$value, color=v$color, atmosphere=TRUE))
    do.call(globejs, args=args)
  })
  
})