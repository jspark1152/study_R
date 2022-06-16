comment = '
회귀 모형 평가 : 구축한 모형에 대한 평가 지표로 결정 계수와 수정된 결정 계수 외에도 RMSE(Root Mean Squared Error), MSE(Mean Squared Error) 등을 이용

RMSE(Root Mean Squared Error) 평균 제곱근 오차
- ModelMetrics 패키지의 rmse 함수 이용
- RMSE 값이 낮을수록 모형의 정확도가 높음
rmse(actual, predicted, ...)
actual : 정답인 label 벡터
predicted : 예측된 값의 벡터
rmse(modelObject, ...)
modelObject : 모형 객체, 현재는 lm만 지원

MSE(Mean Squared Error) 평균 제곱 오차
- ModelMetrics 패키지의 mse 함수 이용
- MSE 값이 낮을수록 모형의 정확도가 높음
mse(actual, predicted, ...)
actual : 정답인 label 벡터
predicted : 예측된 값의 벡터
mse(modelObject, ...)
modelObject : 모형 객체, 현재는 lm만 지원

결정 계수와 수정된 결정 계수
- 구축된 회귀 모형의 summary 함수를 이용
- 결정 계수 및 수정된 결정 계수가 높을수록 모형의 설명력이 높음
결정 계수 = summary$r.squared
수정된 결정 계수 = summary$adj.r.squared
'

#모형 구축
hitters <- na.omit(Hitters)
fit_model <- lm(Salary ~ AtBat + Hits + CWalks + Division + PutOuts, data=hitters)
second_model <- lm(Salary ~ Hits + CWalks + Division + PutOuts, data=hitters)

#rmse, mse 비교
rmse(fit_model)
mse(fit_model)
rmse(second_model)
mse(second_model)
#결과 second_model 의 값이 조금 더 큼 >> 즉, 정확도가 조금 더 떨어짐

#결정 계수, 수정된 결정 계수 비교
summary(fit_model)$r.squared
summary(fit_model)$adj.r.squared
summary(second_model)$r.squared
summary(second_model)$adj.r.squared
#마찬가지 결정 계수 값이 fit_model이 더 높음 >> fit_model의 설명력이 더 좋음