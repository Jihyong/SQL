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
--day04
-- SUBQUERY, DDL(CONSTRAINT 제약)

-- SUBQUERY 서브쿼리(하나의 쿼리가 다른 쿼리를 포함하는 구조)
/*
SELECT  EXPR(SELECT) -- SCALLAR SUBQUERY
FORM    (SELECT) -- INLINE VIEW
WHERE   (SELECT) -- SUBQUERY, 즉 EXPR OPERATOR (SUBQUERY)
GROUP BY (SELECT)
HAVING  (SELECT)
즉,메인 쿼리 안에 서브쿼리 들어갈 수 있음.

유형
- 단일 행 서브쿼리 (리턴 되는 레코드 건수가 1개), (단일 컬림, 다중컬럼)
- 다중 행 서브쿼리 (단일 컬럼, 다중 컬럼)-( IN, ANY, ALL)연산자를 사용.
*/
-- '나승원' 직원과 같은 부서원을 조회
SELECT  *
FROM    EMPLOYEE
WHERE   EMP_NAME = '나승원' --여기서 DEPT_ID가 50이라는 것을 확인


SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = (SELECT  DEPT_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '나성원');

-- '나승원' 직원과 같은 직급이면서 급여가 '나승원' 보다 많이 받는 직원을 조회한다면?
SELECT  *
FROM    EMPLOYEE
WHERE   JOB_ID = (SELECT    JOB_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '나승원')
AND      SALARY > (SELECT    SALARY
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '나승원')

-- 최저급여를 받는 사원의 정보를 검색
SELECT  *
FROM    EMPLOYEE
WHERE   SALARY = (SELECT    MIN(SALARY)
                    FROM    EMPLOYEE);
                    
-- 부서별 급여총합이 가장 높은 부서의 부서이름, 급여 총합을 조회
SELECT  DEPT_NAME,
        SUM(SALARY)
FROM    EMPLOYEE
JOIN    DEPARTMENT USING(DEPT_ID)
GROUP BY DEPT_NAME
HAVING  SUM(SALARY) = (SELECT   MAX(SUM(SALARY))
                        FROM    EMPLOYEE
                        GROUP BY DEPT_ID);

/*
다중 행 서브쿼리
> ANY, < ANY
> ALL, < ALL
*/
-- 관리자들만 조회(즉 MGR_ID에 EMP_ID가 있다면 관리자)

SELECT  EMP_ID,
        EMP_NAME,
        '관리자' AS "관리자 유무"
FROM    EMPLOYEE
WHERE   EMP_ID IN (SELECT   MGR_ID  -- 서브쿼리가 다중 행 이므로 WHERE절에 IN( 다중행 연산자를 씀)
                    FROM    EMPLOYEE)
UNION     
SELECT  EMP_ID,
        EMP_NAME,
        '직원' AS "관리자 유무"
FROM    EMPLOYEE
WHERE   EMP_ID NOT IN (SELECT   MGR_ID  -- 서브쿼리가 NULL 값이 있으면 NOT IN 을 쓰면 NULL이 리턴됨
                        FROM    EMPLOYEE
                        WHERE   MGR_ID IS NOT NULL) --따라서 IS NOT NULL 로 NULL 제거 후 NOT IN 사용
ORDER BY 3;

-- 대리직급의 사원의 이름, 급여 조회
-- 과장 직급의 사원의 이름, 급여 조회
SELECT  EMP_NAME,JOB_TITLE,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
UNION
SELECT  EMP_NAME,JOB_TITLE,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '과장'
ORDER BY 2;

-- 과장직급보다 많은 급여를 받는 대리직의 사원이름, 급여를 조회
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
AND  SALARY > ANY (SELECT    SALARY -- < ANY, <ALL > ALL 구분하기, 여기선 >ANY니까 과장급 급여의 최소한도 보다 큰 대리 사원들 출력
                        FROM    EMPLOYEE
                        JOIN    JOB USING(JOB_ID)
                        WHERE   JOB_TITLE = '과장')
