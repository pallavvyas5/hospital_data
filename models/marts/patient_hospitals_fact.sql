{{
  config(
    materialized = 'view',
    schema = var('mart_schema'), 
  )
}}

select 
    Patient_ID,
    Doctor_ID,
    Hospital_ID,
    Billing_Amount,
    Room_Number
from {{ ref('changes_patient_data') }} 