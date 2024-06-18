
[General]
Version=1

[Preferences]
Username=
Password=2027
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ARIEL
Name=INSURANCE
Count=500

[Record]
Name=INSURANCEID
Type=NUMBER
Size=
Data=Sequence(100, [1], [999) 
Master=

[Record]
Name=INSURANCE_NAME
Type=VARCHAR2
Size=255
Data=List(Pheonix, Har'el, Migdal, Clal, Bituach Yashir)
Master=

[Record]
Name=COVERAGE_STARTDATE
Type=DATE
Size=
Data=Random('01.01.2020, 31.1.2022')
Master=

[Record]
Name=COVERAGE_ENDDATE
Type=DATE
Size=
Data=Random('01.01.2024, 31.1.2026')
Master=

[Record]
Name=PAYMENTID
Type=NUMBER
Size=
Data=List(select paymentID from PAYMENT)
Master=

