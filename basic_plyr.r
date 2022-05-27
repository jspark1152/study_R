comment = '
데이터 전처리 작업에 필요한 함수들을 모아놓은 패키지
대표적으로 plyr / dplyr / reshape2 / data.table 패키지들이 존재
'

comment = '
[plyr 패키지]
원본 데이터를 분석하기 쉬운 형태로 만듬
- 데이터 분할 split
- 원하는 방향으로 특정 함수 적용 apply
- 결과를 재조합 combine
함수는 pqply 형태로 p는 입력 데이터 형태, q는 출력 데이터 형태를 의미
ex) dlply : data.frame > list

adply(data, margins, fun)
data : 입력 데이터
margins : 함수 적용 방향 1 = 행 / 2 = 열 / c(1,2) = 행과 열 모두
fun : 적용할 함수
'

#adply(iris, 1, function(row){row$Sepal.Length >= 5.0 & row$Species == 'setosa'})
#iris 데이터셋을 이용하여 S.L가 5.0 이상이면서 'setosa' 품종인 경우 TRUE 값 반환하여 이를 array로 받아서 data frame에 추가

comment = '
ddply(data, .variables, ddply-func, fun)
data : 입력 데이터
.variables : 데이터를 그룹화할 기준이 되는 변수를 입력
ddply-func : ddply의 내부 함수
fun : .variables에 지정한 변수들의 값이 같은 데이터별로 적용할 함수
'

#ddply(iris, .(Species, Petal.Length<1.5), function(sub){data.frame(mean_to=mean(sub$Sepal.Length), mean_so=mean(sub$Sepal.Width), mean_wo=mean(sub$Petal.Length), mean_jo=mean(sub$Petal.Width))})
#iris 데이터셋의 Species, Petal.Length<1.5(논리)를 기준으로 함수를 이용해 평균값 데이터프레임을 반환

#ddply(iris, .(Species), summarise, mean_to=mean(Sepal.Length))
#iris 데이터셋의 Species 항목을 기준으로 S.L의 평균값을 종별로 반환
#내부함수인 summarise를 이용하면 종별로 종합이 가능

#ddply(iris, .(Species), function(sub){data.frame(mean_to=mean(sub$Sepal.Length))})
#summarise 안쓰면 다음과 같이 표현

comment = '
transform(_data, tag1=value1, tag2=value2, ...)
_data : 추가할 데이터 명
tag : 데이터에 새로 생성할 변수 명
value : 새로운 변수에 들어갈 열 데이터
'

#transform(iris, Total.w=Sepal.Width+Petal.Width)
#iris 데이터셋에 Total.w 라는 새로운 변수 열을 추가