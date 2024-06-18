-- Create Discharge table
CREATE TABLE Discharge
(
  dischargeID INT NOT NULL,
  discharge_doctorID INT NOT NULL,
  dischargeDate DATE NOT NULL,
  PRIMARY KEY (dischargeID)
);

-- Create Payment table
CREATE TABLE Payment
(
  pay_Type VARCHAR2(20) NOT NULL,
  amount INT NOT NULL,
  paymentID INT NOT NULL,
  dischargeID INT NOT NULL,
  PRIMARY KEY (paymentID),
  FOREIGN KEY (dischargeID) REFERENCES Discharge(dischargeID)
);

-- Create Medical_Record table
CREATE TABLE Medical_Record
(
  recordID INT NOT NULL,
  treatment VARCHAR2(255) NOT NULL,
  event_record VARCHAR2(255) NOT NULL,
  dischargeID INT NOT NULL,
  PRIMARY KEY (recordID),
  FOREIGN KEY (dischargeID) REFERENCES Discharge(dischargeID)
);

-- Create Insurance table
CREATE TABLE Insurance
(
  insuranceID INT NOT NULL,
  insurance_name VARCHAR2(255) NOT NULL,
  coverage_startdate DATE NOT NULL,
  coverage_enddate DATE NOT NULL,
  paymentID INT,
  PRIMARY KEY (insuranceID),
  FOREIGN KEY (paymentID) REFERENCES Payment(paymentID)
);

-- Create Patient table
CREATE TABLE Patient
(
  name VARCHAR2(255) NOT NULL,
  address VARCHAR2(255) NOT NULL,
  contact_info VARCHAR2(255) NOT NULL,
  patientID INT NOT NULL,
  insuranceID INT,
  birthdate DATE NOT NULL,
  paymentID INT,
  PRIMARY KEY (patientID),
  FOREIGN KEY (insuranceID) REFERENCES Insurance(insuranceID),
  FOREIGN KEY (paymentID) REFERENCES Payment(paymentID)
);

-- Create Admission table
CREATE TABLE Admission
(
  admission_date DATE NOT NULL,
  admissionID INT NOT NULL,
  ward VARCHAR2(50) NOT NULL,
  doctorID INT NOT NULL,
  patientID INT NOT NULL,
  recordID INT NOT NULL,
  PRIMARY KEY (admissionID),
  FOREIGN KEY (patientID) REFERENCES Patient(patientID),
  FOREIGN KEY (recordID) REFERENCES Medical_Record(recordID)
);

