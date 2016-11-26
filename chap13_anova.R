#############################################
# 추론통계분석 - 2-1. 두집단 비율차이 검정
#############################################

# 1. 실습데이터 가져오기
setwd("c:/Rwork/Part-III")
data <- read.csv("two_sample.csv", header=TRUE)
data
head(data) # 변수명 확인


# 2. 두 집단 subset 작성
data$method # 1, 2 -> 노이즈 없음
data$survey # 1(만족), 0(불만족)

# - 데이터 정체/전처리
x<- data$method # 교육방법(1, 2) -> 노이즈 없음
y<- data$survey # 만족도(1: 만족, 0:불만족)
x;y

# 1) 데이터 확인
# 교육방법 1과 2 모두 150명 참여
table(x) # 1 : 150, 2 : 150
# 교육방법 만족/불만족
table(y) # 0 : 55, 1 : 245

# 2) data 전처리 & 두 변수에 대한 교차분석
table(x, y, useNA="ifany") 
#  y
#x  0   1   -> 불만족/만족 
#1  40 110  -> 교육방법1
#2  15 135  -> 교육방법2


# 3. 두집단 비율차이검증 - prop.test()
# 형식) prop.test(c(110, 135), c(150, 150))

# 양측가설 검정
prop.test(c(110,135),c(150,150))
prop.test(c(110,135),c(150,150), alternative="two.sided", conf.level=0.95)

# 단측가설 검정 
# 방법1 > 방법2
prop.test(c(110,135),c(150,150), alter="greater", conf.level=0.95)
# p-value = 0.98 > 0.05 (x)

# 방법1 < 방법2
prop.test(c(110,135),c(150,150), alter="less", conf.level=0.95)
# p-value = 0.0001711 < 0.05 (o)

# ----------------------------------------------------------------
# <두집단 비율차이 검정 연습문제> 
# ----------------------------------------------------------------

#############################################
# 추론통계분석 - 2-2. 두집단 평균차이 검정
#############################################

# 1. 실습파일 가져오기
data <- read.csv("c:/Rwork/Part-III/two_sample.csv", header=TRUE)
data 
head(data) #4개 변수 확인
summary(data) # score - NA's : 73개

# 2. 두 집단 subset 작성(데이터 정제,전처리)
#result <- subset(data, !is.na(score), c(method, score))
dataset <- data[c('method', 'score')]
table(dataset$method)


# 3. 데이터 분리
# 1) 교육방법 별로 분리
method1 <- subset(dataset, method==1)
method2 <- subset(dataset, method==2)

# 2) 교육방법에서 점수 추출
method1_score <- method1$score
method2_score <- method2$score

# 3) 기술통계량 
length(method1_score); # 150
length(method2_score); # 150

# 4. 분포모양 검정 : 두 집단의 분포모양 일치 여부 검정
# 귀무가설 : 두 집단의 분포모양에 차이가 없다.
var.test(method1_score, method2_score) # p-value = 0.3002 -> 차이가 없다.
# 동질성 분포 : t.test()
# 비동질성 분포 : wilcox.test()

# 5. 가설검정 - 두집단 평균 차이검정
t.test(method1_score, method2_score)
t.test(method1_score, method2_score, alter="two.sided", conf.int=TRUE, conf.level=0.95)
# p-value = 0.0411 - 두 집단간 평균에 차이가 있다.

# 단측검정 1
t.test(method1_score, method2_score, alter="greater", conf.int=TRUE, conf.level=0.95)
# p-value = 0.9794 : a1을 기준으로 비교 -> a1이 b1보다 크지 않다.
# 단측검정2 
t.test(method1_score, method2_score, alter="less", conf.int=TRUE, conf.level=0.95)
# p-value = 0.02055 : a1이 b1보다 작다.

# ----------------------------------------------------------------
# <두집단 평균 차이 검정 연습문제>
# ----------------------------------------------------------------  

################################################
# 추론통계분석 - 2-3. 대응 두 집단 평균차이 검정
################################################
# 조건 : A집단  독립적 B집단 -> 비교대상 독립성 유지
# 대응 : 표본이 짝을 이룬다. -> 한 사람에게 2가지 질문
# 사례) 다이어트식품 효능 테스트 : 복용전 몸무게 -> 복용후 몸무게 

# 1. 실습파일 가져오기
getwd()
setwd("c:/Rwork/Part-III")
data <- read.csv("paired_sample.csv", header=TRUE)

# 2. 두 집단 subset 작성

# 1) 데이터 정제
#result <- subset(data, !is.na(after), c(before,after))
dataset <- data[ c('before',  'after')]
dataset

# 2) 적용전과 적용후 분리
before <- dataset$before# 교수법 적용전 점수
after <- dataset$after # 교수법 적용후 점수
before; after

# 3) 기술통계량 
length(before) # 100
length(after) # 100
mean(before) # 5.145
mean(after, na.rm = T) # 6.220833 -> 1.052  정도 증가


# 3. 분포모양 검정 
var.test(before, after, paired=TRUE) 
# 동질성 분포 : t.test()
# 비동질성 분포 : wilcox.test()

# 4. 가설검정
t.test(before, after, paired=TRUE) # p-value < 2.2e-16 

# 단측검정1
t.test(before, after, paired=TRUE,alter="greater",conf.int=TRUE, conf.level=0.95) 
#p-value = 1 -> x을 기준으로 비교 : x가 y보다 크지 않다.

# 단측검정2
t.test(before, after, paired=TRUE,alter="less",conf.int=TRUE, conf.level=0.95) 
# p-value < 2.2e-16 -> x을 기준으로 비교 : x가 y보다 적다.

#<해설> 교수법 프로그램을 적용하기 전 시험성적과 교수법 프로그램을 적용한 후 
#시험성적을 비교한 결과 교수법을 적용한 후 시험성적이 약 1.052 점수가 향상된 
#것으로 나타났다.


# ----------------------------------------------------------------  
#<대응 두 집단 평균차이 검정 연습문제> 
# ---------------------------------------------------------------- 

