# chap02_data_structure

#######################
## 1. Vector 자료구조
#######################

# 벡터 데이터 생성 함수
c(1:20) 
seq(1,10,2)
rep(1:3, 3) 

# 벡터 데이터 처리 함수
x <- c(1,3,5) 
y <- c(3,5)
setdiff(x, y) # 차집합
intersect(x, y) # 교집합      

# 벡터 변수에 저장
v1 <- c(33,-5,20:23,12,-2:3)
v2 <-c("홍길동", "이순신", "유관순")
v3 <-c(T, TRUE, FALSE, T, TRUE,F,T)
v1;v2;v3
v4 <- c(33,-5,20:23,12,"4")
v4

# 같은 줄에 명령문 중복사용
v1; mode(v1) 
v2; mode(v2)
v3; mode(v3)

# 벡터에 컬럼명 지정
age <- c(10,20,30)
age
names(age) <- c("홍길동", "이순신", "강감찬")
age
age[1]
age <-NULL # age 변수 데이터 삭제
age

# 특정 요소 출력 및 제외
a <- c(1:50) #a[1]=1,... a[50]=50
a
# 참조형식) 변수[index], index는 1부터 시작 

a[10 : 45] # 10~45
a[10 : (length(a)-5)] # 10~45
a[1, 2] # Error [행,열]

# --------------------------------------------------------
# <연습문제1>
# -------------------------------------------------------- 
#<연습문제1> 다음과 같은 벡터를 생성하시오.
#1) Vec1 벡터 변수를 만들고, "R" 문자가 5회 반복되도록 하시오.
vec1 <- rep("R",5)
#2) Vec2 벡터 변수에 1~10까지 3간격으로 연속된 정수를 만드시오.
vec2 <- seq(1,10,3)
vec2
#3) Vec3에는 1~10까지 3간격으로 연속된 정수가 3회 반복되도록 만드시오.
vec3 <- rep(vec2,each=3)
vec3
#4) Vec4에는 Vec2~Vec3가 모두 포함되는 벡터를 만드시오.
vec4 <- c(vec2,vec3)

#5) 25~ -15까지 5간격으로 벡터 생성- seq()함수 이용 
vec5 <- seq(25,-15,-5)
  
#6) Vec4에서 홀수번째 값들만 선택하여 Vec5에 할당하시오.(첨자 이용)
seq(1,length(vec4),2)
vec6 <- vec4[seq(1,length(vec4),2)]
vec6


#######################
## 2. Matrix 
#######################
# - 동일 데이터 타입을 갖는 2차원 배열
# - 관련함수 : rbind():행묶음, cbind():컬럼 묶음, apply() : 함수적용

# (1) c()함수 이용 matrix 생성
m <- matrix(c(1:5))     
m <- matrix(c(1:10), nrow=3) 
m <- matrix(c(1:10), nrow=2, byrow=T) 

# (2) rbind()/cbind() 함수 이용      
x1 <- c(5,40,50:52) 
x2 <- c(30,5,6:8) 
mr <- rbind(x1,x2) 
mc <- cbind(x1,x2)  

# (3) matrix()함수 이용
m3 <- matrix(10 : 19, 2) #10개 데이터를 2행으로 생성

# 자료와 객체 Type 보기
mode(mc); class(mc) #numeric, matrix

# ma행렬 데이터 접근 : [첨자,첨자] 이용
mc[1,] # 1행 전체
mc[,2] # 2열 전체
mc[2,2] #2행 2열의 데이터 1개 -> 15
mc[c(2:5),1] # 1열에서 2~5행 데이터 4개
mc
mc[c(2:4),c(1:2)]

# matrix 데이터 처리 함수      
x <- matrix(c(1:9), nrow=3, ncol=3) # 3행 3열 matrix 객체
length(x) # 데이터 개수 
ncol(x); nrow(x) # 열/행 수

