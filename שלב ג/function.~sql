CREATE OR REPLACE FUNCTION get_patient_admission_history(p_patient_id IN NUMBER)
RETURN SYS_REFCURSOR
IS
    v_result SYS_REFCURSOR; -- מצביע לתוצאות השאילתה
BEGIN
    -- פתיחת cursor עם השאילתה לקבלת היסטוריית האשפוז של המטופל
    OPEN v_result FOR
        SELECT a.admissionID, a.admission_date, a.ward, d.dischargeDate,
               m.treatment, m.event_record
        FROM Admission a
        JOIN Admission_Discharge ad ON a.admissionID = ad.admissionID
        JOIN Discharge d ON ad.dischargeID = d.dischargeID
        JOIN Medical_Record m ON d.dischargeID = m.dischargeID
        WHERE a.patientID = p_patient_id
        ORDER BY a.admission_date DESC; -- מיון לפי תאריך אשפוז בסדר יורד
    
    RETURN v_result; -- החזרת ה-cursor לתוכנית הקוראת

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- טיפול במקרה שלא נמצאו רשומות עבור המטופל
        DBMS_OUTPUT.PUT_LINE('No admission history found for patient ID: ' || p_patient_id);
        RETURN NULL;
    WHEN OTHERS THEN
        -- טיפול בשגיאות לא צפויות
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        RETURN NULL;
END;
/

CREATE OR REPLACE FUNCTION calculate_monthly_payments(
    p_month IN NUMBER,
    p_year IN NUMBER
)
RETURN NUMBER
IS
    v_total_amount NUMBER := 0;
    v_start_date DATE;
    v_end_date DATE;
BEGIN
    -- קביעת טווח התאריכים לחודש ושנה שנבחרו
    v_start_date := TO_DATE(p_year || '-' || LPAD(p_month, 2, '0') || '-01', 'YYYY-MM-DD');
    v_end_date := LAST_DAY(v_start_date);

    -- חישוב סכום התשלומים
    SELECT NVL(SUM(p.amount), 0)
    INTO v_total_amount
    FROM Payment p
    JOIN Discharge d ON p.dischargeID = d.dischargeID
    WHERE d.dischargeDate BETWEEN v_start_date AND v_end_date;

    -- בדיקה אם נמצאו תשלומים
    IF v_total_amount = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No payments found for ' || TO_CHAR(v_start_date, 'Month YYYY'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total payments for ' || TO_CHAR(v_start_date, 'Month YYYY') || ': $' || v_total_amount);
    END IF;

    RETURN v_total_amount;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        RETURN NULL;
END
/


