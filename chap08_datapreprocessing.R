# chap08_datapreprocessing

##########################
##  1. 탐색적 데이터 조회
##########################

# 실습 데이터 읽어오기

setwd("C:/Rwork/Part-II")
dataset <- read.csv("dataset.csv", header=TRUE) # 헤더가 있는 경우


#1) 데이터 셋 보기

# 데이터셋 전체 보기
print(dataset) 
View(dataset) # 뷰어창 출력

# 간단이 앞쪽/뒤쪽 조회
head(dataset) 
tail(dataset) 

# 2) 데이터 셋 구조보기
names(dataset) # 변수명(컬럼)
attributes(dataset) # names(), class, row.names
str(dataset) # 데이터 구조보기

# 3) 데이터 셋 조회 
dataset$age 
dataset$resident
length(dataset$age) # data 수-300개 

x <- dataset$gender # 조회결과 변수 저장
y <- dataset$price
x;y

plot(dataset$price) # 산점도 : 전반적인 가격분포 보기

# $기호 대신 [""]기호를 이용한 변수 조회
dataset["gender"] 
dataset["price"]

# 색인(index)으로 칼럼 조회 
dataset[2] # 두번째 컬럼
dataset[6] # 여섯번째 컬럼
dataset[3,] # 3번째 관찰치(행) 전체
dataset[,3] # 3번째 변수(열) 전체

# dataset에서 2개 이상 칼럼 조회
dataset[c("job","price")]
dataset[c(2,6)] 

dataset[c(1,2,3)] 
dataset[c(1:3)] 
dataset[c(2,4:6,3,1)] 


###########################
## 2. 결측치(NA) 처리
###########################
# - 결측치 처리 방법 : 결측치 제거와 다른 값으로 대체하는 방법
# - 결측치를 무조건 제거하게 되면 결측치가 포함된 관측치가 제거되어 
#   해당 정보가  손실되므로 좋은 대안이 아닐 수 있다.
# - 따라서 결측치를 0이나 평균으로 대체하는 방법을 선택한다.

summary(dataset$price) 
sum(dataset$price) # NA 출력

# 결측데이터 제거 방법1
sum(dataset$price, na.rm=T) # 2362.9

# 결측데이터 제거 방법2 
price2 <- na.omit(dataset$price) 
sum(price2) # 2362.9
length(price2) # 270 -> 30개 제거

# 결측데이터 처리 : 0으로 대체
x <- dataset$price # price vector 생성 
x[1:30] # 5.1 4.2 4.7 3.5 5.0
dataset$price2 = ifelse( !is.na(x), x, 0) # 평균으로 대체
dataset$price2[1:30]

# 결측데이터 처리 : 평균으로 대체
x <- dataset$price # price vector 생성 
x[1:30] # 5.1 4.2 4.7 3.5 5.0
dataset$price3 = ifelse(!is.na(x), x, round(mean(x, na.rm=TRUE), 2) ) # 평균으로 대체
dataset$price3[1:30]

dataset[c('price', 'price2', 'price3')]

#########################
## 3. 극단치 발견과 정제
#########################

# 1) 범주형 변수 극단치 처리
gender <- dataset$gender
gender

# outlier 확인
hist(gender) # 히스토그램
table(gender) # 빈도수
pie(table(gender)) # 파이 차트

# gender 변수 정제(1,2)
dataset <- subset(dataset, gender==1 | gender==2)
dataset # gender변수 데이터 정제
length(dataset$gender) # 297개 - 3개 정제됨
pie(table(dataset$gender))


# 2) 비율척도 극단치 처리
dataset$price # 세부데이터 보기
length(dataset$price) #300개(NA포함)
plot(dataset$price) # 산점도 
summary(dataset$price) # 범위확인


# price변수 정제
dataset2 <- subset(dataset, dataset$price >= 2 & dataset$price <= 10)
length(dataset2$price) 
stem(dataset2$price) # 줄기와 잎 도표보기

#########################
##  4. 코딩변경 
#########################
# - 데이터의 가독성, 척도 변경, 최초 코딩 내용 변경을 목적으로 수행

# 1) 가독성을 위한 코딩변경 


dataset2$resident2[dataset2$resident == 1] <-'1.서울특별시'
dataset2$resident2[dataset2$resident == 2] <-'2.인천광역시'
dataset2$resident2[dataset2$resident == 3] <-'3.대전광역시'
dataset2$resident2[dataset2$resident == 4] <-'4.대구광역시'
dataset2$resident2[dataset2$resident == 5] <-'5.시구군'
dataset2[c("resident","resident2")] # 2개만 지정

dataset2$job2[dataset2$job == 1] <- '공무원'
dataset2$job2[dataset2$job == 2] <- '회사원'
dataset2$job2[dataset2$job == 3] <- '개인사업'
head(dataset2[c('job','job2')])


# 2) 연속형 -> 범주형
dataset2$age2[dataset2$age <= 30] <-"청년층"
dataset2$age2[dataset2$age > 30 & dataset2$age <=55] <-"중년층"
dataset2$age2[dataset2$age > 55] <-"장년층"
head(dataset2)

