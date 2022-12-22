# installing packages and loading library
install.packages("tidyverse")
install.packages("lubridate")
install.packages("ggplot2")
install.packages("janitor")
install.packages("skimr")
install.packages("dplyr")
install.packages("anytime")

library(tidyverse)
library(lubridate)
library(ggplot2)
library(janitor)
library(readr)
library(dplyr)
library(skimr)
library(anytime)

# Does taking more steps correlates to higher calories consumption? 
daily_activity <- read.csv("dailyActivity_merged.csv")

ggplot(data = daily_activity) +
  geom_point(mapping = aes(x = TotalSteps, y = Calories)) +
  geom_smooth(mapping = aes(x = TotalSteps, y = Calories))

# What is the relationship between steps and days of week? 
daily_activity$weekday <- wday(daily_activity$ActivityDate, label=TRUE, abbr=FALSE)

daily_activity %>% 
  mutate(weekday = wday(ActivityDate, label=TRUE, abbr=FALSE)) %>% 
  group_by(weekday) %>%
  summarise(average_steps = mean(TotalSteps)
            ,average_calories = mean(Calories)) %>% 
  arrange(weekday)

# creating daily_activity_v2 dataframe with days of week with average steps and calories.
daily_activity_v2 <- daily_activity %>% 
  mutate(weekday = wday(ActivityDate, label=TRUE, abbr=FALSE)) %>% 
  group_by(weekday) %>%
  summarise(average_steps = mean(TotalSteps)
            ,average_calories = mean(Calories)) %>% 
  arrange(weekday)

# daily_activity_v2 exported as CSV file for visualization.
write.csv(daily_activity, file = '~/Desktop/Google_Case_Study_2/daily_activity_v2.csv')

# What is the trends between steps and the hour users are active?
hourly_steps <- read_csv("hourlySteps_merged.csv")

hourly_steps %>%
  mutate(Time = as.POSIXct(ActivityHour)) %>%
  group_by(lubridate::hour(Time)) %>%
  summarise(count=n()) %>%
  arrange(desc(count))

# creating hourly_steps_v2 dataframe summarizing the average steps of each hour in a 24 hour timeframe. 
hourly_steps_v2 <- hourly_steps %>%
  mutate(Time = as.POSIXct(ActivityHour)) %>%
  group_by(lubridate::hour(Time)) %>%
  summarise(average_steps = mean(StepTotal))

# hourly_steps_v2 exported as CSV file for visualization. 
write.csv(hourly_steps_v2, file = '~/Desktop/Google_Case_Study_2/hourly_steps_v2.csv')

# What is the trend between intensity and hour? 
hourly_intensity <- read.csv("hourlyIntensities_merged.csv")

# creating hourly_intensity_v2 dataframe summarizing the average intensity by hour. 
hourly_intensity_v2 <- hourly_intensity %>%
  mutate(Time = as.POSIXct(ActivityHour)) %>%
  group_by(lubridate::hour(Time)) %>% 
  summarise(average_intensity = mean(TotalIntensity))

# hourly_intensity_v2 exported as CSV file for visualization. 
write.csv(hourly_intensity_v2, file = '~/Desktop/Google_Case_Study_2/hourly_intensity_v2.csv')

# What is the trends in users sleeping activity? 
sleep_day <- read.csv("sleepDay_merged.csv")

# creating a weekday column
sleep_day$weekday <- wday(sleep_day$SleepDay, label=TRUE, abbr=FALSE)

# creating sleep_day_v2 dataframe summarizing average minutes asleep and average time in bed by days of the week.
sleep_day_v2 <- sleep_day %>% 
  mutate(weekday = wday(SleepDay, label=TRUE, abbr=FALSE)) %>% 
  group_by(weekday) %>%
  summarise(average_minutes_asleep = mean(TotalMinutesAsleep)
            ,average_time_in_bed= mean(TotalTimeInBed)) %>% 
  arrange(weekday)

# exporting sleep_day_v2 as CSV file for visualization. 
write.csv(sleep_day_v2, file = '~/Desktop/Google_Case_Study_2/sleep_day_v2.csv')





