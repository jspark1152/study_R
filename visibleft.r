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

'