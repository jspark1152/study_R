#1번
data(BostonHousing)
str(BostonHousing)
head(BostonHousing, 10)
summary(BostonHousing)

#먼저 상위 10번째 값 확인
data <- BostonHousing
data$crim <- sort(data$crim, decreasing=TRUE)
#조심할거 crim만 정렬된거기 때문에 이후에 이 data를 그대로 사용하면 안됨
head(data, 20)
top_10 <- data$crim[10]
top_10
#상위 10개의 값들을 상위 10번째 값으로 변경
BostonHousing$crim <- ifelse(BostonHousing$crim > top_10, top_10, BostonHousing$crim)
head(BostonHousing, 20)

data_80 <- BostonHousing %>% filter(BostonHousing$age >= 80)
head(data_80, 20)

mean(data_80$crim)