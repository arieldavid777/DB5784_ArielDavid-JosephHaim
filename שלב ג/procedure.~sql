-- Procedure to add a new patient admission
CREATE OR REPLACE PROCEDURE add_patient_admission (
    p_patient_id IN NUMBER,           -- Patient ID
    p_admission_date IN DATE,         -- Admission date
    p_ward IN VARCHAR2,               -- Ward name
    p_treatment IN VARCHAR2,          -- Treatment description
    p_event_record IN VARCHAR2        -- Event record description
)
IS
    v_admission_id NUMBER;            -- Variable to hold new admission ID
    v_record_id NUMBER;               -- Variable to hold new medical record ID
    v_discharge_id NUMBER;            -- Variable to hold new discharge ID
BEGIN
    -- Create a new medical record
    SELECT NVL(MAX(recordID), 0) + 1 INTO v_record_id FROM Medical_Record;
    
    -- Create a new discharge record
    SELECT NVL(MAX(dischargeID), 0) + 1 INTO v_discharge_id FROM Discharge;
    INSERT INTO Discharge (dischargeID, discharge_doctorID, dischargeDate)
    VALUES (v_discharge_id, 100, p_admission_date + INTERVAL '7' DAY);
    
    -- Insert the new medical record
    INSERT INTO Medical_Record (recordID, treatment, event_record, dischargeID)
    VALUES (v_record_id, p_treatment, p_event_record, v_discharge_id);

    -- Create a new admission record
    SELECT NVL(MAX(admissionID), 0) + 1 INTO v_admission_id FROM Admission;
    INSERT INTO Admission (admissionID, admission_date, ward, doctorID, patientID, recordID)
    VALUES (v_admission_id, p_admission_date, p_ward, 100, p_patient_id, v_record_id);

    -- Commit the transaction
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('An error occurred while adding admission: ' || SQLERRM);
END;
/


-- Procedure to update payment and discharge status
CREATE OR REPLACE PROCEDURE update_payment_and_discharge_status (
    p_discharge_id IN NUMBER,         -- Discharge ID
    p_payment_amount IN NUMBER,       -- Payment amount
    p_payment_date IN DATE,           -- Payment date
    p_discharge_date IN DATE          -- Discharge date
)
IS
    v_payment_id NUMBER;              -- Variable to hold new payment ID
BEGIN
    -- Check if the discharge record exists
    BEGIN
        SELECT dischargeID INTO v_payment_id
        FROM Discharge
        WHERE dischargeID = p_discharge_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Create a new discharge record if it does not exist
            INSERT INTO Discharge (dischargeID, discharge_doctorID, dischargeDate)
            VALUES (p_discharge_id, 100, p_discharge_date);
    END;

    -- Create a new payment record
    SELECT NVL(MAX(paymentID), 0) + 1 INTO v_payment_id FROM Payment;
    INSERT INTO Payment (paymentID, pay_Type, amount, dischargeID)
    VALUES (v_payment_id, 'Credit', p_payment_amount, p_discharge_id);

    -- Update the discharge date
    UPDATE Discharge
    SET dischargeDate = p_discharge_date
    WHERE dischargeID = p_discharge_id;

    -- Commit the transaction
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('An error occurred while updating payment and discharge status: ' || SQLERRM);
END;
/