-- 직급별(JOB_TLTLE) 평균 급여를 조회, 정수 5자리에서 절삭
SELECT  JOB_TITLE, -- 2. 이 부분은 바로 못쓰기에 GROUP BY를 사용
        TRUNC(AVG(SALARY),-5) -- 1.여기 때문에
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
GROUP BY    JOB_TITLE;

-- 자기 직급의 평균 급여를 받는 직원의 이름, 직급, 급여 조회(다중행 다중 열 서브쿼리)
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   (JOB_TITLE, SALARY) IN (SELECT   JOB_TITLE, TRUNC(AVG(SALARY),-5) --다중 행 다중 열 서브쿼리
                                FROM    EMPLOYEE
                                JOIN    JOB USING(JOB_ID)
                                GROUP BY    JOB_TITLE);
                    
-- 위에 문제를 FROM의 서브쿼리로 풀기                   
SELECT  E.EMP_NAME,
        JOB_TITLE,
        V.JOBAVG
FROM    (SELECT JOB_ID,
                TRUNC(AVG(SALARY),-5) AS JOBAVG
            FROM EMPLOYEE
            JOIN JOB USING(JOB_ID)
            GROUP BY JOB_ID) V
JOIN    EMPLOYEE E ON (JOBAVG = SALARY AND E.JOB_ID = V.JOB_ID)
JOIN    JOB J ON(J.JOB_ID = E.JOB_ID);
                    
                    
-- 상관관계 서브쿼리
-- 메인쿼리에서 처리되는 각 행의 값에 따라서 서브쿼리의 결과값이 달라지는 경우
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E
JOIN    JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE   SALARY = (SELECT    TRUNC(AVG(SALARY),-5)
                    FROM    EMPLOYEE
                    WHERE   JOB_ID = E.JOB_ID); --메인쿼리의 JOB_ID가 서브쿼리로 들어가는 것.
                
--DAY05
-- DDL(DATA DEFINITION LANGUAGE)
/*
TABLE(물리적인 메모리 공간)
VIEW(논리적인 메모리 공간)
SEQUENCE
INDEX

-- CONSTRAINT( PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, CHECK)
--  UNIQUE 와 NOT NULL을 결합하면 PRIMARY KEY가 됨.
-- 데이터의 무결성, 데이터의 중복을 피할 수 있다.

테이블을 만드는[기본구문]
CREATE TABLE TABLE_NAME(
    COLUMN_NAME DATATYPE [DEFAULT EXPR] [COLUMN_CONSTARINT],
    [TABLE_CONSTRAINT]
)
-- INSERT
INSERT INTO TABLE_NAME(COLUMN) VALUES(?,?,?,?)
*/
-- DROP TABLE TABLE_NAME: 테이블 삭제
CREATE TABLE TEST01(
    ID  NUMBER(5),
    NAME    VARCHAR2(50),
    ADDRESS VARCHAR2(50),
    REGDATE DATE DEFAULT SYSDATE
);

INSERT INTO TEST01(ID,NAME,ADDRESS)
VALUES(100,'이지형','서울');

INSERT INTO TEST01(ID,NAME,ADDRESS)
VALUES(100,'이지형','서울', NULL);

INSERT INTO TEST01(ID,NAME,ADDRESS)
VALUES(100,'이지형','서울',DEFAULT);

SELECT  *
FROM    TEST01;

DROP TABLE TEST01;

--NOT NULL : 컬럼에 대한 제약은 가능하나 테이블에 대한 제약은 불가.
-- DROP TABLE TEST_NN;
CREATE TABLE TEST_NN(
    ID      VARCHAR2(50) UNIQUE,
    PWD     VARCHAR2(50)
);
INSERT INTO TEST_NN VALUES('JSLIM','JSLIM');
INSERT INTO TEST_NN VALUES(NULL,'JSLIM');
DROP TABLE TEST_NN;

SELECT  *
FROM    TEST_NN

