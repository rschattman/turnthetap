##### Turn the Tap Data Prepatation file
##### Created: November 19, 2019
##### Last updated: November 19, 2019
##### Author: Rachel Schattman


##### Load libraries
library(graphics)
library(dplyr)
library(data.table)

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

# an elegant subsetting method - create seperate dataframes for each plot
B40B983E <- sensmit.2 %>%
  filter(Device.ID == "B40B983E") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B43CD98E <- sensmit.2 %>%
  filter(Device.ID == "B43CD98E") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B451C068 <- sensmit.2 %>%
  filter(Device.ID == "B451C068") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B4539D4F <- sensmit.2 %>%
  filter(Device.ID == "B4539D4F") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B46C3DF7 <- sensmit.2 %>%
  filter(Device.ID == "B46C3DF7") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B48301B8 <- sensmit.2 %>%
  filter(Device.ID == "B48301B8") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B499C579 <- sensmit.2 %>%
  filter(Device.ID == "B499C579") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B4B0893A <- sensmit.2 %>%
  filter(Device.ID == "B4B0893A") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B4C929E2 <- sensmit.2 %>%
  filter(Device.ID == "B4C929E2") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B4DE10BC <- sensmit.2 %>%
  filter(Device.ID == "B4DE10BC") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B4F2F796 <- sensmit.2 %>%
  filter(Device.ID == "B4F2F796") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

B4F6B164 <- sensmit.2 %>%
  filter(Device.ID == "B4F6B164") %>%
  select(Date, MO1, MO2, INT, EXT, Plot, Treatment, Device.ID)

# Coerce factors into numeric format
str(B40B983E)
B40B983E$MO1N<-as.numeric(as.character(B40B983E$MO1)) #coerce MO1 to numeric
B40B983E$MO2N<-as.numeric(as.character(B40B983E$MO2)) #coerce MO2 to numeric
B40B983E$EXTN<-as.numeric(as.character(B40B983E$EXT)) #coerce EXT to numeric
B40B983E <- B40B983E[,c(1,9,10,11,4,6,7,8)]


# create daily averages for MO1, MO2, INT, EXT - not there yet
B40B983E.Mean <- rowMeans(B40B983E$MO1N, by=Date)

B40B983E[, .(Mean = rowMeans(B40B983E$MO1N)), by = ID]
  