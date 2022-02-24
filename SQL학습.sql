--�н���ǥ(�Լ�)
/*
����
-���� �� �Լ�(Single row function)
-�׷� �Լ�(Group function)

�÷�Ÿ��(���� - number, ����- char, varchar2,  ��¥ - date)
- ���� �Լ�
- ���� �Լ�
- ��¥ �Լ�
- ��Ÿ �Լ�
*/

-- �����Լ�
-- LENGTH
SELECT  *
FROM    COLUMN_LENGTH;
-- CHAR �ѱ��� ��� LENGTH
-- �ѱ� 3BYTE, 6(����)*3(BYTE) = 18, 20(�ִ� BYTE)- 18 =2 , 2+6(����)=8 BYTE
-- ���� CHARACTER TYPE�� �ѱ��� ���� �ʴ�.
SELECT  LENGTH(CHARTYPE),
        LENGTH(VARCHARTYPE)
FROM    COLUMN_LENGTH;

-- INSTR(): ã�� ������ �ε����� �����ϴ� �Լ�
-- INSTR(STRING, SUBSTRING, [POSITION, OCCURRANCE]): NUMBER , [ ]�� �ִ� ���� �ɼų� ����.
--                        ���ڿ��� ��Ī ����, �ݺ� Ƚ��(��, ���� ó�� ã������ �ϴ� ���ڿ��� ������ Ƚ�� ����)
SELECT  *
FROM    EMPLOYEE;

-- '@VCC.COM' ���ڿ� �� .���� ���� 'C'�� �ε����� ���ϰ��� �Ѵٸ�? ����Ŭ�� �ε����� 1���� ������.���̽�� �ٸ�
SELECT  EMAIL,
        INSTR(EMAIL, 'c', -1, 2) -- 3�� ° ���ڴ� �ε����� -1�� �Ųٷ� ���ٴ� ��, OCCURRANCE: 2�� �� �� �ݺ�(��,com���� c�� ã�� �� ���� . �ڿ� �ִ� cã���ϱ� �� ��.)
FROM    EMPLOYEE;

-- LPAD | RPAD
-- LPAD(STRING, N, [STR])
SELECT  EMAIL,
        LENGTH(EMAIL),
        LPAD(EMAIL, 20,'*'),
        RPAD(EMAIL, 20,'*')
FROM    EMPLOYEE;

-- TRIM, LTRIN, RTRIM
-- ���ڸ� ������ ��
-- LTRIM(STRING, [STR]): 1�� ���ڿ��� 2 �� ������ ���ڸ� ����
-- RTRIM(STRING, [STR]) : �� ��° ���ڸ� �������� ������ TRIM �Լ��� �⺻������ ������ ����
-- TRIM(LEADING | TRAILING | BOTH STR FROM STRING), TRIM �ϳ��� L,RTRIM�� ǥ�� �� �� �ִ�.
--       ����         ������     ����
SELECT  LENGTH('    TECH    '),
        LTRIM('    TECH    '),
        LENGTH(LTRIM('    TECH    ')),-- �Լ��� �Լ��� ���� �� ����
        RTRIM('    TECH    '),
        LENGTH(RTRIM('    TECH    '))
FROM    DUAL;  -- DUAL �� ���� ���̺�

SELECT  TRIM(LEADING 'A' FROM 'AATECHAA'),
        TRIM(TRAILING 'A' FROM 'AATECHAA'),
        TRIM(BOTH 'A' FROM 'AATECHAA')
FROM    DUAL;

-- �߿�
-- SUBSTR(STRING, POSITION, [LENGTH]): [LENGTH]��ŭ POSITION ������� ���ڸ� ������,
--               POSITION�� 8�� �ϸ� �¿��� �� ���� ���� 8�� �ε������� ����.
SELECT  EMP_NO,
        SUBSTR(EMP_NO, 1, 6),
        SUBSTR(EMP_NO, 8, 1)
FROM    EMPLOYEE;

-- ������̺��� ������ ������ ����� ��� ������ ��ȸ�Ѵٸ�?
SELECT  *
FROM    EMPLOYEE
WHERE   SUBSTR(EMP_NO, 8, 1) = '1';

-- �����Լ�
-- ROUND(NUMBER,[DECIMAL_PLACE]), TRUNC(NUMBER,[DECIMAL_PLACE])
SELECT  ROUND(123.315,2),
        ROUND(123.315),
        ROUND(123.315,-1), -- DECIMAL_PLACE�� �����̸� ���� �κ�
        TRUNC(125.315,-1) -- �ش� �ڸ������� ����
FROM    DUAL;


-- ��¥ �Լ�
-- SYSDATE: ���� ��¥ ���, ADD_MONTHS(DATE,N): DATE�� N ��ŭ�� �������� �߰��� 
-- MONTHS_BETWEEN(���� ��¥, ���� ��¥) : ���س�¥�� ���� ��¥ ������ ���� ���� ���� ���ϵ�.
SELECT  SYSDATE + 1
FROM    DUAL;

