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
    BloodType,	
    MedicalCondition,
    InsuranceProvider,
    AdmissionType,	
    Medication,	
    TestResults,	
    Doctor_ID,	
    Doctor,	
    Hospital,	
    BillingAmount,	
    RoomNumber,
    DateofAdmission,
    DischargeDate
from {{ source('source_patient_data', 'PATIENT_DIAGNOSIS') }}