# 3) 역코딩 : 긍정순서(5~1)
# 5점 척도 
# 1.매우만족,  ...  5. 매우불만족 -> 6-1, 6-5 -> 5, 1

dataset2$survey
survey <- dataset2$survey
csurvey <- 6-survey # 역코딩
csurvey
survey  # 역코딩 결과와 비교
dataset2$survey <- csurvey # survery 수정
head(dataset2) # survey 결과 확인

# ----------------------------------------------------------------------
# <실습문제> 현재 직급(position) 칼럼은 1 ~ 5까지 5개 등급으로  
#  코딩 되어 있다. 다음 조건에 맞게 직급 칼럼을 처리하시오.
# <조건1> 직급 1 -> 5, 직급 5 -> 1로 역코딩 (1이 가장 높은 직급) 
# <조건2> 직급 1 -> 1급, 직급 5 -> 5급로 코딩변경 후 position2 칼럼 추가   
# ----------------------------------------------------------------------

new_data$position[1:5]
pos <- new_data$position
cpos <- 6 - pos
new_data$position2 <- cpos
new_data$position2[1:5]



#########################
## 5.정제된 데이터 저장
#########################
setwd("C:/Rwork/Part-II")

# (1) 정제된 데이터 저장
write.csv(dataset2,"cleanData.csv", quote=F, row.names=F) 

# (2) 저장된 파일 불러오기/확인
new_data <- read.csv("cleanData.csv", header=TRUE)
new_data 
dim(new_data) # 248  13

# -------------------------------------------------------------
# <데이터 전처리 관련 연습문제> 
# -------------------------------------------------------------

# -------------------------------------------------------------
# <데이터 전처리 관련 연습문제>
# -------------------------------------------------------------
# 1. resident변수의 NA 값을 제거한 후 data 변수에 저장하시오.
new_data <- subset(new_data, !is.na(new_data$resident))
summary(new_data$resident)
new_data
# 2. gender변수를 대상으로 1 -> 남자, 2 -> 여자 형태로 리코딩하여 
#    gender2변수에 추가한 후 파이차트로 결과를 확인하시오.
new_data$gender2[new_data$gender == 1] <- '남자'
new_data$gender2[new_data$gender == 2] <- '여자'
pie(table(new_data$gender2))


# 3. 나이를 30세 이하-> 1, 31~55-> 2, 56이상-> 3 으로 리코딩하여
#    age3변수에 추가한 후 age, age2, age3 변수 3개만 확인하시오.
#----------------------------------------------------------------
new_data$age3[new_data$age<=30] <- 1
new_data$age3[new_data$age>=31 & new_data$age<=55] <- 2
new_data$age3[new_data$age>=56] <- 3
head(new_data[c('age','age2','age3')])

#############################
## 6. 탐색적 분석을 위한 시각화 
#############################

# 1) 명목척도(범주/서열) vs 명목척도(범주/서열) 
# - 거주지역과 성별 칼럼 시각화 
resident_gender <- table(new_data$resident2, new_data$gender2)
gender_resident <- table(new_data$gender2, new_data$resident2)
gender_resident

# 성별에 따른 거주지역 분포 현황 
barplot(resident_gender, beside=T, horiz=T,  col = rainbow(5),
        legend = row.names(resident_gender),
        main = '성별에 따른 거주지역 분포 현황') 
# row.names(resident_gender) # 행 이름 


# 거주지역에 따른 성별 분포 현황 
barplot(gender_resident, beside=T, col=rep(c(2, 4),5), horiz=T,
        legend=c("남자","여자"),  main = '거주지역별 성별 분포 현황') 


# 2) 비율척도(연속) vs 명목척도(범주/서열)
# - 나이와 직업유형에 따른 시각화 
install.packages("lattice") #격자 그랲 
library(lattice)

# 나이와 직업유형 데이터 분포  
densityplot( ~ age, data=new_data, groups = job2,
             plot.points=T, auto.key = T)
# plot.points=T : 밀도, auto.key = T : 범례 


# 3) 비율(연속),명목(범주/서열) vs 명목(범주/서열)
# - 구매비용(연속) : x칼럼 , 직급(서열):조건, 성별(범주):그룹   
densityplot(~ price | factor(gender2), data=new_data, 
            groups = position2, plot.points=T, auto.key = T) 
# groups = gender2 : 한 격자에 나타날 그룹 칼럼 지정 

densityplot(~ price | factor(position2), data=new_data, 
            groups = gender2, plot.points=T, auto.key = T) 


# 4) 비율(연속)2개 vs 명목 
# 형식 : (y~x | 범주 , 데이타 )
xyplot(price ~ age | factor(gender2), data=new_data) 

#######################
## 7.파생변수 생성
#######################

# 1 : N 관계
# user_id  type
# u001     아파트

# 1 : 1 관계
# user_id 주택 빌라 아파트 오피스텔
# u001     0    0     1     0


# - 기존 변수로 새로운 변수 생성
# - 방법) 사칙연산 적용, 1:N 관계 -> 1:1 관계 변수 생성 
# id : 주건환경(주택,빌라,아파트,오피스텔) -> 4개의 칼럼 추가 

