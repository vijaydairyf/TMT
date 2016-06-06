Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      ABSENT_EMP_IN_REGISTER_T
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "ABSENT_EMP_IN_REGISTER_T"
create or replace view ABSENT_EMP_IN_REGISTER_T as
select
       m.id        as register_id
      ,ts.emp_id   as emp_id
      ,ts.emp_name as emp_name
  from milk_dept_register_tbl m, timetables_tbl t, timetables_specs ts, duties_hist_tbl dh, duties_tbl d, duties_types_tbl dt
 where m.dept_id = t.dept_id
   and m.register_year = t.table_year
   and m.register_month = t.table_month
   and t.id = ts.timetable_id
   and ts.prs_duty_hist_id = dh.id
   and dh.duty_id = d.id
   and d.duty_type_id = dt.id
   and dt.is_primary = 1
   and t.table_type = 0
minus
select
       m.id as register_id
      ,ms.emp_id  as emp_id
      ,ms.emp_name  as emp_name
  from milk_specs ms, milk_dept_register_tbl m
 where ms.register_id = m.id
;
