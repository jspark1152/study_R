#단원종합문제
library(dplyr)
library(ISLR)
library(ggplot2)
library(MASS)
library(faraway)

#1.
ds <- airquality
summary(ds)

ds1 <- ds %>% filter(!is.na(ds$Solar.R))
summary(ds1)

sd_before <- sd(ds1$Ozone, na.rm=TRUE)

med <- median(ds1$Ozone, na.rm=TRUE)
ds1$Ozone <- ifelse(is.na(ds1$Ozone)==1, med, ds1$Ozone)
summary(ds1)

sd_after <- sd(ds1$Ozone, na.rm=TRUE)

result <- abs(sd_after - sd_before)
print(result)

#2.
data(Hitters)
ds <- Hitters
summary(ds)
summary(ds$Salary)

iqr <- IQR(ds$Salary, na.rm=TRUE)
print(iqr)
inf_sal <- median(ds$Salary, na.rm=TRUE) - 2*iqr
sup_sal <- median(ds$Salary, na.rm=TRUE) + 2*iqr
print(sup_sal)
ds1 <- ds %>% filter(ds$Salary<=inf_sal | sup_sal<=ds$Salary)
summary(ds1$Salary)

result <- sum(ds1$Salary)
print(result)

#3.
data(diamonds)
ds <- diamonds
summary(ds)
str(ds)
train_ds <- ds[1:(nrow(ds)*0.8),]
str(train_ds)

#train_ds_sort <- sort(train_ds$price, decreasing=TRUE)
#price_list <- head(train_ds_sort,100)
#result <- mean(price_list)
train_ds_sort <- train_ds %>% arrange(desc(train_ds$price))
price_list <- head(train_ds_sort$price, 100)
result <- mean(price_list)
print(result)

#4.
data(airquality)
ds <- airquality
train_ds <- ds[1:(nrow(ds)*0.9),]

mean_oz <- mean(train_ds$Ozone, na.rm=TRUE)
med_before <-median(train_ds$Ozone, na.rm=TRUE)
train_ds$Ozone <- ifelse(is.na(train_ds$Ozone)==1, mean_oz, train_ds$Ozone)
summary(train_ds)
med_after <- median(train_ds$Ozone, na.rm=TRUE)

result <- abs(med_before - med_after)
print(result)

#5.
ds <- read.csv('data_4.csv', fileEncoding='UTF-8-BOM', stringsAsFactors=TRUE)
str(ds)
summary(ds)
q_tempo <- fivenum(ds$tempo)
ds$tempo <- ifelse(ds$tempo <= q_tempo[2] | ds$tempo >= q_tempo[4], 0, ds$tempo)
summary(ds)
result <- mean(ds$tempo, na.rm=TRUE) + sd(ds$tempo, na.rm=TRUE)
print(result)

#6.
ds <- read.csv('WA_Fn-UseC_-Telco-Customer-Churn.csv', fileEncoding='UTF-8-BOM', stringsAsFactors=TRUE)
str(ds)
summary(ds$TotalCharges)
inf_tc <- mean(ds$TotalCharges, na.rm=TRUE) - 1.5*sd(ds$TotalCharges, na.rm=TRUE)
sup_tc <- mean(ds$TotalCharges, na.rm=TRUE) + 1.5*sd(ds$TotalCharges, na.rm=TRUE)
print(inf_tc)
print(sup_tc)

ds1 <- ds %>% filter(TotalCharges>=inf_tc & TotalCharges<=sup_tc)
summary(ds1$TotalCharges)

result <- mean(ds1$TotalCharges, na.rm=TRUE)
print(result)

#7.
ds <- cats
str(ds)
inf_ds <- mean(ds$Hwt, na.rm=TRUE) - 1.5*sd(ds$Hwt, na.rm=TRUE)
sup_ds <- mean(ds$Hwt, na.rm=TRUE) + 1.5*sd(ds$Hwt, na.rm=TRUE)
#filter로 바로 결과 출력도 가능
ds %>% filter(Hwt <= inf_ds | Hwt >= sup_ds) %>% summarise(mean(Hwt))

#8.
ds <- orings
str(ds)
summary(ds)

ds1 <- ds %>% filter(damage >= 1)
result <- cor(ds1, method='pearson')
print(result)

#9.
ds <- mtcars
str(ds)
ds_am <- ds %>% filter(am == 1) %>% arrange(-desc(wt))
ds_auto <- ds %>% filter(am == 0) %>% arrange(-desc(wt))
str(ds_am)
str(ds_auto)
ds_am_bot <- head(ds_am, 10)
ds_auto_bot <- head(ds_auto, 10)

mean_am <- mean(ds_am_bot$mpg, na.rm=TRUE)
mean_auto <- mean(ds_auto_bot$mpg, na.rm=TRUE)
result <- abs(mean_am - mean_auto)
print(result)

#10.
data(diamonds)
ds <- diamonds
str(ds)
ds_20 <- ds[(nrow(ds)*0.8):nrow(ds),]
str(ds_20)

ds_20 <- ds_20 %>% filter(cut == 'Fair' & carat >=1)
result <- max(ds_20$price, na.rm=TRUE)
print(result)