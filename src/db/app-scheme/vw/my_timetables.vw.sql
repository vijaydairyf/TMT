Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Табели Пользователя.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "MY_TIMETABLES"
create or replace view MY_TIMETABLES as
select
     t.id               as id
    ,t.updated          as updated
    ,t.updater          as updater
    ,t.company_id       as company_id
    ,t.dept_id          as dept_id
    ,d.name             as dept_name
    ,t.table_year       as table_year
    ,t.table_month      as table_month
    ,t.table_type       as table_type
    ,utils.month_name(t.table_month)  as table_month_name
    ,t.submitted        as submitted
    ,t.accepted         as accepted
    ,c.id               as corr_id
  from timetables_tbl t, departments_tbl d, timetables_tbl c
 where t.dept_id = d.id
   and t.table_type = 0
   and t.company_id = c.company_id(+)
   and t.dept_id = c.dept_id(+)
   and t.table_year = c.table_year(+)
   and t.table_month = c.table_month(+)
   and c.table_type(+) = 1
   and (t.company_id, t.dept_id) in (select company_id, dept_id from users_depts ud where ud.username = V('APP_USER'))
;