# matrix에 컬럼이름 적용하기
x
colnames(x) <- c("one", "two", "three")   
x
# 형식) apply(변수, 행/열, 내장함수/사용자함수)
apply(x,1,max) # 행 단위 최대값
apply(x,1,min) # 행 단위 최대값
apply(x,2,mean) # 열 단위 평균값   

# 사용자 함수와 apply() 적용
f <- function(x) {
  x * c(1,2,3)
}


apply(x,1,f)


#######################
## 3. Array
#######################
# - 동일 데이터 타입을 갖는 다차원 배열

d <- c(1:12) # 12개 벡터 객체 생성
arr <- array(d, c(3,2,2)) # 3행2열2면 -> 3차원 배열 객체 생성


# 배열 조회
arr[,,1] #1면 
arr[,,2] #2면 

# 배열 자료형과 자료구조 
mode(arr); class(arr) #numeric, array

iris # 2차원
iris3 # 3차원

#######################
## 4. List 
#######################
# 성격이 다른 데이터(벡터, 행렬, 데이터프레임 등 모든 데이터)
# R : data.frame <= List('key'='value') <= json

# 1개의 원소를 갖는 리스트
list1 <- list("lee","이순신",95,"hong","홍길동",85)
list1
list2 <- unlist(list) # list 구조 제거 => vector로 변경 
list2

# 2개 이상의 원소를 갖는 리스트
num <- list(c(1:5), c(6:10))
num

# key, value형태로 저장      
num2 <- list(first=c(1:5), second=c(6:10))
num2
# 데이터 접근 : 변수$key[index]
num2$first
num2$first[3]

# key, value 형태로 저장
member <- list(name="hong",age = 35,
               address="한양",gender="남자")

# list 원소 접근 - 변수$키
member$age <- 45  
member$id <- "hong" # id 원소 추가
member$pwd <- "1234" # pwd 원소 추가 

member$age <- NULL  # age 원소 제거

# list의 데이터와 객체 타입 보기
mode(list); class(list) # list, list

length(member) # 6 -> 리스트 수, key

# list data 처리 함수
a <- list(c(1:5))
b <- list(6:10)    
a;b
  lapply(c(a,b), max) # list로 결과 반환
sapply(c(a,b), max)  # vactor로 결과 반환


#######################
## 5. Data Frame
#######################
#  행과 열의 2차원 자료구조, DB의 Table구조와 동일  

# 1) Vector이용 객체 생성
no <- c(1,2,3,4)
name <- c("hong", "lee", "kim")
pay <- c(150,250,300)
vemp <- data.frame(NO=no, Name=name, Pay=pay) #컬럼명 지정 


# 2) matrix이용 객체 생성
m <- matrix(
  c(1,"hong",150,
    2, "lee", 250,
    3, "kim", 300) ,3 ,by=T) # 행우선, 3개 리스트 생성
memp <- data.frame(m)      


# 3) txt파일 이용 객체 생성
getwd()
setwd("C:/Rwork/Part-I") 
txtemp <- read.table('emp.txt', header=T, sep="") # 제목있음, 공백구분
txtemp; class(txtemp)

# 4) csv파일 이용 객체 생성
csvtemp <- read.csv('emp.csv', header=T) # 제목있음, 컴마구분
csvtemp

# 컬럼명이 없는 파일인 경우
name <- c("사번","이름","급여")
read.csv('emp2.csv', header=F, col.names=name)    


# <실습1> 데이터프레임 만들기      
df <- data.frame( x=c(1:5), y=seq(2,10,2), z=c('a','b','c','d','e') )

# <실습2> student 데이터프레임 만들기  

# --------------------------------------------------------
# <연습문제2>
# --------------------------------------------------------     


# 5) apply() 함수 적용 : 데이터프레임 객체에 apply() 적용

r1 <- c(100,80,90)
r2 <- c(90,80,75)
r3 <- c(86,78,95)    
Data <-data.frame(r1=r1, r2=r2, r3=r3)

