--학습목표(함수)
/*
유형
-단일 행 함수(Single row function)
-그룹 함수(Group function)

컬럼타입(숫자 - number, 문자- char, varchar2,  날짜 - date)
- 숫자 함수
- 문자 함수
- 날짜 함수
- 기타 함수
*/

-- 문자함수
-- LENGTH
SELECT  *
FROM    COLUMN_LENGTH;
-- CHAR 한글일 경우 LENGTH
-- 한글 3BYTE, 6(글자)*3(BYTE) = 18, 20(최대 BYTE)- 18 =2 , 2+6(글자)=8 BYTE
-- 따라서 CHARACTER TYPE에 한글은 좋지 않다.
SELECT  LENGTH(CHARTYPE),
        LENGTH(VARCHARTYPE)
FROM    COLUMN_LENGTH;

-- INSTR(): 찾는 문자의 인덱스를 리턴하는 함수
-- INSTR(STRING, SUBSTRING, [POSITION, OCCURRANCE]): NUMBER , [ ]에 있는 것은 옵셔날 인자.
--                        문자열의 서칭 방향, 반복 횟수(즉, 가장 처음 찾으려고 하는 문자열을 만나는 횟수 지정)
SELECT  *
FROM    EMPLOYEE;

-- '@VCC.COM' 문자열 중 .앞의 문자 'C'의 인덱스를 구하고자 한다면? 오라클은 인덱스가 1부터 시작함.파이썬과 다름
SELECT  EMAIL,
        INSTR(EMAIL, 'c', -1, 2) -- 3번 째 인자는 인덱스를 -1로 거꾸로 센다는 뜻, OCCURRANCE: 2는 두 번 반복(즉,com에서 c를 찾고 그 다음 . 뒤에 있는 c찾으니까 두 번.)
FROM    EMPLOYEE;

-- LPAD | RPAD
-- LPAD(STRING, N, [STR])
SELECT  EMAIL,
        LENGTH(EMAIL),
        LPAD(EMAIL, 20,'*'),
        RPAD(EMAIL, 20,'*')
FROM    EMPLOYEE;

-- TRIM, LTRIN, RTRIM
-- 문자를 제거할 때
-- LTRIM(STRING, [STR]): 1번 인자에서 2 번 인자의 문자를 제거
-- RTRIM(STRING, [STR]) : 두 번째 인자를 지정하지 않으면 TRIM 함수는 기본적으로 공백을 제거
-- TRIM(LEADING | TRAILING | BOTH STR FROM STRING), TRIM 하나로 L,RTRIM을 표현 할 수 있다.
--       왼쪽         오른쪽     양쪽
SELECT  LENGTH('    TECH    '),
        LTRIM('    TECH    '),
        LENGTH(LTRIM('    TECH    ')),-- 함수가 함수를 받을 수 있음
        RTRIM('    TECH    '),
        LENGTH(RTRIM('    TECH    '))
FROM    DUAL;  -- DUAL 은 더미 테이블

SELECT  TRIM(LEADING 'A' FROM 'AATECHAA'),
        TRIM(TRAILING 'A' FROM 'AATECHAA'),
        TRIM(BOTH 'A' FROM 'AATECHAA')
FROM    DUAL;

-- 중요
-- SUBSTR(STRING, POSITION, [LENGTH]): [LENGTH]만큼 POSITION 순서대로 문자를 가져옴,
--               POSITION을 8로 하면 좌에서 우 방향 기준 8번 인덱스부터 시작.
SELECT  EMP_NO,
        SUBSTR(EMP_NO, 1, 6),
        SUBSTR(EMP_NO, 8, 1)
FROM    EMPLOYEE;

-- 사원테이블에서 성별이 남자인 사원의 모든 정보를 조회한다면?
SELECT  *
FROM    EMPLOYEE
WHERE   SUBSTR(EMP_NO, 8, 1) = '1';

-- 숫자함수
-- ROUND(NUMBER,[DECIMAL_PLACE]), TRUNC(NUMBER,[DECIMAL_PLACE])
SELECT  ROUND(123.315,2),
        ROUND(123.315),
        ROUND(123.315,-1), -- DECIMAL_PLACE가 음수이면 정수 부분
        TRUNC(125.315,-1) -- 해당 자리수에서 절삭
FROM    DUAL;


-- 날짜 함수
-- SYSDATE: 현재 날짜 출력, ADD_MONTHS(DATE,N): DATE에 N 만큼의 개월수를 추가함 
-- MONTHS_BETWEEN(기준 날짜, 작은 날짜) : 기준날짜와 작은 날짜 사이의 차이 개월 수가 리턴됨.
SELECT  SYSDATE + 1
FROM    DUAL;

-- 근속년수가 20년 이상인 사원의 모든 정보를 조회한다면?
SELECT  HIRE_DATE,
        ADD_MONTHS(HIRE_DATE, 240)
FROM    EMPLOYEE;

SELECT  *
FROM    EMPLOYEE
WHERE   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

-- 근속년수 출력
SELECT  EMP_NAME,
        HIRE_DATE,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) AS 근속년수
FROM    EMPLOYEE
WHERE   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

-- 타입 변환 함수
/*
<-  TO_NUMBER()  TO_CHAR(DATE,표현형식)
NUMBER - CHARCACTER - DATE
->  TO_CHAR()    TO_DATE()

날짜 -> 문자
표현 형식
- YYYY/YY/YEAR: 네자리 년도/ 두자리 년도/ 문자형식
- MONTH/MON/MM/RM
- HH/MI/SS : 시분초
*/

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = 90; -- 여기서 묵시적으로 TO_CHAR(90), DEPT_ID는 CHAR TYPE 90은 숫자. 따라서 묵시적 형변환.