-- PRIMARY KEY: 테이블 당 1개만 가능
-- NOT NULL + UNIQUE
--DROP TABLE TEST_PK
CREATE TABLE TEST_PK(
    ID  VARCHAR2(50),
    NAME    VARCHAR2(50),
    PRIMARY KEY(ID, NAME) -- TABLE LEVEL의 제약 여기서 ID와 NAME 두 개를 PK
);
INSERT INTO TEST_PK
VALUES('JSLIM','임섭순');
INSERT INTO TEST_PK
VALUES('JSLIM','JSLIM');
SELECT  *
FROM    TEST_PK

--FOREIGN KEY(테이블에 대한 외래키 제약) , REFFERENCES(컬럼 레벨에 대한 외래키 제약)
-- 부모에 의존하는 데이터이거나 NULL을 허용한다.
-- 테이블은 만드는 순서도 중요! 부모 테이블 먼저 생성

-- DML(DELETE ~~~~)
-- REFERENCES [ON DELETE SET NULL]:이런 옵션을 주면 부모테이블을 삭제 참조하고 있는 자식 레코드는 NULL로 만듦
-- REFERENCES [ON DELETE CASCADE]:부모 테이블 및 참조하는 자식 레코드들 삭제, 참조하고 있는 레코드는 전부다 삭제

CREATE TABLE LOC(
    LOCATION_ID     VARCHAR2(50) PRIMARY KEY,
    LOC_DESCRIBE    VARCHAR2(50)
);
INSERT INTO LOC VALUES(10, '아시아');
INSERT INTO LOC VALUES(20, '유럽');
SELECT  *
FROM    LOC;
--DROP TABLE DEPT;
CREATE TABLE DEPT(
    DEPT_ID NUMBER(5)   PRIMARY KEY,
    DEPI_NAME   VARCHAR2(50),
    LOC_ID      VARCHAR2(50) NOT NULL, -- NOT NULL을 넣어주어 LOC_ID는 외래키이면서 NULL을 허용하지 않게 만듦.
    FOREIGN KEY(LOC_ID) REFERENCES LOC(LOCATION_ID)
);
INSERT INTO DEPT VALUES(10, '인사팀',10);
INSERT INTO DEPT VALUES(20, '교육팀',20);
INSERT INTO DEPT VALUES(30, '회계팀',20);
SELECT  *
FROM    DEPT;

SELECT  DEPT_NAME,
        LOC_DESC
