##### Turn the Tap Data Prepatation file
##### Created: November 19, 2019
##### Last updated: November 19, 2019
##### Author: Rachel Schattman


##### Load libraries
library(graphics)
library(dplyr)

##### Section 1: Import data sets
file.choose()
sensmit <- data.frame(read.csv(file = "C:/Users/rschattman/Documents/Research/Water 2017/Turn the Tap 2019_2021/turnthetap/sensmit_web_data_HREC_TTT_2019.csv - sensmit_web_data_HREC_TTT_2019.csv"))
identity <- data.frame(read.csv(file = "C:/Users/rschattman/Documents/Research/Water 2017/Turn the Tap 2019_2021/turnthetap/TTT_IDs.csv"))

# merge on "Device.ID" 
sensmit.2 <- merge(sensmit, identity, by = "Device.ID")
plot(sensmit.2$Device.ID, sensmit.2$MO1)
summary(sensmit.2)

# create a new column with only the date (as opposed to date/time)
str(sensmit.2$Date.Time)

sensmit.2$Date <- format(as.POSIXct(strptime(sensmit.2$Date.Time,"%d/%m/%Y %H:%M",tz="")), format = "%d/%m/%Y")

str(sensmit.2$Date)

# an elegant subsetting method
June8 <- sensmit.2 %>%
  filter(Date == "06/08/2019") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

June8

# create new data table around daily means
  

  