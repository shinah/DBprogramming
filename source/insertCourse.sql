create or replace PROCEDURE InsertCourse(
sCourseName IN VARCHAR2,
nCourseUnit IN NUMBER,
sProfessorId IN VARCHAR2,
sCourseId IN VARCHAR2,
nCourseIdNo IN NUMBER,
sCourseRoom IN VARCHAR2,
nDay IN NUMBER,
nStime IN NUMBER,
nEtime IN NUMBER,
nMax IN NUMBER,
result OUT VARCHAR2)
IS
duplicate_time_professor EXCEPTION;
duplicate_loc_professor EXCEPTION;

overlap NUMBER;
overlap2 NUMBER;

nYear NUMBER;
nSemester NUMBER;



CURSOR duplicate_time_cursor IS
SELECT *
FROM TEACH
WHERE p_id = sProfessorId;

CURSOR duplicate_loc_cursor IS
SELECT *
FROM TEACH
WHERE c_room = sCourseRoom;


BEGIN
result := '';

DBMS_OUTPUT.put_line(sProfessorId || '님이 과목번호 ' || sCourseId || ', 분반 ' || TO_CHAR(nCourseIdNo) || '등록을 요청했습니다.');

/* 년도, 학기 알아내기 */
nYear := Date2EnrollYear(SYSDATE);
nSemester := Date2EnrollSemester(SYSDATE);

/* 에러처리 1 : 요일 및 시간에 중복 수업 있는 경우*/
  overlap := 0;
  FOR teach_list IN duplicate_time_cursor LOOP
    overlap := compareTime2(nDay, nStime,nEtime, teach_list.c_id, teach_list.c_id_no);
  
    IF (overlap > 0)
    THEN
       RAISE duplicate_time_professor;
    END IF;
  END LOOP;

 /*에러처리 2 : 중복시간 및 중복 강의실인 경우*/
overlap2 := 0;
FOR loc_list IN duplicate_loc_cursor LOOP
    overlap2 := compareTime2(nDay, nStime, nEtime, loc_list.c_id, loc_list.c_id_no);

    IF(overlap2 > 0) THEN
        RAISE duplicate_loc_professor;
    END IF;
END LOOP;

/* teach와 course 테이블에 수업 추가 */

INSERT INTO COURSE(c_id,c_id_no,c_name,c_unit)
VALUES(sCourseId, nCourseIdNo, sCourseName, nCourseUnit);

INSERT INTO TEACH(t_year,t_semester,t_max,c_id,c_id_no, c_day, c_stime,c_etime,c_room,p_id)
VALUES(nYear,nSemester, nMax, sCourseId, nCourseIdNo, nDay, nStime,nEtime,SCourseRoom,sProfessorId);

COMMIT;
result := '수업을 추가하였습니다.';

EXCEPTION
WHEN duplicate_time_professor THEN
result := '등록된 과목 중 중복되는 강의가 존재합니다.';
WHEN duplicate_loc_professor THEN
result := '등록하려는 강의실에 이미 강의가 있습니다';
WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/