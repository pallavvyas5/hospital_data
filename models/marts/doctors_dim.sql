{{
  config(
    materialized = 'view',
    schema = var('mart_schema'), 
  )
}}

select 
    Doctor_ID,
    Doctor
from {{ ref('changes_patient_data') }}
group by 1, 2