comment = '
데이터 유형 변환

as.character() : 문자형으로 변환
as.numeric() : 숫자형으로 변환
as.double() : 실수형으로 변환
as.logical() : 논리형으로 변환
as.integer() : 정수형으로 변환
'

a <- 0:9
a
#정수형으로 확인
str(a)

a <- as.character(a)
a
#문자형으로 변환된 것을 확인
str(a)

a <- as.numeric(a)
a
#숫자형으로 변환
str(a)

a <- as.double(a)
a
str(a)
#실수형으로 확인
typeof(a)

a <- as.logical(a)
a
#논리형으로 0 = FALSE, 그 외의 숫자는 TRUE
str(a)

a <- as.numeric(a)
#논리형에서 숫자형으로 변환시 FALSE = 0, TRUE = 1로 변환. 즉, 본래 형태로 변환 불가능
a

a <- 10
typeof(a)
a <- as.integer(a)
typeof(a)

comment = '
자료구조 변환

as.data.frame() : 데이터를 데이터프레임으로 변환
as.list() : 데이터를 리스트로 변환
as.matrix() : 데이터를 행렬로 변환
as.vector() : 데이터를 벡터로 변환
as.factor() : 데이터를 요인으로 변환
'

a <- 0:4
str(a)
a <- as.data.frame(a)
a
str(a)

a <- 0:9
a <- as.data.frame(a)
a <- as.list(a)
a
str(a)

a <- 0:4
a <- as.matrix(a)
a
str(a)

a <- 0:9
a
str(a)
a <- as.vector(a)
a
str(a)

a <- c(0:9)
a
str(a)

a <- 0:9
a <- as.factor(a)
a
str(a)

comment = '
데이터의 범위 변환 : 정규화 / 표준화

scale(x, center = TRUE, scale = TRUE)
x : 수치형 행렬
center : x의 평균으로 값을 빼서 정규화 수행(기본값 TRUE), 수치형 데이터 입력 시 center에 지정된 값으로 뺄셈 실행
scale : x의 표준편차로 나누어서 정규화 수행(기본값 TRUE), 수치형 데이터 입력 시 scale에 지정된 값으로 나눗셈 실행

>> (x - center) / scale

정규화 : 데이터의 범위를 0과 1사이로 변환하여 데이터의 분포를 조정

최소-최대 정규화 : center = Minimum, scale = Maximum - Minimum
단점은 이상값에 너무 많은 영향을 받음
'

data <- c(1, 3, 5, 7, 9)
data_minmax <- scale(data, center = min(data), scale = max(data) - min(data))
data_minmax
mode(data)
class(data)

a <- 1:10
normalize <- function(a){return((a-min(a))/(max(a)-min(a)))}
normalize(a)

comment = '
표준화 : 정규분포를 따른다고 가정하고 평균 0, 표준편차 1 을 갖도록 변환

scale 함수를 통해 표준화 가능
'

data <- c(1, 3, 5, 7, 9)
#scale 함수의 기본 설정이 표준화
data_zscore <- scale(data)
mean(data_zscore)
sd(data_zscore)
data_zscore
