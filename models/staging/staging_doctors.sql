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
    DateofAdmission,
    DischargeDate
from {{ ref('changes_patient_data') }}