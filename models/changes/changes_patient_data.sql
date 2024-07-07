{{
  config(
    materialized = 'view',
    schema = var('changes_schema'), --this will combine with schema mention in profiles section and craete a schema in database mentioned in profile section
  )
}}

select 
    NAME,
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