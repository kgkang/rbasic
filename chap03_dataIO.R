##########################
##  1. 데이터 불러오기
##########################


# 1-1. 키보드 입력

# 1) scan() 함수를 이용
# 숫자입력 
x <- scan()
x
# 합계 구하기
sum <- sum(x) 
sum

# 문자입력
y <- scan(what="")
y

# 2) edit() 함수를 이용한 입력
df = data.frame() #빈 데이터프레임 생성
df = edit(df) # 데이터 편집기
df

# 1-2. 파일 데이터 가져오기

# 1) read.table() 함수 이용

# (1) 컬럼명이 없는 파일 불러오기
getwd()
setwd("C:/Rwork/Part-I")
student  <- read.table(file="student.txt")
student
# (2) 컬럼명이 있는 파일 불러오기
student1  <- read.table(file="student1.txt", header=TRUE)

# (3) 구분자가 있는 경우(세미콜론, 탭)
student2  <- read.table(file="student2.txt", sep=";", header=TRUE) # 세미콜론

# (4) 특정문자 NA 처리(- 문자열을 NA로 처리)
student3<-read.table(file="student3.txt", sep=" ", 
                     header=TRUE, na.strings="-")

# 2)  read.csv() 함수 이용

student4 <- read.csv(file="student4.txt", na.strings="-")

student4 <- read.csv(file.choose(), sep=",", na.strings="-")   # 파일열기 
student4 <- read.csv(file.choose(), sep=",", na.strings=c("&","-"))   # 파일열기 


h <- student3$키
w <- student3$몸무게
mean(h, na.rm = T)
mean(w, na.rm = T)


# 3) read.xlsx() 함수 이용 - 엑셀데이터 읽어오기
Sys.setenv(JAVA_HOME='C:\Rutil\Java\jre1.8.0_111')

# rJava를 로드하기 때문에 rJava 패키지 설치 필요
install.packages("rJava")
library(rJava) # 로딩

# xlsx 패키지 설치
install.packages("xlsx")
library(xlsx) # 로딩

# studentex.xlsx 파일 선택
studentex <- read.xlsx(file.choose(), 
                       sheetIndex=1, encoding="UTF-8")
studentex


# 4) 웹문서 가져오기
install.packages("XML")
library(XML)

# 미국의 각 주별 1인당 소득자료
info.url <- "http://www.infoplease.com/ipa/A0104652.html"

# readHTMLTable() 함수 역할 - <table>,<tr>,<td> 태그 이용
info.df<-readHTMLTable(info.url, header=T, which=1, stringsAsFactors=F)
# header=T : 컬럼명 있음, which=1 : 첫번째, stringsAsFactors 문자는 범주(값의 목록)처리 안함
info.df

# 레코드 수 변경 확인 <- update
info.df<-info.df[1:53,] # NA 레코드 제거(54행 제거)

info.df<-info.df[c(-2,-28),] # $가 있는 행 제거


# 컬럼명 변경
info.df<-info.df[c(-1,-2),] # 1,2행 제거

# 컬럼명 추가
names(info.df) <- c("State",'y1980','y1990','y1995','y2000','y2003','y2006','y2009','y2012','y2015')
head(info.df) # 6출 표시 

# 전처리 결과를 파일로 보관
setwd("C:/Rwork/")
write.csv(info.df, 'info.csv', row.names = F)

finfo <- read.csv('info.csv', header = T)
finfo

# 문자열 처리
library(stringr)
str(finfo)
# 'data.frame':	47 obs. of  10 variables:
y2015 <- finfo$y2015
y2015_r <- str_replace_all(y2015,',','')
y2015_n <- as.numeric(y2015_r)

mean(y2015_n)
sum(y2015_n)
# 앞에 15개 주만 추출
y2015_10 <- y2015_n[1:15]

# 주 15개 추출 
state <- finfo$State
state15 <- state[1:15]

# 막대 차트
barplot(y2015_10, main="주요 15개주 2015년 1인당 소득",
        col=rainbow(15),
        names.arg = state15)




#######################
## 2. 데이터 저장하기
#######################

# 2-1. 화면(콘솔) 출력

# 1) cat() 함수
x <- 10
y <- 20
z <- x * y
cat("x*y의 결과는 ", z ," 입니다.\n")  # \n 줄바꿈
cat("x*y = ", z)

# 2) print() 함수
print(z) # 변수 또는 수식만 가능


# 2-2. 파일에 데이터 저장

# 1) sink() 함수를 이용 파일 저장
setwd("C:/Rwork/output") 
sink("savework.txt") # 저장할 파일명 - 장치 열기

# studentexcel.xlsx 파일 선택
studentx <- read.xlsx(file.choose(), sheetIndex=1, encoding="UTF-8") 
studentx #출력되는 값이 화면에 나타나지 않고 파일에 저장됨
sink() # 해제 - 장치 닫기 


# 2) write.table()함수 이용 파일 저장
getwd() # C:/Rwork/output 경로 확인 

#(변수명, '파일명')
#(1) 기본옵션으로 저장 - 행 이름과 따옴표 붙음
write.table(studentx, "stdt.txt") 
#(2) 행 이름 제거하여 저장
write.table(studentx, "stdt2.txt", row.names=FALSE) 
#(3) 따옴표 제거하여 저장
write.table(studentx, "stdt3.txt", row.names=FALSE, quote=FALSE) 


# 3) write.xlsx() 함수 이용 파일 저장 - 엑셀 파일로 저장
library(xlsx) # excel data 입출력 함수 제공

# studentexcel.xlsx 파일 선택
st.df <- read.xlsx(file.choose(), sheetIndex=1, encoding="UTF-8")
str(st.df)
write.xlsx(st.df, "studentx.xlsx") # excel형식으로 저장

#4) write.csv() 함수 이용 파일 저장
# data.frame 형식의 데이터를 csv 형식으로 저장
setwd("C:/Rwork/output")
st.df
write.csv(st.df,"stdf.csv", row.names=F, quote=F) # 행 이름 제거

# --------------------------------------------------------
# <데이터 입출력 연습문제>
# --------------------------------------------------------     

# chap03_DataIO (연습문제)


# <연습문제> info.df 변수 내용을 다음과 같이 GDP.csv 파일로  저장한 후 처리하시오.
info.df

setwd("C:/Rwork/output")
write.csv(info.df, "info.csv",row.names=F)
# <조건1> "C:/Rwork/output" 디렉토리에 "info.csv "로 저장
# 힌트) write.csv()함수 이용

# <조건2> ""GDP.csv " 파일을 GDP_ranking 변수로 결과 확인
finfo.df <- read.csv("info.csv")

# <조건3> GDP_ranking 데이트 셋 구조 보기 함수를 이용하여 관측치와 컬럼수 확인
str(finfo.df)
# <조건4> 1980년과 1990년을 제외한 나머지 컬럼 대상으로 상위 6개 관측치 보기

head(finfo.df[,-c(2:3)]) # 2번 3번 컬럼 제외



