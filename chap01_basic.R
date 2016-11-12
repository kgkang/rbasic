# chap01_Basic

#단축키
# 실행방법 : Ctrl+Enter, R+Enter
# 자동완성 : ctrl+space

# 수업내용
# 1. 패키지와 세션 보기
dim(available.packages())
# 실행결과 : [1] 9416 (row)  17 (colume)
# 패키지 보기
available.packages()
# session 보기 => 다국어정보, 기본설치 패키지
sessionInfo()


# 2. 변수와 데이터 형
# 1) 변수 : 메모리(휘발성) 이름
# 2) 변수명 작성 규칙
# - 영문시작, 두번째(숫자,특수문자(_,.))
# - 대문자, 소문자 구분(Num과 num은 다른 변수)
# - 키워드, 함수명 사용 불가
# - 특징: 가장 최근값만 저장함

var1 <- 0
var1 <- 1
var1

var2 <- 10
var3 <- 20
var2; var3

# 변수명.멤버
member.id <- 'hong'
member.pwd <- '1234'
member.name <- '홍길동'

# scalar vs vector 변수
# scalar : 1개 값 저장
# vector : 2개 이상 값 저장

age <- 35
name <- '홍길동'
age; name

# vector 변수
age2 <- c(35,45,55)
name2 <- c('홍길동','이순신','유관순')
age2
name2
name2[2]

# 변수 목록 보기
ls()

# 3) 데이터 형 (data type)
# 값에 의해서 데이터 형이 결정됨
int <- 100
string <- 'hong gildong'
bool <- TRUE # T, FALSE=F

# 변수 타입 확인 함수 => mode, p19~p20
mode(int); mode(string); mode(bool)

is.numeric(int)
is.logical(bool)

# NA(결측치)
score <- c(98,85,NA,75,65)
score
mean(score) # na가 있어서 평균을 못구함.
mean(score, na.rm = TRUE) # na를 무시하고 평균 구하기
is.na(score)
# 함수에 대한 설명 보기 
help(mean) # help("mean")

# 4) 데이터 형 변환 (casting)
#   (1) "문자열" -> 숫자
x <- c(10,20,30,'40') # 동일한 타입 저장
x # "10" "20" "30" "40"

#x * 0.5 # Error

#숫자 형변환 (p22)
num <- as.numeric(x)
num * 0.5 
num ** 0.5 # sqrt
hist(num)


#-----------------------------------------------------------------------
#<연습문제1> name, age, address 라는 객체를 생성하시오.

# 조건1) 변수의 특성에 맞게 값을 초기화하고 결과를 확인한다.
   name <- "강경구"
   age <- 45
   address <- '용인시' 

# 조건2) 각 변수에 데이터 타입 보기 함수를 적용한다.
   mode(name)
   is.numeric(age)
   
#----------------------------------------------------------------------- 

# (2) 요인형 (Factor)
# - 동일한 값을 범주로 갖는 vector형

   gender <- c('M','F','M','F','M')
   gender
   # plot(gender) #Erro
   
   fgender <- as.factor(gender) #문자열 -> 요인형
   fgender
   plot(fgender)
   str(fgender) 
   # Factor w/ 2 levels "F","M": 2 1 2 1 2
   # 더미변수 : 0과 1
   
   # mode() vs class()
   # mode() : data type을 리턴 
   # class() : data structure를 리턴 
   mode(fgender) # [1] "numeric"
   class(fgender) # [1] "factor"

# (3) 날짜형
   Sys.Date() # [1] "2016-11-05"
   Sys.time() # [1] "2016-11-05 11:58:05 KST"
   

   #문자열 -> 날짜형 객체
   today <- '2016-11-05 11:58:05'
   mode(today) # "character"
   class(today) # "character"
   
   ctoday <- strptime(today,'%Y-%m-%d %H:%M:%S')
   mode(ctoday) # "list" 두개의 다른 타입이 존재.
   class(ctoday) # "POSIXlt" "POSIXt" 
   
   #영문식 -> 한국식
   sdate <- '13-Jun-16' #2016-06-13
   # 다국어 정보 확인
   Sys.getlocale() # "LC_COLLATE=Korean_Korea.949
   
   Sys.setlocale(locale='English_USA') #'locale = 언어_국가"
   etoday <- strptime(sdate,'%d-%b-%y')
   etoday # "2016-06-13 KST"
   
   # 다국어 원위치 
   Sys.setlocale(locale='Korean_Korea') #'locale = 언어_국가"

# 3. 패키지 사용법
   # - package = dataset + function 
   # 패키지 안에는 다수의 함수와 데이타셋이 존재
   
   # 1) 패키지 설치
   # 형식 ) install.packages('패키지명')
   
   install.packages('stringr') # 문자열 처리 
   library(stringr) # in memory , 패키지를 메모리에 로딩
   
   str_extract_all('홍길동35이순신45','[0-9]{2}')
   # "35" "45"
   str_extract_all('홍길동35이순신45','[가-히]{3}')
   # [1] "홍길동" "이순신"
   
   # 2) 패키지 제거
   remove.packages('stringr')
   
   # 3) 기본 데이터 셋
   data()
   Nile
   length(Nile)
   plot(Nile)
   hist(Nile)
# 4. 기본함수 사용법
   # 1) 도움말
   help("var")
   ?var # help('var')와 같음 
   args(var) # var의 매개변수 확인 
   example("var") # var에 관련된 예
   
   # 2) 패키지 정보 
   # stringr in R 이라고 구글링하면 관련 pdf파일 검색가능
   

   
# 5. 작업공간
   
   getwd()
   setwd('C:\\Rwork\\Part-I')
   getwd()
   
   test <- read.csv('test.csv')
   test
   str
   
   
   #-----------------------------------------------------------------------
   # <연습문제2> R에서 제공하는 women 데이터 셋을 다음과 같이 처리하시오.
   
   # <조건1> women 데이터 셋은 어떤 데이터인가?
   
   # <조건2> women 데이터 셋의 자료 유형과 자료구조는?
   
   # <조건3> plot() 함수를 이용하여 기본 차트를 그리시오.
   #-----------------------------------------------------------------------
   help(women)
   data(women)
   women
   str(women)

   
   mode(women) # [1] "list"
   class(women) # [1] "data.frame"
   
   plot(women)
   