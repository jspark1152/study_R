comment = '
K-NN 최근접 이웃 Nearest Neighbor
- 새로운 데이터 클래스를 해당 데이터와 가장 가까운 k개 데이터들의 클래스로 분류
- 유클리디안 / 맨하탄 / 민코우스키 거리 등을 사용
- 근접 이웃 수인 K는 학습 난이도와 훈련 데이터 개수에 따라 결정
- 일반적으로 훈련 데이터 개수의 제곱근으로 설정

분석 모형 구축
- class 패키지의 knn 함수 이용
- k개의 가장 근접한 그룹 중에서 다수결에 의해 가장 많은 그룹을 선택하는 함수
knn(train, test, cl, k)
train : 훈련 데이터
test : 평가 데이터
cl : 훈련 데이터의 종속 변수
k : 근접 이웃 수 (기본값 = 1)
'

#데이터 세트 준비
data <- iris[, c('Sepal.Length', 'Sepal.Width', 'Species')]
set.seed(1234)

#전처리 : 결측값이 존재하지 않음

#변수 선택
idx <- sample(x=c('train', 'valid', 'test'), size=nrow(data), replace=TRUE, prob=c(3,1,1))
train <- data[idx=='train',]
valid <- data[idx=='valid',]
test <- data[idx=='test',]
#3번째 열인 Species를 제외
train_x <- train[,-3]
valid_x <- valid[,-3]
test_x <- test[,-3]
#3번째 열인 Species는 y변수(종속 변수)
train_y <- train[,3]
valid_y <- valid[,3]
test_y <- test[,3]

knn_1 <- knn(train=train_x, test=valid_x, cl=train_y, k = 2)

accuracy_k <- NULL
for(i in c(1:nrow(train_x))){
    set.seed(1234)
    knn_k <- knn(train=train_x, test=valid_x, cl=train_y, k = i)
    accuracy_k <- c(accuracy_k, sum(knn_k == valid_y)/length(valid_y))
}
valid_k <- data.frame(k=c(1:nrow(train_x)), accuracy=accuracy_k)
plot(formula=accuracy~k, data=valid_k, type='o', pch=20, main='validation-optimal k')

min(valid_k[valid_k$accuracy %in% max(accuracy_k), 'k'])
max(accuracy_k)
#분류 정확도가 가장 높으면서 가장 작은 k 값은 13
#최적의 분류 정확도는 0.89 정도

#모형 평가 : k=13인 모형에 knn 함수 적용
#평가 단계라서 test set을 사용해야함
knn_13 <- knn(train=train_x, test=test_x, cl=train_y, k=13)
confusionMatrix(knn_13, reference=test_y)
#테스트 데이터로 적용 결과 0.77로 감소
#versicolor 종에 대한 민감도가 0.4 정도로 낮음..