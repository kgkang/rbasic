##########################
## 1. 조건문
##########################

# 1) if()함수
# if (조건식) {참} else {거짓}
# 조건식 : 산술식,
x <- 10
y <- 5
z <- x * y
z

if(x*y > 40){
  cat("x*y의 결과는 40 이상입니다.\n")  # \n 줄바꿈
  cat("x*y =", z)
}else{
  cat("x*y의 결과는 40 미만입니다. x*y =", z,"\n")
}


# 학점 구하기
score <- scan()
score

if(score >= 90){
  result="A학점"
}else if(score >=80){
  result="B학점"
}else if(score >=70){
  result="C학점"
}else if(score >=60){
  result="D학점"
}else{
  result="F학점"
}  
cat("당신의 학점은 ",result) 
print(result) 


#주민번호 이용 -> 성별 판별
library(stringr)
jumin <- "123456-1234567"
gender <- str_sub(jumin,8,8)
if (gender=="1" || gender=="3") {
  cat('당신은 남자입니다.')
} else if (gender=="2" || gender=="4") {
  cat('당신은 여자입니다.')
} else {
  cat('당신은 중성입니다')
}

# 2) ifelse(조건, 참, 거짓) - 3항 연산자 기능
# vector -> vector

score <- c(85,70,94,65) #vector
ifelse(score>=80, "우수","노력") #우수


#ifelse() 응용
excel <-read.csv("c:/Rwork/Part-I/excel.csv", header = T)
str(excel)
q1 <- excel$q1 # q1 변수값 추출

ifelse(q1>=4, sqrt(q1),q1) #4보다 큰 경우 sqrt()적용

#논리연산자 적용
ifelse(q1>=2 & q1<=4, q1^2, q1) #1과 5만 출력, 나머지(2~4) 지수승


# 3) switch 문
# 형식) switch(비교구문, 실행구문1, 실행구문2, 실행구문3)

switch("name", id="hong", pwd="1234",age=105, name="홍길동")    

# 4) which 문
# which()의 괄호내의 조건에 해당하는 위치(인덱스)를 출력한다.

# 벡터에서 사용-> index값 리턴
name <- c("kim","lee","choi","park")
which(name=="choi") 

# 데이터프레임에서 사용
no <- c(1:5)
name <-c("홍길동","이순신","강감찬","유관순","김유신")
score <- c(85,78,89,90,74)

exam <- data.frame(학번=no,이름=name,성적=score)

which(exam$이름=="유관순") 

##########################
## 2. 반복문
##########################

# 1) 반복문 - for(변수 in 자료구조) {표현식}
# 자료구조 -> vector
name <- c("kim", "lee", "kang")
for (n in name) { # 3회 반
  
}



i <- c(1:10)
for(n in i){ # 10회 반복
  print(n * 10) # 계산식(numeric만 가능) 출력
  print(n)
}

for(n in i){
  if(n%%2==0) print(n) # %% : 나머지값 - 짝수만 출력
} 

for(n in i){
  if(n%%2==0){
    next # 짝수면 skip
  }else{
    print(n) # 홀수만 출력
  }    
} 


# 2) 반복문 - while(조건){표현식}
i = 0
while(i< 10){
  i <- i + 1
  print(i) # 1~10까지 출력됨
}

# 3) 반복문 - repeat{ 탈출조건 }
cnt <-1
repeat{
  print(cnt)
  cnt <- cnt + 2 
  if(cnt>15) break # cnt가 15보다 크면 탈출
}


# ---------------------------------------------------------------------   
#<데이터프레임 처리 관련 연습문제> 
# ---------------------------------------------------------------------   
# chap04_Control (연습문제)


#<연습문제> 다음 client 데이터프레임을 대상으로 조건에 맞게 처리하시오.

name <-c("aaa","bbb","ccc","ddd")
gender <- c("F","M","M","F")
price <-c(50,65,45,75)
client <- data.frame(name,gender,price)

# <조건1> price가 65만원 이상인 고객은 "Best" 미만이면 
#     "Normal" 문자열을 result 변수에 넣고, client의 객체에 컬럼으로 추가하기

result <- ifelse(client$price>=65, "Best", "Normal")
client$result <- result


# <조건2> result의 빈도수를 구하시오. 힌트) table()함수 이용
table(client$result)
# <조건3> gender가 'M'이면 "Male", 'F'이면 "Female" 형식으로 client의 객체에
#  gender2 컬럼을 추가하고 빈도수 구하기

client$gender2 <- ifelse(client$gender=="M","Male","Female")
table(client$gender2)


