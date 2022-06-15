comment = '
군집 모델
군집 분석 : 관측된 여러 개의 변숫값으로부터 유사성에만 기초하여 n개의 군집으로 집단화하고, 형성된 집단의 특성으로부터 관계를 분석

군집 간 거리 계산
- 연속형 변수 거리 : 유클리드/맨하탄/민코우스키/표준화/마힐라노비스 거리 등
- 명목형 변수 거리 : d(i, j) = (i와 j에서 다른 값을 가지는 변수 개수)/(총 변수의 수)
- 순서형 변수 거리 : 순위 상관 계수 이용

군집 분석 결과 : 덴드로그램으로 파악하며 각 개체는 하나의 군집에만 속함

계층적 군집 분석
- 모형 구축(군집 간 거리 측정)
dist(거리를 측정), hclust(계층 군집 분석 실행) 함수 이용

dist(data, method) : 데이터의 군집 간 거리 측정
data : 데이터 프레임
method : 거리 측정 방법(euclidean, maximum, manhattan, canberra, binary, minkowski)

mahalanobis(data, center, cov) : 데이터의 마할라노비스 거리를 측정
data : 데이터 프레임
center : 중심 값
cov : 공분산

hclust(data, method)
data : dist 함수로 거리가 측정된 데이터 프레임
method : 군집 연결 방법(single, complete, average, median, ward.D)

agnes(data, metric, method) : cluster 패키지에서 계층적 군집방법을 이용하여 분석
data : dist 함수로 거리가 측정된 데이터 프레임
metric : 거리 측정 방법(euclidean, manhattan)
method : 병합 또는 연결 방법 지정

daisy(data, metric) : cluster 패키지에서 데이터 관측시 사이의 거리를 계산
data : dist 함수로 거리가 측정된 데이터 프레임
metric : 거리 측정 방법
'

#데이터 탐색
str(USArrests)
head(USArrests)
summary(USArrests)

#유클리디안 거리 측정
US.dist_euclidean <- dist(USArrests, 'euclidean')
US.dist_euclidean

#모형 구축
US.single <- hclust(US.dist_euclidean^2, method='single')
US.single
plot(US.single)
US.complete <- hclust(US.dist_euclidean^2, method='complete')
US.complete
plot(US.complete)

comment = '
군집 분석을 통한 그룹 확인
- 결과는 plot 함수를 통해 덴드로그램으로 시각화
- 덴드로그램 결과는 cutree 함수로 그룹화하거나 rect.hclust 함수를 이용하여 그룹화
- 덴드로그램 결과에서 가로선을 그었을 때 세로축 개수를 군집의 수로 선정
- 적절한 군집 수 선정을 위해 최상단부터 순차적으로 가로선을 그음

plot(data) : 거리 행렬 데이터를 기준으로 덴드로그램 출력
data : 데이터 프레임명

cutree(tree, k, h) : 덴드로그램 tree의 높이(h), 그룹 수(k)를 옵션으로 지정하여 그룹 생성
tree : 덴드로그램 객체
k, h : 나누고자 하는 그룹 너비, 높이의 수

rect.hclust(tree, k, which, x, h, border, cluster) : hclust 결과의 그룹을 사각형으로 구분
tree : hclust로 생성된 데이터 프레임
k, h : 나누고자 하는 그룹 너비, 높이의 수이며 둘 중 하나만 지정 가능
which, x : which는 트리 클러스터, x는 선택된 클러스터의 수평 위치 선택
border : 테두리 색 지정(기본값=2)
cluster : 클러스터 그룹 지정
'

group <- cutree(US.single, k=6)
group

rect.hclust(US.single, k=6, border='blue')

comment = '
비계층적 군집 분석 - k means cluster
k-means 군집 : k개만큼 원하는 군집 수를 초깃값으로 지정하고, 각 개체를 가까운 초깃값에 할당하여 군집을 형성하고 각 군집의 평균을 재계산하여 초깃값을 갱신. 이를 반복하여 k개의 최종군집을 형성.

모형 구축
- kmeans 함수 이용
- NbClust 패키지의 NbClust 함수로 최적의 k를 선정할 수 있음
kmeans(data, centers)
data : 데이터
centers : 군집 개수 설정
'

#wine 변수 중 첫 속성인 Type 제거
df <- scale(wine[-1])
nrow(df)
set.seed(1234)
#nstart는 알고리즘은 몇 번 실행할지 설정
fit.km <- kmeans(df, 3, nstart=25)
fit.km$size #k개의 점과 가장 가까운 데이터 위치. 즉, 군집별 데이터 개수
fit.km$centers #k개의 점에 대한 위치

#모형 활용
plot(df, col=fit.km$cluster)
points(fit.km$center, col=1:3, pch=8, cex=1.5)