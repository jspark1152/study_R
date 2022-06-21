data <- read.csv('Train_21_2_2.csv', fileEncoding='UTF-8-BOM', stringsAsFactor = TRUE)
str(data)

data$Reached.on.Time_Y.N <- as.factor(data$Reached.on.Time_Y.N)
str(data)

train_X <- data[1:8009,]
test_X <- data[8010:nrow(data), -12]

set.seed(12000)
idx <- sample(nrow(train_X), size=(nrow(train_X)*0.75))
train_ds <- train_X[idx,]
valid_ds <- train_X[-idx,]
summary(train_ds)

pre_Proc <- preProcess(train_ds[-12], method='range')
scaled_train_ds <- predict(pre_Proc, train_ds)
scaled_valid_ds <- predict(pre_Proc, valid_ds)
summary(scaled_train_ds)

comment = '
md_svm <- svm(Reached.on.Time_Y.N ~., data = scaled_train_ds, probability = TRUE)
pred_svm <- predict(md_svm, newdata = scaled_valid_ds, probability = TRUE)
caret::confusionMatrix(pred_svm, reference = scaled_valid_ds$Reached.on.Time_Y.N) #정확도 0.7229'

comment = '
md_rf <- randomForest(Reached.on.Time_Y.N ~., data = scaled_train_ds, ntree=300, probability = TRUE)
pred_rf <- predict(md_rf, newdata = scaled_valid_ds, probability = TRUE)
caret::confusionMatrix(pred_rf, reference = scaled_valid_ds$Reached.on.Time_Y.N)'
#정확도 0.7119

md_fit <- svm(Reached.on.Time_Y.N ~., data = train_X, probability = TRUE)
pred_fit <- predict(md_fit, newdata = test_X, probability = TRUE)
str(pred_fit)
prob <- attr(pred_fit, 'probabilities')[,2]
head(prob)

result <- cbind(test_X$ID, prob)
colnames(result) <- c('ID', 'probability')
head(result)

write.csv(result, '수험번호_1.csv', row.names=FALSE)