-- input a list of columns
--
-- Logic:
-- cast values to strings; coalesce with 'null_string'; concat together with '-' separator
-- apply sha1() hash function to final concatenated string
-- if list is empty or has one null item, then return sha1('null_string')
--
-- Usage:
-- select sha1_hash(['FIELD_A','FILED_B']) as field_alias
-- 
-- Null/Empty string list will result in same sha:
-- sha1_hash() == sha1_hash(null) == sha1_hash([null])
{% macro sha1_hash(columns) -%}

    {%- set null_replacement = 'null_string' -%}

    {%- if columns|length == 0 or columns == [null] -%}

        sha1('{{ null_replacement }}')

    {%- else -%}

        sha1(
            coalesce(
                concat(
                    {%- for column in columns -%}
                        coalesce("{{ column }}"::string, '{{ null_replacement }}')
                        {%- if not loop.last %}, '-', {% endif -%}
                    {%- endfor -%}
                )
                , '{{ null_replacement }}'
            )
        )

    {%- endif -%}

{%- endmacro %}
