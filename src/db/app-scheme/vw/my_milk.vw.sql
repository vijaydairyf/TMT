Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      MY_MILK
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "MY_MILK"
create or replace view MY_MILK as
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
 ,m.received          as received
 ,(select count(*) from milk_dept_specs_tbl where dpt_register_id = m.id)       as emp_count
 ,(select sum(work_off) from milk_dept_specs_tbl where dpt_register_id = m.id)  as work_off
 ,(select sum(earned) from milk_specs where register_id = m.id)                 as earned
 ,(select sum(debt) from milk_specs where register_id = m.id)                   as debt
 ,(select sum(on_order) from milk_dept_specs_tbl where dpt_register_id = m.id)  as on_order
 ,(select sum(received) from milk_dept_specs_tbl where dpt_register_id = m.id)  as given_out
from milk_dept_register_tbl m, departments_tbl d, collections_tbl c
where m.dept_id = d.id
  and m.register_status = c.value_no
  and c.category = 'MILK-REGISTER-STATUS'
  and m.dept_id in (select dept_id from users_depts ud where ud.username = V('APP_USER'))
;
