DECLARE
    -- משתנים עבור הוספת אשפוז
    v_patient_id NUMBER := 1499; -- מזהה מטופל תקין
    v_admission_date DATE := SYSDATE;
    v_ward VARCHAR2(50) := 'Cardiology';
    v_treatment VARCHAR2(255) := 'Initial assessment and treatment';
    v_event_record VARCHAR2(255) := 'Admitted for further evaluation';
    
    -- משתנים עבור עדכון סטטוס תשלום ושחרור
    v_discharge_id NUMBER := 1499; -- מזהה שחרור לדוגמה
    v_payment_amount NUMBER := 5000; -- סכום תשלום לדוגמה
    v_payment_date DATE := SYSDATE;
    v_discharge_date DATE := SYSDATE;
    
    -- משתנים לטיפול בשגיאות
    v_error_message VARCHAR2(4000);
BEGIN
    -- זימון הפרוצדורה להוספת אשפוז
    BEGIN
        add_patient_admission(v_patient_id, v_admission_date, v_ward, v_treatment, v_event_record);
        DBMS_OUTPUT.PUT_LINE('Patient admission added successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('An error occurred while adding admission: ' || v_error_message);
    END;
    
    -- זימון הפרוצדורה לעדכון סטטוס תשלום ושחרור
    BEGIN
        update_payment_and_discharge_status(v_discharge_id, v_payment_amount, v_payment_date, v_discharge_date);
        DBMS_OUTPUT.PUT_LINE('Payment and discharge status updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('An error occurred while updating payment and discharge status: ' || v_error_message);
    END;
END;
/
