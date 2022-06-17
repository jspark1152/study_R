comment = '
분류 모형 평가 : 혼동 행렬과 AUC 등을 이용

혼동 행렬 ConfusionMatrix
- 혼동 행렬은 분석 모델에서 구한 분류의 예측 범주와 데이터의 실제 분류 범주를 교차 표 형태로 정리한 행렬
- caret 패키지의 confusionMatrix 함수 이용
- 분류 모델의 성능을 평가
confusionMatrix(data, reference, ...)
data : 예측된 분류 데이터 또는 분할표(table 형식)
reference : 실제 분류 데이터
'

data('PimaIndiansDiabetes2')

df_pima <- na.omit(PimaIndiansDiabetes2)

#sample의 일정한 결과를 위하여 시드 배정
set.seed(19190301)
train.idx <- sample(1:nrow(df_pima), size = nrow(df_pima)*0.8)

train <- df_pima[train.idx,]
test <- df_pima[-train.idx,]

md.rf <- randomForest(diabetes ~., data=train, ntree=30)
pred <- predict(md.rf, newdata=test)

confusionMatrix(as.factor(pred), test$diabetes)

comment = '
AUC Area Under ROC(AUROC)
- ROC 곡선의 x축은 False Positive Ratio, y축은 True Positive Ratio이며 곡선의 아래 면적 값이 AUC
- AUC가 1에 가까울수록 좋은 모형
- ModelMetrics 패키지의 auc 함수 이용
auc(actual, predicted, ...)
actual : 정답인 label 벡터
predicted : 예측된 값의 벡터
'

auc(actual=test$diabetes, predicted=as.factor(pred))