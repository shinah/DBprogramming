﻿CREATE OR REPLACE PROCEDURE InsertEnroll (
  sStudentId IN VARCHAR2,
  sCourseId IN VARCHAR2,
  nCourseIdNo IN NUMBER,
  result OUT VARCHAR2)
IS
  too_many_sumCourseUnit EXCEPTION;
  too_many_courses EXCEPTION;
  too_many_students EXCEPTION;
  duplicate_time EXCEPTION;
  nYear NUMBER;
  nSemester NUMBER;
  nSumCourseUnit NUMBER;
  nCourseUnit NUMBER;
  nCnt NUMBER;
  nTeachMax NUMBER;
  overlap NUMBER;
CURSOR duplicate_time_cursor IS
SELECT *
FROM enroll
WHERE s_id = sStudentId;

BEGIN
  result := '';

DBMS_OUTPUT.put_line('#');
DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || sCourseId || ', 분반 ' || TO_CHAR(nCourseIdNo) || '의 수강 등록을 요청하였습니다.');

  /* 년도, 학기 알아내기 */
  nYear := Date2EnrollYear(SYSDATE);
  nSemester := Date2EnrollSemester(SYSDATE);


  /* 에러 처리 1 : 최대학점 초과여부 */
  SELECT SUM(c.c_unit)
  INTO    nSumCourseUnit
  FROM   course c, enroll e
  WHERE  e.s_id = sStudentId and e.e_year = nYear and e.e_semester = nSemester
    and  e.c_id = c.c_id and e.c_id_no = c.c_id_no;

  SELECT c_unit
  INTO    nCourseUnit
  FROM    course
  WHERE    c_id = sCourseId and c_id_no = nCourseIdNo;

  IF (nSumCourseUnit + nCourseUnit > 18)
  THEN
     RAISE too_many_sumCourseUnit;
  END IF;


  /* 에러 처리 2 : 동일한 과목 신청 여부 */
  SELECT COUNT(*)
  INTO    nCnt
  FROM   enroll
  WHERE  s_id = sStudentId and c_id = sCourseId;

  IF (nCnt > 0)
  THEN
     RAISE too_many_courses;
  END IF;


  /* 에러 처리 3 : 수강신청 인원 초과 여부 */
  SELECT t_max
  INTO    nTeachMax
  FROM   teach
  WHERE  t_year= nYear and t_semester = nSemester
    and c_id = sCourseId and c_id_no= nCourseIdNo;

  SELECT COUNT(*)
  INTO   nCnt
  FROM   enroll
  WHERE  e_year = nYear and e_semester = nSemester
         and c_id = sCourseId and c_id_no = nCourseIdNo;

  IF (nCnt >= nTeachMax)
  THEN
     RAISE too_many_students;
  END IF;

  /* 에러 처리 4 : 신청한 과목들 시간 중복 여부 */
  overlap := 0;
  FOR enroll_list IN duplicate_time_cursor LOOP
    overlap := compareTime(sCourseId, nCourseIdNo, enroll_list.c_id, enroll_list.c_id_no);
  
    IF (overlap > 0)
    THEN
       RAISE duplicate_time;
    END IF;
 END LOOP;


  /* 수강 신청 등록 */
  INSERT INTO enroll(S_ID,C_ID,C_ID_NO,E_YEAR,E_SEMESTER)
  VALUES (sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);

  COMMIT;
  result := '수강신청 등록이 완료되었습니다.';

EXCEPTION
  WHEN too_many_sumCourseUnit THEN
    result := '최대학점을 초과하였습니다';
  WHEN too_many_courses THEN
    result := '이미 등록된 과목을 신청하였습니다';
  WHEN too_many_students THEN
    result := '수강신청 인원이 초과되어 등록이 불가능합니다';
  WHEN duplicate_time THEN
    result := '이미 등록된 과목 중 중복되는 시간이 존재합니다';
  WHEN no_data_found THEN
    result := '이번 학기 과목이 아닙니다.';
  WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/