-- �ټӳ���� 20�� �̻��� ����� ��� ������ ��ȸ�Ѵٸ�?
SELECT  HIRE_DATE,
        ADD_MONTHS(HIRE_DATE, 240)
FROM    EMPLOYEE;

SELECT  *
FROM    EMPLOYEE
WHERE   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

-- �ټӳ�� ���
SELECT  EMP_NAME,
        HIRE_DATE,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) AS �ټӳ��
FROM    EMPLOYEE
WHERE   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

-- Ÿ�� ��ȯ �Լ�
/*
<-  TO_NUMBER()  TO_CHAR(DATE,ǥ������)
NUMBER - CHARCACTER - DATE
->  TO_CHAR()    TO_DATE()

��¥ -> ����
ǥ�� ����
- YYYY/YY/YEAR: ���ڸ� �⵵/ ���ڸ� �⵵/ ��������
- MONTH/MON/MM/RM
- HH/MI/SS : �ú���
*/

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = 90; -- ���⼭ ���������� TO_CHAR(90), DEPT_ID�� CHAR TYPE 90�� ����. ���� ������ ����ȯ.

-- ��¥�� ǥ������ ���ϴ� ���� ���� �������� ����ȯ �� ���ϴ� �������� ǥ�� ����
SELECT  TO_CHAR(SYSDATE,'YYYY-MM-DY'), --DY �� ����, DD�� ����.
        TO_CHAR(SYSDATE,'YYYY-MM-DD DAY'),
        TO_CHAR(SYSDATE,'MM-DD,YYYY'), -- ���ϴ� �������� ���� ����
        TO_CHAR(SYSDATE,'YYYY'),
        TO_CHAR(SYSDATE,'AM HH24:MI:SS'),
        TO_CHAR(SYSDATE,'YEAR, Q') -- Q�� ����
FROM    DUAL;

SELECT  HIRE_DATE,
        TO_CHAR(HIRE_DATE,'YYYY-MM-DD')
FROM    EMPLOYEE
WHERE   DEPT_ID = '90';


-- CHAR -> DATE, ���������� ��¥ �������� ���� ���� TO_DATE�� ���� ������ �������� �״�� �ؾ���.
--
SELECT  TO_DATE('20200215','YYYYMMDD'),
        TO_DATE('220215','YYMMDD'),
        TO_CHAR(TO_DATE('220215','YYMMDD'),'YYYY-MM-DD')
FROM    DUAL;

-- �⵵�� �������� �� YYYY(���� ���⸦ ��ȯ), RRRR(����,����,���� ���⸦ ��ȯ)
SELECT  HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM--DD')
FROM    EMPLOYEE
WHERE   EMP_NAME = '�Ѽ���';

-- �������� ��¥�� �����Ҷ� ���ڿ� 8�ڸ��� ������
SELECT  SYSDATE AS ����,
        '95/02/15' AS �Է�,
        TO_CHAR(TO_DATE('95/02/15','YY/MM/DD'),'YYYY'),
        TO_CHAR(TO_DATE('95/02/15','RR/MM/DD'),'YYYY')
FROM    DUAL;

-- ��Ÿ�Լ�
-- NULL �� ó�� �Լ�: NVL(����, ��) -> NVL�� ������ NULL���� ���� ������ ��ü��.
SELECT  EMP_NAME,
        BONUS_PCT,
        NVL(BONUS_PCT, 0)
FROM    EMPLOYEE
WHERE   SALARY > 3500000;

SELECT  EMP_NAME,
        SALARY,
        SALARY * 12 AS ANNUL_SALARY,
        (SALARY +(SALARY * NVL(BONUS_PCT, 0))) * 12 AS "12��������"
FROM    EMPLOYEE ;

-- ����Ŭ ���� �Լ�
-- DECODE(EXPR, SEARCH, RESULT, [SEARCH, RESULT],[DEFALUT])
-- IF~ELSE �� ���� 
-- �μ���ȣ�� 50���� ������� �̸�, ������ ��ȸ�Ѵٸ�?
SELECT  EMP_NAME,
        DECODE(SUBSTR(EMP_NO,8,1),
                '1', '����',
                '3', '����',
                '����') AS GENDER
FROM    EMPLOYEE
WHERE   DEPT_ID = '50';

-- �μ��� �λ�޿��� Ȯ���ϰ��� �Ѵ�
-- 90�� �μ��� �޿��� 10% �λ��Ѵٸ�?
SELECT  SALARY,
        DEPT_ID,
        DECODE(DEPT_ID,
                '90', SALARY * 1.1,
                SALARY) AS �λ�޿�
FROM    EMPLOYEE;

--ANSI ǥ�� (���� ǥ��) CASE~~END<- *DECODE�� ����Ŭ ����*
-- CASE EXPR WHEN SEARCH THEN RESULT[ WHEN SEARCH THEN RESULT ] ELSE DEFAULT END
-- CASE WHEN CONDITION THEN RESULT[ WHEN SEARCH THEN RESULT ] ELSE DEFAULT END
SELECT  SALARY,
        DEPT_ID,
        CASE DEPT_ID WHEN '90' THEN SALARY * 1.1
                     ELSE SALARY
        END AS �λ�޿�
