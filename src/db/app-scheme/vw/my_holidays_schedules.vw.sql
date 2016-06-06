Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      MY_HOLIDAYS_SCHEDULES
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "MY_HOLIDAYS_SCHEDULES"
create or replace view MY_HOLIDAYS_SCHEDULES as
select
  hs.id             as id
 ,hs.company_id     as company_id
 ,hs.dept_id        as dept_id
 ,d.name            as dept_name
 ,hs.schedule_year  as schedule_year
  from holidays_schedules_tbl hs, departments_tbl d
 where hs.dept_id = d.id
   and (hs.company_id, hs.dept_id) in (select company_id, dept_id from users_depts ud where ud.username = V('APP_USER'))
;
