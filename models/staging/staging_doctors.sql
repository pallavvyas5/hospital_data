{{
  config(
    materialized = 'view',
    schema = var('staging_schema'), 
  )
}}

select 
    Doctor_ID,	
    Doctor,	
    Hospital,	
    DATEOF_ADMISSION,
    DISCHARGE_DATE
from {{ ref('changes_patient_data') }}