FROM    EMPLOYEE;

SELECT  SALARY,
        DEPT_ID,
        CASE WHEN DEPT_ID='90' THEN SALARY * 1.1
                     ELSE SALARY
        END AS �λ�޿�
FROM    EMPLOYEE;

-- �޿��� ���� �޿� ����� Ȯ���ҷ��� �Ѵ�.
-- 3000000 ���ϸ� �ʱ�, 4000000 ���ϸ� �߱�, �ʰ��� ������� �����ϰ� �ʹٸ�?
SELECT  EMP_NAME,
        SALARY,
        CASE WHEN SALARY<= 3000000 THEN '�ʱ�'
             WHEN SALARY<= 4000000 THEN '�߱�'
             ELSE '���'
        END AS �޿����
FROM    EMPLOYEE

-- �׷��Լ�(SUM, AVG) - INPUT���� NUMBER
-- MIN, MAX, COUNT�� ���ڵ��� �Ǽ��� ���) - ANY(NUMBER, CHARACTER, DATE)
-- INPUT N -> OUTPUT 1
SELECT  SUM(SALARY), -- SELECT���� SUM���� �׷��Լ��� ���Ǹ� �Ϲ� �Ӽ��� ���� ����.
        AVG(SALARY), -- AVG�� NULL�� ������
        MIN(SALARY),
        MAX(SALARY),
        COUNT(SALARY), -- ���� ��Ȳ������ COUNT(*)�� ����.
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
ORDER BY    SALARY DESC , EMP_NAME DESC; -- ��������[ASC]�� �⺻ ����Ʈ, [DESC] ��������

-- ��Ī�� �������� ORDER BY ����
SELECT  EMP_NAME AS �̸�,
        HIRE_DATE AS �Ի���,
        DEPT_ID AS �μ��ڵ�
FROM    EMPLOYEE
ORDER BY    �μ��ڵ� DESC, �Ի���, �̸�;  .

-- �ε��� ��� ����
SELECT  EMP_NAME AS �̸�, --�ε��� 1
        HIRE_DATE AS �Ի���,--�ε��� 2
        DEPT_ID AS �μ��ڵ� --�ε��� 3
FROM    EMPLOYEE
ORDER BY    3 DESC, 2, 1; -- ORDER BY �ε���


-- GROUP BY: ���� ������ �׷�
SELECT  DEPARTMENT_NO �а���ȣ,
        COUNT(*) "�л���(��)"
FROM    TB_STUDENT
GROUP BY    DEPARTMENT_NO
ORDER BY    1 ASC;

-- �μ��� ��� �޿��� ��ȸ�Ѵٸ�?
SELECT  DEPT_ID �μ�,
        FLOOR(AVG(SALARY)) ��ձ޿�
FROM    EMPLOYEE
GROUP BY    DEPT_ID

-- ������ ���� ��� �޿� ��ȸ
SELECT  CASE WHEN SUBSTR(EMP_NO,8,1) IN ('1','3') THEN 'MALE' ELSE 'FEMALE' END AS ����,
        FLOOR(AVG(SALARY)) ��ձ޿�
FROM    EMPLOYEE
GROUP BY    SUBSTR(EMP_NO,8,1);--CASE WHEN SUBSTR(EMP_NO,8,1) IN ('1','3') THEN 'MALE' ELSE 'FEMALE' END ǥ������ ���� �� �� ��Ȯ

SELECT  DEPT_ID,
        EMP_NAME,
        COUNT(*)
FROM    EMPLOYEE
GROUP BY    DEPT_ID, EMP_NAME;

SELECT  DEPT_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY    DEPT_ID
HAVING  SUM(SALARY) > 9000000; -- GROUP �� ���� ������ HAVING, WHERE�� ���̺� ���� ����

--ROLLUP()
SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY    ROLLUP(DEPT_ID, JOB_ID); -- �Ұ�� ���� �Ѱ����
-- ROLLUP( (DEPT_ID, JOB_ID) ) ��ȣ�� �������� ����� �Ұ�X,���� �Ѱ踸 ���

SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY    DEPT_ID, ROLLUP(JOB_ID); -- �Ұ�O, ���� �Ѱ�X

-- ERD
-- EMPLOYEE, DEPARTMENT
-- PK�� �ߺ��� ������� �ʰ�, NULL���� ������� ����.
-- FK�� �θ� �����ϴ� �������̰ų� ,NULL �� ���.
SELECT  *
FROM    DEPARTMENT;

SELECT  *
FROM    EMPLOYEE;

-- ����� �̸�, �μ��̸� ��ȸ
-- ��, �ΰ��� �÷��� �ѹ��� �� �� �ִ� ���
-- JOIN
-- EQUALS JOIN ������ �������� �ְ�, �θ��� 
SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID
FROM    EMPLOYEE E,DEPARTMENT D -- ���̺����� ��Ī���� AS �� ���� �ʰ�.
WHERE   E.DEPT_ID = D.DEPT_ID; -- JOIN�� �� �� ��ȣ���� �߻��� �� �ֱ� ������ ���̺� ��Ī�� ��

