# chap06_DataVisualization

#이산변수 : 정수
#연속변수 : 실수 
# 이산변수,연속변수 각각에 적합한 시각화 툴을 사용하는 것이 좋다.

#############################
##  1. 이산변수 시각화
#############################

#1) 막대차트 시각화
install.packages("RSADBE")
library(RSADBE)
help("RSADBE") # Package 정보제공

data(Severity_Counts) # RSADBE 패키지 제공 데이터셋
str(Severity_Counts) 
Severity_Counts # 버그 측정 데이터 셋


# (1) 세로 막대 차트
barplot(Severity_Counts, ylim=c(0,12000), 
        col=rainbow(10), main ="소프트웨어 버그 측정 결과(BR/AR)",
        font.main=4)

# ?barplot 

# (2) 가로 막대 차트
# xlab : x축 이름, xlim : x축 값 범위, horiz=T : 가로막대
barplot(Severity_Counts,xlab="Bug Count", xlim=c(0,12000), 
        horiz=T, col=rainbow(10)) # 10가지 무지개 색

barplot(Severity_Counts,xlab="Bug Count", xlim=c(0,12000), 
        horiz=T, col=rep(c(2, 4),5)) # red와 blue 색상 5회 반복

barplot(Severity_Counts,xlab="Bug Count", xlim=c(0,12000), 
        horiz=T, col=rep(c(1, 7),5)) 
# 1 : 검정, 2: 빨강, 3: 초록, 4: 파랑, 5: 하늘색, 6: 자주색, 7 : 노랑색


data(Bug_Metrics_Software) # RSADBE 패키지 제공 데이터셋
Bug_Metrics_Software # 행렬 구조 - 1면(Before)과 2면(After) 구성
# 5개의 소프트웨어 별로 발표전과 후 버그 측정 결과를 3차원 배열구조로 제공

par(mfrow=c(1,2)) # 1행 2열 그래프 보기

# Before Bug(1면)
barplot(Bug_Metrics_Software[,,1], beside=T, 
        col=c("lightblue","mistyrose","lightcyan","lavender","cornsilk"),
        legend=c("JDT","PDE","Equinox","Lucene","Mylyn"))
title(main ="Before Release Bug Frequency",font.main=4) 


# After Bug(2면) 
barplot(Bug_Metrics_Software[,,2], beside=F,
        col=c("lightblue","mistyrose","lightcyan","lavender","cornsilk"),
        legend=c("JDT","PDE","Equinox","Lucene","Mylyn"))
title(main ="After Release Bug Frequency", font.main=4)

#2) 점 차트 시각화
par(mfrow=c(1,1)) # 1행 1열 그래프 보기

dotchart(Severity_Counts, col=9:10, lcolor="black", pch=1:2,
         labels=names(Severity_Counts),
         main="Dot Plot for the Before and After", cex=1.2)


#3) 파이 차트 시각화
class(Severity_Counts) # "numeric"

par(mfrow=c(1,2)) # 1행 2열 그래프 보기
pie(Severity_Counts[c(1,3,5,7,9)]) # Bugs.BR
title("Before Release Bug Frequency")
pie(Severity_Counts[c(2,4,6,8,10)]) # Bugs.AR
title("After Release Bug Frequency")



#############################
##  2. 연속변수 시각화
#############################

library(RSADBE)
data(resistivity) # RSADBE패키지에서 제공하는 데이터셋
class(resistivity) 
resistivity 

#1) 상자 그래프 시각화

boxplot(resistivity, range=0) # 두 Process 상자 그래프 시각화

boxplot(resistivity, range=0, notch=T) 
# notch=T : 중위수 비교시 사용되는 옵션

abline(h=0.140, lty=3) # 기준선 추가


#2) 히스토그램 시각화
install.packages("psych")
library(psych)
galton # psych 패키지 제공 데이터 셋

data(galton) # 자식과 부모의 키 사이의 관계 

par(mfrow=c(1,2))
hist(galton$parent,breaks="FD", xlab="Height to Parent",
     main="Histogram for Parent Height with Freedman-Diaconis",
     xlim=c(60,75))
# breaks="FD" : Freedman-Diaconis, 구간 너비


hist(galton$parent,breaks="Sturges", xlab="Height to Parent",
     main="Histogram for Parent Height with Sturges",
     xlim=c(60,75))
#breaks="Sturges"  : 구간 너비


hist(galton$child, xlab="Height to Child",
     main="Histogram for Child Height with Freedman-Diaconis",
     xlim=c(60,75), col="mistyrose")
# col="mistyrose" : 색상(흐릿한 장미) 적용

hist(galton$child, xlab="Height to Child",
     main="Histogram for Child Height with Sturges",
     xlim=c(60,75), col="magenta")
# col="magenta" : 색상(진홍색) 적용

