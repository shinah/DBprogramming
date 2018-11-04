CREATE OR REPLACE FUNCTION compareTime2 (
	first_c_day NUMBER,
	first_c_s_time NUMBER,
	first_c_e_time NUMBER,
	second_c_id VARCHAR,
	second_c_id_no NUMBER
)
RETURN NUMBER
IS
	overlap NUMBER;
	first_day NUMBER;
	second_day NUMBER;
	first_start_time NUMBER;
	first_end_time NUMBER;
	second_start_time NUMBER;
	second_end_time NUMBER;
BEGIN
	first_day := first_c_day;
	first_start_time := first_c_s_time;
	first_end_time := first_c_e_time;

	SELECT  c_day, c_stime, c_etime
	INTO second_day, second_start_time, second_end_time
	FROM teach
	WHERE second_c_id = c_id AND second_c_id_no = c_id_no;

	overlap := 1;
  IF(first_day = second_day) THEN
		IF(first_start_time > second_start_time) THEN
			IF(first_start_time > second_end_time) THEN
				overlap := 0;
			ELSIF(first_start_time = second_end_time) THEN
				overlap := 0;
			END IF;
		END IF;


		IF(first_end_time < second_start_time) THEN
			IF(first_end_time < second_end_time) THEN
				overlap := 0;
			ELSIF(first_end_time = second_end_time) THEN
				overlap := 0;
			END IF;
		END IF;
	ELSE
		overlap :=0;
	END IF;
	COMMIT;

RETURN overlap;
END;
/
