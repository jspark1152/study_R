comment = '
나이브 베이즈 기법
- 특성들 사이의 독립을 가정하는 베이즈 정리를 적용한 확률 분류기
- 베이즈 정리와 조건부 확률을 이용

모형 구축
- e1071 패키지의 naiveBayes 함수 이용
- 분석 데이터에서 훈련 데이터를 선정할 수 있음
- 라플라스 매개변수는 라플라스 추정기로 중간에 0이 들어가서 모든 확률을 0으로 만들어 버리는 것을 방지
naiveBayes(formula, data, subset, laplace, ...)
formula : 종속변수~독립변수
data : 데이터
subset : 훈련 데이터에서 사용할 데이터를 지정하는 인덱스 벡터
laplace : 라플라스 추정기 사용 여부(기본값 = 0)
'

#데이터 탐색
str(iris)
head(iris)
summary(iris)

#전처리 : 결측값 없음

#변수 선택 : Species 제외한 모든 변수 선택

#모형 구축
train_data <- sample(1:150, size = 100)
naive_model <- naiveBayes(Species ~., data=iris, subset=train_data)
naive_model

#모형 평가
pred <- predict(naive_model, newdata = iris)
confusionMatrix(pred, reference = iris$Species)
#정확도는 0.98로 높음
#민감도 및 특이도 역시 클래스별로 높음