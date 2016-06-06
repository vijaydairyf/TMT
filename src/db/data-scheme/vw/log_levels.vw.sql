Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "LOG_LEVELS"
create or replace view LOG_LEVELS as
select lvl_no, lvl_name from (
  select 10 as lvl_no, 'OFF' as lvl_name from dual
  union all select 20 as lvl_no, 'FATAL' as lvl_name from dual
  union all select 30 as lvl_no, 'ERROR' as lvl_name from dual
  union all select 40 as lvl_no, 'WARNING' as lvl_name from dual
  union all select 50 as lvl_no, 'INFORMATION' as lvl_name from dual
  union all select 60 as lvl_no, 'DEBUG' as lvl_name from dual
  union all select 70 as lvl_no, 'ALL' as lvl_name from dual
 )
;
