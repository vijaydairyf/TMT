Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "DAYS_TYPES_TBL"
create or replace view DAYS_TYPES_TBL as
select
  dt.rn         as id
 ,dt.code       as code
 ,dt.name       as name
 ,absence_sign  as absence
  from prs_days_types dt
;
