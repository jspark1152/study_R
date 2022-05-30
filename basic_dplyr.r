comment = '
dplyr 패키지는 R에서 데이터 전처리 작업에 가장 많이 사용됨
주요함수는 다음과 같음
select : 열 추출
filter : 행 추출
mutate : 변수 추가
group_by : 데이터 그룹별로 나눔
summarise : 요약 통계치 산출
arrange : 데이터 정렬
inner_join : 두 데이터프레임에서 공통적으로 존재하는 모든 열 병합
left_join : 왼쪽 데이터프레임 기준으로 모든 열 병합
right_join : 오른쪽 데이터프레임 기준으로 모든 열 병합
full_join : 두 데이터프레임 모든 열 병합
bind_rows : 행 방향으로 데이터 결합
bind_cols : 열 방향으로 데이터 결합
'

comment = '
데이터프레임이름 %>% select(선택할 변수명, -제외할 변수명)
%>% : 파이프 연산자로 기호 앞에 데이터를 계속 사용한다는 의미
'

#iris %>% select(Sepal.Length) : S.L 열만 추출
#iris %>% select(-Sepal.Length) : S.L 열을 제외

comment = '
데이터프레임이름 %>% filter(조건)
조건에 맞는 데이터 추출
'

#iris %>% filter(Species=='setosa') %>% select(Sepal.Length, Sepal.Width)
#iris 데이터 프레임에서 'setosa'인 행만 추출한 후 S.L과 S.W열을 추출

comment = '
데이터프레임이름 %>% mutate(새로운 변수명 = 값)
데이터에 새로운 파생변수를 추가
'

#iris %>% filter(Species == 'virginica') %>% mutate(Len = ifelse(Sepal.Length>6, 'L', 'S')) %>% select(Species, Len)
#iris 데이터 프레임에서 'virginica' 종만 필터링한 후 Len 이란 파생변수를 생성 이 때 변수 값은 S.L값이 6보다 클 경우 L, 아닌 경우 S로 하며 최종적으로 Species와 Len 열값을 추출

comment = '
group_by는 지정한 변수들을 기준으로 데이터를 그룹화하는 함수이며 summarise는 요약 통계치를 계산하는 함수
이 두 함수는 함께 쓰이는 경우가 많음

데이터프레임이름 %>% group_by(그룹화할 기준 변수1, ...) %>% summarise(새로운 변수명 = 계산식)
'

#iris %>% group_by(Species) %>% summarise(P.W = mean(Petal.Width))
#iris 데이터 프레임에서 Species 값을 기준으로 그룹화하고 P.W라는 Petal.Width의 평균값을 그룹의 요약값으로 출력

comment = '
데이터프레임이름 %>% arrange(정렬 기준변수) : 오름차순 정렬
데이터프레임이름 %>% arrange(desc(정렬 기준변수)) : 내림차순 정렬
'

#iris %>% filter(Species == 'setosa') %>% mutate(Len = ifelse(Sepal.Length>5, 'L', 'S')) %>% select(Species, Len, Sepal.Length) %>% arrange(desc(Sepal.Length))
#iris 데이터 프레임에서 'setosa' 종을 필터링한 후 Len 파생변수 생성하고 Species, Len, Sepal.Length 열들을 추출한 후 S.L를 내림차순으로 정렬

commnet = '
inner_join(x, y, by, ...) : 두 데이터 프레임에서 공통적으로 존재하는 모든 열을 병합
x, y : 병합할 데이터 프레임
by : 병합 기준 컬럼
'

#X <- data.frame(Department=c(11,12,13,14), DepartmentName=c('Production', 'Sales', 'Marketing', 'Research'), Manager=c(1, 4, 5, NA))
#Y <- data.frame(Employee=c(1,2,3,4,5,6), EmployeeName=c('A', 'B', 'C', 'D', 'E', 'F'), Department=c(11,11,12,12,13,21), Salary=c(80,60,90,100,80,70))

#inner_join(X,Y,by='Department')

comment = '
left_join(x, y, by, ...) : 왼쪽 데이터 프레임을 기준으로 열을 병합
right_join(x, y, by, ...) : 오른쪽 데이터 프레임을 기준으로 열을 병함
full_join(x, y, by, ...) : 두 데이터 프레임에 존재하는 모든 열을 병합
'

#left_join(X, Y, by='Department')
#right_join(X, Y, by='Department')
#full_join(X, Y, by='Department')

comment = '
bind_rows(데이터명1, ...) : 데이터의 행들을 이어 붙여 결합
'

#x <- data.frame(x=1:3, y=1:3)
#y <- data.frame(x=4:6, z=4:6)

#bind_rows(x, y)

comment = '
bind_cols(데이터명1, ...) : 데이터의 열들을 이어 붙여 결합
'

#x <- data.frame(title=c(1:5), a=c(30,70,45,90,65))
#y <- data.frame(b=c(70,65,80,80,90))

#bind_cols(x, y)

comment = '
reshape2 패키지 : melt, cast 함수를 사용

melt(data, id.vars, measure.vars, na.rm)
data : 함수를 적용할 데이터 프레임
id.vars : 데이터를 변형할 때 기준이 되는 식별자 컬럼들
measure.vars : 식별자가 아닌 측정치 컬럼들, 지정하지 않는 경우 id.vars 외의 모든 컬럼으로 지정
na.rm : 결측값이 포함된 행을 삭제할지의 여부(기본값은 FALSE)
'

#a <- melt(data = Cars93, id.vars = c('Type', 'Origin'), measure.vars = c('MPG.city', 'MPG.highway'))

#a

comment = '
dcast(data, formula, fun.aggregate)
data : melt 함수가 적용된 형태의 데이터 프레임
formula : id변수 ~ variable변수 형태로 입력, 여러 변수를 나열할 경우는 +, 아무 변수도 지정하지 않는 경우 ., 나열되지 않은 모든 변수들을 지정하는 경우 ...
fun.aggregate : id변수를 기준으로 여러 행이 존재할 경우 해당 행들에 적용할 집합 함수
'

#a <- melt(data = Cars93, id.vars = c('Type', 'Origin'), measure.vars = c('MPG.city', 'MPG.highway'))

#dcast(data = a, Type + Origin ~ variable, fun = mean)
#Type과 Origin이 id변수로 이를 기준으로 variable 값들을 평균치로 반환

comment = '
data.table 패키지는 연산속도가 매우 빨라서 크기가 큰 데이터를 처리
데이터 테이블은 데이터 프레임과 동일하게 취급되므로 데이터 프레임에 적용할 수 있는 함수들을 사용할 수 있음

data.table(tag=value, ...) : 데이터 테이블의 클래스는 데이터 프레임을 포함하기 때문에 데이터 테이블로 변환해서 사용이 가능
'

#t <- data.table(x=c(1:3), y=c('가', '나', '다'))
#t

comment = '
as.data.table(데이터 프레임) : 데이터 프레임을 테이블로 변환
'

iris_table <- as.data.table(iris)
iris_table

comment = '
데이터테이블[행, 열, by] : 조건에 맞는 데이터에 접근
by : 데이터를 그룹화할 기준변수 지정
'

iris_table[1,]
iris_table[1:2,]
iris_table[, mean(Petal.Width), by='Species']
#Species를 기준으로 P.W 값에 접근하여 이의 평균값을 출력

comment ='
패키지를 설치할 때 이전에 설치된 패키지와 동일한 함수명이 있는 경우 충돌이 발생

tidyverse 패키지를 사용하면 충돌되는 함수를 확인 가능
'