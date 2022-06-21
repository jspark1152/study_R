#제 2 유형

#데이터 확인
x_csv <- read.csv('TravelInsurancePrediction.csv')

x_csv$TravelInsurance <- as.factor(x_csv$TravelInsurance)
str(x_csv)
summary(x_csv)

X_train <- x_csv[1:1490,]
X_test <- x_csv[1491:nrow(x_csv), -10]

#전처리 : 일단 결측값이 없음
set.seed(2000)
idx <- sample(1:nrow(X_train), size=(nrow(X_train)*0.75))
train_ds <- X_train[idx,]
valid_ds <- X_train[-idx,]
#스케일링 해야할듯
preProc <- preProcess(train_ds[-10], method='range')
scaled_train_ds <- predict(preProc, train_ds)
scaled_valid_ds <- predict(preProc, valid_ds)
scaled_train_ds <- scaled_train_ds[,-1]
scaled_valid_ds <- scaled_valid_ds[,-1]
summary(scaled_train_ds)


#모델 구축
md_svm <- svm(TravelInsurance ~., data=scaled_train_ds, probability=TRUE)
pred_svm <- predict(md_svm, newdata=scaled_valid_ds, probability=TRUE)
caret::confusionMatrix(pred_svm, reference=scaled_valid_ds$TravelInsurance)

md_rf <- randomForest(TravelInsurance ~., data=scaled_train_ds, ntree=300, probability=TRUE)
pred_rf <- predict(md_rf, newdata=scaled_valid_ds, probability=TRUE)
caret::confusionMatrix(pred_rf, reference=scaled_valid_ds$TravelInsurance)
#랜덤 포레스트가 더 성능이 좋네?

md_fit <- randomForest(TravelInsurance ~., data=X_train[,-1], ntree=300, probability=TRUE)
pred_fit <- predict(md_fit, newdata=X_test[,-1], probability=TRUE, type='prob')
head(pred_fit)
pred_prob <- pred_fit[,1]

result <- cbind(X_test[1], pred_prob)
colnames(result) <- c('index', 'y_pred')
head(result)

write.csv(result, '21_3_2.csv', row.names=FALSE)