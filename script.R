library("EBImage")

city_image = readImage("1.png")

##To Choose your own Image uncomment this to select your own Image
##city_image = readImage(file.choose())

display(city_image)
hist(anImage)

ImageofBuildingThreshol <- .6

city_image_threshold <- city_image > ImageofBuildingThreshol

display(city_image)

display(city_image_threshold)

building_count <- bwlabel(city_image_threshold)
max(building_count)
