#ggplot 패키지는 그래픽 문법에 기반한 그래프
#데이터와 좌표체계 등 동일한 구성요소로 모든 그래프를 작성할 수 있다는 아이디어에서 착안
#ggplot 구성요소
#Data : 시각화하려는 데이터 또는 실제 정보를 의미
#Aesthetics : 축의 스케일, 색상, 채우기 등 미학적/시각적 속성을 의미
#Geometries : 데이터를 표현하는 도형을 의미

comment = '
ggplot(data, aes(x, y))+geom_xx() 또는 ggplot()+geom_xx(data, aes(x, y))
data : 그래프를 그릴 객체명
aes(x, y) : x=x축에 해당하는 컬럼명 / y=y축에 해당하는 컬럼명
geom_xx() : 그래프 지정 함수
'

comment = '
ggplot(data, aes(x, y))+geom_bar()
data : 그래프를 그릴 객체명
aes(x, y) : x=x축에 해당하는 컬럼명 / y=y축에 해당하는 컬럼명
geom_bar() : 막대그래프 출력
'

#diamonds 데이터 셋은 기본 내장형 데이터 셋으로 10개의 컬럼으로 구성
ggplot(diamonds, aes(color))+geom_bar() #color라는 컬럼 사용

comment = '
ggplot(data, aes(x, y))+geom_point()
data : 그래프를 그릴 객체명
aes(x, y) : x=x축에 해당하는 컬럼명 / y=y축에 해당하는 컬럼명
geom_point() : 산점도 출력
'

#sleep 데이터 셋은 2개의 약 효력으로 인한 수면데이터와 관련된 데이터 셋으로 3개의 컬럼(extra=수면 시간 증가, group=약물 종류, ID=환자 id)으로 구성
ggplot(sleep, aes(x=ID, y=extra))+geom_point()

comment = '
ggplot(data, aes(x, y))+geom_line()
data : 그래프를 그릴 객체명
aes(x, y) : x=x축에 해당하는 컬럼명 / y=y축에 해당하는 컬럼명
geom_line(mapping) : 시계열 그래프 출력 *mapping = aes의 매개변수인 color를 이용하여 line 색상을 다르게 표현
'

#Orange 나무 성장과 관련된 데이터 셋으로 3개의 컬럼(Tree=나무 종류, age=수령, circumference=나무 둘레)으로 구성
ggplot(Orange, aes(age, circumference))+geom_line(aes(color=Tree))

comment = '
ggplot(data, aes(x, y, group))+geom_boxplot()
data : 그래프를 그릴 객체명
aes(x, y, group) : x=x축에 해당하는 컬럼명 / y=y축에 해당하는 컬럼명 / group=박스 플롯을 그리는 기준 컬럼
geom_boxplot() : 박스 플롯 출력
'

#airquality는 뉴욕 대기 질과 관련된 데이터 셋으로 6개의 컬럼(Ozone=평균 오존, Solar.R=일간 태양 복사, Wind=일간 평균 풍속, Temp=일간 평균 기온, Month=월, Day=일)
ggplot(data=airquality, aes(x=Month, y=Temp, group=Month))+geom_boxplot()
