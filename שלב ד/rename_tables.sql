-- rename tables for integration:
rename Discharge to Discharge1;
rename Payment to Payment1;
rename Medical_Record to Medical_Record1;
rename Insurance to Insurance1;
rename Patient to Patient1;
rename Admission to Admission1;
rename Admission_Discharge to Admission_Discharge1;


SELECT COUNT(*) FROM PATIENT;-- (465)
SELECT COUNT(*) FROM PATIENT1; -- (499)

SELECT COUNT(*) FROM PATIENT P WHERE P.PATIENT_ID NOT IN (SELECT PATIENTID FROM PATIENT1);-- ALL THE PATIENTS (465) ARE DIFFERENT

--merge patient and patient1:

--preprocessing patient1:

ALTER TABLE Patient1
ADD sexe VARCHAR2(30) NULL;


ALTER TABLE Patient1
DROP CONSTRAINT insuranceID;
DROP CONSTRAINT paymentID;
ALTER TABLE Patient1 MODIFY address VARCHAR2(30) NULL;
ALTER TABLE Patient1 MODIFY contactInfo VARCHAR2(30) NULL;
ALTER TABLE Patient1 MODIFY birthDate VARCHAR2(30) NULL;

--inserting:
INSERT INTO Patient1 p(patientID, p.name, address, contactInfo, birthDate, sexe)
SELECT Patient_ID, patient_name, 'UNKNOWN', 'UNKNOWN', 'UNKNOWN',sexe
FROM Patient;


ALTER TABLE Patient1
DROP CONSTRAINT insuranceID;
DROP CONSTRAINT paymentID;
ALTER TABLE Patient1 MODIFY address VARCHAR2(30) NULL;
ALTER TABLE Patient1 MODIFY contactInfo VARCHAR2(30) NULL;
ALTER TABLE Patient1 MODIFY birthDate VARCHAR2(30) NULL;


--preprocessing Discharge1:
ALTER TABLE Discharge1 
DROP COLUMN discharge_doctorID;

ALTER TABLE Discharge1
ADD followup_date DATE NOT NULL;


UPDATE Discharge1
SET followup_date = dischargeDate + INTERVAL '7' DAY;







/*
CREATE TABLE Attending_doctor (
    doctor_id NUMBER NOT NULL,
    admissionID NUMBER NOT NULL,
    PRIMARY KEY (doctor_id, admissionID),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (admissionID) REFERENCES Admission(admissionID)
);
*/

/*
CREATE TABLE Insured_Patients (
    paymentID NUMBER NOT NULL,
    patientID NUMBER NOT NULL,
    insuranceID NUMBER NOT NULL,
    PRIMARY KEY (paymentID, patientID, insuranceID),
    FOREIGN KEY (paymentID) REFERENCES Payment(paymentID),
    FOREIGN KEY (patientID) REFERENCES Patient(patientID),
    FOREIGN KEY (insuranceID) REFERENCES Insurance(insuranceID)
);
*/


