# Counting Building in a City Off a Google Map ScreenShot 


## Getting Started

* Clone Repo to Your Machine
* Open it in RStudio

### Prerequisites

* BioConductor
* R Studio
* Flexdashboard

### Installing

Install the Packages 

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("EBImage")
```


### Using Custom Image in the Project

Find this Line of Code in Any of the Scripts and uncomment it

```
city_image = readImage(file.choose()) -- uncomment this
city_image = readImage("1.png") -- comment this
```



