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

--DAY03
-- ORDER BY
SELECT *
FROM    EMPLOYEE;

SELECT *
FROM    EMPLOYEE
ORDER BY    SALARY DESC , EMP_NAME DESC; -- 오름차순[ASC]이 기본 디폴트, [DESC] 내림차순

-- 별칭을 기준으로 ORDER BY 가능
SELECT  EMP_NAME AS 이름,
        HIRE_DATE AS 입사일,
        DEPT_ID AS 부서코드
FROM    EMPLOYEE
ORDER BY    부서코드 DESC, 입사일, 이름;  .

-- 인덱스 사용 가능
SELECT  EMP_NAME AS 이름, --인덱스 1
        HIRE_DATE AS 입사일,--인덱스 2
        DEPT_ID AS 부서코드 --인덱스 3
FROM    EMPLOYEE
ORDER BY    3 DESC, 2, 1; -- ORDER BY 인덱스


-- GROUP BY: 하위 데이터 그룹
SELECT  DEPARTMENT_NO 학과번호,
        COUNT(*) "학생수(명)"
FROM    TB_STUDENT
GROUP BY    DEPARTMENT_NO
ORDER BY    1 ASC;

-- 부서별 평균 급여를 조회한다면?
SELECT  DEPT_ID 부서,
        FLOOR(AVG(SALARY)) 평균급여
FROM    EMPLOYEE
GROUP BY    DEPT_ID

-- 성별에 따른 평균 급여 조회
SELECT  CASE WHEN SUBSTR(EMP_NO,8,1) IN ('1','3') THEN 'MALE' ELSE 'FEMALE' END AS 성별,
        FLOOR(AVG(SALARY)) 평균급여
FROM    EMPLOYEE
GROUP BY    SUBSTR(EMP_NO,8,1);--CASE WHEN SUBSTR(EMP_NO,8,1) IN ('1','3') THEN 'MALE' ELSE 'FEMALE' END 표현식이 들어가는 게 더 정확

SELECT  DEPT_ID,
        EMP_NAME,
        COUNT(*)
FROM    EMPLOYEE
GROUP BY    DEPT_ID, EMP_NAME;

SELECT  DEPT_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY    DEPT_ID
HAVING  SUM(SALARY) > 9000000; -- GROUP 에 대한 조건은 HAVING, WHERE은 테이블에 대한 조건

--ROLLUP()
SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY    ROLLUP(DEPT_ID, JOB_ID); -- 소계와 누적 총계출력
-- ROLLUP( (DEPT_ID, JOB_ID) ) 괄호를 이중으로 씌우면 소계X,누적 총계만 출력

SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY    DEPT_ID, ROLLUP(JOB_ID); -- 소계O, 누적 총계X

-- ERD
-- EMPLOYEE, DEPARTMENT
-- PK는 중복을 허용하지 않고, NULL값을 허용하지 않음.
-- FK는 부모에 의존하는 데이터이거나 ,NULL 값 허용.
SELECT  *
FROM    DEPARTMENT;

SELECT  *
FROM    EMPLOYEE;

-- 사원의 이름, 부서이름 조회
-- 즉, 두개의 컬럼을 한번에 볼 수 있는 방법
-- JOIN
-- EQUALS JOIN 업무적 연관성이 있고, 부모의 
SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID
FROM    EMPLOYEE E,DEPARTMENT D -- 테이블에서도 별칭가능 AS 는 쓰지 않고.
WHERE   E.DEPT_ID = D.DEPT_ID; -- JOIN을 할 때 모호성이 발생할 수 있기 때문에 테이블에 별칭을 줌

-- ANSI JOIN 표준 조인
/*
SELECT
FROM    TABLE1
[INNER] JOIN    TABLE2 ON (CONDITION) -- 필요에 따라서 ON 부모의 외래키와 자식의 기본키가 같으면. 관계가 없는 두 테이블에서의 NOT EQUALS JOIN은 ON으로 사용.
[INNER] JOIN    TABLE2 USING (COLUMN) -- 필요에 따라서 USING,두 개의 테이블이 내부 조인으로 조인 될 때 조인하고자 하는 두 테이블의 컬럼명이 같을 경우 조인 조건을 길게 적지 않고 간단하게 적을 수 있도록 하는 역할
-- OUTER JOIN: 조건에 만족하지 않는 데이터까지 포함시키는 조인.
LEFT | RIGHT | FULL [OUTER] JOIN    TABLE2 ON (CONDITION)
LEFT | RIGHT | FULL [OUTER] JOIN    TABLE2 USING (COLUMN)
*/

