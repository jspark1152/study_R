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
