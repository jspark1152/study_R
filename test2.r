#제 2 유형
#1번
library(caret)
library(e1071)
library(randomForest)

ds <- read.csv('WA_Fn-UseC_-Telco-Customer-Churn.csv', fileEncoding='UTF-8-BOM', stringsAsFactors=TRUE)
str(ds)
summary(ds)
ds <- na.omit(ds)

idx_1 <- sample(1:nrow(ds), size=(nrow(ds)*0.75))
train_ds <- ds[idx_1,]
test_ds <- ds[-idx_1, -21]

idx_2 <- sample(1:nrow(train_ds), size=(nrow(train_ds)*0.75))
train_X <- train_ds[idx_2, ]
valid_X <- train_ds[-idx_2, ]
summary(train_X)

#결측값이 있었네? 슈밤
pre_Proc <- preProcess(train_X[,-21], method='range')
scaled_train_X <- predict(pre_Proc, train_X)
scaled_valid_X <- predict(pre_Proc, valid_X)

#모델 구축
md_svm <- svm(Churn ~., data = scaled_train_X, probability=TRUE)
pred_svm <- predict(md_svm, newdata = scaled_valid_X, probability=TRUE)
caret::confusionMatrix(pred_svm, reference=scaled_valid_X$Churn)

md_rf <- randomForest(Churn ~., data = scaled_train_X, ntree=300, probability=TRUE)
pred_rf <- predict(md_rf, newdata=scaled_valid_X, probability=TRUE)
caret::confusionMatrix(pred_rf, reference = scaled_valid_X$Churn)