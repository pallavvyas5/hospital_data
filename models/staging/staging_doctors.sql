{{
  config(
    materialized = 'view',
    schema = var('staging_schema'), 
  )
}}

select 
    Doctor_ID,
    Doctor
from {{ ref('changes_patient_data') }}
group by 1, 2