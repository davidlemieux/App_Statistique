library(dplyr)
library(ggplot2)

library(gridExtra)
library(ggplot2)

if (Sys.getenv("USERNAME") =="David"){
  setwd("C:\\Users\\David\\OneDrive\\1_Ecole\\HEC\\Msc\\Aut 2020\\Apprentissage Statistique\\Travail d'équipe")
}


data <- read.csv(file = "./raw_data/2020_FR_Region_Mobility_Report.csv",header =TRUE,encoding = "UTF-8")

data <- data %>% filter( sub_region_2=="Paris") %>% select(-c(country_region_code,country_region,sub_region_1,metro_area,iso_3166_2_code,census_fips_code))

data$date <- as.Date(data$date)



summary(data)
str(data)



melt_data <- melt(data = data %>% select(-c(sub_region_2)),id.vars="date")


ggplot(data=melt_data)+
  geom_line(mapping=aes(x=date,y=value,color=variable)) + facet_grid(variable~.) +ggtitle("Variable transport")

