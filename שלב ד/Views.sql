CREATE VIEW OperationOverview AS
/*
-------------
THEIR VIEW
-------------
Description:
This view provides a comprehensive overview of surgical operations performed in the hospital.
It combines information from multiple tables to give a holistic view of each operation,
including details about the operation itself, the patient, the performing doctor,
the assisting nurse, the operation room, and any equipment used.

Tables included:
- Operation: Core operation details
- Patient: Information about the patient undergoing the operation
- Doctor: Details of the doctor performing the operation
- Nurse: Information about the assisting nurse
- Operation_Room: Details of the room where the operation is performed
- Equipment: Information about any equipment used in the operation

Note: LEFT JOINs are used for Nurse and Equipment information as not all operations
may have recorded nurse assistance or specific equipment usage.
*/
SELECT 
    o.operation_id,                          -- Unique identifier for the operation
    o.duration_operation,                    -- Duration of the operation in minutes
    o.operation_date,                        -- Date when the operation was performed
    p.patientID,                             -- Unique identifier for the patient
    p.patient_name,                          -- Name of the patient undergoing the operation
    d.doctor_id,                             -- Unique identifier for the doctor
    d.doctor_name,                           -- Name of the doctor performing the operation
    d.speciality,                            -- Specialty of the doctor
    n.nurse_id,                              -- Unique identifier for the nurse (may be NULL if not assigned)
    n.nurse_name,                            -- Name of the nurse assisting (may be NULL if not assigned)
    n.telephone_number AS nurse_telephone,   -- Contact number of the nurse (may be NULL if not assigned)
    r.room_id,                               -- Unique identifier for the operation room
    r.max_number_people,                     -- Maximum number of people the room can accommodate
    e.equipment_id,                          -- Unique identifier for the equipment (may be NULL if not used)
    e.equipment_name                         -- Name of the equipment used (may be NULL if not used)

FROM 
    Operation o
JOIN Patient p ON o.patientID = p.patientID                     -- Joins the Patient table to include patient details
JOIN Operation_by ob ON o.operation_id = ob.operation_id         -- Joins the Operation_by table to connect operations with doctors
JOIN Doctor d ON ob.doctor_id = d.doctor_id                     -- Joins the Doctor table to include doctor details
LEFT JOIN Asist_by ab ON o.operation_id = ab.operation_id        -- Left join with Asist_by to include nurse details if available
LEFT JOIN Nurse n ON ab.nurse_id = n.nurse_id                   -- Left join with Nurse table to get nurse details
JOIN Operation_Room r ON o.room_id = r.room_id                   -- Joins the Operation_Room table to include room details
LEFT JOIN Using u ON r.room_id = u.room_id                      -- Left join with Using table to include equipment details if available
LEFT JOIN Equipment e ON u.equipment_id = e.equipment_id         -- Left join with Equipment table to get equipment details


--------------------------------------------------------------------------------------------------------------------------------------------

-- This query retrieves key information about recent long operations from the OperationOverview table.

SELECT 
    operation_id,           -- Unique identifier for the operation
    operation_date,         -- Date when the operation was performed
    patient_name,           -- Name of the patient who underwent the operation
    doctor_name,            -- Name of the doctor who performed the operation
    doctor_speciality,      -- Specialty of the doctor
    nurse_name,             -- Name of the nurse involved in the operation
    room_id,                -- Room where the operation was conducted
    equipment_name,         -- Equipment used during the operation
    duration_operation      -- Duration of the operation in minutes

FROM 
    OperationOverview       -- Table containing operation details

WHERE 
    operation_date >= CURRENT_DATE - INTERVAL 7 DAY  -- Filters operations to include only those performed in the last 7 days
    AND duration_operation > 120                     -- Further filters to include only operations lasting more than 120 minutes

ORDER BY 
    duration_operation DESC    -- Orders the results by duration, showing the longest operations first

LIMIT 10;    -- Limits the output to the top 10 longest operations


------------------------------------------------------------------------------------------------------------------------------------------------

/*
Description:
This view, named PatientAdmissionOverview, provides a comprehensive overview of patient admissions,
including details about the patient, their admission, discharge, medical records, payment, and insurance information.
It combines data from multiple tables to give a holistic view of each patient's interaction with the hospital.

Tables included:
- Patient: Core patient details
- Admission: Information about patient admissions
- Admission_Discharge: Bridge table connecting admissions with discharges and medical records
- Discharge: Details of patient discharge
- Medical_Record: Records of medical events and treatments
- Payment: Payment details related to the patient
- Insured_Patients: Bridge table linking patients and payments with insurance information
- Insurance: Details of insurance coverage

Note: LEFT JOINs are used throughout to ensure that all patients are included in the view, even if they do not have corresponding records in some of the other tables.

*/

