library(data.table)
library(dplyr)

train_raw<-fread("C:/Users/Komal/Documents/Projects/NYC Taxi Trip/Data/train.csv")
test_raw<-fread("C:/Users/Komal/Documents/Projects/NYC Taxi Trip/Data/test.csv")
sample_sub<-fread("C:/Users/Komal/Documents/Projects/NYC Taxi Trip/Data/sample_submission.csv")

##Summary of columns
summary(train_raw)
summary(test_raw)
str(train_raw)
str(test_raw)

##Determing data types of columns
sapply(train_raw, typeof)


##Type casting
library(lubridate)
train_raw <- train_raw %>%
  mutate(pickup_datetime = ymd_hms(pickup_datetime),
         dropoff_datetime = ymd_hms(dropoff_datetime),
         vendor_id = factor(vendor_id),
         passenger_count = factor(passenger_count))

###Checking for nulls
sapply(train_raw, function(x) sum(is.na(x)))
sapply(test_raw, function(x) sum(is.na(x)))

####Extracting date time features

train_raw$phour<-hour(train_raw$pickup_datetime)
test_raw$phour<-hour(train_raw$pickup_datetime)
train_raw$pmonth<-factor(month(train_raw$pickup_datetime))
test_raw$pmonth<-factor(month(test_raw$pickup_datetime))
train_raw$pwday<-factor(wday(train_raw$pickup_datetime))
test_raw$pwday<-factor(wday(test_raw$pickup_datetime))


library(ggplot2)
library(ggthemes)
library(extrafont)


intersect(train_raw$vendor_id,test_raw$vendor_id)
