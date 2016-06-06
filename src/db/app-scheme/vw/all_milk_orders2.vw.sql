Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      ALL_MILK_ORDERS2
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "ALL_MILK_ORDERS2"
create or replace view ALL_MILK_ORDERS2 as
select
  id                     as id
 ,updated                as updated
 ,updater                as updater
 ,dept_id                as dept_id
 ,dept_name              as dept_name
 ,register_year          as register_year
 ,register_month         as register_month
 ,register_month_name    as register_month_name
 ,register_status        as register_status
 ,register_status_name   as register_status_name
 ,register_timemark      as register_timemark
 ,emp_count              as emp_count
 ,work_off               as work_off
 ,milk_cost_norm         as milk_cost_norm
 ,(work_off * nvl(milk_cost_norm,0)) as charge
  from (
 select
  m.id          as id
 ,m.updated     as updated
 ,m.updater     as updater
 ,m.dept_id     as dept_id
 ,d.name        as dept_name
 ,m.register_year     as register_year
 ,m.register_month    as register_month
 ,utils.month_name(m.register_month)  as register_month_name
 ,m.register_status   as register_status
 ,c.value_name        as register_status_name
 ,m.register_timemark as register_timemark
 ,(select count(*) from milk_dept_specs2_tbl where dpt_register_id = m.id) as emp_count
 ,(select sum(work_off) from milk_dept_specs2_tbl where dpt_register_id = m.id) as work_off
 ,(nvl(mc.cost_value,0) / 2) as milk_cost_norm
from milk_dept_register2_tbl m, departments_tbl d, collections_tbl c, milk_cost2_tbl mc
where m.dept_id = d.id
  and m.register_status = c.value_no
  and m.year_month = mc.year_month(+)
  and c.category = 'MILK-REGISTER-STATUS'
)
;
