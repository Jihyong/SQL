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