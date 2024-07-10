--this will combine with schema mention in profiles section and craete a schema in database mentioned in profile section
{{
  config(
    materialized = 'view',
    schema = var('changes_schema'), 
  )
}}

select 
    Patient_ID,
    Name,	
    Age,
    Gender,	
    BLOOD_TYPE,	
    MEDICAL_CONDITION,
    INSURANCE_PROVIDER,
    ADMISSION_TYPE,	
    Medication,	
    TEST_RESULTS,	
    Doctor_ID,	
    Doctor,	
    Hospital_ID
    Hospital,	
    BILLING_AMOUNT,	
    ROOM_NUMBER,
    DATEOF_ADMISSION,
    DISCHARGE_DATE
from {{ source('source_patient_data', 'PATIENT_DIAGNOSIS') }}