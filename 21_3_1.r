#1번
ds_1 <- read.csv('housing.csv')
summary(ds_1)
#결측값 제거
ds_1 <- na.omit(ds_1)
summary(ds_1)
#훈련 데이터 세팅
train_ds_1 <- ds_1[1:(nrow(ds_1)*0.7),]
#결과 도출
summary(train_ds_1$housing_median_age)
result_1 <- as.integer(summary(train_ds_1$housing_median_age)[2])
print(result_1)

#2번 이건 어렵네 >> 문제에 낚임
#데이터 확인
ds_2 <- read.csv('train.csv')
str(ds_2)
summary(ds_2)
#결측값 개수 확인
colSums(is.na(ds_2))
#결측값의 비율 확인
na_ds_2 <- colSums(is.na(ds_2))/nrow(ds_2)
data.frame(na_ds_2)
#결과 도출
sort_na <- sort(na_ds_2, decreasing=TRUE)
sort_na
#변수의 이름을 출력해야함
print(names(sort_na)[1])

#3번
ds_3 <- read.csv('TB_notifications.csv')
View(ds_3)
ds_3 <- ds_3[, c('country', 'year', 'new_sp')]
ds_3 <- ds_3 %>% filter(ds_3$year == 2000)
ds_3 <- na.omit(ds_3)
str(ds_3)

#평균
summary(ds_3)
mean_sp <- mean(ds_3$new_sp)
mean_sp

#필터링
ds_3 <- ds_3 %>% filter(new_sp > mean_sp)
result <- nrow(ds_3)
print(result)