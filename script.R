source("http://bioconductor.org/biocLite.R")

biocLite("EBImage")
library("EBImage")

anImage <- readImage(file.choose())
display(anImage)

hist(anImage)
city_image = readImage(file.choose())

ImageofBuildingThreshol <- .6

city_image_threshold <- city_image > ImageofBuildingThreshol

display(city_image)

display(city_image_threshold)

building_count <- bwlabel(city_image_threshold)
max(building_count)