##########################
# 1. 사용자 정의함수
##########################

# 1) 매개변수가 없는 함수 예
f1 <- function(){
  cat("매개변수가 없는 함수")
}

f1() # 함수 호출

# 2) 매개변수가 있는 함수 예
f2 <- function(x){ # 가인수=매개변수 
  cat("x의 값 = ",x, "\n") # \n 줄바꿈
  print(x) # 변수만 사용
}
f2(50) # 함수 호출(실인수)

# 3) 리턴이 있는 함수 예
f3 <- function(x,y) {
  add <- x + y
  return(add) #반환
}

result <- f3(10,20)
cat('result =', result)

#파일 불러오기
setwd("c:/Rwork/Part-I")

test <- read.csv("test.csv", header=TRUE)
head(test)

summary(test) # 요약통계량
table(test$A) # A변수 대상 빈도분석

#변수A 대상 빈도분석,최대값, 최소값 구하기 함수
fa <- function(){
  a <- table(test$A) # A변수 대상 빈도분석
  cat("변수 A에 대한 빈도분석 결과 \n")
  print(a) # 빈도분석 
  cat("max =", max(a), "\n")
  cat("min =", min(a))
}
fa() #함수 호출


#파타고라스 정의 증명- 식 : a^2+b^2=c^2
pytha <- function(s,t){
  a <- s^2 - t^2
  b <- 2*s*t
  c <- s^2 + t^2
  cat("피타고라스의 정리 : 3개의 변수 : ",a,b,c)
}

pytha(2,1) # s,t는 양의 정수 -> 3 4 5

#결측치(NA) 데이터 처리
data <- c(10,20,5,4,40,7,NA,6,3,NA,2,NA)
data 
mean(data) # NA

#결측치 데이터 처리 함수
na <- function(x){ 
  cat("x값에 대한 평균 : ",mean(x, na.rm=TRUE),"\n")
  cat("x값에 대한 평균(소수점 2자리) : ",
      round(mean(x, na.rm=TRUE),2),"\n")
  ifelse(x>=0, x, NA) # 원소 출력
}
na(data ) #함수 호출

# 분산, 표준편자
x <- c(7,15,5,9,6)
var(x) 
sd(x)
sqrt(var(x))

var_sd <- function(x) {
  #분산 = sum((x-평균)^2 ) / (n-1)
  var <- sum((x-mean(x))^2) / (length(x)-1)
  sd <- sqrt(var)
  cat('분산 = ', var, '\n')
  cat('표준편차 =', sd)
}

var_sd(x)


# ------------------------------------------------------------------- 
#<연습문제> 
# ------------------------------------------------------------------- 

# 문자열 -> 숫자 변경
library(stringr)
str <- '($124,512)'
str2 <- str_replace_all(str, '\\,|\\(|\\)|\\$','')
num <- as.numeric(str2)
num * 100 

str_pro <- function(str) {
  str2 <- str_replace_all(str, '\\,|\\(|\\)|\\$','')
  num <- as.numeric(str2)
  return(num)
}

print(str_pro(str))

info <- read.csv('C:/Rwork/output/info.csv', header=T)
head(info)
str(info)

state <- info[1]
num_col <- info[2:10]
head(num_col)

num_result <- apply(num_col,2,str_pro)
info_result = cbind(state,num_result)
class(info_result)
head(info_result)



##########################
##  2. 주요 R 내장 함수 
##########################

seq(-2, 2, by=.2) # 0.2씩 증가
seq(length=10, from=-5, by=.2) # -5부터 10개 생성 
rnorm(20, mean = 0, sd = 1) # 정규분포를 따르는 20개 데이터 생성
runif(20, min=0, max=100) # 0~100사이의 20개 난수 생성
sample(0:100, 20) # 0~100사이의 20개 sample 생성
vec<-1:10
min(vec)
max(vec)
range(vec)
mean(vec) # 평균
median(vec) # 중위수
sum(vec) 
prod(vec) # 데이터의 곱

factorial(5) # 팩토리얼=120
abs(-5)  # 절대값
sd(rnorm(10)) # 표준편차 구하기 
table(vec) # 빈도수 
sqrt(16) # 4 
4^2 # 16
# 나머지 구하기
5%%3 # 2
6%%2 # 0


getwd()
setwd("c:/Rwork/Part-I")
excel <- read.csv("excel.csv", header=TRUE)
head(excel,10) 

#colMeans()함수 : 각 열의 평균 계산
colMeans(excel[1:5])
colSums(excel[1:5])
summary(excel)  #요약통계량 

