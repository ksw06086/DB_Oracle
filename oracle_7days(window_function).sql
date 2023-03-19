/*  �� window function : �� over�� �ʼ��� ������
    [ ���� ]
    SELECT window_function (arguments) OVER (
    [PARTITION BY Į��] [ORDER BY ��] [WINDOWING ��])
    FROM ���̺� ��;
    -- window_function : ������ ����ϴ� �Լ��� �ְ�, ���Ӱ� window �Լ������� �߰��� �͵� ����
    -- arguments(�μ�)  : �Լ��� ���� 0~n���� �μ��� ������ �� ����
    -- PARTITION BY    : ��ü ������ ���ؿ� ���� �ұ׷����� ���� �� ����
    -- ORDER BY        : � �׸� ���� ������ ���������� ���� ���
    -- WINDOWING       : �Լ��� ����� �Ǵ� �� ������ ������ �����ϰ� ����
                       : SQL SERVER������ �������� ����
                       : ROWS -> �������� �������� ��� ���� �����ϴ���
                       : RANGE -> �������� �������� � ���� ������ �����ϴ���
    �� WINDOWING ��� ��
    -- BETWEEN ���Ÿ��)
    ROWS | RANGE BETWEEN
    UNBOUNDED PRECEDING | CURRENT ROW | VALUE_EXPR PRECEDING/FOLLOWING
    AND
    UNBOUNDED PRECEDING | CURRENT ROW | VALUE_EXPR PRECEDING/FOLLOWING
    -- BETWEEN �̻��Ÿ��)
    ROWS | RANGE
    UNBOUNDED PRECEDING | CURRENT ROW | VALUE_EXPR PRECEDING/FOLLOWING
    -- DEFAULT ���)
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    [] UNBOUNDED : �Ѱ踦 ���� �ʰ�, �ش� ��Ƽ���� �������� �ǹ�
    [] PRECEDING : ���� �࿡�� ������ ���� ��Ÿ��
                 : <> 3 PRECEDING : ������ ���� ������ 3��° ���� ������ ��
                 : <> UNBOUNDED PRECEDING : �������� ���� ��ġ�� ù��° ROW
    [] FOLLOWING : ���� �࿡�� ������ ���� ��Ÿ��
                 : FOLLOWING�� ����ϱ� ���ؼ��� BETWEEN~AND~������ ����ؾ���
                 : <> UNBOUNDED FOLLOWING : �������� ������ ��ġ�� ������ ROW
*/
-- 1. �޿����� ������ / 2. �������� ����� ���� �ȿ��� ���� ������
-- ������ �޿��� �������� ������ ������ �ι�° ���� ���ָ� JOB_ID ������ ������ �ǰ� 
SELECT JOB_ID, LAST_NAME, SALARY,
        RANK() OVER(ORDER BY SALARY DESC) S_SAL,
        RANK() OVER(PARTITION BY JOB_ID ORDER BY SALARY DESC) JOB_SAL
FROM EMPLOYEES;
