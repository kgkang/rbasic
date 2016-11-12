######################################################
# 1. plyr 패키지 활용 - 데이터 병합
######################################################

install.packages('plyr')
library(plyr) # 패키지 로딩

# 병합할 데이터프레임 셋 만들기
x = data.frame(ID = c(1,2,3,4,5), height = c(160,171,173,162,165))
y = data.frame(ID = c(5,4,1,3,2), weight = c(55,73,60,57,80))

# 1. join() : plyr패키지 제공 함수
z <- join(x,y,by='ID') # ID컬럼으로 조인
z

x = data.frame(ID = c(1,2,3,4,6), height = c(160,171,173,162,180))
y = data.frame(ID = c(5,4,1,3,2), weight = c(55,73,60,57,80))

# left 조인
z <- join(x,y,by='ID') # ID컬럼으로 left 조인(왼쪽 변수 기준)
z
z <- join(x,y,by='ID', type='inner') # type='inner' : 값이 있는 것만 조인
z
z <- join(x,y,by='ID', type='full') # type='full' : 모든 항목 조인
z

# key값으로 병합하기

x = data.frame(key1 = c(1,1,2,2,3), 
               key2 = c('a','b','c','d','e'),
               val1 = c(10,20,30,40,50))
y = data.frame(key1 = c(3,2,2,1,1), 
               key2 = c('e','d','c','b','a'),
               val2 = c(500,400,300,200,100))

join(x,y,by=c('key1', 'key2'))


# 2. tapply() 함수 이용 - 그룹별 통계치 구하기
# 형식) tapply(적용data, 집단변수, 함수)
# 집단변수 = 범주형 변수 (ex: gender)
table(iris$Species)


# 꽃의 종류별(Species)로 꽃받침 길이 평균 구하기
tapply(iris$Sepal.Length, iris$Species, mean) 
# 꽃의 종류별(Species)로 꽃받침 길이 합계 구하기
tapply(iris$Sepal.Width, iris$Species, sum) 


# 3. ddply() : plyr 패키지 제공 함수
# 형식) ddply(dataframe, .(집단변수), 요약집계, 컬럼명=함수(변수))

# 꽃의 종류별(Species)로 꽃받침 길이(Sepal.Length)의 평균 계산
a <- ddply(iris, 
           .(Species), 
           summarise, # 요약 키워드 
           avg = mean(Sepal.Length),
           tot = sum(Sepal.Length),
           var = var(Sepal.Length))

a
# -------------------------------------------------------------
# <plyr 패키지 관련 연습문제>
# -------------------------------------------------------------

#-----------------------------------------------------------
#<plyr 패키지 관련 연습문제>
#------------------------------------------------------------
#  'mtcars' 데이터셋을 대상으로 차종별 실린더 수(cyl)와 기어단수(gear)별로 
#  연비(mpg)의 평균과 표준편차 통계치를
#  계산하시오.

# <조건1> 데이터 셋 구조 보기
data(mtcars)
str(mtcars)
table(mtcars$cyl)
table(mtcars$gear)

# <조건2> 평균과 표준편차 통계치 계산
a <- ddply(mtcars, .(cyl, gear), summarise,avg=mean(mpg), var=var(mpg))
a
b <- ddply(mtcars, .(cyl), summarise,avg=mean(mpg), var=var(mpg))
b


################################################
# 2. dplyr 패키지 활용
################################################

# dplyr 패키지와 데이터 셋 hflight 설치
install.packages(c("dplyr", "hflights"))
library(dplyr) # 함수 사용
library(hflights) # dataset 사용 


# 차원 보기
dim(hflights)
str(hflights)

# 1. tbl_df() 함수 : 데이터셋 화면창 안에서 한 눈에 파악할 수 있는 데이터 구성
hflights
hflights_df <- tbl_df(hflights)
hflights_df



# 2. filter(dataframe, 조건1,조건2)함수를 이용한 데이터 추출
# 1월 1일 데이터 추출
filter(hflights_df, Month == 1, DayofMonth == 1) 

# 1월 혹은 2월 데이터 추출
filter(hflights_df, Month == 1 | Month == 2) 

# 3. arrange()함수를 이용한 정렬(년도,월,도착시간)
arrange(hflights_df, Year, Month, ArrTime )

# Month 기준 내림차순 정렬 - desc(변수)
arrange(hflights_df, desc(Month))

# 4. select()함수를 이용한 열 조작
select(hflights_df, Year, Month, DayOfWeek)  # 3개 칼럼 선택

# 칼럼의 범위 지정 : Year~DayOfWeek 선택
select(hflights_df, Year:DayOfWeek)

