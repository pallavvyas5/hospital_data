{{
  config(
    materialized = 'view',
    schema = var('staging_schema'), 
  )
}}

select 
    Hospital_ID,
    Hospital
from {{ ref('changes_patient_data') }}
group by 1, 2