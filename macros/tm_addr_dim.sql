{{
    config(
        materialized='incremental',
        unique_key = ['ADDR_KEY'],
        incremental_strategy='merge',
        full_refresh = false,
        schema = var('tm_schema')
    )
}}

with incoming_data as(
    select *
    from {{ ref('tm_stage_addr_dim') }}
),

{% if is_incremental() %}
    updates AS (

        SELECT
            staging.ADDR_KEY,
            staging.CITY,
            staging.PROVINCE,
            staging.POSTAL_CD,
            staging.COUNTRY,
            staging.TZ_OFFSET_HRS,
            staging.is_deleted,
            dimension.ADD_DATE_DW,
            current_timestamp() as UPDATE_DATE_DW
        FROM incoming_data as staging
        left join {{ this }} as dimension
        on staging.ADDR_KEY = dimension.ADDR_KEY
        where dimension.ADDR_KEY is not null
    ),
{% endif %}

inserts AS (

    SELECT
        ADDR_KEY,
        CITY,
        PROVINCE,
        POSTAL_CD,
        COUNTRY,
        TZ_OFFSET_HRS,
        is_deleted,
        current_timestamp() as ADD_DATE_DW,
        current_timestamp() as UPDATE_DATE_DW
    FROM incoming_data

    {% if is_incremental() %}
        WHERE ADDR_KEY NOT IN (SELECT ADDR_KEY FROM {{ this }})
    {% endif %}
)

{% if is_incremental() %}
    select * from updates 
    union
{% endif %}

select * from inserts

{% if not is_incremental() %}
    union 

    select 
        sha1('UNASSIGNED') as ADDR_KEY,
        'UNASSIGNED' as CITY,
        NULL as PROVINCE,
        NULL as POSTAL_CD,
        NULL as COUNTRY,
        NULL as TZ_OFFSET_HRS,
        NULL as is_deleted,
        current_timestamp() as ADD_DATE_DW,
        current_timestamp() as UPDATE_DATE_DW

    union 
    
    select
        sha1('NOT FOUND') as ADDR_KEY,
        'NOT FOUND' as CITY,
        NULL as PROVINCE,
        NULL as POSTAL_CD,
        NULL as COUNTRY,
        NULL as TZ_OFFSET_HRS,
        NULL as is_deleted,
        current_timestamp() as ADD_DATE_DW,
        current_timestamp() as UPDATE_DATE_DW
{% endif %}   