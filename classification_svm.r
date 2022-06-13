comment = '
4. 서포트 벡터 머신 Support Vector Machine
- 데이터를 분리하는 초평면 중에서 데이터들과 거리가 가장 먼 초평면을 선택하여 분리하는 지도 학습 기반의 이진 선형 분류 모델
- 최대 Margin을 가지는 비확률적 선형 판별에 기초

R에는 SVM을 위한 e1071 패키지 등이 있음
svm(formula, data = NULL)
predict(object, data, type) : 만들어진 모델에 대한 예측 수행
object : svm 객체
data : 예측을 수행할 데이터
type : 예측 결과 유형(response=예측값, probabilities=확률)
'

#데이터 탐색
str(iris)
head(iris)
summary(iris)

#전처리 : 결측값이 존재하지 않음

#변수 선택 : Species 제외한 모든 변수 선택

#모형 구축
model <- svm(Species ~., data = iris)
model

#모형 평가
pred <- predict(model, iris)
confusionMatrix(data = pred, reference = iris$Species)
#정확도가 상당히 높음
#민감도 및 특이도 역시 클래스별로 상당히 높음