-- ANSI JOIN ǥ�� ����
/*
SELECT
FROM    TABLE1
[INNER] JOIN    TABLE2 ON (CONDITION) -- �ʿ信 ���� ON �θ��� �ܷ�Ű�� �ڽ��� �⺻Ű�� ������. ���谡 ���� �� ���̺����� NOT EQUALS JOIN�� ON���� ���.
[INNER] JOIN    TABLE2 USING (COLUMN) -- �ʿ信 ���� USING,�� ���� ���̺��� ���� �������� ���� �� �� �����ϰ��� �ϴ� �� ���̺��� �÷����� ���� ��� ���� ������ ��� ���� �ʰ� �����ϰ� ���� �� �ֵ��� �ϴ� ����
-- OUTER JOIN: ���ǿ� �������� �ʴ� �����ͱ��� ���Խ�Ű�� ����.
LEFT | RIGHT | FULL [OUTER] JOIN    TABLE2 ON (CONDITION)
LEFT | RIGHT | FULL [OUTER] JOIN    TABLE2 USING (COLUMN)
*/

SELECT  EMP_NAME,
        DEPT_NAME,
        DEPT_ID,
        JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D USING(DEPT_ID) --USING�� �� �� SELECT ���� ��Ī�� ��������
JOIN    JOB        J  USING(JOB_ID)
JOIN    LOCATION   L  ON (L.LOCATION_ID = D.LOC_ID); -- LOCATION TABLE�� �⺻Ű�� DEPARTMNET�� �ܷ�Ű LOC_ID�� �������� �ʱ⿡ USING �Ұ�,ON ���


SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID,
        J.JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D ON(D.DEPT_ID = E.DEPT_ID)
JOIN    JOB        J ON(E.JOB_ID = J.JOB_ID)
JOIN    LOCATION   L  ON (L.LOCATION_ID = D.LOC_ID);
-- ���� ������ ANSI ǥ�� JOIN

-- ������� ���� �� ���̺� ���� ����
SELECT  *
FROM    SAL_GRADE

SELECT  EMP_NAME,
        SALARY,
        SLEVEL
FROM    EMPLOYEE 
JOIN    SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST)
ORDER BY    SLEVEL, SALARY DESC;

--OUTER JOIN ����Ŭ
SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E, DEPARTMENT D
WHERE   E.DEPT_ID(+) = D.DEPT_ID -- ����Ŭ ����: ������ LEFT OUTER JOIN (+) ǥ�ð� ����, RIGHT OUTER JOIN�� �����ʿ� (+), FULL OUTER JOIN�� ����Ŭ���� ���� ����.

--���� ANSI ǥ������ LEFT RIGHT FULL OUTER JOIN 
SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
FULL JOIN  DEPARTMENT D USING(DEPT_ID);

-- ����� �̸��� ����� �̸��� ������������ ��ȸ�Ѵٸ�?, ����� �����?
SELECT  E.EMP_NAME,
        M.EMP_NAME,
        S.EMP_NAME
FROM    EMPLOYEE E
JOIN    EMPLOYEE M ON (E.MGR_ID = M.EMP_ID)
JOIN    EMPLOYEE S ON (E.MGR_ID = S.EMP_ID)

-- LOC_DESCIRBE�� �ƽþƷ� �����ϰ� ������ �븮�� ����� �̸�, �μ��̸��� ��ȸ
SELECT  LOC_DESCRIBE
FROM    LOCATION

SELECT  EMP_NAME,
        DEPT_NAME
FROM    JOB
JOIN    EMPLOYEE    USING(JOB_ID)
JOIN    DEPARTMENT  USING(DEPT_ID)
JOIN    LOCATION    ON(LOC_ID = LOCATION_ID)
WHERE   LOC_DESCRIBE LIKE '�ƽþ�%' AND JOB_TITLE = '�븮';

