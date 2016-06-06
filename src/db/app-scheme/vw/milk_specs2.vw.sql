Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      MILK_SPECS2
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "MILK_SPECS2"
create or replace view MILK_SPECS2 as
select
  ms.id               as id
 ,ms.updated          as updated
 ,ms.updater          as updater
 ,ms.dpt_register_id  as register_id
 ,ms.emp_id           as emp_id
 ,e.name              as emp_name
 ,ms.emp_post_id      as emp_post_id
 ,p.name              as emp_post_name
 ,ms.work_off         as work_off
 ,(nvl(mc.cost_value,0) / 2)               as norm
 ,round((ms.work_off * nvl(mc.cost_value,0) / 2),2) as charge
 from milk_dept_specs2_tbl ms, employees_tbl e, posts_tbl p, milk_cost2_tbl mc
 where ms.emp_id = e.id
   and ms.emp_post_id = p.id
   and ms.year_month = mc.year_month(+)
;
