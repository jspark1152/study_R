#실기 교재 Start
comment = "1
2
3
4
5+6
"

#덧셈
7+4
#뺄셈
7-4
#곱셈
7*4
#나눗셈
7/4
#나눗셈의 나머지
7%%4
#나눗셈의 몫
7%/%4
#지수 계산
7^4

#관계 연산자
7>4
7<4
7>=4
7<=4
7==4
7!=4

#논리 연산자
#& : 두 논리값이 모두 참이면 참, 아니면 거짓
TRUE & FALSE
3 & 0 #0은 False 나머지 수는 True로 판단
#| : 하나라도 참이면 참, 아니면 거짓
TRUE | FALSE
3 | 0
#! : 반대 논리값 출력
!TRUE
!1
!0

#대입 연산자 = <- ->

#변수 생성
a = 'bigdata'
b <- 5
print(a)
print(b)

#데이터 타입 확인
mode(a)
mode(b)
typeof(b) #typeof는 숫자형 데이터를 정수형인지 실수형인지도 구분
mode(TRUE)
typeof(FALSE)

#NA = Not Available(결측값) > 결측값인지 확인을 위해 is.na() 함수 사용
a <- NA
is.na(a)
b <- 3
is.na(b)
#NULL = 변수가 초기화되지 않는 경우 > is.null() 함수로 확인
c <- NULL
is.null(c)

#데이터 타입 확인 함수
is.numeric(c(1:4))
is.integer(c(1:4))
is.double(c(1:4))
is.character(c('a', 'b'))
is.logical(c(1:4))
is.null(c())
is.na(c(NA, 2, NA))

#c 를 이용하여 벡터 생성, 이 때 각 데이터들은 모두 같은 데이터 타입이어야 함
x <- c(1,2,3)
x
y <- c("1", 2, '3') #문자형이 하나라도 있는 경우 모든 성분이 문자형으로 변환
y
z <- c(5:10)
z

#반복 함수 = rep(반복할 객체, 반복 횟수)
x <- rep(c(1:3), 4)
x

#수열 함수 = seq(from, to, by(증감을 의미))
x <- seq(1, 10, 3)
x

#인덱싱
x[2] #x 벡터의 2번째 성분 출력
x[-1] #x 벡터의 1번째 성분을 제외한 성분들 출력
x[x>2] #조건문에 해당하는 성분들 출력
x[2:6] #x 벡터의 2번째부터 6번째 성분들을 모두 출력, 없는 경우 결측값으로 출력

#벡터 연산
x <- c(1:3)
x*3
y <- c(3:5)
x+y
x*y
z <- c(7:10) #두 벡터가 길이가 다른 경우 짧은 쪽 벡터를 반복
#x+z
#x*z

#R에서 리스트 개념 = 파이썬에서는 딕셔너리 형
#(키, 값) 형태의 데이터를 담을 수 있는 구조
#list(k1=v1, k2=v2,...)
list(name = 'soo', height = 90)
list(name = 'soo', height = c(2, 6))

#리스트 중첩
list(x=list(a = c(1,2,3)), y=list(b = c(1,2,3,4)))

#행렬은 벡터와 마찬가지로 한가지 유형의 스칼라 값만 취함
#matrix(data, nrow=행의 개수, ncol=열의 개수, byrow=데이터 입력 순서로 기본값은 False-열 기준, dimnames=행과 열의 이름 리스트)
matrix(c(1:12), nrow=4)
matrix(c(1:12), nrow=4, byrow=TRUE)
matrix(c(1:12), ncol=4)
matrix(c(1:9), nrow=3, dimnames=list(c('t1', 't2', 't3'), c('c1', 'c2', 'c3')))

a <- matrix(c(1:4), nrow=2)
b <- matrix(c(1:4), nrow=2)

#사칙연산인데 행렬곱이 수학에서의 행렬곱이 아니고 그냥 동위값들과의 연산
a+b
a-b
a*b
a/b
t(a) #Transpose matrix
solve(a) #Inverse matrix
a%*%b #수학에서의 행렬곱

#데이터 프레임 : 벡터들의 집합, 행과 열로 이루어진 표 형식의 구조, 행렬과는 다르게 각 변수들이 서로 다른 데이터 타입을 가질 수 있음
#data.frame(변수명1=벡터1, ...)

d <- data.frame(a=c(1,2,3,4), b=c(2,3,4,5), c=c('M','F','M','F'))
d
str(d)

exam <- data.frame('이름'=c('홍길동', '장길산', '임꺽정', '수제비'), '영어점수'=c(60, 70, 80, 90), '수학점수'=c(70, 50, 40, 90), '반'=c(1, 1, 2, 2))
exam
exam[2, 3]

#배열(Array) : 3차원 또는 그 이상으로 확장된 형태의 데이터(행렬은 2차원)
#array(data, dim=차원을 벡터로 지정, dimnames=배열의 차원이름 지정)

row_name <- c('1행', '2행')
col_name <- c('1열', '2열')
mat_name <- c('1차원', '2차원')
array(1:8, dim=c(2,2,2), dimnames=list(row_name, col_name, mat_name))

#팩터(Factor) : 범주형 자료를 표현, 범주형에는 순서형과 명목형이 있음
#factor(x=범주형데이터, levels=구분하고자 하는 범주 목록 지정, labels=범주별 표시 값 지정, ordered=TRUE(순서형), FALSE(명목형=default))

factor("s", levels=c('s', 'l')) #명목형
factor(c('a', 'b', 'c'), ordered=TRUE) #순서형
#음.. 팩터 아직 잘 이해가 안가는군..

#데이터 결합
#rbind(행결합)/cbind(열결합)/merge(행렬결합-동일한 키값 기준)
x <- data.frame(a=c('s1','s2','s3'), b=c('A','B','C'))
y <- data.frame(a=c('s5','s6','s7'), b=c('E','F','G'))
x
y
rbind(x, y)
cbind(x, y)
merge(x, y) #키값 중 겹치는 값이 없음

#merge : 공통된 (키값의)열을 하나 이상 가지고 있는 두 데이터 프레임에 대하여기준이 되는 특정 컬럼의 값이 같은 행끼리 묶는 기능
#merge(x, y, by=병합 기준 컬럼, by.x, by.y=기준 컬럼의 이름이 서로 다른 경우 이를 통해 지정, all=FALSE(공통행만 병합)/TRUE(공통이 아닌 경우는 NA로 채우고 전체 행 병합), all.x, all.y=TRUE(해당데이터의 모든 행이 결과에 포함))

x <- data.frame(name=c('a','b','c'), math=c(1,2,3))
y <- data.frame(name=c('c','b','d'), english=c(4,5,6))
merge(x, y) #공통된 키값은 b, c
merge(x, y, all.x=TRUE) #all.x를 활성화함으로서 x의 모든 행값을 포함
merge(x, y, all.y=TRUE) #all.y를 활성화함으로서 y의 모든 행값을 포함
merge(x, y, all=TRUE) #all을 활성화함으로서 x, y의 모든 행값을 포함
merge(x, y, by='name') #공통된 기준 컬럼이 name 뿐