# 형식) apply(data.frame, 1/2, 함수)
apply(Data, 1, min) # 열 단위 함수 적용 - 86 78 75
apply(Data, 2, min) # 행 단위 함수 적용 - 80 75 78 
apply(Data, 1, var) # 분산
apply(Data, 2, sd) # 표준편차 

# --------------------------------------------------------
# <연습문제3>
# --------------------------------------------------------                 


#####################
## 6) 서브셋 만들기    
#####################
x1 <- subset(df, x>=3) # x가 3이상인 레코드 대상       

y1 <- subset(df, y<=8) # y가 8이하인 레코드 대상 

xy <- subset(df, x>=2 & y<=6) # 2개 조건이 참인 레코드 대상

#####################
## 7) Data join 
#####################
# - 칼럼 값으로 기준으로  두 개의 프레임 연결    
height <- data.frame(id=c(1,2), h=c(180,175))
weight <- data.frame(id=c(1,2), w=c(80,75))

user <- merge(height, weight, by.x="id", by.y="id")
user
# --------------------------------------------------------
# <연습문제4>
# -------------------------------------------------------- 


################################
# 8) 문자열 처리 함수와 정규표현식
################################

# - stringr 패키지에서 제공하는 함수 이용 문자열 처리

install.packages("stringr")  # 패키지 설치
library(stringr) # 메모리 로딩

# str_extract(string, '정규표현식')
# 메타문자: [] 1회 반복, {n} : n 반복 
str_extract("abcd12aaa33", "[1-9]{2}") # "12" -> 연속된 숫자2개 추출(첫번째)
str_extract_all("abcd12aaa33", "[1-9]{2}") # "12" "33" -> 모두
str_extract_all("abcd12aaa33", "[a-z]{3,}") # "12" "33" -> 모두
str_extract_all("이순신12이사도라33", "[가-희]{3,4}") # "12" "33" -> 모두
d <- c("김길동","유관순","강감찬","김길동")      
str_replace(d, "김길동","홍길동") # 문자열 교체
subs <- str_sub("abcd12aaa33", 3,6) # 서브스트링      
subs

# email 양식
email <- 'kgkang@gmail.com'
str_extract_all(email,'\\w{4,}@\\w{3,}.\\w{2,}') # \\w

# 주민번호
jumin <- '123456-1234567'
str_extract_all(jumin,'\\d{6}-[1,2,3,4]\\d{6}' ) #\\d

# --------------------------------------------------------
# <연습문제5>
# -------------------------------------------------------- 

# <연습문제5> 다음의 Data2 객체를 대상으로 정규표현식을 적용하여 문자열을 처리하시오
Data2 <- c("2016-06-05 수입3000원","2016-06-06 수입4500원","2016-06-07 수입2500원")

#<조건1> 일짜별 수입을 다음과 같이 출력하시오. 
#        출력 결과) "3000원" "4500원" "2500원" 
income <- str_extract_all(Data2, '\\d{4}원')
income <- unlist(income)
income
#<조건2> 위 벡터에서 연속하여 2개 이상 나오는 모든 숫자를 제거하시오.  
#        출력 결과) "-- 수입원" "-- 수입원" "-- 수입원"  
str_replace_all(Data2,'\\d{2,}','')


#<조건3> 위 벡터에서 -를 /로 치환하시오.
#        출력 결과) "2016/06/05 수입3000원" "2016/06/06 수입4500원" "2016/06/07 수입2500원"  
str_replace_all(Data2, '-', '/')

#<조건4> 모든 원소를 쉼표(,)에 의해서 하나의 문자열로 합치시오. 
# 힌트) paste(데이터셋, collapse="구분자")함수 이용
#        출력 결과) "2016-06-05 수입3000원,2016-06-06 수입4500원,2016-06-07 수입2500원"
paste(Data2,collapse = ",")
