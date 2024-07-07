{{
  config(
    materialized = 'view',
    schema = var('tm_stg_schema'),
  )
}}

-- Incoming Source Data
with incoming_data as(
    select
        trim(upper(CTY_NAME)) as CITY,
        trim(upper(STA_CD)) as PROVINCE,
        trim(PSTL_CD) as POSTAL_CD,
        trim(upper(CTRY_CD)) as COUNTRY,
        TM_ZN_OFST as TZ_OFFSET_HRS,
        is_deleted
    from {{ ref('tm_changes_addr_dim') }}
    where SOURCE_SCHEMA != 'DM_OWNER'
),

incoming_data_1 as (
  select  {{ sha1_hash(['CITY', 'PROVINCE','POSTAL_CD','COUNTRY','TZ_OFFSET_HRS']) }} as ADDR_KEY,
          CITY,
          PROVINCE,
          POSTAL_CD,
          COUNTRY,
          TZ_OFFSET_HRS,
          is_deleted
  from incoming_data
)

select * from incoming_data_1
