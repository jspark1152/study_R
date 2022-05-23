comment = '
데이터 전처리 작업에 필요한 함수들을 모아놓은 패키지
대표적으로 plyr / dplyr / reshape2 / data.table 패키지들이 존재
'

comment = '
[plyr 패키지]
원본 데이터를 분석하기 쉬운 형태로 만듬
- 데이터 분할 split
- 원하는 방향으로 특정 함수 적용 apply
- 결과를 재조합 combine
함수는 pqply 형태로 p는 입력 데이터 형태, q는 출력 데이터 형태를 의미
ex) dlply : data.frame > list

adply(data, margins, fun)
data : 입력 데이터
margins : 함수 적용 방향 1 = 행 / 2 = 열 / c(1,2) = 행과 열 모두
fun : 적용할 함수
'