Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "DUTIES_TYPES_TBL"
create or replace view DUTIES_TYPES_TBL as
select
  t.rn    as id
 ,t.code  as code
 ,t.name  as name
 ,t.is_primary  as is_primary
  from prs_duties_types t
;