FROM    DEPT
JOIN    LOC ON(
--DROP TABLE EMP; 부모와 자식간 연결이 되어있으면 DROP은 자식부터 먼저 해야함.
CREATE TABLE EMP(
    EMP_ID  VARCHAR2(50) PRIMARY KEY,
    EMP_NAME    VARCHAR2(50),
    DEPT_ID     NUMBER(5) REFERENCES DEPT(DEPT_ID)
);
INSERT INTO EMP VALUES('100','JSLIM',10);
INSERT INTO EMP VALUES('200','JSLIM',NULL);
SELECT  *
FROM    EMP;

-- COMPOSITE PRIMARY KEY일 경우
-- DROP TABLE SUPER_PK CASCADE CONSTRAINTS;
CREATE TABLE SUPER_PK(
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    O_DATE  DATE,
    AMOUNT  NUMBER, -- NUMBER()는 사이즈를 안 줘도 됨.
    PRIMARY KEY(U_ID,P_ID)
);
INSERT INTO SUPER_PK VALUES('JSLIM','P100',SYSDATE,10000);

CREATE TABLE SUB_FK(
    SUB_ID  VARCHAR2(20) PRIMARY KEY,
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    FOREIGN KEY(U_ID,P_ID) REFERENCES SUPER_PK(U_ID,P_ID) ON DELETE CASCADE);
    
-- SUB_ID,U_ID,P_ID 셋을 (두개는 외래키이자) 기본키로.
CREATE TABLE SUB_FK(
    SUB_ID  VARCHAR2(20),
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    FOREIGN KEY(U_ID,P_ID) REFERENCES SUPER_PK(U_ID,P_ID) ON DELETE CASCADE,
    PRIMARY KEY(SUB_ID,U_ID,P_ID)
);
    
INSERT INTO SUB_FK VALUES('SUB100','JSLIM','P100');
SELECT  *
FROM    SUB_FK;
DROP TABLE SUB_FK;

-- CHECK
-- 조건을 정의할 때 변하는 값을 조건으로 사용할 수 없다.
-- DROP TABLE TEST_CK;
CREATE TABLE TEST_CK(
    ID  VARCHAR2(50) PRIMARY KEY,
    SALARY  NUMBER,
    --HIRE_DATE DATE CHECK(HIRE_DATE < SYSDATE), SYSDATE는 변하는 변수이기 때문에 CHECK 불가.
    MARRIAGE CHAR(1), -- 혹은컬럼에 CHECK(MARIAGE IN('Y','N'))
    CHECK(SALARY BETWEEN 0 AND 100), 
    CHECK(MARRIAGE IN ('Y','N')) 
);
INSERT INTO TEST_CK VALUES('100',100, 'Y');
SELECT  *
FROM    TEST_CK;

-- DROP
-- DROP TABLE TABLE_NAME [CASCADE CONSTRAINTS] : 관계가 있는 부모 테이블 먼저 삭제 가능.


-- VIEW : 논리적인 구조만 갖고 있고 데이터는 담고 있지 않음. 
-- 테이블의 부분집합으로 보안 측면이나 복잡한 쿼리를 단순화하기 위해 사용. 읽기 전용으로 생각.
-- 단일 뷰(INSERT,UPDATE,DELETE)가능 (원본 테이블에 영향 미침) , 복합 뷰(I,U,D) 불가
-- DROP VIEW VIEW_NAME 
/*
[기본구문]
CREATE [OR REPLACE] VIEW VIEW_NAME(ALIAS)
AS SUBQUERY;
*/
-- 부서번호가 90번인 사원의 이름, 부서번호만 접근할 수 있는 VIEW를 생성한다면?
CREATE OR REPLACE VIEW V_EMP_90(A,B) -- 여기서도 별칭(ALIAS)을 만들 수 있다 A,B
AS  SELECT  EMP_NAME,
            DEPT_ID
    FROM    EMPLOYEE
    WHERE   DEPT_ID = '90';

SELECT  *
FROM    V_EMP_90

-- 인라인 뷰를 활용한 TOP N 분석 가능하다. : 조건에 맞는 상위 몇 개
-- 조건에 맞는 최상위 또는 최하위 레코드 N개를 식별할 때 사용
/*
분석 원리
- 정렬
- ROWNUM 이라는 가상의 컬럼을 이용해서 정렬 순서대로 순번 부여
- 부여된 순번을 이용해서 필요한 수 만큼 식별
*/
--부서별 급여 평균
SELECT  ROWNUM,
        EMP_NAME
FROM    EMPLOYEE;

-- 부서별 평균 급여보다 많이 받는 사람들
SELECT  ROWNUM,
        EMP_NAME,
        SALARY
FROM    (SELECT  
                DEPT_ID,
                ROUND(AVG(SALARY),-3) AS DAVG
        FROM    EMPLOYEE
        GROUP BY    DEPT_ID) V
JOIN    EMPLOYEE E ON(E.DEPT_ID = V.DEPT_ID)
WHERE     SALARY > V.DAVG AND ROWNUM <= 5;
-- ORDER BY 3 DESC; 이렇게 소팅하면 ROWNUM이 흐트러짐

-- TOP N 분석, 정렬이 되어있는 레코드에 ROWNUM 또는 RANK를 사용하는 것이 TOP N 분석.
-- ROWNUM은 정렬 되어있는 레코드에 '=' 등호를 쓰면 최상위 한 건만 출력.
SELECT  ROWNUM, EMP_NAME, SALARY
FROM (   
            SELECT  EMP_NAME,
                    SALARY      
            FROM    (SELECT  
                            DEPT_ID,
                            ROUND(AVG(SALARY),-3) AS DAVG
                    FROM    EMPLOYEE
                    GROUP BY    DEPT_ID) V
            JOIN    EMPLOYEE E ON(E.DEPT_ID = V.DEPT_ID)
            WHERE     SALARY > V.DAVG
            ORDER BY 2 DESC)
WHERE ROWNUM = 1;

-- RANK()를 이용한 TOP N 분석
SELECT  *
FROM    (SELECT  EMP_NAME,
                    SALARY,
                     RANK() OVER(ORDER BY SALARY DESC) AS RANK
            FROM    EMPLOYEE)
WHERE   RANK = 5;


-- SEQUENCE
-- 순차적으로 정수 값을 자동으로 생성하는 객체
/* CREATE SEQUENCE SEQUENCE_NAME;
START WITH 10
INCREMENT BY 10
MAXVALUE 100

*/
-- NEXTVAL, CURRVAL
CREATE SEQUENCE TEST_SEQ;
SELECT TEST_SEQ.NEXTVAL FROM DUAL; -- 다음 값을 리턴.
SELECT TEST_SEQ.CURRVAL FROM DUAL; -- 마지막 값을 리턴.
DROP SEQUENCE TEST_SEQ;



CREATE TABLE CUSTOMERS(
    CNO     NUMBER(5) PRIMARY KEY,
    CNAME   VARCHAR2(10) NOT NULL,
    ADDRESS VARCHAR2(50) NOT NULL,
    EAIL    VARCHAR2(20) NOT NULL,
    PHONE   VARCHAR2(20) NOT NULL
);
SELECT  *
FROM    CUSTOMERS

CREATE TABLE ORDERS(
    ORDERNO     NUMBER(10) PRIMARY KEY,
    ORDERDATE   DATE DEFAULT SYSDATE       NOT NULL,
    ADDRESS     VARCHAR2(50) NOT NULL,
    PHONE       VARCHAR2(20) NOT NULL,
    STATUS      VARCHAR2(20) NOT NULL,
    CNO NUMBER(5)   NOT NULL,
    FOREIGN KEY(CNO) REFERENCES CUSTOMERS(CNO)
);

CREATE TABLE PRODUCTS(
    PNO     NUMBER(5)   PRIMARY KEY,
    PNAME   VARCHAR2(20) NOT NULL,
    COST    NUMBER(8)   DEFAULT 0   NOT NULL,
    STOCK   NUMBER(5)   DEFAULT 0   NOT NULL
)

CREATE TABLE ORDERDETAIL(
    ORDERNO NUMBER(10),
    PNO     NUMBER(5) ,
    QTY     NUMBER(5),
    COST    NUMBER(8),
    FOREIGN KEY(ORDERNO) REFERENCES ORDERS(ORDERNO),
    FOREIGN KEY(PNO) REFERENCES PRODUCTS(PNO),
    PRIMARY KEY(ORDERNO,PNO)
);
/*
ALTER TABLE TABLE명 ADD 컬럼명 데이터타입 : 컬럼 추가
ALTER TABLE TABLE명 DROP COLUMN 컬럼명 : 컬럼 삭제
ALTER TABLE ORTL RENAME TO ORDERDETAIL : 테이블 명 바꾸기
*/

--DAY05
-- DML(SELECT, INSERT, UPDATE, DELETE)
-- TRANSACTION( COMMIT, ROLLBACK)
/*
무결성 제약
            부모      자식
UPDATE       X         O
INSERT       O         O
DELETE       X         O
*/
-- 데이터 갱신 구문
/*
UPDATE  TABLE_NAME
SET     COLUMN_NMAE = VALUE | SUBQUERY, [COLUMN_NAME = VALUE] -- SET 절 까지만 쓰면 특정 컬럼에 전체 행에 대한 변경
[WHERE   CONDITION] -- 이건 옵션이지만 WHERE절을 넣으면 특정 컬럼에 대한 값 변경
*/
SELECT  *
FROM    EMPLOYEE;

UPDATE  EMPLOYEE
SET     JOB_ID = (SELECT    JOB_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '성해교'),
        DEPT_ID = '90'
WHERE   EMP_NAME = '심하균'

UPDATE  EMPLOYEE
SET     MARRIAGE = DEFAULT
WHERE   EMP_ID = '100';

-- INSERT
/*
INSERT INTO TABLE_NAME(COLUMN_NAME)
VALUES (VALUE1,VALUE2)
INSERT INTO TABLE_NAME(COLUMN_NAME)
SUBQUERY
- 데이터 타입 일치
- 순서 일치
- 개수 일치
*/
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO)
VALUES('900', '임정섭', '123456-1234567');

