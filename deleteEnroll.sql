CREATE OR Replace PROCEDURE DeleteEnroll (sStudentId IN VARCHAR2, 
		sCourseId IN VARCHAR2, 
		nCourseIdNo IN NUMBER)
IS
BEGIN

	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || sCourseId ||'를 취소하려합니다.');

	DELETE
	FROM enroll
	WHERE s_id = sStudentId and c_id = sCourseId;

	COMMIT;

EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
END;
/