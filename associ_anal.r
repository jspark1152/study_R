comment = '
연관성 분석 Association Analysis
- 데이터 내부에 존재하는 항목 간의 상호 관계 혹은 종속 관계를 찾아내는 분석기법
- 쇼핑 시 고객들이 물건을 살 때 선택하는 물건의 규칙성을 발견하여 연관해서 물건을 보여줄 수 있도록 판매 전략을 수립하는데 사용
- 데이터 간의 관계에서 조건과 반응을 연결하는 분석으로 장바구니 분석, 서열 분석이라고 함
- 장바구니 분석은 A를 산 사람이 B도 같이 산다는 것을 분석
- 서열 분석은 A를 산 다음에 B를 산다는 것을 분석

분석 함수
- arules 패키지에 포함되어 있는 apriori 함수 이용
- apriori 함수는 트랜잭션 데이터를 다루고 데이터 세트 내에 최소 N번의 트랜잭션이 일어난 아이템 집합들을 찾아 연관 분석을 수행

as : 데이터 형태 변환 함수, 데이터를 transactions 형태로 변경
apriori : transactions 데이터를 다루고 데이터 세트 내에서 최소 N번의 transactions가 일어난 아이템 집합들을 찾아서 연관규칙 계산
inspect : 연관 분석 결과를 확인하는 함수, transactions 데이터를 확인할 수 있는 함수

as 함수 : 객체들을 리스트로 결합
as(data, class)
data : class를 변경하고자 하는 객체
class : 객체를 변경할 클래스 이름, 연관분석에서는 transactions

apriori 함수
- 아이템 간의 연관 관계를 분석하기 위해 아이템의 로그 기록인 트랜잭션 데이터를 사용
- 트랜잭션 데이터가 아닌 데이터는 apriori 함수를 이용하기 전에 트랜잭션 형태로 변경하고 사용
apriori(data, parameter, appearance, control)
data : 연관 규칙 또는 트랜잭션 또는 아이템 매트릭스 데이터
parameter : 최소 지지도(supp), 신뢰도(conf), 최대 아이템 개수(maxlen), 최소 아이템 개수(minlen) 입력
appearance : 특정 연관규칙 결과를 찾을 수 있음
control : 결과 보여주기 등의 알고리즘의 성능을 조정

inspect 함수 : transactions 데이터를 확인
inspect(x, ...)
x : 연관 분석 결과, 트랜잭션 또는 아이템 매트릭스 데이터
'

#예제용으로 0과 1로만 이루어진 5X5 행렬 생성
mx.ex <- matrix(c(1,1,1,1,0,1,1,0,1,0,1,0,0,1,0,1,1,1,0,0,1,1,1,0,0), ncol=5, byrow=TRUE) #1은 구매를 의미
rownames(mx.ex) <- c('p1', 'p2', 'p3', 'p4', 'p5') #고객명
colnames(mx.ex) <- c('a', 'b', 'c', 'd', 'e') #상품명
mx.ex

#Transactions 클래스로 변환
trx.ex <- as(mx.ex, 'transactions')
trx.ex

summary(trx.ex)

#transactions 데이터 확인
inspect(trx.ex)

#연관성 분석 수행 예제
#데이터 준비
data('Groceries')
summary(Groceries)

#연관 규칙 생성
apr <- apriori(Groceries, parameter=list(support=0.01, confidence=0.3))

#연관 규칙 확인
inspect(sort(apr, by='lift')[1:10])
#생성된 연관 규칙을 정렬하여 상위 10개에 대해 확인