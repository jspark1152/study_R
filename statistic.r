comment = '
중심 경향성 통계량

1. 평균
mean(x, trim=0, na.rm=FALSE, ...)
x : 데이터
trim : 평균을 구하려는 값에서 양 극단의 일정 부분을 뺄 때 사용
na.rm : 결측값을 제거할지 지정
'

x <- c(0:50, 50)
mean(x)

#x 벡터에서 양쪽에서 전체의 10%에 해당하는 데이터를 제외하고 평균을 계산
mean(x, trim=0.1)

x <- c(12, 7, 4, -5, NA)
x
#결측값이 포함된 상태에서 평균 계산시 NA로 반환
mean(x)
mean(x, na.rm=TRUE)

mean(cars$speed)
mean(cars$speed, trim=0.2)

cars %>% summarise(mean01 = mean(speed), mean02 = mean(speed, trim=0.1))

comment = '
2. 중위수
median(x, na.rm=FALSE)
x : 데이터
na.rm : 결측값을 제거할지 지정
'

x <- c(12, 7, 5, -21, 8, -5)
#x의 길이가 짝수이기에 가운데 두 수의 평균으로 출력
median(x)

x <- c(12, 7, 4, -5, NA)
#평균과 마찬가지로 결측값을 포함한 상태에서 중위수를 확인시 NA로 출력
median(x)
median(x, na.rm=TRUE)

median(cars$speed)

cars %>% summarise(median01 = median(speed))

comment = '
3. 최빈수
최빈수를 구하는 함수가 없으므로 직접 함수를 정의해야함
'

getmode <- function(x){
    y <- table(x)
    names(y)[which(y==max(y))]
}

x <- c('a', 'b', 'b', 'a')
table(x)
max(table(x))
getmode(x)

comment = '
산포도 통계량

1. 분산
stats 패키지의 var 함수 이용
다른 패키지와 충돌될 경우 stats::var() 함수로 사용

var(x, y=NULL, na.rm=FALSE)
x : 데이터
y : 데이터(아마 공분산 계산 때 사용하지 않을까.. 예상)
na.rm : 결측값을 제거할지 지정
'

v <- c(3, 4, 5, 2, 4, 3, 4)
var(v)
var(1:10)

comment = '
2. 표준편차

sd(x, na.rm=FALSE)
x : 데이터
na.rm : 결측값을 제거할지 지정
'

v <- c(3, 4, 5, 2, 4, 3, 4)
sd(v)
sd(1:10)

comment = '
3. 범위
자료 중에서 최댓값과 최솟값의 차이를 의미
range 함수와 diff 함수를 이용

range(x, na.rm) : x 의 범위를 출력. 즉, 최솟값과 최댓값을 출력
diff(x, ...)
'

v <- c(1, 7, 3, 5, 11, 4, 6)
diff(range(v))
range(v)
diff(range(1:10))

comment = '
순위 계산
대상 데이터를 추출하거나 복잡한 시간 데이터를 결합할 때 시간 순서로 순위를 매겨 결합의 조건으로 이용할 수 있음
순위 계산 시에는 데이터의 행을 집약한 후에 집약한 결과를 다시 계산하여 각 행에 첨부
값의 순위 index는 row_number(), min_rank(), dense_rank() 함수를 사용
이 중 row_number()는 데이터값의 순위 index를 출력하는 함수

row_number(x)
min_rank(x)
dense_rank(x)
x : 순위(rank)를 지정할 벡터값
'

x <- c(1, 1, 5, 5, 9, 7)
x
#x 성분의 순위 중복 없이 순위 표시
row_number(x)
#x 성분의 순위 중복을 허용하여 순위 표시
min_rank(x)
#x 성분의 순위 중복을 허용하되 건너뜀 없이 순위 표시
dense_rank(x)

cars %>% arrange(dist) %>% mutate(rank=row_number(dist))

cars %>% arrange(dist) %>% mutate(rank=min_rank(dist))

cars %>% arrange(dist) %>% mutate(rank=dense_rank(dist))