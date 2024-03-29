comment = '
1. 회귀 분석
- 하나 이상의 독립변수들이 종속변수에 미치는 영향을 추정
- 독립변수와 종속변수와의 관계가 선형이고 독립변수의 개수가 하나이면 단순 선형 회귀, 독립변수가 2개 이상이면 다중 선형 회귀

회귀 분석 가정
- 선형성, 독립성, 등분산성, 비상관성, 정상성

단순 선형 회귀 분석 모형 구축 : lm 함수 사용
lm(formula, data)
formula : 종속변수~독립변수 형식으로 지정
data : 데이터

다중 선형 회귀 분석 모형 구축 : lm 함수 사용
lm(formula, data)
formula : 다중 회귀는 독립변수 여러 개 지정
data : 데이터

회귀 분석 평가(검증)
- 회귀 계수 검정
회귀 계수 beta1 = 0 이면 입력변수와 출력변수는 인과 관계 없음
회귀 계수 beta1 = 1 이면 적합된 추정식은 의미 없음
회귀 계수 t-통계량의 p-값이 0.05보다 작으면 통계적으로 유의
- 회귀 모형 설명력 - 결정 계수(R^2)
결정 계수는 전체 데이터를 회귀 모형이 얼마나 잘 설명하고 있는지를 보여주는 지표로 회귀선의 정확도를 평가
결정 계수 = SSR(회귀 제곱 합) / SST(전체 제곱 합)
수정된 결정 계수를 확인하기도 함
- 적합도 검정
결정 계수를 통해 추정된 회귀식이 얼마나 타당한지 검토(결정 계수가 1에 가까울수록 회귀 모형이 자료를 잘 설명)
독립변수가 많아지면 결정 계수가 높아지는 단점이 있음
- 통계적 유의성 검정
회귀 분석 결과로 산출되는 F-통계량의 p-값이 0.05보다 작으면 회귀 모형은 통계적으로 유의함
- 다중공선성
다중 회귀 분석에서 설명변수들 사이에 선형 관계가 존재하면 회귀 계수의 정확한 추정이 난해
분산팽창 요인(VIF) : 4보다 크면 다중공선성이 존재. 10보다 크면 심각.
상태지수 : 10 이상이면 문제가 있으며, 30 이상이면 심각.

회귀 분석 모형 결과 활용
- 모형의 잔차를 그래프로 그리고 회귀 진단을 수행하여 판단
- plot 함수를 이용해 lm;linear model 의 결과를 6가지 그래프로 진단
plot(x, which)
x : 선형 회귀 모형 지정
which : 그래프 종류 지정(6가지)
- 유형
1) 적합값 대비 잔차 그래프
x 축 = 예측된 Y값, y축 = 잔차
오차는 평균이 0이고 분산이 일정한 정규분포를 가정
잔차의 평균은 0이고 분산은 일정
그래프의 기울기가 0인 직선이 관측되는 것이 이상적
2) 잔차의 Q-Q 그래프
잔차가 정규분포를 따르는지 확인
3) 표준화 잔차 그래프
x축 = 예측된 Y값, y축 = 표준화 잔차
기울기가 0인 직선이 이상적
4) 쿡의 거리
회귀 직선의 모양에 크게 영향을 끼치는 점들을 찾는 방법
쿡의 거리는 Leverage(관측치가 다른 관측치 집단으로부터 떨어진 정도)와 잔차에 비례하므로 두 값이 큰 우측 상단과 우측 하단에 쿡의 거리가 큰 값들이 위치
5) 레버리지 대비 잔차 그래프
x축 = 레버리지, y축 = 표준화 잔차
레버리지로 독립변수가 얼마나 극단에 치우쳐 있는지 분석
6) 레버리지 대비 쿡의 거리
x축 = 레버리지, y축 = 쿡의 거리
레버리지와 쿡의 거리는 비례 관계
'
#Hitters 데이터셋은 ISLR 패키지에 있음
#View(Hitters)
library(ISLR)
#단순 선형 회귀 예제
#PutOuts에 따른 Salary 분석
summary(lm(Salary~PutOuts, data = Hitters))
#결과가 통계적으로는 유의하나 결정계수가 너무 작음

#다중 선형 회귀 예제
str(Hitters)
head(Hitters)
summary(Hitters)
#Hitters 데이터 셋 탐색
#Salary 변수에 결측값이 존재 > 전처리 작업
hitters <- na.omit(Hitters) #결측값을 제거
summary(hitters) #제거되었는지 확인

#분석모형구축
full_model <- lm(Salary ~ ., data = hitters)
summary(full_model)
#유의하지 않은 변수들에는 * 이 없음 > 이를 모두 제거
#유의한 변수들로 모델 다시 구축
first_model <- lm(Salary ~ AtBat + Hits + Walks + CWalks + Division + PutOuts, data = hitters)
#후진소거법을 통해 최적화 진행
fit_model <- step(first_model, direction = 'backward')
#결과로 Division, AtBat, PutOuts, Hits, CWalks 5변수가 선택됨.

#다중공선성 확인 및 해결 : car 패키지의 vif 함수를 이용
vif(fit_model)
#vif 값이 10 이상이면 문제가 심각하다고 해석
#가장 큰 AtBat 제거
second_model <- lm(Salary ~ Hits + CWalks + Division + PutOuts, data = hitters)
vif(second_model)
#결과 다중 공선성 문제가 해결되었음을 확인

summary(second_model)
#결정 계수값도 높아짐.