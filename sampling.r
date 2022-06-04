comment = '
표본 추출
1. 단순 무작위 추출 : 정해진 규칙 없이 표본을 추출
2. 계통 추출 : 모집단을 일정 간격을 기준으로 추출
3. 층화 추출 : 모집단을 서로 겹치지 않게 여러 계층으로 나누고 계층별로 단순 무작위 추출
** 이때 계층은 내부적으론 동질적이며 외부적으론 이질적.
4. 군집 추출 : 모집단을 여러 군집으로 나누고 일부 군집의 전체 또는 일부를 추출, 계층과는 다르게 군집은 무작위로 설정

표본 추출 함수
1. sample 함수
sample(x, size, replace, prob)
x : 데이터
size : 추출 개수 설정
replace : TRUE = 복원, FALSE(기본값) = 비복원
prob : 가중치 설정
'

s <- sample(1:10, 5, replace = TRUE)
s

s <- sample(1:20, 7)
s

s <- sample(1:10, 5, replace = TRUE, prob = 1:10)
s

comment = '
2. createDataPartition 함수
createDataPartition(y, times, p, list)
y : 데이터
times : 생성할 분할의 수
p : 훈련 데이터에서 사용할 데이터의 비율
list : 결과를 리스트로 반환(TRUE), 행렬로 반환(FALSE)
'

ds <- createDataPartition(iris$Species, times=1, p=0.7)
#결과를 보면 iris 데이터의 150개의 행의 70%의 인덱스를 ds의 Resample1 변수에 저장. 즉, 분할 자체가 아니라 분할을 할 기준이라고 봐야함
ds

table(iris[ds$Resample1, 'Species'])
table(iris[-ds$Resample1, 'Species'])

#ds에서 얻은 분할 정보를 이용하기 위해 벡터화
idx <- as.vector(ds$Resample1)
idx

#벡터화한 분할 정보를 이용하여 훈련데이터, 검정데이터를 지정
ds_train <- iris[idx,]
ds_train
ds_test <- iris[-idx,] #-idx는 주어진 행에서 제외된 걸 의미. 실제로 -idx를 호출시 idx 벡터 값에 -가 취한것으로 출력됨
ds_test

comment = '
3. createFolds 함수
데이터를 k-fold로 교차 검증할 때 데이터를 분할하기 위한 함수
훈련 단계에 따라 1개는 평가 데이터, 나머지 k-1개는 훈련 데이터로 활용

createFolds(y, k, list, returnTrain)
y : 분할 대상 데이터
k : 겹으로 분할하는 개수
list : 결과를 리스트로 반환(TRUE), 행렬로 반환(FALSE)
returnTrain(list가 TRUE일 때 사용) : TRUE=훈련데이터 정보 반환, FALSE=평가데이터 정보 반환
'

ds_k_fold <- createFolds(iris$Species, k=3, list=TRUE, returnTrain=FALSE)
#ds_k_fold 는 3겹이기에 변수는 Fold1/Fold2/Fold3 으로 이루어졌으며 returnTrain=FALSE 이기에 각 변수에는 평가데이터의 정보가 들어있음
ds_k_fold
length(ds_k_fold$Fold1)
length(ds_k_fold$Fold2)
length(ds_k_fold$Fold3)
#여러번 실행 결과 분할 시 정확하게 분할하는건 아닌듯 함. 150개의 자료를 3분할 하는데 49/50/51 분할을 하는 경우도 있음