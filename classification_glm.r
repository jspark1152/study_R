comment = '
2. 로지스틱 회귀 분석
- 반응변수가 범주형인 경우
- 새로운 설명변수 값이 주어질 때 반응변수의 각 범주에 속할 확률이 얼마인지를 추정하여 추정 확률을 기준치에 따라 분류하는 목적

변수 선택
- 변수의 유의성 검정
개별 회귀 계수에 대한 유의성 검정은 Z-통계량을 이용하여 p-값과 유의수준을 비교
p-값이 유의수준보다 작을 경우 해당 회귀 계수는 유의
유의하지 않은 변수는 모형에서 제거
- 모형의 유의성 검정
카이제곱 겁정을 이용
영 모형과 선정된 모형을 카이제곱 검정을 이용하여 유의성을 검정
자유도는 선정된 모형이 가진 변수의 개수가 됨

모형 구축
- glm 함수를 이용하여 모형 생성, predict 함수를 이용하여 분류
- 선형 회귀 분석과 마찬가지로 step 함수를 이용하여 자동화된 변수 선택을 실시(변수 선택 기준은 AIC)
glm(formula, family, data, ...)
formula : 종속변수 ~ 독립변수 지정
family : 모델에서 사용할 분포, 이항 로지스틱 회귀 분석의 경우 binomial 사용
data : 분석 대상 데이터

모형 평가
- 평가는 반드시 평가용 데이터를 이용하여 진행
- 분류 모형의 결과를 평가하기 위해서 혼동 행렬을 이용(ROC 곡선, AUC 를 평가지표로 사용)
caret 패키지의 confusionMatrux 함수
confusionMatrix(data, reference, ...)
data : 예측된 분류 데이터 또는 분할표
reference : 실제 분류 데이터
ModelMetrics 패키지의 auc 함수
auc(actual, predicted, ...) : 1에 가까울수록 좋은 모델
actual : 정답인 label의 벡터
predicted : 예측된 값의 벡터
'

str(Default)

head(Default)

summary(Default)
#결측값이 존재하지 않음

#모형 구축 - 유의성 검정
bankruptcy <- Default
set.seed(202012)
train_idx <- sample(1:nrow(bankruptcy), size=0.8*nrow(bankruptcy), replace=FALSE)
test_idx <- (-train_idx)
bankruptcy_train <- bankruptcy[train_idx,]
bankruptcy_test <- bankruptcy[test_idx,]

#변수 전체를 선택
full_model <- glm(default ~., family = binomial, data = bankruptcy_train)

#변수 선택법은 단계적 방법 이용
step_model <- step(full_model, direction = 'both')
#결과 student, balance 변수가 선택됨

#분석 모형 구축 - 변수의 유의성 검정
summary(step_model)

#분석 모형 구축 - 모형의 유의성 검정
null_deviance <- 2354.0
residual_deviance <- 1287.4
model_deviance <- null_deviance - residual_deviance
#null_deviance의 자유도가 7999, residual_deviance의 자유도가 7997 이기 때문에 df = 2
pchisq(model_deviance, df=2, lower.tail = FALSE)

#분석 모형 구축 - 다중공선성 확인
vif(step_model)
#VIF 가 4를 초과하면 다중공선성이 존재한다고 판단
#결과 4를 초과하지 않기 때문에 문제 없음

#분석 모형 평가 - 평가용 데이터를 이용한 분류
pred <- predict(step_model, newdata = bankruptcy_test[, -1], type = 'response')
df_pred <- as.data.frame(pred)
df_pred$default <- ifelse(df_pred$pred >= 0.5, df_pred$default <- 'Yes', df_pred$default <- 'No')
df_pred$default <- as.factor(df_pred$default)

#분석 모형 평가 - 혼동 행렬
#confusionMatrix(data = df_pred$default, reference = bankruptcy_test[,1])

#분석 모형 평가 - AUC
auc(actual = bankruptcy_test[, 1], predicted = df_pred$default)
#음.. 혼동행렬하고 AUC 하려고 하는데 왜 안되는거지
#결과 AUC 값은 0.64 정도로 불량의 성능