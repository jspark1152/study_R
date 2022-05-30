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