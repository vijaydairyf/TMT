Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem       Все табели.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "ALL_TIMETABLES"
create or replace view ALL_TIMETABLES as
select
     t.id           as id
    ,t.updated      as updated
    ,t.updater      as updater
    ,t.company_id   as company_id
    ,t.dept_id      as dept_id
    ,(select name from departments_tbl where id = t.dept_id)  as dept_name
    ,t.table_year   as table_year
    ,t.table_month  as table_month
    ,utils.month_name(t.table_month)  as table_month_name
    ,t.submitted    as submitted
    ,t.accepted     as accepted
  from timetables_tbl t
 where t.company_id in (select company_id from users where username = V('APP_USER'))
;
