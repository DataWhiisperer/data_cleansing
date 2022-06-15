## Importing of the libraries that will be used in the cleaning process.
library(ggplot2)
library(janitor)
library(lubridate)
## Error in the installation of tidyverse so will bypass the use of tidyverse for now.
## Cleaning of the enviroment and listing of the data in the location
rm(list=ls())
dir("~/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data",full.names = T)
## Display script and assign them to the dataframes/load the csv's into the dataframe
df1 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202104-divvy-tripdata.csv")
df2 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202105-divvy-tripdata.csv")
df3 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202106-divvy-tripdata.csv")
df4 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202107-divvy-tripdata.csv")
df5 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202108-divvy-tripdata.csv")
df6 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202109-divvy-tripdata.csv")
df7 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202110-divvy-tripdata.csv")
df8 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202111-divvy-tripdata.csv")
df9 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202112-divvy-tripdata.csv")
df10 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202201-divvy-tripdata.csv")
df11 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202202-divvy-tripdata.csv")
df12 <- read.csv("/Users/Ryan2/Dropbox/Uni Documents/MSc AAIDS/PortfolioProjects/Cyclistic/historic_data/202203-divvy-tripdata.csv")
## Combine the data into 1 dataframe using rbind then cline with janitor package
bike_rides <- rbind(df1,df2,df3,df4,df5,df6,df7,df8,df9,df10,df11,df12)
bike_rides <- janitor::remove_empty(bike_rides, which = c("cols"))
dim(bike_rides)
bike_rides <- janitor::remove_empty(bike_rides, which = c("rows"))
## Size of the Data structure evaluation 
dim(bike_rides)
## Wrong data type for start/end_at. Convert to Data/Time 
bike_rides$started_at <- lubridate::ymd_hms(bike_rides$started_at)
bike_rides$ended_at <- lubridate::ymd_hms(bike_rides$ended_at)
## Individual hourly time stamps 
bike_rides$start_hour <- lubridate::hour(bike_rides$started_at)
bike_rides$end_hour <- lubridate::hour(bike_rides$ended_at)
## Start date and end date extraction
bike_rides$start_date <- lubridate::as_date(bike_rides$started_at)
bike_rides$end_date <- lubridate::as_date(bike_rides$ended_at)
## Sorting of the data by hours started
## Sorting can be done through the bike_rides data frame window
## write.csv(bike_rides,"//Users//Ryan2//Dropbox//Uni Documents//MSc AAIDS//PortfolioProjects//Cyclistic//bike_data.csv", row.names = FALSE)
bike_rides$ride_length <- difftime(bike_rides$ended_at, bike_rides$started_at, units = "mins")
#write.csv(bike_rides,"//Users//Ryan2//Dropbox//Uni Documents//MSc AAIDS//PortfolioProjects//Cyclistic//bike_data_clean_v1.csv", row.names = FALSE)
## Creation of the new data set so easier to load, clean and track on differing days
new_data <- read.csv("//Users//Ryan2//Dropbox//Uni Documents//MSc AAIDS//PortfolioProjects//Cyclistic//bike_data_clean_v1.csv")
## Change char to date
new_data$start_date <- lubridate::as_date(new_data$start_date)
new_data$end_date <- lubridate::as_date(new_data$end_date)
## Check the number of duplicates within the data sets if any 
n_occur <- data.frame(table(new_data$ride_id))
n_occur[n_occur$Freq > 1,]
## Find day of the week
new_data$day_of_week <- lubridate::wday(new_data$start_date, week_start = 1)
## Final creation of clean data 
write.csv(new_data,"//Users//Ryan2//Dropbox//Uni Documents//MSc AAIDS//PortfolioProjects//Cyclistic//bike_data_clean_v2.csv", row.names = FALSE)
## Import of clean data as travel_data 
travel_data <- read.csv("//Users//Ryan2//Dropbox//Uni Documents//MSc AAIDS//PortfolioProjects//Cyclistic//bike_data_clean_v2.csv")
## Initial summary/descriptive analysis of the data set
summary(travel_data)
head(travel_data)
## Rename of member heading 
names(travel_data)[names(travel_data)== "member_casual"] <- "member_type"


