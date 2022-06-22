#단원종합문제
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