
[General]
Version=1

[Preferences]
Username=
Password=2181
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ARIEL
Name=DISCHARGE
Count=500

[Record]
Name=DISCHARGEID
Type=NUMBER
Size=
Data=Sequence(1000, [1], [9999) 
Master=

[Record]
Name=DISCHARGE_DOCTORID
Type=NUMBER
Size=
Data=Sequence(100, [1], [999) 
Master=

[Record]
Name=DISCHARGEDATE
Type=DATE
Size=
Data=Random('01.01.2023, 31.6.2024')
Master=

