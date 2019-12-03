##### Turn the Tap Data Prepatation file
##### Created: November 19, 2019
##### Last updated: November 19, 2019
##### Author: Rachel Schattman


##### Load libraries
library(graphics)
library(dplyr)
library(data.table)
library(DescTools)

##### Section 1: Import data sets
file.choose()
sensmit <- data.frame(read.csv(file = "C:/Users/rschattman/Documents/Research/Water 2017/Turn the Tap 2019_2021/turnthetap/sensmit_web_data_HREC_TTT_2019.csv - sensmit_web_data_HREC_TTT_2019.csv"))
identity <- data.frame(read.csv(file = "C:/Users/rschattman/Documents/Research/Water 2017/Turn the Tap 2019_2021/turnthetap/TTT_IDs.csv"))

# merge on "Device.ID" 
sensmit.2 <- merge(sensmit, identity, by = "Device.ID")
summary(sensmit.2)

# create a new column with only the date (as opposed to date/time)
str(sensmit.2$Date.Time)

sensmit.2$Date <- format(as.POSIXct(strptime(sensmit.2$Date.Time,"%m/%d/%Y %H:%M",tz="EST")), format = "%m/%d/%Y")

str(sensmit.2$Date)

# Coerce factors into numeric format
sensmit.2$MO1<-as.numeric(as.character(sensmit.2$MO1)) #coerce MO1 to numeric
sensmit.2$MO2<-as.numeric(as.character(sensmit.2$MO2)) #coerce MO2 to numeric
sensmit.2$MO3<-as.numeric(as.character(sensmit.2$MO3)) #coerce MO2 to numeric
sensmit.2$EXT<-as.numeric(as.character(sensmit.2$EXT)) #coerce EXT to numeric
str(sensmit.2)

#create new column that indicates which week each Date belongs to
sensmit.2$Week <- Week(sensmit.2$Date, method = "us")



# use dplyr to create a tibble with daily values summarized
#scott says dplyr group by day and week and set up a tibble that summarizes by day and week

sensmit.2 %>%
  group_by(Device.ID, Date) %>%
  summarize(mean_MO1 = mean(MO1, na.rm = TRUE),
            mean_MO2 = mean(MO2, na.rm = TRUE),
            mean_EXT = mean(EXT, na.rm = TRUE),
            mean_INT = mean(INT, na.rm = TRUE)) #%>%  
  # filter(!is.na(Date)) # Was used to remove mystery NAs but is no longer needed

sensmit.2 %>%
  group_by(week = week(Date)) %>%
  summarize(mean_MO1 = mean(MO1, na.rm = TRUE),
          mean_MO2 = mean(MO2, na.rm = TRUE),
          mean_EXT = mean(EXT, na.rm = TRUE),
          mean_INT = mean(INT, na.rm = TRUE))
  