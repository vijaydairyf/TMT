Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "DEPARTMENTS_TBL"
create or replace view DEPARTMENTS_TBL as
select
  d.rn        as id
 ,d.company   as company_id
 ,d.code      as code
 ,d.name      as name
 ,d.agent     as resp_id
  from prs_departments d
;
