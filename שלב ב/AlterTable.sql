CREATE TABLE Admission_Discharge (
    admissionID INT NOT NULL,
    dischargeID INT NOT NULL,
    PRIMARY KEY (admissionID, dischargeID),
    FOREIGN KEY (admissionID) REFERENCES Admission(admissionID),
    FOREIGN KEY (dischargeID) REFERENCES Discharge(dischargeID)
);

INSERT INTO Admission_Discharge (admissionID, dischargeID)
SELECT A.admissionID, D.dischargeID
FROM Admission A
JOIN Medical_Record MR ON A.recordID = MR.recordID
JOIN Discharge D ON MR.dischargeID = D.dischargeID;