-- SET ������
/*
�� �� �̻��� ���� ����� �ϳ��� ���ս�Ű�� ������
- UNION: ������, �ߺ� ����
- UNION ALL : ������ �ߺ� ����
- INTERSECT : ������
- MINUS : ������
����) �ݵ�� ����(�÷� ����, ������ Ÿ��)
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

--UNION �μ���ȣ�� 50�� �μ��� �μ����� �����ڿ� �������� �����Ͽ� �����ȣ,�̸�,������ ǥ��
-- �����ڿ� ������ �����ϴ� ������ EMP_ID = '141'�̸� ������

SELECT  EMP_ID,
        EMP_NAME,
        '������' AS ����
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' AND EMP_ID = '141'
UNION
SELECT  EMP_ID,
        EMP_NAME,
        '����' AS ����
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' AND EMP_ID != '141'
ORDER BY 3;


SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE IN ('�븮' , '���');


-- �� ������ UNION���� ǥ��
SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
UNION
SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '���'
ORDER BY 2, 1;
--day04
-- SUBQUERY, DDL(CONSTRAINT ����)

-- SUBQUERY ��������(�ϳ��� ������ �ٸ� ������ �����ϴ� ����)
/*
SELECT  EXPR(SELECT) -- SCALLAR SUBQUERY
FORM    (SELECT) -- INLINE VIEW
WHERE   (SELECT) -- SUBQUERY, �� EXPR OPERATOR (SUBQUERY)
GROUP BY (SELECT)
HAVING  (SELECT)
��,���� ���� �ȿ� �������� �� �� ����.

����
- ���� �� �������� (���� �Ǵ� ���ڵ� �Ǽ��� 1��), (���� �ø�, �����÷�)
- ���� �� �������� (���� �÷�, ���� �÷�)-( IN, ANY, ALL)�����ڸ� ���.
*/
-- '���¿�' ������ ���� �μ����� ��ȸ
SELECT  *
FROM    EMPLOYEE
WHERE   EMP_NAME = '���¿�' --���⼭ DEPT_ID�� 50�̶�� ���� Ȯ��


SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = (SELECT  DEPT_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '������');

-- '���¿�' ������ ���� �����̸鼭 �޿��� '���¿�' ���� ���� �޴� ������ ��ȸ�Ѵٸ�?
SELECT  *
FROM    EMPLOYEE
WHERE   JOB_ID = (SELECT    JOB_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '���¿�')
AND      SALARY > (SELECT    SALARY
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '���¿�')

-- �����޿��� �޴� ����� ������ �˻�
SELECT  *
FROM    EMPLOYEE
WHERE   SALARY = (SELECT    MIN(SALARY)
                    FROM    EMPLOYEE);
                    
-- �μ��� �޿������� ���� ���� �μ��� �μ��̸�, �޿� ������ ��ȸ
SELECT  DEPT_NAME,
        SUM(SALARY)
FROM    EMPLOYEE
JOIN    DEPARTMENT USING(DEPT_ID)
GROUP BY DEPT_NAME
HAVING  SUM(SALARY) = (SELECT   MAX(SUM(SALARY))
                        FROM    EMPLOYEE
                        GROUP BY DEPT_ID);

/*
���� �� ��������
> ANY, < ANY
> ALL, < ALL
*/
-- �����ڵ鸸 ��ȸ(�� MGR_ID�� EMP_ID�� �ִٸ� ������)

SELECT  EMP_ID,
        EMP_NAME,
        '������' AS "������ ����"
FROM    EMPLOYEE
WHERE   EMP_ID IN (SELECT   MGR_ID  -- ���������� ���� �� �̹Ƿ� WHERE���� IN( ������ �����ڸ� ��)
                    FROM    EMPLOYEE)
UNION     
SELECT  EMP_ID,
        EMP_NAME,
        '����' AS "������ ����"
FROM    EMPLOYEE
WHERE   EMP_ID NOT IN (SELECT   MGR_ID  -- ���������� NULL ���� ������ NOT IN �� ���� NULL�� ���ϵ�
                        FROM    EMPLOYEE
                        WHERE   MGR_ID IS NOT NULL) --���� IS NOT NULL �� NULL ���� �� NOT IN ���
ORDER BY 3;

-- �븮������ ����� �̸�, �޿� ��ȸ
-- ���� ������ ����� �̸�, �޿� ��ȸ
SELECT  EMP_NAME,JOB_TITLE,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
UNION
SELECT  EMP_NAME,JOB_TITLE,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '����'
ORDER BY 2;

-- �������޺��� ���� �޿��� �޴� �븮���� ����̸�, �޿��� ��ȸ
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
AND  SALARY > ANY (SELECT    SALARY -- < ANY, <ALL > ALL �����ϱ�, ���⼱ >ANY�ϱ� ����� �޿��� �ּ��ѵ� ���� ū �븮 ����� ���
                        FROM    EMPLOYEE
                        JOIN    JOB USING(JOB_ID)
                        WHERE   JOB_TITLE = '����')
-- ���޺�(JOB_TLTLE) ��� �޿��� ��ȸ, ���� 5�ڸ����� ����
SELECT  JOB_TITLE, -- 2. �� �κ��� �ٷ� �����⿡ GROUP BY�� ���
        TRUNC(AVG(SALARY),-5) -- 1.���� ������
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
GROUP BY    JOB_TITLE;

-- �ڱ� ������ ��� �޿��� �޴� ������ �̸�, ����, �޿� ��ȸ(������ ���� �� ��������)
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   (JOB_TITLE, SALARY) IN (SELECT   JOB_TITLE, TRUNC(AVG(SALARY),-5) --���� �� ���� �� ��������
                                FROM    EMPLOYEE
                                JOIN    JOB USING(JOB_ID)
                                GROUP BY    JOB_TITLE);
                    
