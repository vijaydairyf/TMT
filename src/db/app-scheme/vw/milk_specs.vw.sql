Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      MILK_SPECS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "MILK_SPECS"
create or replace view MILK_SPECS as
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
 ,ms.milk_norm        as milk_norm
 ,(ms.work_off * ms.milk_norm)  as earned
 ,nvl((select sum((work_off * milk_norm) - received)
    from milk_dept_specs_tbl t
   where t.emp_id = ms.emp_id
     and t.year_month < ms.year_month
  ),0)                as debt
 ,ms.on_order         as on_order
 ,ms.received         as received
 from milk_dept_specs_tbl ms, employees_tbl e, posts_tbl p
 where ms.emp_id = e.id
   and ms.emp_post_id = p.id
;
