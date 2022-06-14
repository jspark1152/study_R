comment = '
인공신경망 Artificial Neural Network
- 인간의 뉴런 구조를 모방하여 만든 기계학습 모델
- 입력값을 받아서 출력값을 만들기 위해 활성화 함수를 사용

분석 모형 구축
- nnet 패키지의 nnet 함수를 이용
nnet(formula, data, size, maxit, decay = 5e-04, ...)
formula : 종속변수 ~ 독립변수
data : 데이터
size : 은닉층의 개수
maxit : 반복할 학습 횟수
decay : 가중치 감소의 모수(기본값 = 5e-04)
'

#전처리
data(iris)
#iris 데이터셋에서 Species를 제외한 열을 Scale한 후 다시 Species를 bind.
iris.scaled <- cbind(scale(iris[-5]), iris[5])
set.seed(1000)
index <- c(sample(1:50, size=35), sample(51:100, size=35), sample(101:150, size=35))
train <- iris.scaled[index,]
test <- iris.scaled[-index,]

#모형 구축
set.seed(1234)
model.nnet <- nnet(Species ~., data=train, size=2, maxit=200, decay=5e-04)
summary(model.nnet)