

## Installation des Librairie

library(dplyr)
library(ropenaq) ## Super librairie pour faire des API pour aller chercher des données sur le site de openSCI
library(lubridate)
library(purrr)
library(ggplot2)
library(grid)
library(gridExtra)

# Voir les exemples
# https://ropensci.org/blog/2017/02/21/ropenaq/


setwd("C:\\Users\\David\\OneDrive\\1_Ecole\\HEC\\Msc\\Aut 2020\\Apprentissage Statistique\\Travail d'équipe")

city <- c("Paris","Berlin","Bern","London","Madrid")
g_list=list()
for (cities in city ){
  print(cities)
  data <- aq_measurements(city = cities,
                date_from = "2019-01-01",
                date_to = "2020-09-30",
                parameter = "no2") 
  
  
  data2 <- data %>% select(-c(longitude,latitude,date.utc,cityURL)) %>% 
    group_by(city,dateLocal) %>% summarise (mean_no2 = mean(value))

  data2$dateLocal <- as.Date(data2$dateLocal)


  g_list[[cities]] <- ggplot(data=data2)+
    geom_line(mapping=aes(x=as.Date(dateLocal),y=mean_no2), color= "green")  +
    geom_vline(aes(xintercept = as.Date("2020-03-01")),linetype = 4, colour = "black")+
    annotate("text", x = as.Date("2020-03-01"), y=100, label = "2020-03-01")+
    ggtitle(paste("NO2 in",cities))
    
  
  ggsave(paste("./plots/NO2 in",cities,".png"),plot=g_list[[cities]])
  
  

}


