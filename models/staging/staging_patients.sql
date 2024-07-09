{{
  config(
    materialized = 'view',
    schema = var('staging_schema'), 
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
    TEST_RESULTS
from {{ ref('changes_patient_data') }}