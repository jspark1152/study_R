comment = '
부스팅 Boosting
- 예측력이 약한 모형들을 결합하여 강한 예측 모형을 만드는 기법
- AdaBoost, GBM, LightGBM, XGBoost, CatBoost 등의 알고리즘 사용

XGBoost 알고리즘
- 병렬 처리가 지원되도록 구현하여 훈련과 분류 속도가 빠름
- xgboost 패키지의 xgboost와 xgb.train 함수 사용

xgb.train(params, data, nrounds, early_stopping_rounds, watchlist)
params : 파라미터 리스트
data : xgb.DMatrix 객체
nrounds : 최대 부스팅 반복 횟수
early_stopping_rounds : early_stopping 횟수 지정, 지정된 회수 이상 성능 향상이 없을 경우 중지
watchlist : 모형의 성능을 평가하기 위하여 사용
- 독립변수가 수치형 데이터만 사용이 가능, 명목형인 경우 One Hot Encoding을 수행하여 수치형으로 변환한 후 사용
- 종속변수가 팩터형인 경우 숫자로 변환한 후 0부터 시작하기 위해 1을 뺌
- 매개변수로는 일반 / 부스터 / 태스크 매개변수

일반 매개변수 : 부스터 방법을 설정
booster : gbtree(기본값) / gblinear

부스터 매개변수 : 부스터 설정에 따른 매개변수를 설정
- gbtree
eta : 학습률(기본값 = 0.3)
gamma : Information Gain에 페널티를 부여하는 수, 클수록 트리의 깊이가 줄어서 보수적인 알고리즘
max_depth : 한 트리의 최대 깊이(기본값 = 6)
subsample : 훈련 데이터의 샘플 비율(기본값 = 1)
colsample_bytree : 개별 트리 구성할 때 컬럼의 subsample의 비율(기본값 = 1)
- gblinear
lambda : weight에 대한 L2 regularization term(기본값 = 0)
lambda_bias : bias에 대한 L2 regularization term(기본값 = 0)
alpha : weight에 대한 L1 regularization term(기본값 = 0)

태스크 매개변수 : 훈련에 대한 시나리오를 지정하는 매개변수
objective : 목적함수 지정(기본값 = reg:squarederror)
eval_metric : 모델의 평가 함수

훈련 데이터는 xgb.DMatrix 객체를 이용하여 생성
xgb.DMatrix(data, info, ...)
data : Matrix 객체
info : 추가로 저장할 정보 리스트
'

#데이터 탐색
data(PimaIndiansDiabetes2)
str(PimaIndiansDiabetes2)
summary(PimaIndiansDiabetes2)

#데이터 전처리
PimaIndiansDiabetes2 <- na.omit(PimaIndiansDiabetes2)

idx <- sample(1:nrow(PimaIndiansDiabetes2), size=nrow(PimaIndiansDiabetes2)*2/3)
train <- PimaIndiansDiabetes2[idx,]
test <- PimaIndiansDiabetes2[-idx,]

#모형 구축
#종속변수를 0부터 시작하도록 1을 뺀 후 변수 할당
train.label <- as.integer(train$diabetes)-1
#diabetes 변수가 9번째 열
mat_train.data <- as.matrix(train[, -9])
mat_test.data <- as.matrix(test[, -9])

xgb.train <- xgb.DMatrix(data=mat_train.data, label=train.label)
xgb.test <- xgb.DMatrix(data=mat_test.data)
param_list <- list(booster='gbtree', eta=0.001, max_depth=10, gamma=5, subsample=0.8, colsample_bytree=0.8, objective='binary:logistic', eval_metric='auc')

md.xgb <- xgb.train(params=param_list, data=xgb.train, nrounds=200, early_stopping_rounds=10, watchlist=list(val1=xgb.train), verbose=1)
#반복 회수를 200회로 했으나 25회에서 조기 중단.

#모형 평가
xgb.pred <- predict(md.xgb, newdata=xgb.test)
xgb.pred2 <- ifelse(xgb.pred >= 0.5, xgb.pred <- 'pos', xgb.pred <- 'neg')

xgb.pred2 <- as.factor(xgb.pred2)
confusionMatrix(xgb.pred2, reference=test$diabetes, positive='pos')
#평가 결과 애매한 성능