setwd('C:\\Rwork\\Part-II')
user_data <- read.csv('user_data.csv', header = T)
head(user_data) # user_id age house_type resident job child

# 1) 1:1 파생변수 생성 
# - 주택 유형 :  1, 아파트 유형 : 0 
summary(user_data$house_type) # NA확인 - 없음 
# 파생변수 생성 
house_type2 <- ifelse(user_data$house_type == 1 | user_data$house_type == 2, 1, 2)
# 결과 확인
user_data$house_type[1:10]
house_type2[1:10] 
# 파생변수 추가 
user_data$house_type2 <- house_type2
head(user_data)


# 2) 1:N 파생변수 생성 
pay_data <- read.csv('pay_data.csv', header = T)
head(pay_data,10) # user_id product_type pay_method  price

library(reshape2)

# (1) 고객별 상품 유형에 따른 구매금액 합계 파생변수 생성   
product_price <- dcast(pay_data, user_id ~ product_type , sum, na.rm=T) # 행 ~ 열 
head(product_price, 3) # 행(고객 id) 열(상품 타입)

class(product_price) # "data.frame"
# 칼럼명 수정 
names(product_price) <- c('user_id','product_type1','product_type2','product_type3','product_type4','product_type5')
head(product_price, 3) # 칼럼명 수정 확인 

# (2) 고객별 지불유형에 따른 구매금액 합계 파생변수 생성 
pay_price <- dcast(pay_data, user_id ~ pay_method, sum, na.rm=T) # 행 ~ 열 
head(pay_price, 3) # 행(고객 id) 열(상품 타입)

names(pay_price) <- c('user_id','pay_method1','pay_method2','pay_method3','pay_method4')
head(pay_price, 3) # 칼럼명 수정 확인 


# (3) 파생변수 추가(data.frame 합치기) 
library(plyr) # 패키지 로딩

# 형식) join(df1, df2, by='column')
user_pay_data <- join(user_data, product_price, by='user_id')
head(user_pay_data,10) # product_typeNo 파생변수 추가(NA : 해당 상품 구매이력 없음) 

user_pay_data <- join(user_pay_data, pay_price, by='user_id')
head(user_pay_data,10) # pay_methodNo 파생변수 추가 

# (4) 파생변수 대상 더미변수화(1 or 0) -> 특정 고객의 구매상품 내역을 파악할 수 있다. 
user_pay_data$product_type1 <- ifelse( user_pay_data$product_type1 > 0, 1, 0)
user_pay_data$product_type2 <- ifelse( user_pay_data$product_type2 > 0, 1, 0)
user_pay_data$product_type3 <- ifelse( user_pay_data$product_type3 > 0, 1, 0)
user_pay_data$product_type4 <- ifelse( user_pay_data$product_type4 > 0, 1, 0)
user_pay_data$product_type5 <- ifelse( user_pay_data$product_type5 > 0, 1, 0)
head(user_pay_data,30) # pay_methodNo 파생변수 추가 
# pay_methodNo 칼럼은 고객의 지불유형과 총구매액의 내역을 파악할 수 있다.


# (5) 총 구매금액 파생변수 생성(사칙연산 : 지급방법 이용) -> 전체 고객을 대상으로 우수고객을 파악할 수 있다. 
user_pay_data$total_price <- user_pay_data$pay_method1 + user_pay_data$pay_method2 + user_pay_data$pay_method3 + user_pay_data$pay_method4 
head(user_pay_data,10) # total_price 칼럼 확인

# (6) 파생변수 대상 더미변수화(1 or 0) -> 특정 고객의 지불방법 내역을 파악할 수 있다. 
user_pay_data$pay_method1 <- ifelse( user_pay_data$pay_method1 > 0, 1, 0)
user_pay_data$pay_method2 <- ifelse( user_pay_data$pay_method2 > 0, 1, 0)
user_pay_data$pay_method3 <- ifelse( user_pay_data$pay_method3 > 0, 1, 0)
user_pay_data$pay_method4 <- ifelse( user_pay_data$pay_method4 > 0, 1, 0)
head(user_pay_data,30) # 더미변수화(1 or 0) 확인  

# -------------------------------------------------------------
# <파생변수 생성 관련 연습문제>
# -------------------------------------------------------------

#####################
##  8. 표본 셈플링
#####################

# - 전체 데이터 셋을 대상으로 무작위(random)로 관측치를 추출하는 방법  

choice <- sample(c(1:100), 30) # 1~100
choice # 30개 랜덤 추출 

# 1) 행 번호 추출 
idx <- sample(1:nrow(user_pay_data),30) # 30개 무작위 추출
idx # 추출값 : 행 번호

# 2) 관측치 추출 
result <- user_pay_data[idx, ]
result

#다양한 범위를 지정해서 무작위 셈플링
choice2 <- sample(c(10:50, 70:150, 160:190),30)
choice2



# iris (150) -> train : 70%, test : 30%
idx <- sample(1:nrow(iris),0.7*nrow(iris))
idx
train <- iris[idx,]
test <- iris[-idx,]
dim(train)
dim(test)
