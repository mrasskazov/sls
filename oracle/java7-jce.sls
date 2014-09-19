include:
  - oracle/java7

{% set JAVAHOME = '/usr/lib/jvm/java-7-oracle/jre' %}

local_policy.jar:
  file.managed:
    - name: {{ JAVAHOME }}/lib/security/local_policy.jar
    - source: salt://oracle/files/UnlimitedJCEPolicyJDK7/local_policy.jar

US_export_policy.jar:
  file.managed:
    - name: {{ JAVAHOME }}/lib/security/US_export_policy.jar
    - source: salt://oracle/files/UnlimitedJCEPolicyJDK7/US_export_policy.jar
