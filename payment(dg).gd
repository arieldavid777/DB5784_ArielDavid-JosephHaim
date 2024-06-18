
[General]
Version=1

[Preferences]
Username=
Password=2230
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ARIEL
Name=PAYMENT
Count=500

[Record]
Name=PAY_TYPE
Type=VARCHAR2
Size=20
Data=List('Cash', 'Credit','Check')
Master=

[Record]
Name=AMOUNT
Type=NUMBER
Size=
Data=Random(1000, 50000)
Master=

[Record]
Name=PAYMENTID
Type=NUMBER
Size=
Data=Sequence(1000, [1], [9999) 
Master=

[Record]
Name=DISCHARGEID
Type=NUMBER
Size=
Data=list(select dischargeID from Discharge)
Master=

