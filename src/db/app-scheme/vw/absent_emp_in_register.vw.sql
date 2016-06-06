Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      ABSENT_EMP_IN_REGISTER
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "ABSENT_EMP_IN_REGISTER"
create or replace view ABSENT_EMP_IN_REGISTER as
select
       m.id        as register_id
      ,ts.emp_id   as emp_id
      ,e.name     as emp_name
  from milk_dept_register_tbl m, timetables_tbl t, timetables_specs_tbl ts, duties_hist_tbl dh, duties_tbl d, duties_types_tbl dt, employees_tbl e
 where m.dept_id = t.dept_id
   and m.register_year = t.table_year
   and m.register_month = t.table_month
   and t.id = ts.timetable_id
   and ts.prs_duty_hist_id = dh.id
   and dh.duty_id = d.id
   and d.duty_type_id = dt.id
   and t.table_type = 0
   and ts.emp_id = e.id
minus
select
       m.id       as register_id
      ,ms.emp_id  as emp_id
      ,e.name     as emp_name
  from milk_dept_specs_tbl ms, milk_dept_register_tbl m, employees_tbl e
 where ms.dpt_register_id = m.id
   and ms.emp_id = e.id
;
