######################################################
# 회귀분석(Regression Analysis)
######################################################
# - 특정 변수(독립변수)가 다른 변수(종속변수)에 어떠한 영향을 미치는가 분석


#############################
## 1. 단순회귀분석
#############################
#  - 독립변수와 종속변수가 1개인 경우

# 연구가설 : 제품 적절성은  제품 만족도에 정(正)의 영향을 미친다.
# 연구모델 : 제품적절성(독립변수) -> 제품 만족도(종속변수)

# 단순선형회귀 모델 생성  
# 형식) lm(formula= y ~ x 변수, data) # x:독립, y 종속, data=dataset
# lm() 함수 -> x변수를 대상으로 y변수 값 유추 

product <- read.csv("C:/Rwork/Part-IV/product.csv", header=TRUE)
head(product) # 친밀도 적절성 만족도(등간척도 - 5점 척도)

str(product) # 'data.frame':  264 obs. of  3 variables:
y = product$제품_만족도 # 종속변수
x = product$제품_친밀도 # 독립변수
df <- data.frame(x, y)

# 회귀모델 생성 
result.lm <- lm(formula=y ~ x, data=df)
result.lm # 계수 확인 


head(df, 1) # 3 3
# 회귀방정식 = 1차 함수 
# Y = 절편 + 기울기 * X


# (2) 선형회귀 분석 결과 보기
summary(result.lm)

# <회귀모델 분석순서>
# 1. 모델의 유의성 검정 
# 2. 모델의 설명력 = 상관계수^2
# 3. x변수의 유의성 검정 


# (3) 단순선형회귀 시각화
# x,y 산점도 그리기 
plot(formula=y ~ x, data=df)
# 회귀분석
result.lm <- lm(formula=y ~ x, data=df)
# 회귀선 
abline(result.lm, col='red')

#############################
## 2. 다중회귀분석
#############################
# -  여러 개의 독립변수 -> 종속변수에 미치는 영향 분석
# 연구가설 : 음료수 제품의 적절성(x1)과 친밀도(x2)는 제품 만족도(y)에 정의 영향을 미친다.
# 연구모델 : 제품 적절성(x1), 제품 친밀도(x2) -> 제품 만족도(y)

#(1) 적절성 + 친밀도 -> 만족도  
y = product$제품_만족도 # 종속변수
x1 = product$제품_친밀도 # 독립변수2
x2 = product$제품_적절성 # 독립변수1

df <- data.frame(x1, x2, y)

result.lm <- lm(formula=y ~ x1 + x2, data=df)
#result.lm <- lm(formula=y ~ ., data=df)

# 계수 확인 
result.lm

names(result.lm)

# 잔차 확인
residuals(result.lm)[1:2]
# 적합값(예측값)
fitted.values(result.lm)[1:2]

# 회귀방정식 : Y(종속변수) = 상수 + 베타1.x1 + 베타2.x2...
# Y = a + b*x1 + b*x2

summary(result.lm)
# <회귀모델 분석순서>
# 1. 모델의 유의성 검정  (p-value , 0.05보다 작아야 유의함)
# 2. 모델의 설명력 = 상관계수^2 (R-squared, 1에 가까울수록 모델 설명력이 높다 )
# 3. x변수의 유의성 검정 

#(2) 학습데이터와 검증데이터 분석

# 단계1 : 7:3비율 데이터 샘플링
dataset <- read.csv("C:/Rwork/Part-IV/product.csv", header=TRUE)
dataset
dim(dataset) # 264   3

idx <- sample(1:nrow(dataset), 0.7*nrow(dataset))
idx

# 단계2 : 학습데이터와 검정데이터 생성
train <- dataset[idx,] # result중 70%
dim(train) # [1] 184   3
train # 학습데이터

test <- dataset[-idx, ] # result중 나머지 30%
dim(test) # [1] 80  3
test # 검정 데이터

# 단계3 : 회귀모델 생성 : train set 이용  
result.lm <- lm(formula=제품_만족도 ~ 제품_적절성 + 제품_친밀도, data=train)
summary(result.lm) # 학습데이터 분석 -> p-value: < 2.2e-16

# 단계4 : 모델 평가 : test set
pred <- predict(result.lm, test) # 1) 예측치 생성 

cor(pred, test$제품_만족도) # 2) 모델 평가

#  predict()함수
# - 회귀분석 결과를 대상으로 회귀방정식을 적용한 새로운 값 예측(Y값)
# 형식) predict(model, test) test에 x변수(회귀분석결과) 값 존재해야함

# ----------------------------------------------------------------
#<연습문제1>  다중회귀분석 수행
# ----------------------------------------------------------------