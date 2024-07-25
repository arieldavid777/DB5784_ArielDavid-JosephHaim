-- select patient with a specific name.
SELECT * FROM Patient
WHERE name = 'John';

-- selects all patients admitted in the aloted time frame.
SELECT * FROM Admission
WHERE admission_date BETWEEN date '2024-01-01' AND date '2024-03-31';

-- selects a specific id from discharge table with priority to the listed id's.
SELECT * FROM Discharge
WHERE dischargeID IN (&<name="DischargeID List" list="1000, 1002, 1111, 1222, 1300">);

-- selects all patients with a certain birthday(given a hint).
CREATE INDEX patient_birthdate_idx ON Patient(birthdate);
SELECT /*+ INDEX(Patient patient_birthdate_idx) */ * FROM Patient
WHERE birthdate = date '2007-10-09';