#3) 산점도 시각화
price<- runif(10, min=1, max=100) # 난수 발생

plot(price)

par(mfrow=c(2,2)) # 2행 2열 차트 그리기
plot(price, type="l") # 유형 : 실선
plot(price, type="o") # 유형 : 원형과 실선
plot(price, type="h") # 직선
plot(price, type="s") # 꺾은선

# plot() 함수 속성 : pch : 연결점 문자타입-> plotting characher-번호(1~30)
plot(price, type="o", pch=5) # 빈 사각형
plot(price, type="o", pch=15)# 채워진 마름모
plot(price, type="o", pch=20, col="blue") 
plot(price, type="o", pch=20, col="orange", cex=1.5) 

plot(price, type="o", pch=20, col="green", cex=2.0, lwd=3) 

#######################
## plot() 일반 객체 적용
#######################

# plot(x,y) ==> plot(y~x) 와 같음 


methods(plot) 
# plot 삼수는 넘겨진 데이터 모델에 따라서 34개의 메서드가 호출된다.
# ex. 회귀분석 데이터 객체이면 회귀분석 메서드가 호출됨
head(galton)
model <- lm(child~parent,  data=galton) #lm(종속변수~독립변수)
par(mfrow=c(1,1)) # 1행 1열 차트 그리기
plot(model)

# 산점도와 회귀선 시각화(galton 데이터 셋)
par(mfrow=c(1,1))
plot(child~parent, data=galton) # y ~ x

out = lm(child~parent, data=galton)
abline(out, col="red") 


########################
## 3. 중복 데이터 시각화
########################

x <- c(1:4,2,4)
y <- rep(2,6)
x;y
plot(x,y)

# 교차테이블
table(x,y)

#  y
#---
#x 2
#---
#1 1 -> (1,2)이 1번
#2 2 -> (2,2)이 2번 
#3 1
#4 2

xy_df <- data.frame(table(x,y))
xy_df
#   x y Freq
# 1 1 2    1
# 2 2 2    2
# 3 3 2    1
# 4 4 2    2

plot(y~x, cex = 0.8*xy_df$Freq,pch='@',col='red')




# (1) 데이터프레임으로 변환
library(psych)
freqData <- as.data.frame(table(galton$child, galton$parent))

names(freqData)=c("child","parent", "freq") # 컬럼명 지정

# (2) 프레임 -> 벡터 -> 수치데이터변환 -> 가중치 적용
parent <- as.numeric(as.vector(freqData$parent))
child <- as.numeric(as.vector(freqData$child))
plot(child~parent, pch=21, col="blue", bg="green",
     cex=0.15*freqData$freq, xlab="parent", ylab="child")

########################
# 4. 변수 간의 산점도 matrix
########################

data(iris)

# 4개 변수 상호비교
pairs(iris[,1:4]) # Sepal.Length Sepal.Width Petal.Length Petal.Width

# Species=="virginica"인 경우만 4개 변수 상호비교
iris[iris$Species=="virginica", 1:4]

pairs(iris[iris$Species=="virginica", 1:4])
pairs(iris[iris$Species=="setosa", 1:4])

########################
# 5. 차트 결과 파일 저장
########################

setwd("C:/Rwork/Part-II") # 폴더 지정
jpeg("galton.jpg", width=720, height=480) # jpg 장치 open, 픽셀 지정 가능

plot(child~parent, data=galton) # y ~ x
title(main="부모와 자식의 키 유전관계")
out = lm(child~parent, data=galton)
abline(out, col="red") 
dev.off() # 장치 종료 


# ------------------------------------------------------------------- 
# <데이터 시각화 관련 연습문제> 
# ------------------------------------------------------------------- 

# chap06_DataVisualization (연습문제)


# <연습문제>  iris 데이터 테이블을 대상으로 plot()함수를 이용하여 
#             다음 조건에 맞게 차트를 그리시오.


# 조건1) 1번 컬럼이 x축, 3번 컬럼을 y축으로 차트 그리기
plot(iris$Sepal.Length, iris$Petal.Length)

# 조건2) 5번 컬럼으로 색상 지정하기
plot(iris$Sepal.Length, iris$Petal.Length,col=iris$Species)

# 조건3) 제목 추가("iris 데이터 테이블 산포도 차트")
title(main="iris 데이터 테이블 산포도 차트")

# 조건4) 파일로 차트 저장하기("C:/Rwork/Part-II/iris.jpg")

setwd("C:/Rwork/Part-II") # 폴더 지정
jpeg("iris.jpg", width=720, height=480) # jpg 장치 open, 픽셀 지정 가능
plot(iris$Sepal.Length, iris$Petal.Length,col=iris$Species)
title(main="iris 데이터 테이블 산포도 차트")
dev.off() # 장치 종료 
