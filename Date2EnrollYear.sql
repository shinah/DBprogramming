  CREATE OR REPLACE FUNCTION Date2EnrollYear
  (dDate IN DATE)
  RETURN NUMBER
  IS
     nYear  NUMBER;
     sMonth CHAR(2);
  BEGIN /* 11월 ~ 4월 : 1학기,   5월 ~ 10월  : 2학기  */
  SELECT   TO_NUMBER(TO_CHAR(dDate, 'YYYY')), TO_CHAR(dDate, 'MM')
  INTO      nYear, sMonth
  FROM DUAL;

  IF (sMonth =11 or sMonth=12)  THEN
          nYear := nYear + 1;
  END IF;
  RETURN nYear;
  END;
  /
