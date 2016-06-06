Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      RPT_TIMETABLES
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "RPT_TIMETABLES"
create or replace view RPT_TIMETABLES as
select
  t.id           as id
 ,t.updated      as updated
 ,t.updater      as updater
 ,t.company_id   as company_id
 ,(select name from companies_tbl where id = t.company_id)  as company_name
 ,t.dept_id      as dept_id
 ,(select code from departments_tbl where id = t.dept_id)   as dept_code
 ,(select name from departments_tbl where id = t.dept_id)   as dept_name
 ,t.table_year   as table_year
 ,t.table_month  as table_month
 ,t.table_type   as table_type
 ,to_char(last_day(to_date('01'||to_char(t.table_month,'fm00')||to_char(t.table_year,'fm0000'),'ddmmyyyy')),'dd') as lastday
 ,utils.month_name_gen(t.table_month)  as table_month_name
 ,utils.month_name(extract(month from add_months(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'),-1)))  as previous_month_name
from timetables_tbl t
;