# 칼럼의 범위 제외 : Year부터 DayOfWeek 제외
select(hflights_df, -(Year:DayOfWeek))


# -------------------------------------------------------------
# <실습문제> Month 기준으로 내림차순 정렬하여  
#            Year, Month, AirTime, ArrDelay 컬럼을 선택하시오.
# -------------------------------------------------------------

# 5. mutate() 함수를 이용하여 열 추가(변형-파생변수 만들기)
mutate(hflights_df, gain = ArrDelay - DepDelay, 
       gain_per_hour = gain/(AirTime/60))


# 새로 추가된 열을 select() 함수로 보기
select(mutate(hflights_df, gain = ArrDelay - DepDelay, 
              gain_per_hour = gain/(AirTime/60)), 
       Year, Month, ArrDelay, DepDelay,gain, gain_per_hour)


# 6. summarise()함수를 이용한 집계 - 평균 출발지연시간
summarise(hflights_df, cnt = n(), delay = mean(DepDelay, na.rm = TRUE))
# n() : row값 리턴


# 7. group_by(dataframe, 기준변수)함수를 이용한 그룹화
# - 형식) group_by(dataframe, 기준변수)함수

#  예제) 항공기별 비행편수가 20편 초과, 평균 비행거리 2,000마일 이내의 평균 연착시간 구하기

# 1) 비행편수를 구하기 위해서 항공기별 그룹화
planes <- group_by(hflights_df, TailNum) # TailNum : 항공기 일련번호
planes

# 2) 항공기별 필요한 변수 요약
planesInfo <- summarise(planes, count = n(), 
                        dist=mean(Distance, na.rm=T), 
                        delay=mean(ArrDelay, na.rm = T))
planesInfo

# 3) planesInfo객체를 대상으로 조건 지정
result <- filter(planesInfo, count > 20, dist < 2000)
result

# 4) 결측치 처리 : dist와 delay가 모두 1이상인 경우만 필터링
filter(result, dist>=1 & delay>=1)

#-----------------------------------------------------------
# <dplyr 패키지 관련 연습문제> 
#------------------------------------------------------------

######################################################
# 3. reshape2 패키지 활용
######################################################

install.packages('reshape2')
library(reshape2)

# 1. dcast()함수 이용 : 긴 형식 -> 넓은 형식 변경
# - '긴 형식'(Long format)을 '넓은 형식'(wide format)으로 모양 변경

data <- read.csv("c:/Rwork/Part-II/data.csv")
data

# data.csv 데이터 셋 구성 - 22개 관측치, 3개 변수
# Date : 구매날짜
# Customer : 고객ID
# Buy : 구매수량

# (1) '넓은 형식'(wide format)으로 변형
# 형식) dcast(데이터셋, 앞변수~뒤변수, 함수)
# 앞변수 : 행 구성, 뒷변수 : 칼럼 구성

wide <- dcast(data, Customer_ID ~ Date, sum)
wide 


# (2) 열 또는 행 단위 통계치 계산 함수 
# - colSums(), rowSums(), colMeans(), rowMeans()

# 고객별,날짜별 구매횟수의 합계 구하기
rowSums(wide) # 행 합계 -> 고객별
colSums(wide) # 열 합계 -> 날짜별

# - cbind와 rbind() 이용하여 원래 데이터 셋에 붙임 
wide <- cbind(wide, rowSums(wide)) # 컬럼으로 행 합계 붙임
wide <- rbind(wide, colSums(wide)) # 행으로 컬럼 합계 붙임
wide

# - 컬럼명 변경 : 'Sum by User' 
colnames(wide)
colnames(wide)[9] <- 'Sum by User' # 9번째 컬럼명 변경

# - 특정 셀값 변경 : 'Sum by day'
wide[6,1] <- 'Sum by day'
wide


# 2. melt() 함수 이용 : 넓은 형식 -> 긴 형식 변경
#   형식) melt(데이터셋, id='열이름 변수')

wide <- wide[-6,-9] # 6행과 9컬럼 제거
wide

# - 긴 형식 변경
long <- melt(wide, id='Customer_ID') 
long
# id변수를 기준으로 넓은 형식이 긴 형식으로 변경

# - 칼럼명 수정.
name <- c("Customer_ID", "Date", "Buy")
colnames(long) <- name   
head(long)

data("smiths")
smiths 

# wide -> long
long <- melt(id=1:2, smiths) # id:기준 칼럼 
long

# long -> wide
dcast(long, subject + time~...)
#-----------------------------------------------------------
# < reshape2 패키지 관련 연습문제> 
#------------------------------------------------------------