SELECT  EMP_NAME,
        DEPT_NAME,
        DEPT_ID,
        JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D USING(DEPT_ID) --USING을 쓸 때 SELECT 절에 별칭을 쓰지못함
JOIN    JOB        J  USING(JOB_ID)
JOIN    LOCATION   L  ON (L.LOCATION_ID = D.LOC_ID); -- LOCATION TABLE에 기본키가 DEPARTMNET에 외래키 LOC_ID와 동일하지 않기에 USING 불가,ON 사용


SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID,
        J.JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D ON(D.DEPT_ID = E.DEPT_ID)
JOIN    JOB        J ON(E.JOB_ID = J.JOB_ID)
JOIN    LOCATION   L  ON (L.LOCATION_ID = D.LOC_ID);
-- 위에 까지가 ANSI 표준 JOIN

-- 연결고리가 없는 두 테이블 간의 조인
SELECT  *
FROM    SAL_GRADE

SELECT  EMP_NAME,
        SALARY,
        SLEVEL
FROM    EMPLOYEE 
JOIN    SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST)
ORDER BY    SLEVEL, SALARY DESC;

--OUTER JOIN 오라클
SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E, DEPARTMENT D
WHERE   E.DEPT_ID(+) = D.DEPT_ID -- 오라클 전용: 좌측은 LEFT OUTER JOIN (+) 표시가 있음, RIGHT OUTER JOIN은 오른쪽에 (+), FULL OUTER JOIN은 오라클에서 지원 안함.

--따라서 ANSI 표준으로 LEFT RIGHT FULL OUTER JOIN 
SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
FULL JOIN  DEPARTMENT D USING(DEPT_ID);

-- 사원의 이름과 사수의 이름을 셀프조인으로 조회한다면?, 사수의 사수는?
SELECT  E.EMP_NAME,
        M.EMP_NAME,
        S.EMP_NAME
FROM    EMPLOYEE E
JOIN    EMPLOYEE M ON (E.MGR_ID = M.EMP_ID)
JOIN    EMPLOYEE S ON (E.MGR_ID = S.EMP_ID)

-- LOC_DESCIRBE가 아시아로 시작하고 직급이 대리인 사원의 이름, 부서이름을 조회
SELECT  LOC_DESCRIBE
FROM    LOCATION

SELECT  EMP_NAME,
        DEPT_NAME
FROM    JOB
JOIN    EMPLOYEE    USING(JOB_ID)
JOIN    DEPARTMENT  USING(DEPT_ID)
JOIN    LOCATION    ON(LOC_ID = LOCATION_ID)
WHERE   LOC_DESCRIBE LIKE '아시아%' AND JOB_TITLE = '대리';

-- SET 연산자
/*
두 개 이상의 쿼리 결과를 하나로 결합시키는 연산자
- UNION: 합집합, 중복 제거
- UNION ALL : 합집합 중복 포함
- INTERSECT : 교집합
- MINUS : 차집합
주의) 반드시 동일(컬럼 개수, 데이터 타입)
*/

SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE;
UNION ALL
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY;

--UNION
SELECT  TO_CHAR(SALARY),
        JOB_ID,
        HIRE_DATE
FROM    EMPLOYEE
UNION
SELECT  DEPT_NAME,
        DEPT_ID,
        NULL
FROM    DEPARTMENT
WHERE   DEPT_ID = 20;

--UNION 부서번호가 50번 부서의 부서원을 관리자와 직원으로 구분하여 사원번호,이름,구분을 표시
-- 관리자와 직원을 구분하는 기준은 EMP_ID = '141'이면 관리자

SELECT  EMP_ID,
        EMP_NAME,
        '관리자' AS 구분
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' AND EMP_ID = '141'
UNION
SELECT  EMP_ID,
        EMP_NAME,
        '직원' AS 구분
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' AND EMP_ID != '141'
ORDER BY 3;


SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE IN ('대리' , '사원');


-- 위 구문을 UNION으로 표현
SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
UNION
SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '사원'
ORDER BY 2, 1;