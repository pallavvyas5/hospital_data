{{
  config(
    materialized = 'view',
    schema = var('mart_schema'), 
  )
}}

select 
    Patient_ID,
    Doctor_ID,	
    BILLING_AMOUNT,	
    ROOM_NUMBER
from {{ ref('changes_patient_data') }} 