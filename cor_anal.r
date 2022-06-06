comment = '
상관 분석 Correlation Analysis
두 변수 사이에 존재하는 상호 연관성의 존재 여부와 연관성의 강도를 측정하여 분석. 단, 인과관계를 설명하는 것은 아님.

표현방법
1. 산점도(Scatter Plot)
2. 공분산을 통한 표현
-공분산 : 2개의 변수 사이의 상관 정도를 나타내는 값. 측정단위에 따라 달라지므로 선형 관계의 강도를 나타내지는 못함.
-상관 계수 함수
cor(x, method, ...)
x : 상관 계수 계산하기 위한 대상 데이터
method : 계산할 상관 계수 종류
pearson(기본값) = 피어슨 상관 계수
spearman = 스피어만 상관 계수
kendall = 켄달 순위 상관 계수
-상관 계수 시각화 함수 : pairs 함수와 corrplot 패키지의 corrplot 함수를 이용
pairs(x, ...)
x : 시각화 대상 데이터
-상관 계수 검정 : cor.test 함수를 이용
귀무가설과 대립가설은 다음과 같이 설정
귀무가설(H0) = 변수1과 변수2 사이에는 상관관계가 없다.(상관계수 = 0)
대립가설(H1) = 변수1과 변수2 사이에는 상고나관계가 있다.(상관계수 != 0)
cor.test(x, y, method, ...)
x, y : 상관 계수 검정을 위한 벡터형 데이터
method : 검정 상관 계수 종류 (pearson/spearman/kendall)
'

data(PimaIndiansDiabetes)
#View(PimaIndiansDiabetes)
#PID 데이터 셋에서 3 4 5 8열을 df_pima로 지정
df_pima <- PimaIndiansDiabetes[c(3:5, 8)]
str(df_pima)
summary(df_pima)

#변수 4개에 대한 피어슨 상관계수를 출력 > triceps 와 insulin 두 변수에서 뚜렷한 양의 상관관계가 나타남
cor(x = df_pima, method = 'pearson')

cor(x = df_pima, method = 'spearman')

cor(x = df_pima, method = 'kendall')

#windows(width = 12, height = 10)
corrplot(cor(df_pima), method = 'circle', type = 'lower')
#결과를 보면 상관관계가 강한 경우 원의 크기 또한 큼

#triceps 와 insulin 두 변수의 상관 관계가 강했기 때문에 이에 대한 검정을 진행
#먼저 정규성 만족 여부 검정 : shapiro.test
shapiro.test(df_pima$triceps)
shapiro.test(df_pima$insulin)
#두 변수 모두 p 값이 0.05 보다 작으므로 귀무가설을 기각. 즉, 두 변수 모두 정규성을 만족한다고 할 수 없음.
#따라서 비모수 검정 방법인 스피어만 또는 켄달 상관 계수를 이용해야 함

cor.test(df_pima$triceps, df_pima$insulin, method = 'kendall')
#p 값이 0.05 보다 작으므로 귀무가설을 기각하고 대립가설 채택
#즉, 두 변수의 상관관계는 0이 아니라고 유의하게 볼 수 있음
#tau(상관 계수)는 약 0.42 로 뚜렷한 양의 선형 관계

cor.test(df_pima$triceps, df_pima$insulin, method = 'spearman')
#스피어만 검정을 해도 결과는 비슷