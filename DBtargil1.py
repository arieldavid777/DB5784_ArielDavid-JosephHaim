import random
from faker import Faker
import datetime

# Initialize Faker
fake = Faker()

# Initialize IDs
start_id = 1000

# Generate random date between two dates
def random_date(start, end):
    return start + datetime.timedelta(days=random.randint(0, (end - start).days))

# Define date range
start_date = datetime.date(2023, 1, 1)
end_date = datetime.date(2024, 6, 30)

# List of hospital wards
wards = [
    "General Medicine", "Surgery", "Pediatrics", "Orthopedics",
    "Cardiology", "Oncology", "Neurology", "Maternity",
    "Emergency", "ICU", "Psychiatry", "Dermatology"
]

# Generate 500 rows of data
rows = []

for i in range(500):
    admission_date = random_date(start_date, end_date)
    admissionID = start_id + i
    ward = random.choice(wards)
    doctorID = fake.random_int(min=100, max=999)
    patientID = start_id + (i % 500)
    recordID = start_id + (i % 500)
    
    rows.append((admission_date, admissionID, ward, doctorID, patientID, recordID))

# Print SQL insert statements
print("INSERT INTO Admission (admission_date, admissionID, ward, doctorID, patientID, recordID) VALUES")
for row in rows:
    print(f"('{row[0]}', {row[1]}, '{row[2]}', {row[3]}, {row[4]}, {row[5]}),")
print(";")
