CREATE OR Replace PROCEDURE DeleteTeach 
(pProfessorId IN VARCHAR2, 
		
sCourseId IN VARCHAR2, 
		
nCourseIdNo IN NUMBER,
		
result OUT VARCHAR2)

IS

BEGIN
	
result := '';

	
DBMS_OUTPUT.put_line('#');
	
DBMS_OUTPUT.put_line(pProfessorId || '님이 과목번호 ' || sCourseId || ', 분반 ' || TO_CHAR(nCourseIdNo) || '의 강의를 취소하려 합니다.');

	
DELETE
	
FROM teach
	
WHERE p_id = pProfessorId and c_id = sCourseId and c_id_no = nCourseIdNo;

	
DELETE
	
FROM course
	
WHERE c_id = sCourseId and c_id_no = nCourseIdNo;
	
	
DELETE
	
FROM enroll
	
WHERE c_id = sCourseId and c_id_no = nCourseIdNo;
	

	
COMMIT;
	
result := '강의 삭제가 완료되었습니다.';


EXCEPTION
	
WHEN OTHERS THEN
		
ROLLBACK;
		
result := SQLCODE;

END;

/