#파일 수집
#파일 종류에는 TXT, CSV, TSV, EXCEL 등
#파일에 따라 수집 방법이 다름

#TXT = 일반 문자열이 저장되는 텍스트 파일
#CSV(Comma-Separated Values) = 필드를 콤마로 구분한 데이터
#TSV(Tab-Separated Values) = 필드를 탭(\t)으로 구분한 데이터
#EXCEL = 스프레드 시트 형태의 엑셀 파일

comment = '
scan(file, what)
이는 키보드를 통해 값을 직접 입력하거나 지정된 파일을 읽는 함수
file : 읽어 들일 파일명
what : 실수와 문자를 읽는 경우 사용
'

#scan("")

comment = '
read.table(file, header, sep, fill, what)
이는 TXT 파일로부터 데이터를 읽는 함수
file : 읽어 들일 파일명
header : TRUE=첫 번째 행을 열 이름으로 인식 / FALSE(기본값)=데이터로 인식
sep : 구분자 지정 sep=""(공백) / sep=","(콤마) / sep="\t"(탭)
fill : 비어있는 부분을 NA(결측값)으로 채울지 여부(TRUE or FALSE)
what : 실수와 문자를 읽는 경우 사용
'

df <- read.table(file='data.txt', header=TRUE)
df

comment = '
write.table(x, file, append, quote, sep, ...)
x : 데이터 집합, 보통 데이터 프레임 형태
file : 작업 폴더에 저장하려는 파일명과 확장명 기록, 경로 지정도 가능
append : TRUE=이어쓰기 / FALSE(기본값)=덮어쓰기
quote : TRUE(기본값)=모든 값과 열에 ""로 수식 / FALSE="" 생략
sep : 구분자 지정(기본 값은 " "=space)
'

#iris 데이터 셋을 write.txt에 작성
#write.table(iris, file='write.txt')
#이 방법으로 내장 데이터들 구조를 확인 가능할 듯

comment = '
read.csv(file, header)
이는 csv 파일로부터 데이터를 수집하는 함수
file : 읽어 들일 파일명
header : TRUE(**기본값)=첫 번째 행을 열 이름으로 인식 / FALSE=데이터로 인식 
'

#보통 csv 파일의 첫 행은 열들의 label에 해당하는 듯함
csv_data <- read.csv(file='data.csv')
csv_data

comment = '
write.csv(x, file, append, quote, sep, ...)
x : 데이터 집합, 보통 데이터 프레임 형태
file : 작업 폴더에 저장하려는 파일명과 확장명 기록, 경로 지정도 가능
append : TRUE=이어쓰기 / FALSE(기본값)=덮어쓰기
quote : TRUE(기본값)=모든 값과 열에 ""로 수식 / FALSE="" 생략
sep : 구분자 지정(기본 값은 " "=space)
'

#write.csv(csv_data, file='write.csv')

comment = '
read.delim(file, header)
이는 구분자 tab을 자동 인식하는 함수
file : 읽어 들일 파일명
header : TRUE=첫 번째 행을 열 이름으로 인식 / FALSE=데이터로 인식
'

tsv_data <- read.delim(file='data.tsv', header=TRUE)
tsv_data

#구분자 포함된 데이터를 쓰는 경우 write.table 함수 사용
#write.table(tsv_data, file='write.tsv', sep='\t')

comment = '
read_excel(path, sheet, range, col_name)
이는 엑셀 파일로부터 데이터를 읽을 때 사용하는 함수
path : 읽어 들일 파일명
sheet : 읽어 들일 시트명
range : 읽어 들일 시트의 범위
col_name : TRUE=첫 번째 행을 열 이름으로 인식 / FALSE=데이터로 인식
'

comment = '
write.xlsx(x, file, ...)
이는 엑셀 파일로 저장할 때 사용하는 함수
x : 저장할 데이터 집합
file : 작업 폴더에 저장하려는 파일명과 확장명 기록, 경로 지정 가능
'