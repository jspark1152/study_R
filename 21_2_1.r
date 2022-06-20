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

#2번
ds_init <- read.csv('housing.csv')
#첫행부터 80%행까지 추출
ds <- ds_init[1:(nrow(ds_init)*0.8),]
#결측값 확인
summary(ds$total_bedrooms)
#중위값 확인
med_totb <- median(ds$total_bedrooms, na.rm=TRUE)
med_totb
#전처리 전의 표준편차 확인
sd_before <- sd(ds$total_bedrooms, na.rm=TRUE)
sd_before
#전처리
ds$total_bedrooms <- ifelse(is.na(ds$total_bedrooms)==1, med_totb, ds$total_bedrooms)
summary(ds$total_bedrooms)
#전처리 후의 표준편차 확인
sd_after <- sd(ds$total_bedrooms)
sd_after
#결과 정리
result <- abs(sd_before - sd_after)
print(result)

#3번
#데이터셋 확인
ds_3 <- read.csv('insurance.csv')
summary(ds_3$charges)
#이상값 기준 설정
mean_ch <- mean(ds_3$charges)
sd_ch <- sd(ds_3$charges)
sup_ch <- mean_ch + 1.5*sd_ch
inf_ch <- mean_ch - 1.5*sd_ch
#설정한 이상값 기준을 토대로 필터링
#out_ds_3_ch <- ds_3 %>% filter(ds_3$charges >= sup_ch | ds_3$charges <= inf_ch)
result_3 <- ds_3 %>% filter(charges >= sup_ch | charges <= inf_ch) %>% summarise(sum(charges))
#결과 도출
#result_3 <- sum(out_ds_3_ch$charges)
print(result_3)