-- ���� ������ FROM�� ���������� Ǯ��                   
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
                    
                    
-- ������� ��������
-- ������������ ó���Ǵ� �� ���� ���� ���� ���������� ������� �޶����� ���
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E
JOIN    JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE   SALARY = (SELECT    TRUNC(AVG(SALARY),-5)
                    FROM    EMPLOYEE
                    WHERE   JOB_ID = E.JOB_ID); --���������� JOB_ID�� ���������� ���� ��.
                
--DAY05
-- DDL(DATA DEFINITION LANGUAGE)
/*
TABLE(�������� �޸� ����)
VIEW(������ �޸� ����)
SEQUENCE
INDEX

-- CONSTRAINT( PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, CHECK)
--  UNIQUE �� NOT NULL�� �����ϸ� PRIMARY KEY�� ��.
-- �������� ���Ἲ, �������� �ߺ��� ���� �� �ִ�.

���̺��� �����[�⺻����]
CREATE TABLE TABLE_NAME(
    COLUMN_NAME DATATYPE [DEFAULT EXPR] [COLUMN_CONSTARINT],
    [TABLE_CONSTRAINT]
)
-- INSERT
INSERT INTO TABLE_NAME(COLUMN) VALUES(?,?,?,?)
*/
-- DROP TABLE TABLE_NAME: ���̺� ����
CREATE TABLE TEST01(
    ID  NUMBER(5),
    NAME    VARCHAR2(50),
    ADDRESS VARCHAR2(50),
    REGDATE DATE DEFAULT SYSDATE
);

INSERT INTO TEST01(ID,NAME,ADDRESS)
VALUES(100,'������','����');

INSERT INTO TEST01(ID,NAME,ADDRESS)
VALUES(100,'������','����', NULL);

INSERT INTO TEST01(ID,NAME,ADDRESS)
VALUES(100,'������','����',DEFAULT);

SELECT  *
FROM    TEST01;

DROP TABLE TEST01;

--NOT NULL : �÷��� ���� ������ �����ϳ� ���̺� ���� ������ �Ұ�.
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

-- PRIMARY KEY: ���̺� �� 1���� ����
-- NOT NULL + UNIQUE
--DROP TABLE TEST_PK
CREATE TABLE TEST_PK(
    ID  VARCHAR2(50),
    NAME    VARCHAR2(50),
    PRIMARY KEY(ID, NAME) -- TABLE LEVEL�� ���� ���⼭ ID�� NAME �� ���� PK
);
INSERT INTO TEST_PK
VALUES('JSLIM','�Ӽ���');
INSERT INTO TEST_PK
VALUES('JSLIM','JSLIM');
SELECT  *
FROM    TEST_PK

--FOREIGN KEY(���̺� ���� �ܷ�Ű ����) , REFFERENCES(�÷� ������ ���� �ܷ�Ű ����)
-- �θ� �����ϴ� �������̰ų� NULL�� ����Ѵ�.
-- ���̺��� ����� ������ �߿�! �θ� ���̺� ���� ����

-- DML(DELETE ~~~~)
-- REFERENCES [ON DELETE SET NULL]:�̷� �ɼ��� �ָ� �θ����̺��� ���� �����ϰ� �ִ� �ڽ� ���ڵ�� NULL�� ����
-- REFERENCES [ON DELETE CASCADE]:�θ� ���̺� �� �����ϴ� �ڽ� ���ڵ�� ����, �����ϰ� �ִ� ���ڵ�� ���δ� ����

CREATE TABLE LOC(
    LOCATION_ID     VARCHAR2(50) PRIMARY KEY,
    LOC_DESCRIBE    VARCHAR2(50)
);
INSERT INTO LOC VALUES(10, '�ƽþ�');
INSERT INTO LOC VALUES(20, '����');
SELECT  *
FROM    LOC;
--DROP TABLE DEPT;
CREATE TABLE DEPT(
    DEPT_ID NUMBER(5)   PRIMARY KEY,
    DEPI_NAME   VARCHAR2(50),
    LOC_ID      VARCHAR2(50) NOT NULL, -- NOT NULL�� �־��־� LOC_ID�� �ܷ�Ű�̸鼭 NULL�� ������� �ʰ� ����.
    FOREIGN KEY(LOC_ID) REFERENCES LOC(LOCATION_ID)
);
INSERT INTO DEPT VALUES(10, '�λ���',10);
INSERT INTO DEPT VALUES(20, '������',20);
INSERT INTO DEPT VALUES(30, 'ȸ����',20);
SELECT  *
FROM    DEPT;

SELECT  DEPT_NAME,
        LOC_DESC
