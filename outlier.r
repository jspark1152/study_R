comment = '
이상값 : 관측된 데이터의 범위에서 비정상적으로 벗어난 값을 의미

이상값 판별
-ESD, 기하평균, 사분위수 등을 활용

ESD(Extreme Studentized Deviation) : 평균으로부터 3 표준편차 떨어진 값을 이상값으로 판단
즉, |Z| < 3
단 평균을 이용하기 때문에 이상값에 민감

사분위수 활용 : IQR 값의 1.5배한 값만큼 떨어진 위치로 판단
Q1 - 1.5*IQR < data < Q3 + 1.5*IQR
중위수를 이용하므로 ESD와 달리 이상치에 민감하지 않음

박스플롯의 5가지 수치 요약
-최솟값 : 하위 경계 내 최솟값 = $stats[1]
-Q1 : 하위 25% 위치 = $stats[2]
-Q2(median) : 자료들의 50% 위치 = $stats[3]
-Q3 : 하위 75% 위치 = $stats[4]
-최댓값 : 상위 경계 내 최댓값 = $stats[5]
'

#ESD 활용
score <- c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10000)
name <- c('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L')

df_score <- data.frame(score, name)
df_score

#함수로 esd 구현, 논리값으로 리턴
esd <- function(x){return(abs(x-mean(x))/sd(x) < 3)}

#12행의 이상값이 FALSE로 출력
esd(df_score$score)

#df_score 에서 이상값을 필터
df_score %>% filter(esd(score))

#박스플롯
score <- c(65, 60, 70, 75, 200)
name <- c('Bell', 'Cherry', 'Don', 'Jake', 'Fox')

df_score <- data.frame(name, score)

box_score <- boxplot(df_score$score)

#성분중 $out을 통해 이상값을 확인 가능
box_score

box_score$out

box_score$stats

min_score <- box_score$stats[1]
max_score <- box_score$stats[5]

#범위에서 벗어나는 값을 필터링
df_score <- df_score %>% filter(min_score <= df_score$score & df_score$score <= max_score)
df_score

comment = '
함수를  이용한 이상값 검출

quantile(x, na.rm, ...)

fivenum(x, na.rm)

IQR(x, na.rm, ...)
'

score <- c(65, 60, 70, 75, 200)
#데이터를 순서대로 정렬할 때 사분위 값들을 출력
quantile(score)

#5개의 요약 수치 = 최소/Q1/Q2/Q3/최대 출력
fivenum(score)

#IQR 함수를 이용하면 바로 IQR=Q3 - Q1 계산 가능
score <- c(65, 60, 70, 75, 200)
name <- c('Bell', 'Cherry', 'Don', 'Jake', 'Fox')

df_score <- data.frame(name, score)

#1.5IQR 이 아닌 2IQR로
min_score <- median(df_score$score)-2*IQR(df_score$score)
max_score <- median(df_score$score)+2*IQR(df_score$score)

df_score %>% filter(min_score <= df_score$score & df_score$score <= max_score)

comment = '
이상값 처리 : 분석의 목적에 따라 이상값을 어떻게 처리할지 판단
-삭제 : 이상값을 제거하고 분석, 분산은 작아지지만 편의가 발생할 수 있음
-대체 : 이상값을 평균이나 중앙값 등으로 대체
-변환 : 극단적인 값으로 인해 이상값이 발생한 경우 자연로그를 취함
-분류 : 관측값들을 그룹화하여 그룹별로 분석 처리한 후 결과를 취합
'