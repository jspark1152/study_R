comment = '
결측값 : 입력이 누락된 값

결측값 인식
- 분석 데이터에 결측값이 있는지 확인 > NA 로 처리
- 결측값이 포함되어 있을 경우 산술 연산을 수행할 수 없어 분석 결과가 왜곡될 수 있음

is.na(x) : 데이터의 각 행과 열별로 결측값이 있을 경우 TRUE, 아니면 FALSE 출력 > 데이터 성분 하나하나 확인
complete.cases(x) : 데이터의 행별로 결측값이 없을 경우 TRUE, 아니면 FALSE 출력 > 행을 기준으로 확인
'

#ds_NA <- head(airquality, 5)

#ds_NA

#is.na(ds_NA)
#complete.cases(ds_NA)

#summary 함수를 이용한 결측값 확인

#mlbench 라이브러리를 이용하여 다음 P.I.D2 데이터셋을 이용
Pima2 <- PimaIndiansDiabetes2

str(Pima2)

summary(Pima2)

#write.csv(Pima2, file='pima.csv')

#is.na(Pima2)
#complete.cases(Pima2)

#sum(is.na(Pima2))
#sum(complete.cases(Pima2))

#colSums(is.na(Pima2))

comment = '
결측값 처리
1. 결측값 삭제 : 특정 컬럼에 결측값이 집중되어 있는 경우 해당 열을 삭제
'

#Pima2$insulin <- NULL #insulin 열 삭제

#summary(Pima2)

#Pima2$triceps <- NULL #triceps 열 삭제

#summary(Pima2)

#sum(!complete.cases(Pima2))

#colSums(is.na(Pima2))

comment = '
2. 단순 대치법 : 결측값을 유의미한 값으로 대체하는 통계적 기법

완전 분석법 : 결측값이 존재하는 행을 삭제하여 완전한 데이터만 분석
특정 컬럼을 삭제하는 경우와 결측값이 있는 모든 컬럼을 삭제하는 경우

is.na 함수로 특정 행을 삭제
na.omit 함수로 모든 행을 삭제

데이터명 [!is.na(데이터명),]
데이터명 %>% filter(!is.na(데이터명))
na.omit(데이터명)
'

Pima3 <- Pima2 %>% filter(!is.na(glucose) & !is.na(mass))
#glucose와 mass 컬럼에 결측값이 없는 행만 필터
colSums(is.na(Pima3))
#glucose와 mass에 결측값이 0개인 것을 확인

dim(Pima3)
#총 16개의 행이 삭제되어 있음

Pima4 <- na.omit(Pima3)
#Pima3 데이터에서 모든 결측값이 포함된 행을 제거한 것을 Pima4로 지정

colSums(is.na(Pima4))

dim(Pima4)

comment = '
평균 대치법 : 데이터의 결측값을 평균값으로 변경
결측값이 존재하는 경우 삭제하지 않고 평균이나 중위수로 대체
'

#ifelse 사용하기
ds_NA <- head(airquality, 5)
head(ds_NA$Ozone)

ds_NA$Ozone <- ifelse(is.na(ds_NA$Ozone), mean(ds_NA$Ozone, na.rm=TRUE), ds_NA$Ozone)
#ifelse 문을 이용하여 결측값인 경우 Ozone 열에서 결측값을 제외한 값들의 평균값으로 대체

ds_NA
#Ozone의 5열 값이 평균값으로 대치된것을 확인할 수 있음

table(is.na(ds_NA$Ozone))

#리스트 요소 직접 접근하여 평균 대치
ds_NA2 <- head(airquality, 5)

ds_NA2[is.na(ds_NA2$Ozone), 'Ozone'] <- mean(ds_NA2$Ozone, na.rm=TRUE)
#Ozone 열의 값이 결측값이면 평균으로 대치

ds_NA2

table(is.na(ds_NA2$Ozone))
#Ozone 열의 5값 모두 결측값이 아니므로 FALSE 5 출력

#Pima3 에서 결측값 처리를 해보려고 함
summary(Pima3)

#먼저 결측값을 제외한 pressure 열 값들의 평균
mean_press <- mean(Pima3$pressure, na.rm=TRUE)
mean_press

#결측값 제거하기 전의 표준편차 확인
std_before <- sd(Pima3$pressure, na.rm=TRUE)
std_before

#Pima3의 pressure 열에서 결측값을 제거
Pima3$pressure <- ifelse(is.na(Pima3$pressure), mean_press, Pima3$pressure)

#결측값 제거 후의 표준편차 확인
std_after <- sd(Pima3$pressure)
std_after

#표준편차 값의 변화 확인 >> 대략 0.2 정도 감소
std_diff <- std_after - std_before
std_diff