CREATE VIEW PatientAdmissionOverview AS
SELECT 
    p.patientID,                                -- Unique identifier for the patient
    p.patient_name,                            -- Name of the patient
    p.address,                                 -- Address of the patient
    p.contact_info,                            -- Contact information of the patient
    p.birthdate,                               -- Birthdate of the patient
    p.sexe,                                    -- Gender of the patient
    a.admissionID,                             -- Unique identifier for the admission
    a.admission_date,                          -- Date of admission
    a.ward,                                    -- Ward where the patient was admitted
    d.dischargeID,                             -- Unique identifier for the discharge
    d.discharge_date,                          -- Date of discharge
    d.followup_date,                           -- Date for follow-up (if applicable)
    mr.recordID,                               -- Unique identifier for the medical record
    mr.event_record,                           -- Record of medical events
    mr.treatment,                              -- Treatment details
    pay.paymentID,                             -- Unique identifier for the payment
    pay.type AS payment_type,                  -- Type of payment (e.g., insurance, self-pay)
    pay.amount AS payment_amount,              -- Amount of payment
    i.insuranceID,                             -- Unique identifier for the insurance
    i.coverage_startdate,                      -- Start date of insurance coverage
    i.coverage_enddate,                        -- End date of insurance coverage
    i.insurance_name                           -- Name of the insurance provider

FROM 
    Patient p
LEFT JOIN Admission a ON p.patientID = a.patientID                     -- Left join with Admission to include admission details for each patient
LEFT JOIN Admission_Discharge ad ON a.admissionID = ad.admissionID     -- Left join with Admission_Discharge to connect admissions with discharges and medical records
LEFT JOIN Discharge d ON ad.dischargeID = d.dischargeID                -- Left join with Discharge to include discharge details
LEFT JOIN Medical_Record mr ON ad.recordID = mr.recordID                -- Left join with Medical_Record to include medical record information
LEFT JOIN Payment pay ON p.patientID = pay.patientID                    -- Left join with Payment to include payment details related to the patient
LEFT JOIN Insured_Patients ip ON p.patientID = ip.patientID AND pay.paymentID = ip.paymentID  -- Left join with Insured_Patients to connect patients and payments with insurance information
LEFT JOIN Insurance i ON ip.insuranceID = i.insuranceID                -- Left join with Insurance to include insurance coverage details

------------------------------------------------------------------------------------------------------------------------------------------------

/*
Description:
This query retrieves recent patient admission details from the PatientAdmissionOverview view.
It provides insights into the length of stay, payment, insurance information, and the current status of each patient.
The query focuses on admissions within the last 3 months and presents the results sorted by the most recent admissions.

Key Functions:
- Calculates the length of stay using the DATEDIFF function.
- Determines the patient's status with a CASE statement based on discharge and follow-up dates.
- Filters records to include only those with admissions in the last 3 months.
- Orders the results by admission date in descending order.

*/

SELECT 
    patient_name,                                 -- Name of the patient
    admission_date,                              -- Date of admission
    discharge_date,                             -- Date of discharge (may be NULL if currently admitted)
    DATEDIFF(day, admission_date, discharge_date) AS length_of_stay,  -- Length of stay in days
    payment_amount,                             -- Amount of payment made
    insurance_name,                            -- Name of the insurance provider
    CASE 
        WHEN discharge_date IS NULL THEN 'Currently Admitted'  -- Status for patients who are still admitted
        WHEN followup_date IS NOT NULL THEN 'Follow-up Scheduled'  -- Status for patients with a follow-up date
        ELSE 'Discharged'                        -- Status for patients who have been discharged
    END AS patient_status

FROM 
    PatientAdmissionOverview                    -- View providing comprehensive details about patient admissions

WHERE 
    admission_date >= DATEADD(month, -3, GETDATE())  -- Filters to include only admissions in the last 3 months

ORDER BY 
    admission_date DESC;                       -- Orders results by admission date, with the most recent first
-------------------------------------------------------------------------------------------------------------------------------------------------
