comment = '
랜덤 포레스트 Random Forest
- 의사결정나무의 특징인 분산이 크다는 점을 고려하여 배깅과 부스팅보다 더 많은 무작위성을 주어 약한 학습기들을 생성한 후 이를 선형 결합
- 랜덤 입력에 따른 여러 트리의 집합인 포레스트를 이용한 분류 방법

모형 구축
- randomForest 패키지의 randomForest 함수 이용
randomForest(formula, data, ntree, mtry)
formula : 종속변수~독립변수
data : 데이터 프레임
ntree : 사용할 트리 수
mtry : 각 분할에서 랜덤으로 뽑힌 변수의 수(분류모델 = 변수 개수, 회귀모델 = 변수 개수/3)
'

#데이터 탐색
data(PimaIndiansDiabetes2)
summary(PimaIndiansDiabetes2)

#데이터 전처리
PimaIndiansDiabetes2 <- na.omit(PimaIndiansDiabetes2)
summary(PimaIndiansDiabetes2)

idx <- sample(1:nrow(PimaIndiansDiabetes2), size=nrow(PimaIndiansDiabetes2)*2/3)

train <- PimaIndiansDiabetes2[idx,]
test <- PimaIndiansDiabetes2[-idx,]

#모형 구축
md.rf <- randomForest(diabetes ~., data=train, ntree=100, proximity=TRUE)
md.rf

#모형 평가 : importance 함수를 이용
importance(md.rf)
#glucose 변수의 중요도가 가장 높음

pred <- predict(md.rf, newdata=test)
confusionMatrix(as.factor(pred), test$diabetes, positive='pos')