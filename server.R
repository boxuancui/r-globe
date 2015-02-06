library(shiny)
library(threejs)
library(maps)

earth_dark <- system.file("images/world.jpg", package="threejs")
earth_col <- list(img=earth_dark, bodycolor="#0000ff", emissive="#0000ff", lightcolor="#9999ff")

shinyServer(function(input, output) {
  h <- 100
  
  values <- reactive({
    cities <- data[1:10000, ]
    
    value <- h * cities$pop / max(cities$pop)
    # THREE.Color only accepts RGB form, drop the A value:
    col <- sapply(rainbow(sample(seq(10, 50, 10), 1)), function(x) substr(x, 1, 7))
    names(col) <- c()
    # Extend palette to data values
    col <- col[floor(length(col)*(h-value)/h) + 1]
    list(value=value, color=col, cities=cities)
  })
  
  output$globe <- renderGlobe({
    v <- values()
    args <- c(
      earth_col,
      list(
        lat=v$cities$lat,
        long=v$cities$long,
        value=v$value,
        color=v$color,
        atmosphere=TRUE,
        rotationlat=0.6,
        rotationlong=0.1
      )
    )
    do.call(globejs, args=args)
  })
  
})
