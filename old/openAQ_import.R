

## Installation des Librairie

library(dplyr)
library(ropenaq) ## Super librairie pour faire des API pour aller chercher des donn√©es sur le site de openSCI
library(lubridate)
library(purrr)
library(ggplot2)
library(grid)
library(zoo)
library(gridExtra)

# Voir les exemples
# https://ropensci.org/blog/2017/02/21/ropenaq/


setwd("C:\\Users\\David\\OneDrive\\1_Ecole\\HEC\\Msc\\Aut 2020\\Apprentissage Statistique\\Travail d'Èquipe")

city <- c("Paris","Berlin","Bern","London","Madrid")

extract_ac <- function(cities, start_date,end_date){
  print(cities)
  data <- aq_measurements(country= "France",
                          city = cities,
                          date_from = start_date,
                          date_to = end_date,
                          parameter = "no2") 
  data2 <- data %>% select(-c(longitude,latitude,date.utc,cityURL)) %>% 
                        group_by(city,dateLocal) %>% 
                        summarise (mean_no2 = mean(value))
  data2$dateLocal <- as.Date(data2$dateLocal)
  return (data2)

}


# POur les Weather data
#https://www.ncdc.noaa.gov/cdo-web/review
Weather_data <- read.csv2("./raw_data/Weather_data.csv",header=TRUE,sep=",")




# POur les 

data <- read.csv(file = "./raw_data/2020_FR_Region_Mobility_Report.csv",header =TRUE,encoding = "UTF-8")
data <- data %>% filter( sub_region_2=="Paris") %>% select(-c(country_region_code,country_region,sub_region_1,metro_area,iso_3166_2_code,census_fips_code))
data$date <- as.Date(data$date)
