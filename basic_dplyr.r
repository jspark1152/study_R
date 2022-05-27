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
