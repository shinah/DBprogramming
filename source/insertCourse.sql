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

DBMS_OUTPUT.put_line(sProfessorId || '���� �����ȣ ' || sCourseId || ', �й� ' || TO_CHAR(nCourseIdNo) || '����� ��û�߽��ϴ�.');

/* �⵵, �б� �˾Ƴ��� */
nYear := Date2EnrollYear(SYSDATE);
nSemester := Date2EnrollSemester(SYSDATE);

/* ����ó�� 1 : ���� �� �ð��� �ߺ� ���� �ִ� ���*/
  overlap := 0;
  FOR teach_list IN duplicate_time_cursor LOOP
    overlap := compareTime2(nDay, nStime,nEtime, teach_list.c_id, teach_list.c_id_no);
  
    IF (overlap > 0)
    THEN
       RAISE duplicate_time_professor;
    END IF;
  END LOOP;

 /*����ó�� 2 : �ߺ��ð� �� �ߺ� ���ǽ��� ���*/
overlap2 := 0;
FOR loc_list IN duplicate_loc_cursor LOOP
    overlap2 := compareTime2(nDay, nStime, nEtime, loc_list.c_id, loc_list.c_id_no);

    IF(overlap2 > 0) THEN
        RAISE duplicate_loc_professor;
    END IF;
END LOOP;

/* teach�� course ���̺� ���� �߰� */

INSERT INTO COURSE(c_id,c_id_no,c_name,c_unit)
VALUES(sCourseId, nCourseIdNo, sCourseName, nCourseUnit);

INSERT INTO TEACH(t_year,t_semester,t_max,c_id,c_id_no, c_day, c_stime,c_etime,c_room,p_id)
VALUES(nYear,nSemester, nMax, sCourseId, nCourseIdNo, nDay, nStime,nEtime,SCourseRoom,sProfessorId);

COMMIT;
result := '������ �߰��Ͽ����ϴ�.';

EXCEPTION
WHEN duplicate_time_professor THEN
result := '��ϵ� ���� �� �ߺ��Ǵ� ���ǰ� �����մϴ�.';
WHEN duplicate_loc_professor THEN
result := '����Ϸ��� ���ǽǿ� �̹� ���ǰ� �ֽ��ϴ�';
WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/