FROM    DEPT
JOIN    LOC ON(
--DROP TABLE EMP; �θ�� �ڽİ� ������ �Ǿ������� DROP�� �ڽĺ��� ���� �ؾ���.
CREATE TABLE EMP(
    EMP_ID  VARCHAR2(50) PRIMARY KEY,
    EMP_NAME    VARCHAR2(50),
    DEPT_ID     NUMBER(5) REFERENCES DEPT(DEPT_ID)
);
INSERT INTO EMP VALUES('100','JSLIM',10);
INSERT INTO EMP VALUES('200','JSLIM',NULL);
SELECT  *
FROM    EMP;

-- COMPOSITE PRIMARY KEY�� ���
-- DROP TABLE SUPER_PK CASCADE CONSTRAINTS;
CREATE TABLE SUPER_PK(
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    O_DATE  DATE,
    AMOUNT  NUMBER, -- NUMBER()�� ����� �� �൵ ��.
    PRIMARY KEY(U_ID,P_ID)
);
INSERT INTO SUPER_PK VALUES('JSLIM','P100',SYSDATE,10000);

CREATE TABLE SUB_FK(
    SUB_ID  VARCHAR2(20) PRIMARY KEY,
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    FOREIGN KEY(U_ID,P_ID) REFERENCES SUPER_PK(U_ID,P_ID) ON DELETE CASCADE);
    
-- SUB_ID,U_ID,P_ID ���� (�ΰ��� �ܷ�Ű����) �⺻Ű��.
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
-- ������ ������ �� ���ϴ� ���� �������� ����� �� ����.
-- DROP TABLE TEST_CK;
CREATE TABLE TEST_CK(
    ID  VARCHAR2(50) PRIMARY KEY,
    SALARY  NUMBER,
    --HIRE_DATE DATE CHECK(HIRE_DATE < SYSDATE), SYSDATE�� ���ϴ� �����̱� ������ CHECK �Ұ�.
    MARRIAGE CHAR(1), -- Ȥ���÷��� CHECK(MARIAGE IN('Y','N'))
    CHECK(SALARY BETWEEN 0 AND 100), 
    CHECK(MARRIAGE IN ('Y','N')) 
);
INSERT INTO TEST_CK VALUES('100',100, 'Y');
SELECT  *
FROM    TEST_CK;

-- DROP
-- DROP TABLE TABLE_NAME [CASCADE CONSTRAINTS] : ���谡 �ִ� �θ� ���̺� ���� ���� ����.


-- VIEW : ������ ������ ���� �ְ� �����ʹ� ��� ���� ����. 
-- ���̺��� �κ��������� ���� �����̳� ������ ������ �ܼ�ȭ�ϱ� ���� ���. �б� �������� ����.
-- ���� ��(INSERT,UPDATE,DELETE)���� (���� ���̺� ���� ��ħ) , ���� ��(I,U,D) �Ұ�
-- DROP VIEW VIEW_NAME 
/*
[�⺻����]
CREATE [OR REPLACE] VIEW VIEW_NAME(ALIAS)
AS SUBQUERY;
*/
-- �μ���ȣ�� 90���� ����� �̸�, �μ���ȣ�� ������ �� �ִ� VIEW�� �����Ѵٸ�?
CREATE OR REPLACE VIEW V_EMP_90(A,B) -- ���⼭�� ��Ī(ALIAS)�� ���� �� �ִ� A,B
AS  SELECT  EMP_NAME,
            DEPT_ID
    FROM    EMPLOYEE
    WHERE   DEPT_ID = '90';

SELECT  *
FROM    V_EMP_90

-- �ζ��� �並 Ȱ���� TOP N �м� �����ϴ�. : ���ǿ� �´� ���� �� ��
-- ���ǿ� �´� �ֻ��� �Ǵ� ������ ���ڵ� N���� �ĺ��� �� ���
/*
�м� ����
- ����
- ROWNUM �̶�� ������ �÷��� �̿��ؼ� ���� ������� ���� �ο�
- �ο��� ������ �̿��ؼ� �ʿ��� �� ��ŭ �ĺ�
*/
--�μ��� �޿� ���
SELECT  ROWNUM,
        EMP_NAME
FROM    EMPLOYEE;

-- �μ��� ��� �޿����� ���� �޴� �����
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
-- ORDER BY 3 DESC; �̷��� �����ϸ� ROWNUM�� ��Ʈ����

-- TOP N �м�, ������ �Ǿ��ִ� ���ڵ忡 ROWNUM �Ǵ� RANK�� ����ϴ� ���� TOP N �м�.
-- ROWNUM�� ���� �Ǿ��ִ� ���ڵ忡 '=' ��ȣ�� ���� �ֻ��� �� �Ǹ� ���.
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

-- RANK()�� �̿��� TOP N �м�
SELECT  *
FROM    (SELECT  EMP_NAME,
                    SALARY,
                     RANK() OVER(ORDER BY SALARY DESC) AS RANK
            FROM    EMPLOYEE)
WHERE   RANK = 5;


-- SEQUENCE
-- ���������� ���� ���� �ڵ����� �����ϴ� ��ü
/* CREATE SEQUENCE SEQUENCE_NAME;
START WITH 10
INCREMENT BY 10
MAXVALUE 100

*/
-- NEXTVAL, CURRVAL
CREATE SEQUENCE TEST_SEQ;
SELECT TEST_SEQ.NEXTVAL FROM DUAL; -- ���� ���� ����.
SELECT TEST_SEQ.CURRVAL FROM DUAL; -- ������ ���� ����.
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
ALTER TABLE TABLE�� ADD �÷��� ������Ÿ�� : �÷� �߰�
ALTER TABLE TABLE�� DROP COLUMN �÷��� : �÷� ����
ALTER TABLE ORTL RENAME TO ORDERDETAIL : ���̺� �� �ٲٱ�
*/

--DAY05
-- DML(SELECT, INSERT, UPDATE, DELETE)
-- TRANSACTION( COMMIT, ROLLBACK)
/*
���Ἲ ����
            �θ�      �ڽ�
UPDATE       X         O
INSERT       O         O
DELETE       X         O
*/
-- ������ ���� ����
/*
UPDATE  TABLE_NAME
SET     COLUMN_NMAE = VALUE | SUBQUERY, [COLUMN_NAME = VALUE] -- SET �� ������ ���� Ư�� �÷��� ��ü �࿡ ���� ����
[WHERE   CONDITION] -- �̰� �ɼ������� WHERE���� ������ Ư�� �÷��� ���� �� ����
*/
SELECT  *
FROM    EMPLOYEE;

UPDATE  EMPLOYEE
SET     JOB_ID = (SELECT    JOB_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '���ر�'),
        DEPT_ID = '90'
WHERE   EMP_NAME = '���ϱ�'

UPDATE  EMPLOYEE
SET     MARRIAGE = DEFAULT
WHERE   EMP_ID = '100';

-- INSERT
/*
INSERT INTO TABLE_NAME(COLUMN_NAME)
VALUES (VALUE1,VALUE2)
INSERT INTO TABLE_NAME(COLUMN_NAME)
SUBQUERY
- ������ Ÿ�� ��ġ
- ���� ��ġ
- ���� ��ġ
*/
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO)
VALUES('900', '������', '123456-1234567');

