Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      ALL_HOLIDAYS_SCHEDULES
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "ALL_HOLIDAYS_SCHEDULES"
create or replace view ALL_HOLIDAYS_SCHEDULES as
select
  hs.id             as id
 ,hs.company_id     as company_id
 ,hs.dept_id        as dept_id
 ,d.name            as dept_name
 ,hs.schedule_year  as schedule_year
  from holidays_schedules_tbl hs, departments_tbl d
 where hs.dept_id = d.id
;
