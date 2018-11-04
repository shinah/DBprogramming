CREATE OR REPLACE TRIGGER BeforeUpdateStudent 
BEFORE
UPDATE ON student
FOR EACH ROW

DECLARE
    underflow_length EXCEPTION;
    invalid_value EXCEPTION;
    invalid_value2 EXCEPTION;
    nLength NUMBER;
    nBlank varchar2(20);
    nBlank2 NUMBER;

BEGIN
    SELECT length(:new.s_pwd), :new.s_pwd, instr(:new.s_pwd,'\0')
    INTO nLength, nBlank, nBlank2
    FROM DUAL;

    IF (nLength < 4) THEN
        RAISE underflow_length;
    ELSIF (nBlank is null) THEN
        RAISE invalid_value;
    ELSIF (nBlank2 > 0) THEN
        RAISE invalid_value2;
    END IF;


    EXCEPTION
    WHEN underflow_length THEN
        RAISE_APPLICATION_ERROR(-20002, '암호는 4자리 이상이어야 합니다');
    WHEN invalid_value THEN
        RAISE_APPLICATION_ERROR(-20003, '암호에 공란은 입력되지 않습니다.');
    WHEN invalid_value2 THEN
        RAISE_APPLICATION_ERROR(-20004, '암호에 공란은 입력되지 않습니다.');
END;
/
