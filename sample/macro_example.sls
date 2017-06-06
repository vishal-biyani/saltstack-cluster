### Macro File
{%- macro test_macro(region, role) -%}
    {{ salt['pillar.get']('base:{0}:{1}'.format(region, role), '127.0.0.1') }}
{%- endmacro -%}


## Import in another SLS:
{% from 'macro_example.sls' import test_micro with context %}
