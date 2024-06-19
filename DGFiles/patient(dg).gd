
[General]
Version=1

[Preferences]
Username=
Password=2564
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ARIEL
Name=PATIENT
Count=500

[Record]
Name=NAME
Type=VARCHAR2
Size=255
Data=FirstName
Master=

[Record]
Name=ADDRESS
Type=VARCHAR2
Size=255
Data=Address1
Master=

[Record]
Name=CONTACT_INFO
Type=VARCHAR2
Size=255
Data=Email
Master=

[Record]
Name=PATIENTID
Type=NUMBER
Size=
Data=Sequence(1000, [1], [9999) 
Master=

[Record]
Name=INSURANCEID
Type=NUMBER
Size=
Data=list(select insuranceID from Insurance)
Master=

[Record]
Name=BIRTHDATE
Type=DATE
Size=
Data=Random('01.01.1960, 31.1.2024')
Master=

[Record]
Name=PAYMENTID
Type=NUMBER
Size=
Data=list(select paymentID from Payment)
Master=

