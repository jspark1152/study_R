comment = '
앙상블 : 여러 가지 동일한 종류 또는 상이한 모형들의 예측/분류 결과를 종합하여 최종적인 의사결정에 활용하는 기법

배깅 Bagging
- 훈련 데이터에서 다수의 부트스트랩 자료를 생성, 각 자료를 모델링한 후 결합하여 최종 예측 모형을 만듬
- 부트스트랩은 주어진 자료에서 동일한 크기의 표본을 랜덤 복원 추출로 뽑은 자료를 의미

모형 구축
- adabag 패키지의 bagging 함수
bagging(formula, data, mfinal, control)
formula : 종속변수~독립변수
data : 데이터
mfinal : 반복수 또는 트리의 수
control : 의사결정나무 옵션
'

#데이터 탐색
data(PimaIndiansDiabetes2)
str(PimaIndiansDiabetes2)
head(PimaIndiansDiabetes2)
summary(PimaIndiansDiabetes2)

#데이터 전처리
PimaIndiansDiabetes2 <- na.omit(PimaIndiansDiabetes2) #결측값 제거
summary(PimaIndiansDiabetes2)

#모형 구축
train.idx <- sample(1:nrow(PimaIndiansDiabetes2), size=nrow(PimaIndiansDiabetes2)*2/3)
train <- PimaIndiansDiabetes2[train.idx,]
test <- PimaIndiansDiabetes2[-train.idx,]
md.bagging <- bagging(diabetes ~., data=train, nbagg=25)
md.bagging

#모형 평가
pred <- predict(md.bagging, test)
confusionMatrix(as.factor(pred), reference=test$diabetes, positive='pos')
#결과가 좋은 성능은 아닌듯 함