##### Turn the Tap Data Prepatation file
##### Created: November 19, 2019
##### Last updated: November 19, 2019
##### Author: Rachel Schattman


##### Load libraries
library(graphics)
library(dplyr)
library(data.table)
library(DescTools)
library(tidyverse)
library(lubridate)
library(ggpubr)

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
sensmit.2$Date <- as.Date(sensmit.2$Date, format = "%m/%d/%Y") #coerce Date into Date format
str(sensmit.2)

# Create new column that indicates which week each Date belongs to
sensmit.2$Week <- isoweek(sensmit.2$Date)

# Use dplyr to create a tibble with weekly values summarized
sensmit.3<-data.frame(sensmit.2 %>%
  group_by(Device.ID, Week) %>%
  summarize(mean_MO1 = mean(MO1, na.rm = TRUE),
            mean_MO2 = mean(MO2, na.rm = TRUE),
            mean_EXT = mean(EXT, na.rm = TRUE),
            mean_INT = mean(INT, na.rm = TRUE))) #%>%  
  #filter(!is.na(mean_MO1)) # Was used to remove mystery NAs but is no longer needed

# merge (again?) on "Device.ID" 
sensmit.3 <- merge(sensmit.3, identity, by = "Device.ID")
summary(sensmit.3)

# set comparisons for error plots 
my_comparisons <- list(c("control", "feel"), 
                       c("control", "sensor"), 
                       c("control", "timer"), 
                       c("sensor","timer"), 
                       c("sensor","feel"), 
                       c("feel","timer"))

my_comparisons <- list(c("sensor", "feel"), 
                       c("timer", "sensor"), 
                       c("feel", "timer"),
                       c("control", "feel"), 
                       c("control", "sensor"), 
                       c("control", "timer"))

# Plot sensmit data
ggerrorplot(sensmit.3, x = "Treatment", 
            y = c("mean_MO1", "mean_MO2"),
            combine = TRUE, merge = FALSE,
            desc_stat = "mean_sd",  
            color = "black",
            palette = "npg",
            title = "dsitribution of cB by irrigation treatment",
            add = "violin", add.params = list(color = "Treatment", fill="Treatment"),
            ylim = c(-10, 300),
            legend = "bottom",
            legend.title = "Treatment", 
            xlab = "Treatment",
            ylab = "cB",
            orientation = "vertical", 
            caption = "2019 HREC") +
  stat_compare_means(comparisons = my_comparisons) +
  stat_compare_means(label.y = 150, label.x = 1.5)

  