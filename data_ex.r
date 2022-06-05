comment = '
데이터 탐색 : 수집한 데이터를 분석하기 전에 그래프타 통계적인 방법을 이용하여 특징을 파악

개별 데이터 탐색 : 범주형 / 수치형일 경우로 나누어 탐색

범주형 데이터
- 명목 / 순위 척도
- 빈도수, 최빈값, 비율, 백분율
- 막대형 그래프(barplot)

수치형 데이터
- 등간 / 비율 척도
- 평균, 분산, 표준편차, 첨도, 왜도
- 박스 플롯, 히스토그램

1. 범주형 데이터
빈도수 탐색
table(x)
x : 범주형 데이터
'

#mtcars 데이터셋의 cyl(실린더 개수 변수)의 빈도수로서 4/6/8기통 별로 몇 개 인지 출력
table(mtcars$cyl)

summary(mtcars)

str(mtcars)

comment = '
백분율 및 비율 탐색
length(x)
x : 데이터
'

cnt <- table(mtcars$cyl)
total <- length(mtcars$cyl)
total
cnt / total

comment = '
시각화
범주형 데이터에 대한 개별데이터는 barplot / pie 함수를 통하여 시각화
'

cnt <- table(mtcars$cyl)
barplot(cnt, xlab = '기통', ylab = '수량', main = '기통별 수량')
pie(cnt, main = '기통별 비율')

comment = '
2. 수치형 데이터
요약 통계량
summary() : 요약 통계량 출력
head() : 데이터 앞부분 출력
tail() : 데이터 뒷부분 출력
str() : 데이터 속성 출력
View() : 뷰어 창에서 데이터 확인
dim() : 데이터의 차원 출력

summary 함수 : 최솟값, Q1, Q2, Q3, 최댓값을 구할 수 있음
summary(object)
object : 요약 통계량을 위한 객체
'

summary(mtcars$wt)

comment = '
head 함수 : 데이터의 앞부분을 출력
head(x, n)
x : 출력을 위한 객체
n : 출력할 데이터 개수(기본값은 6)
'

head(mtcars$wt)

comment = '
str 함수 : 데이터의 속성을 출력
str(object)
object : 데이터 속성 출력을 위한 객체
'

str(mtcars)

comment = '
개별 데이터의 시각화
히스토그램 / 박스플롯
'

#hist 함수를 이용하여 히스토그램 출력
wt_hist <- hist(mtcars$wt, breaks=5, xlab = '무게', ylab = '수량', main = '무게별 수량')
#boxplot 함수를 이용하여 박스플롯 출력
wt_box <- boxplot(mtcars$wt, main = '무게 분포')

comment = '
다차원 데이터 탐색 : 범주형-범주형 / 수치형-수치형 / 범주형-수치형

범주형-범주형
- 빈도수와 비율을 활용한 교차 빈도, 비율, 백분율 분석
- 시각화는 막대형 그래프(barplot)

수치형-수치형
- 산점도와 기울기를 통하여 변수 간의 상관성을 분석
- 상관성과 추세성 여부는 산점도를 이용하여 시각화
- 공분산을 통하여 방향성 파악
- 피어슨 상관 계수를 통하여 방향과 강도 파악

범주형-수치형
- 범주형 항목들을 그룹으로 간주, 각 그룹에 따라 수치형 변수의 기술 통계량 차이를 상호 비교
- 그룹 간 비교를 위하여 박스플롯을 이용하여 시각화

1. 범주형-범주형 데이터 탐색 : 빈도수와 비율을 활용
빈도수와 비율 탐색 - table
'

table(mtcars$am, mtcars$cyl)

#factor 함수를 이용하여 변속기어 변수(am) 값이 0이면 오토, 1이면 수동으로 명명
mtcars$label_am <- factor(mtcars$am, labels = c('automatic', 'manual'))

table(mtcars$label_am, mtcars$cyl)

comment = '
빈도수와 비율 탐색 - prop.table / addmargins
prop.table(x)
x : 표시하고자 하는 table형식의 데이터
addmargins(x, margin)
x : 표시하고자 하는 table / array 형식의 데이터
margin : 합계를 표시하려는 행 또는 열 지정
1 = 열의 합계
2 = 행의 합계
c(1, 2) = 열과 행 합계 모두 표시(기본값)
'

#100을 곱하는 이유는 % 표현으로 변경을 위함
prop_table <- prop.table(table(mtcars$label_am, mtcars$cyl)) * 100
prop_table
#round함수를 통해 소수 1번째 자리까지만 표현
addmargins(round(prop_table, digits=1))

comment = '
범주형-범주형 데이터는 주로 barplot으로 시각화
'

barplot(table(mtcars$am, mtcars$cyl), xlab = '실린더 수', ylab = '수량')

comment = '
2. 수치형-수치형 데이터 탐색
피어슨 상관 계수를 이용하여 변수간의 상관관계를 파악하고 산점도로 변수 간의 상관성을 시각화

상관관계 탐색
cor(x, y, method, ...)
x : 상관관계를 계산하기 위한 X에 해당하는 데이터
y : 상관관계를 계산하기 위한 Y에 해당하는 데이터
method : 상관 계수 종류 선택
pearson = 피어슨 상관계수(기본값)
spearman = 스피어만 상관계수
kendall = 켄달 순위 상관계수
'

cor_mpg_wt <- cor(mtcars$mpg, mtcars$wt)
#피어슨 상관계수 값이 -0.87 정도로 강한 음의 상관관계를 가짐
cor_mpg_wt
#실제로 시각화 하였을 때 음의 형태
plot(mtcars$mpg, mtcars$wt)

comment = '
3. 범주형-수치형 데이터 탐색
범주형 데이터 항목들을 그룹으로 간주하고 항목들에 관한 기술 통계량으로 데이터 탐색
시각화는 boxplot 이용

그룹 간 기술 통계량 분석
aggregate(formula, data, FUN, ...)
formula : y~x 형식의 공식
data : 분석 대상 데이터
FUN : 적용할 함수(mean, median 등)
'

aggregate(mpg~cyl, data = mtcars, FUN = mean)
boxplot(mpg~cyl, data = mtcars, main = '기통별 연비')