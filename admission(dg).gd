
[General]
Version=1

[Preferences]
Username=
Password=2976
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ARIEL
Name=ADMISSION
Count=20

[Record]
Name=ADMISSION_DATE
Type=DATE
Size=
Data=Random('01.01.2023, 30.6.2024')
Master=

[Record]
Name=ADMISSIONID
Type=NUMBER
Size=
Data=[1111]
Master=

[Record]
Name=WARD
Type=VARCHAR2
Size=50
Data=List('Emergency', 'ICU', 'Surgery', 'Pediatrics', 'Cardiology', 'Maternity')
Master=

[Record]
Name=DOCTORID
Type=NUMBER
Size=
Data=[111]
Master=

[Record]
Name=PATIENTID
Type=NUMBER
Size=
Data=list(select patientID from PATIENT)
Master=

[Record]
Name=RECORDID
Type=NUMBER
Size=
Data=list(select recordID from MEDICAL_RECORD)
Master=

