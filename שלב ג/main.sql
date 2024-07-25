DECLARE
    v_patient_id NUMBER := 1000; -- מזהה מטופל תקין
    v_cursor SYS_REFCURSOR;
    v_admission_id NUMBER;
    v_admission_date DATE;
    v_ward VARCHAR2(50);
    v_discharge_date DATE;
    v_treatment VARCHAR2(255);
    v_event_record VARCHAR2(255);
    v_monthly_payments NUMBER;
    v_record_found BOOLEAN := FALSE;
    v_month NUMBER := 5; -- מאי
    v_year NUMBER := 2024; -- שנה נוכחית
BEGIN
    v_cursor := get_patient_admission_history(v_patient_id);
    
    DBMS_OUTPUT.PUT_LINE('Admission History for Patient ID: ' || v_patient_id);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    
    LOOP
        FETCH v_cursor INTO v_admission_id, v_admission_date, v_ward, v_discharge_date, v_treatment, v_event_record;
        EXIT WHEN v_cursor%NOTFOUND;
        
        v_record_found := TRUE;
        
        DBMS_OUTPUT.PUT_LINE('Admission ID: ' || v_admission_id);
        DBMS_OUTPUT.PUT_LINE('Admission Date: ' || TO_CHAR(v_admission_date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Ward: ' || v_ward);
        DBMS_OUTPUT.PUT_LINE('Discharge Date: ' || TO_CHAR(v_discharge_date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Treatment: ' || v_treatment);
        DBMS_OUTPUT.PUT_LINE('Event Record: ' || v_event_record);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
    
    IF NOT v_record_found THEN
        DBMS_OUTPUT.PUT_LINE('No admission records found for this patient.');
    END IF;
    
    CLOSE v_cursor;
    
    -- חישוב סך התשלומים לחודש ושנה נבחרים
    v_monthly_payments := calculate_monthly_payments(v_month, v_year);
    
    IF v_monthly_payments IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Total payments for ' || v_month || '/' || v_year || ': $' || v_monthly_payments);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        IF v_cursor%ISOPEN THEN
            CLOSE v_cursor;
        END IF;
END;
/