-- 날짜로 표현하지 못하는 것을 문자 형식으로 형변환 후 원하는 형식으로 표현 가능
SELECT  TO_CHAR(SYSDATE,'YYYY-MM-DY'), --DY 는 요일, DD는 일자.
        TO_CHAR(SYSDATE,'YYYY-MM-DD DAY'),
        TO_CHAR(SYSDATE,'MM-DD,YYYY'), -- 원하는 형식으로 지정 가능
        TO_CHAR(SYSDATE,'YYYY'),
        TO_CHAR(SYSDATE,'AM HH24:MI:SS'),
        TO_CHAR(SYSDATE,'YEAR, Q') -- Q는 쿼터
FROM    DUAL;

SELECT  HIRE_DATE,
        TO_CHAR(HIRE_DATE,'YYYY-MM-DD')
FROM    EMPLOYEE
WHERE   DEPT_ID = '90';


-- CHAR -> DATE, 문자형식이 날짜 형식으로 들어올 때는 TO_DATE의 포멧 형식이 문자형식 그대로 해야함.
--
SELECT  TO_DATE('20200215','YYYYMMDD'),
        TO_DATE('220215','YYMMDD'),
        TO_CHAR(TO_DATE('220215','YYMMDD'),'YYYY-MM-DD')
FROM    DUAL;

-- 년도를 포맷팅할 때 YYYY(현재 세기를 반환), RRRR(이전,현재,다음 세기를 반환)
SELECT  HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM--DD')
FROM    EMPLOYEE
WHERE   EMP_NAME = '한선기';

-- 현업에서 날짜를 관리할때 문자열 8자리로 관리함
SELECT  SYSDATE AS 현재,
        '95/02/15' AS 입력,
        TO_CHAR(TO_DATE('95/02/15','YY/MM/DD'),'YYYY'),
        TO_CHAR(TO_DATE('95/02/15','RR/MM/DD'),'YYYY')
FROM    DUAL;

-- 기타함수
-- NULL 값 처리 함수: NVL(인자, 값) -> NVL은 인자의 NULL값을 지정 값으로 대체됨.
SELECT  EMP_NAME,
        BONUS_PCT,
        NVL(BONUS_PCT, 0)
FROM    EMPLOYEE
WHERE   SALARY > 3500000;

SELECT  EMP_NAME,
        SALARY,
        SALARY * 12 AS ANNUL_SALARY,
        (SALARY +(SALARY * NVL(BONUS_PCT, 0))) * 12 AS "12개월연봉"
FROM    EMPLOYEE ;

-- 오라클 전용 함수
-- DECODE(EXPR, SEARCH, RESULT, [SEARCH, RESULT],[DEFALUT])
-- IF~ELSE 랑 같음 
-- 부서번호가 50번인 사원들의 이름, 성별을 조회한다면?
SELECT  EMP_NAME,
        DECODE(SUBSTR(EMP_NO,8,1),
                '1', '남자',
                '3', '남자',
                '여자') AS GENDER
FROM    EMPLOYEE
WHERE   DEPT_ID = '50';

-- 부서별 인상급여를 확인하고자 한다
-- 90번 부서만 급여의 10% 인상한다면?
SELECT  SALARY,
        DEPT_ID,
        DECODE(DEPT_ID,
                '90', SALARY * 1.1,
                SALARY) AS 인상급여
FROM    EMPLOYEE;

--ANSI 표준 (공통 표준) CASE~~END<- *DECODE는 오라클 전용*
-- CASE EXPR WHEN SEARCH THEN RESULT[ WHEN SEARCH THEN RESULT ] ELSE DEFAULT END
-- CASE WHEN CONDITION THEN RESULT[ WHEN SEARCH THEN RESULT ] ELSE DEFAULT END
SELECT  SALARY,
        DEPT_ID,
        CASE DEPT_ID WHEN '90' THEN SALARY * 1.1
                     ELSE SALARY
        END AS 인상급여
FROM    EMPLOYEE;

SELECT  SALARY,
        DEPT_ID,
        CASE WHEN DEPT_ID='90' THEN SALARY * 1.1
                     ELSE SALARY
        END AS 인상급여
FROM    EMPLOYEE;

-- 급여에 따른 급여 등급을 확인할려고 한다.
-- 3000000 이하면 초급, 4000000 이하면 중급, 초과면 고급으로 구분하고 싶다면?
SELECT  EMP_NAME,
        SALARY,
        CASE WHEN SALARY<= 3000000 THEN '초급'
             WHEN SALARY<= 4000000 THEN '중급'
             ELSE '고급'
        END AS 급여등급
FROM    EMPLOYEE

-- 그룹함수(SUM, AVG) - INPUT으로 NUMBER
-- MIN, MAX, COUNT는 레코드의 건수를 출력) - ANY(NUMBER, CHARACTER, DATE)
-- INPUT N -> OUTPUT 1
SELECT  SUM(SALARY), -- SELECT절에 SUM같은 그룹함수가 사용되면 일반 속성은 쓸수 없음.
        AVG(SALARY), -- AVG는 NULL을 제외함
        MIN(SALARY),
        MAX(SALARY),
        COUNT(SALARY), -- 지금 상황에서는 COUNT(*)도 가능.
        COUNT(BONUS_PCT),
        MAX(HIRE_DATE),
        MIN(HIRE_DATE)
FROM    EMPLOYEE;