-- DELETE: 테이블에 포함된 기존 데이터를 삭제, 즉 레코드 삭제, ROLLBACK 가능
/*
DELETE FROM TABLE_NAME : 여기까지만 하면 테이블 구조는 남기고 전체 데이터를 삭제
[WHERE CONDITION];

TRUNCATE TABLE TABLE_NAME : ROLLBACK불가능 무조건 COMMIT됨 따라서 데이터 복구가 안됨.
*/
SELECT  *
FROM    DEPARTMENT;

-- ERROR 무결성 제약 위배, EMPLOYEE테이블이 DEPARTMENT의 LOC_ID를 외래키로 참조.
DELETE 
FROM  DEPARTMENT
WHERE LOC_ID LIKE 'A%';

DELETE
FROM    JOB
WHERE   JOB_ID = 'J2';

DELETE
FROM    EMPLOYEE
WHERE   EMP_ID = '141'; --EMPLOYEE는 재귀(MGR_ID가 EMP_ID 참조 중)

-- TRANSACTION
-- 데이터의 일관성을 유지하기위해서 사용하는 논리적으로 연관된 작업들의 집합
-- 하나이상의 연관된 DML 작업
>INSERT~~
>UPDATE~~
>COMMIT/ROLLBACK :테이블에 직접 반영 / 원상 복귀

