install.packages("tidyverse")
install.packages("lubridate")
install.packages("ggplot2")
library(tidyverse)
library(lubridate)
library(ggplot2)
getwd()
setwd("D:\\Pooja\\R programming_Pooja\\R studio")
getwd()
q2_2019 <- read.csv("Divvy_Trips_2019_Q2.csv")
q3_2019 <- read.csv("Divvy_Trips_2019_Q3.csv")
q4_2019 <- read.csv("Divvy_Trips_2019_Q4.csv")
q1_2020 <- read.csv("Divvy_Trips_2020_Q1.csv")
colnames(q2_2019)
colnames(q3_2019)
colnames(q4_2019)
colnames(q1_2020)
q3_2019<- rename(q3_2019, 
                 ride_id = trip_id,
                 started_at = start_time,
                 ended_at = end_time,
                 start_station_name = from_station_name,
                 start_station_id = from_station_id,
                 end_station_name = to_station_id,
                 end_station_id = to_station_id,
                 rideable_type = bikeid,
                 member_casual = usertype)
q4_2019<- rename(q4_2019, 
                 ride_id = trip_id,
                 started_at = start_time,
                 ended_at = end_time,
                 start_station_name = from_station_name,
                 start_station_id = from_station_id,
                 end_station_name = to_station_id,
                 end_station_id = to_station_id,
                 rideable_type = bikeid,
                 member_casual = usertype)
q2_2019<- rename(q2_2019, 
                 ride_id = X01...Rental.Details.Rental.ID,
                 started_at = X01...Rental.Details.Local.Start.Time,
                 ended_at = X01...Rental.Details.Local.End.Time,
                 start_station_name = X03...Rental.Start.Station.Name,
                 start_station_id = X03...Rental.Start.Station.ID,
                 end_station_name = X02...Rental.End.Station.Name,
                 end_station_id = X02...Rental.End.Station.ID,
                 rideable_type = X01...Rental.Details.Bike.ID,
                 member_casual = User.Type,
                 tripduration = X01...Rental.Details.Duration.In.Seconds.Uncapped,
                 birthyear = X05...Member.Details.Member.Birthday.Year)
q2_2019<- rename(q2_2019,
                 tripduration = X01...Rental.Details.Duration.In.Seconds.Uncapped,
                 birthyear = X05...Member.Details.Member.Birthday.Year)
colnames(q3_2019)
colnames(q4_2019)
colnames(q2_2019)
str(q2_2019)
str(q3_2019)
str(q4_2019)
str(q1_2020)
q4_2019 <-  mutate(q4_2019, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 
q3_2019 <-  mutate(q3_2019, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 
q2_2019 <-  mutate(q2_2019, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type))
str(q2_2019)
all_trips <- bind_rows(q2_2019, q3_2019, q4_2019, q1_2020)
all_trips <- all_trips %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng, birthyear, gender, tripduration))
colnames(all_trips)
nrow(all_trips)
dim(all_trips)
head(all_trips)
str(all_trips)
summary(all_trips)
table(all_trips$member_casual)
all_trips <- all_trips %>% 
  mutate(member_casual = recode(member_casual
                                , "Subscriber" = "member"
                                , "Customer" = "casual"))
table(all_trips$member_casual)

all_trips$date <- as.Date(all_trips$started_at)
all_trips$month <- format(as.Date(all_trips$date),"%b")
all_trips$day_of_week <- format(as.Date(all_trips$date),"%a")
all_trips$year <- format(as.Date(all_trips$date), "%Y")

all_trips$ride_length <- difftime(all_trips$ended_at, all_trips$started_at)
str(all_trips)
is.numeric(all_trips$ride_length)
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)
all_trips_v2 <- all_trips[!(all_trips$start_station_name =="HQ QR" | all_trips$ride_length<0),]
summary(all_trips_v2$ride_length)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN=mean)
all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c("Sun","Mon","Tue","Wed","Thu","Fri","Sat"))

all_trips_v2 %>%                        
  group_by(member_casual, day_of_week) %>%                                        ## groups by user type and weekday
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>%  ## calculates the number of rides and average duration
  arrange(member_casual, day_of_week)  %>% 
ggplot(aes(x = day_of_week, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")+
  labs(title = "Average duration v/s day of the week")
