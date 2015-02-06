library(maps)

data(world.cities)
data <- world.cities[order(world.cities$pop, decreasing=TRUE), ]
