CREATE OR REPLACE TRIGGER BeforeUpdateProfessor 
BEFORE
UPDATE ON Professor
FOR EACH ROW

DECLARE
    underflow_length EXCEPTION;
    invalid_value EXCEPTION;
    nLength NUMBER;
    nBlank varchar2(20);

BEGIN
    SELECT length(:new.p_pwd), :new.p_pwd
    INTO nLength, nBlank
    FROM DUAL;

    IF (nLength < 4) THEN
        RAISE underflow_length;
    ELSIF (nBlank is null) THEN
        RAISE invalid_value;
    END IF;


    EXCEPTION
    WHEN underflow_length THEN
        RAISE_APPLICATION_ERROR(-20002, '암호는 4자리 이상이어야 합니다');
    WHEN invalid_value THEN
        RAISE_APPLICATION_ERROR(-20003, '암호에 공란은 입력되지 않습니다.');
END;
/
