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
    BloodType,	
    MedicalCondition,
    InsuranceProvider,
    AdmissionType,	
    Medication,	
    TestResults
from {{ ref('changes_patient_data') }}