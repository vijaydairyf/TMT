Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      MY_MILK2
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "MY_MILK2"
create or replace view MY_MILK2 as
select
  m.id                as id
 ,m.updated           as updated
 ,m.updater           as updater
 ,m.dept_id           as dept_id
 ,d.name              as dept_name
 ,m.register_year     as register_year
 ,m.register_month    as register_month
 ,utils.month_name(m.register_month)  as register_month_name
 ,m.register_status   as register_status
 ,c.value_name        as register_status_name
 ,m.register_timemark as register_timemark
 ,(select count(*) from milk_dept_specs2_tbl where dpt_register_id = m.id)       as emp_count
 ,(select sum(work_off) from milk_dept_specs2_tbl where dpt_register_id = m.id)  as work_off
from milk_dept_register2_tbl m, departments_tbl d, collections_tbl c
where m.dept_id = d.id
  and m.register_status = c.value_no
  and c.category = 'MILK-REGISTER-STATUS'
  and m.dept_id in (select dept_id from users_depts ud where ud.username = V('APP_USER'))
;