-- DELETE: ���̺� ���Ե� ���� �����͸� ����, �� ���ڵ� ����, ROLLBACK ����
/*
DELETE FROM TABLE_NAME : ��������� �ϸ� ���̺� ������ ����� ��ü �����͸� ����
[WHERE CONDITION];

TRUNCATE TABLE TABLE_NAME : ROLLBACK�Ұ��� ������ COMMIT�� ���� ������ ������ �ȵ�.
*/
SELECT  *
FROM    DEPARTMENT;

-- ERROR ���Ἲ ���� ����, EMPLOYEE���̺��� DEPARTMENT�� LOC_ID�� �ܷ�Ű�� ����.
DELETE 
FROM  DEPARTMENT
WHERE LOC_ID LIKE 'A%';

DELETE
FROM    JOB
WHERE   JOB_ID = 'J2';

DELETE
FROM    EMPLOYEE
WHERE   EMP_ID = '141'; --EMPLOYEE�� ���(MGR_ID�� EMP_ID ���� ��)

-- TRANSACTION
-- �������� �ϰ����� �����ϱ����ؼ� ����ϴ� �������� ������ �۾����� ����
-- �ϳ��̻��� ������ DML �۾�
>INSERT~~
>UPDATE~~
>COMMIT/ROLLBACK :���̺� ���� �ݿ� / ���� ����

>UPDATE
>DELETE
>CREATE - AUTO COMMIT �߻�(DDL ��ɾ �Է��ϸ�), ���̺� ���� ��.

-- ���ü� ����


--ALTER
/*
-���̺� ����, ���÷� �߰�, ���� �÷� ����, ���� �÷��� ���������̳� �Ӽ� ���氡��
-���̺� ���� = ���̺��� �÷� ����
-���� ���� ���� �߰� �ÿ��� Ȱ�� ����
*/
--CASE 1. �÷� �Ӽ� ����
ALTER TABLE TABLE_NAME
MODIFY �÷��� ������Ÿ��; --��)MODIFY EMP_NAME VARCHAR2(20)
--CASE 2. �÷��� ���� ���� �߰�
ALTER TABLE TABLE_NAME
ADD CONSTRAINTS �������Ǹ� PRIMARY KEY(�÷���);
--2�� �̻��� �÷��� �⺻ Ű�� ����(�÷���1,�÷���2)
ALTER TABLE TABLE_NAME
DROP CONSTRAINTS �������Ǹ� -- ���� ������ ����
--CASE 3. ���ο� �÷� �߰�
ALTER TABLE TABLE_NAME
ADD �÷��� ������Ÿ��; NOT NULL ��� ����
--CASE 4. �÷� ����
ALTER TABLE TABLE_NAME
DROP COLUMN �÷���

ALTER TABLE item_content
    ADD COLUMN badge INTEGER,
    ADD COLUMN age INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN duration INTEGER AFTER description;
--�÷� �̸� �ٲٱ�
ALTER TABLE contacts
    CHANGE COLUMN old_name new_name
    varchar(20) NOT NULL;
-- ���̺� �̸� �ٲٱ�
ALTER TABLE contacts
  RENAME TO people;
