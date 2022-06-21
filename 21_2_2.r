#제 2 유형 어렵네
X_csv <- read.csv('Train_21_2_2.csv', fileEncoding='UTF-8-BOM', stringsAsFactor=TRUE) #외우자

X_train <- X_csv[1:8009, ]
X_test <- X_csv[8010:nrow(X_csv), -12] #12번째 변수가 정시 도착 가능 여부로서 예측해야할 변수이기 때문에 제거

str(X_train) #정시도착 변수가 Factor 형이 아님
str(X_test)
X_train$Reached.on.Time_Y.N <- as.factor(X_train$Reached.on.Time_Y.N)
str(X_train) #변수 팩터화
summary(X_train)
#결측값 없음

set.seed(13579)
idx <- sample(nrow(X_train), size = (nrow(X_train)*0.8))
train_ds <- X_train[idx,]
valid_ds <- X_train[-idx,]

#전처리 함수 preProcess 기억해두자
md_prePro <- preProcess(train_ds[,-12], method = c('range'))
scaled_train_ds <- predict(md_prePro, train_ds)
scaled_valid_ds <- predict(md_prePro, valid_ds)

md_svm <- svm(Reached.on.Time_Y.N ~., data=scaled_train_ds, probability=TRUE)
pred_svm <- predict(md_svm, newdata = scaled_valid_ds, probability=TRUE)

caret::confusionMatrix(pred_svm, reference = scaled_valid_ds$Reached.on.Time_Y.N)

set.seed(13579)
md_rf <- randomForest(Reached.on.Time_Y.N ~., data=scaled_train_ds, ntree=300, probability=TRUE)
pred_rf <- predict(md_rf, newdata=scaled_valid_ds, probability =TRUE)

caret::confusionMatrix(pred_rf, reference=scaled_valid_ds$Reached.on.Time_Y.N)
#결과 svm 모델이 정확도가 조금더 나음

md_fit <- svm(Reached.on.Time_Y.N ~., data=X_train, probability=TRUE)
pred_fit <- predict(md_fit, newdata=X_test, probability=TRUE, type='prob')
print(pred_fit)

pred_prob <- attr(pred_fit, 'probabilities')[, 2]

result <- cbind(X_test$ID, pred_prob)
colnames(result) <- c('ID', 'pred')
head(result)

write.csv(result, '수험번호.csv', row.names=FALSE)

check_result <- read.csv('수험번호.csv')
print(check_result)