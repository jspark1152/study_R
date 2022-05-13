#시각화를 위해 크게 graphics, ggplot 패키지를 사용
#graphics에는 산점도, 히스토그램, 막대형 그래프 등
#plot() = 산점도
#hist() = 히스토그램
#barplot() = 막대형 그래프
#pie() = 원그래프
#boxplot() = 상자 수염 그림

comment = '
plot(x, y, option)
x : y축을 우선으로 표현해야하기 때문에 y가 없을 경우 x가 y축을 표현
y : y축에 들어갈 데이터 저장

option
xlab : x축 label
ylab : y축 label
main : 그래프 Title
type : 출력 형태 지정(기본은 p=point)
p=점 / l=선 / b=점&선 / o=점&선(겹침) / h=히스토그램과 유사 / s=계단 형태 / S=(Upper)계단 형태 / n=좌표를 찍지 않음
'
a <- c(3,5,4)
plot(a) #a가 y축으로, x축에는 index 자동생성
plot(a, main='Example', type='n') #다양한 타입으로 출력

#R에서 제공하는 iris 데이터 셋을 이용
length <- iris$Petal.Length
width <- iris$Petal.Width
plot(x=length, y=width, xlab='꽃잎 길이', ylab='꽃잎 너비', main='꽃잎과 길이')

x <- c(1,5,2,4,6,9,11,8,13)
plot(x, main='시계열 그래프 예제', type='l')

comment ='
hist(x, option)
x축에는 각 계급을 표시하며 y축에는 각 계급의 도수 또는 상대도수를 표시

option
xlab : x축 label
ylab : y축 label
main : 그래프 title
freq : TRUE인 경우 도수(기본값), FALSE인 경우 상대도수 표시
breaks : 계급 구간 지정
'

length <- iris$Sepal.Length
hist(x = length, xlab = '꽃받침 길이', ylab = '수량', main= '꽃받침 길이 분포', breaks = 4, freq = FALSE)

comment = '
barplot(height, option)
height : 각 기둥에 해당하는 값

option
xlab : x축 label
ylab : y축 label
main : 그래프 title
names.arg : 각 막대에 사용할 문자열 벡터
'

height <- c(15, 23, 5, 20)
name <- c('1분기', '2분기', '3분기', '4분기')
barplot(height, names.arg = name)

h <- table(iris$Species)
barplot(h, ylab = '수량', main = '종별 수량')

comment = '
barplot(formula, data, option)
formula : x축과 y축의 데이터를 지정, y~x 로 y는 수치형 / x는 범주형
data : 데이터프레임 및 리스트데이터

option
xlab : x축 label
ylab : y축 label
main : 그래프 title
names.arg : 각 막대에 사용할 문자열 벡터
'

sales <- c(15, 23, 5, 20)
seasons <- c('1분기', '2분기', '3분기', '4분기')
df <- data.frame(sales, seasons)
barplot(sales~seasons, data=df)

comment = '
pie(x, option)
x : 파이의 조각 형태로 표시하는 수치형 벡터

option
labels : 파이 조각의 이름
density : 파이 조각 사선의 밀도
angle : 사선의 각도
main : 그래프 title
'

p <- c(15, 23, 5, 20)
l <- c('1분기', '2분기', '3분기', '4분기')
pie(x = p, labels=l, density=5, angle=30 * 1:4)

comment = '
boxplot(x, option)
x : 상자 수염 그림에 표시할 수치형 벡터

option
xlab : x축 label
ylab : y축 label
main : 그래프 title
notch : TRUE=중위수에 대한 신뢰 구간을 움푹 들어간 형태 / FALSE(기본값)=움푹 들어가지 않음
'

s <- iris$Sepal.Length
boxplot(s, main='꽃받침 길이 분포', notch=TRUE)

comment = '
boxplot(formula, option)
formula : x축과 y축의 데이터를 지정, y~x 로 y는 수치형 / x는 범주형

option
xlab : x축 label
ylab : y축 label
main : 그래프 title
notch : TRUE=중위수에 대한 신뢰 구간을 움푹 들어간 형태 / FALSE(기본값)=움푹 들어가지 않음
'

boxplot(iris$Sepal.Length~iris$Species, notch=TRUE, xlab='종별', ylab='꽃받침 길이', main='종별 꽃받침 길이 분포')