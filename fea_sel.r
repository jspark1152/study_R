comment = '
변수 선택 : 데이터의 독립변수 X, 종속변수 Y 에 가장 관련성이 높은 변수만을 선정하는 방법

특징
- 사용자가 해석하기 쉽게 모델을 단순화해주고 훈련 시간 축소, 차원의 저주 방지, 과적합을 줄여 일반화를 해주는 장점
- 변수를 선택하면 모델의 정확도 향상 및 성능 향상을 기대

선택 기법
1. 전진 선택법
- 모형을 가장 많이 향상 시키는 변수를 하나씩 점진적으로 추가
- 비어 있는 상태에서 시작하며 변수 추가 시 선택기준이 향상되지 않을 때는 변수 추가를 중단
2. 후진 선택법
- 모두 포함된 상태에서 시작하여 가장 적은 영향을 주는 변수부터 하나씩 제거하는 방법
- 더 이상 제거할 변수가 없다고 판단될 때 변수 제거 중단
3. 단계적 방법
- 전진 / 후진 함께 사용

변수 선택은 step 함수를 사용, direction 옵션을 통하여 선택
기준은 AIC(Akaike Information Criterion)로 하여 모델을 선택

step 함수 : AIC가 작아지는 방향으로 단계적으로 변수를 선택
step(object, scope, direction)
object : 대상 객체
scope : 탐색할 모델의 범위를 지정
direction : 변수 선택 방향 결정
forward = 전진
backward = 후진(scope가 없으면 기본값)
both = 단계적(scope가 있으면 기본값)

formula 함수 : step 함수를 수행한 뒤 반환 값을 파라미터로 전달받아 종속변수~독립변수 형태를 구하는 함수
formula(x)
x : step 함수의 반환 값을 입력
'

data(mtcars)
m1 <- lm(hp~., data=mtcars)
m2 <- step(m1, direction='both')
#m2 결과를 유심히 살펴볼 필요가 있음. 변수가 어떻게 추가되는지 원리 이해.
#마지막 스텝에서 wt, disp, carb 중 어떤 변수를 제거해도 AIC가 더 작아지지 않기 때문에 중지

#따라서 formula 결과는 hp ~ disp + wt + carb 로 출력됨
formula(m2)

comment = '
파생변수 생성
- 파생변수는 주어진 독립변수에서 분석 목적에 맞게 파생해낸 변수
- 도메인에 대한 지식을 통하여 생성하거나 상호작용 변수를 추가
- 주관적인 관점이 포함될 수 있으므로 타당성이 따라야함
'
pima <- PimaIndiansDiabetes
summary(pima$age)

#cut 함수를 통해 20~39=Young, 40~59=Middle, 60~100=Old로 구분
pima <- pima %>% mutate(age_gen = cut(pima$age, c(20, 40, 60, 100), right = FALSE, label = c('Young', 'Middle', 'Old')))
table(pima$age_gen)

comment = '
더미 변수 생성
- 더미 변수는 회귀 분석에서 범주형 변수의 각 범주를 0과 1의 값만으로 표현하여 생성한 변수
- 실질적으로는 이분형 변수이지만 연속형 변수로 간주하고 분석에 사용
- lm 함수에서 범주형 변수는 자동으로 더미 변수로 변환하여 분석을 수행
- 더미 변수의 개수 = 범주의 개수 - 1 (기준값 = 0)
'

중요도 <- c('상', '중', '하')
df <- data.frame(중요도)
df

transform(df, 변수1 = ifelse(중요도=='중', 1, 0), 변수2 = ifelse(중요도=='하', 1, 0))