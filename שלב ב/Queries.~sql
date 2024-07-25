

/*----------------------------------------------SELECTS----------------------------------------------------*/

--שאילתת Select כדי לקבל פרטי אשפוז יחד עם פרטי שחרור מתאימים:


SELECT 
    A.admissionID, 
    A.admission_date, 
    D.dischargeDate, 
    P.name,
    EXTRACT(YEAR FROM A.admission_date) AS admission_year,
    EXTRACT(MONTH FROM A.admission_date) AS admission_month,
    EXTRACT(DAY FROM A.admission_date) AS admission_day,
    EXTRACT(YEAR FROM D.dischargeDate) AS discharge_year,
    EXTRACT(MONTH FROM D.dischargeDate) AS discharge_month,
    EXTRACT(DAY FROM D.dischargeDate) AS discharge_day
FROM 
    Admission A
JOIN 
    Admission_Discharge AD ON A.admissionID = AD.admissionID
JOIN 
    Discharge D ON AD.dischargeID = D.dischargeID
JOIN 
    Patient P ON A.patientID = P.patientID
ORDER BY 
    A.admission_date;




--שאילתת Select כדי לקבל את הסכום הכולל ששולם על ידי כל מטופל יחד עם תאריכי האשפוז והשחרור:

SELECT 
    P.name, 
    SUM(Pay.amount) AS total_amount, 
    A.admission_date, 
    D.dischargeDate,
    EXTRACT(YEAR FROM A.admission_date) AS admission_year,
    EXTRACT(MONTH FROM A.admission_date) AS admission_month,
    EXTRACT(DAY FROM A.admission_date) AS admission_day,
    EXTRACT(YEAR FROM D.dischargeDate) AS discharge_year,
    EXTRACT(MONTH FROM D.dischargeDate) AS discharge_month,
    EXTRACT(DAY FROM D.dischargeDate) AS discharge_day
FROM 
    Patient P
JOIN 
    Admission A ON P.patientID = A.patientID
JOIN 
    Admission_Discharge AD ON A.admissionID = AD.admissionID
JOIN 
    Discharge D ON AD.dischargeID = D.dischargeID
JOIN 
    Payment Pay ON D.dischargeID = Pay.dischargeID
GROUP BY 
    P.name, A.admission_date, D.dischargeDate
ORDER BY 
    P.name, A.admission_date, D.dischargeDate;



--תציין את מספר האשפוזים בכל מחלקה לפי חודש ושנה


SELECT 
    A.ward, 
    COUNT(A.admissionID) AS admission_count, 
    EXTRACT(YEAR FROM A.admission_date) AS admission_year,
    EXTRACT(MONTH FROM A.admission_date) AS admission_month
FROM 
    Admission A
GROUP BY 
    A.ward, 
    EXTRACT(YEAR FROM A.admission_date),
    EXTRACT(MONTH FROM A.admission_date)
ORDER BY 
    A.ward, 
    EXTRACT(YEAR FROM A.admission_date),
    EXTRACT(MONTH FROM A.admission_date);



--שאילתת Select כדי לקבל פרטי מטופלים שאושפזו ושוחררו באותו החודש:


SELECT 
    P.name, 
    EXTRACT(YEAR FROM A.admission_date) AS admission_year,
    EXTRACT(MONTH FROM A.admission_date) AS admission_month,
    EXTRACT(DAY FROM A.admission_date) AS admission_day,
    EXTRACT(YEAR FROM D.dischargeDate) AS discharge_year,
    EXTRACT(MONTH FROM D.dischargeDate) AS discharge_month,
    EXTRACT(DAY FROM D.dischargeDate) AS discharge_day
FROM 
    Patient P
JOIN 
    Admission A ON P.patientID = A.patientID
JOIN 
    Admission_Discharge AD ON A.admissionID = AD.admissionID
JOIN 
    Discharge D ON AD.dischargeID = D.dischargeID
WHERE 
    EXTRACT(MONTH FROM A.admission_date) = EXTRACT(MONTH FROM D.dischargeDate)
ORDER BY 
    P.name;



/*----------------------------------------------UPDATE----------------------------------------------------*/

--שאילתת Update לשינוי מחלקה ורופא עבור אשפוז של מטופל מסוים:


UPDATE Admission A
SET A.ward = 'Emergency', A.doctorID = 555
WHERE A.admissionID IN (
  SELECT AD.admissionID
  FROM Admission_Discharge AD
  JOIN Admission A2 ON AD.admissionID = A2.admissionID
  JOIN Patient P ON A2.patientID = P.patientID
  WHERE P.name = 'Allison'
);


--שאילתת Update לשינוי תאריך השחרור עבור אשפוז מסוים:

UPDATE Discharge D
SET D.dischargeDate = DATE '2026-1-15'
WHERE D.dischargeID = (
  SELECT AD.dischargeID
  FROM Admission_Discharge AD
  JOIN Admission A ON AD.admissionID = A.admissionID
  WHERE A.admissionID = 1001
);

/*----------------------------------------------DELETE----------------------------------------------------*/

--שאילתת Delete לרשומות מ-Admission_Discharge לאשפוזים בתאריך מסוים:

 
-- מחיקת רשומות בטבלת Admission_Discharge עבור תאריך מסוים
DELETE FROM Admission_Discharge
WHERE admissionID IN (
  SELECT admissionID
  FROM Admission
  WHERE admission_date = DATE '2023-01-12'
);

-- מחיקת רשומות בטבלת Admission עבור תאריך מסוים
DELETE FROM Admission
WHERE admission_date = DATE '2023-01-12';


--שאילתת Delete לאשפוזים ושחרורים מתאימים עבור מטופל מסוים:

DELETE FROM Admission_Discharge
WHERE admissionID IN (
  SELECT A.admissionID
  FROM Admission A
  JOIN Patient P ON A.patientID = P.patientID
  WHERE P.name = 'Blair'
);

DELETE FROM Admission
WHERE admissionID IN (
  SELECT A.admissionID
  FROM Admission A
  JOIN Patient P ON A.patientID = P.patientID
  WHERE P.name = 'Blair'
);

DELETE FROM Patient p
  WHERE P.name = 'Blair';





