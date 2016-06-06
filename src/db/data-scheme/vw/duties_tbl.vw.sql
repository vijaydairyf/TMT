Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "DUTIES_TBL"
create or replace view DUTIES_TBL as
select
  t.rn             as id
 ,t.clnpspfmtypes  as duty_type_id
 ,t.persrn         as emp_id
 ,t.deptrn         as dept_id
  from prs_duties t
;
