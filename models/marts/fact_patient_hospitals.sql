{{
  config(
    materialized = 'view',
    schema = var('mart_schema'), 
  )
}}

select 
    staging_p.Patient_ID,
    staging_d.Doctor_ID,	
    changes_pd.BILLING_AMOUNT,	
    changes_pd.ROOM_NUMBER
from {{ ref('changes_patient_data') }} as changes_pd
join {{ ref('staging_patients') }} as staging_p
    on changes_pd.Patient_ID = staging_p.Patient_ID
join {{ ref('staging_doctors') }} as staging_d
    on changes_pd.Doctor_ID = staging_d.Doctor_ID