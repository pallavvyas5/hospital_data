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
    Blood_Type,
    Medical_Condition,
    Medication,
    Insurance_Provider,
    Dateof_Admission,
    ADMISSION_TYPE,
    TEST_RESULTS,
    Discharge_Date
from {{ ref('changes_patient_data') }}