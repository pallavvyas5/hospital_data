--this will combine with schema mention in profiles section and craete a schema in database mentioned in profile section
{{
  config(
    materialized = 'view',
    schema = var('changes_schema'), 
  )
}}

select 
    AGE,
    GENDER,
    BLOODTYPE,
    MEDICALCONDITION,
    DATEOFADMISSION,
    DOCTOR,
    HOSPITAL,
    INSURANCEPROVIDER,
    BILLINGAMOUNT,
    ROOMNUMBER,
    ADMISSIONTYPE,
    DISCHARGEDATE,
    MEDICATION,
    TESTRESULTS
from {{ source('source_patient_data', 'PATIENT_DIAGNOSIS') }}