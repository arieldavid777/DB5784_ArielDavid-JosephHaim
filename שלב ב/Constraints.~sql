--This constraint ensures that the contact_info column in the Patient table cannot contain NULL values. 
ALTER TABLE Patient
MODIFY contact_info VARCHAR2(255) NOT NULL;
--problem it already has a not null value(all the tables have it).

--This constraint ensures that the "amount" column in the payment table must always
-- contain a value greater than 0.
ALTER TABLE Payment1
ADD CONSTRAINT chk_amount1 CHECK (amount >= 0);
/*
This constraint sets a DEFAULT constraint on this column to use SYSDATE(the current date and time),
when no value is explicitly provided.
*/
ALTER TABLE Admission
MODIFY admission_date DATE DEFAULT SYSDATE;