>UPDATE
>DELETE
>CREATE - AUTO COMMIT 발생(DDL 명령어를 입력하면), 테이블에 적용 됨.

-- 동시성 제어


--ALTER
/*
-테이블 수정, 새컬럼 추가, 기존 컬럼 삭제, 기존 컬럼의 데이터형이나 속성 변경가능
-테이블 수정 = 테이블의 컬럼 수정
-각종 제약 조건 추가 시에도 활용 가능
*/
--CASE 1. 컬럼 속성 변경
ALTER TABLE TABLE_NAME
MODIFY 컬럼명 데이터타입; --예)MODIFY EMP_NAME VARCHAR2(20)
--CASE 2. 컬럼에 제약 조건 추가
ALTER TABLE TABLE_NAME
ADD CONSTRAINTS 제약조건명 PRIMARY KEY(컬럼명);
--2개 이상의 컬럼을 기본 키로 설정(컬럼명1,컬럼명2)
ALTER TABLE TABLE_NAME
DROP CONSTRAINTS 제약조건명 -- 제약 조건을 삭제
--CASE 3. 새로운 컬럼 추가
ALTER TABLE TABLE_NAME
ADD 컬럼명 데이터타입; NOT NULL 명시 가능
--CASE 4. 컬럼 삭제
ALTER TABLE TABLE_NAME
DROP COLUMN 컬럼명

ALTER TABLE item_content
    ADD COLUMN badge INTEGER,
    ADD COLUMN age INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN duration INTEGER AFTER description;
--컬럼 이름 바꾸기
ALTER TABLE contacts
    CHANGE COLUMN old_name new_name
    varchar(20) NOT NULL;
-- 테이블 이름 바꾸기
ALTER TABLE contacts
  RENAME TO people;
