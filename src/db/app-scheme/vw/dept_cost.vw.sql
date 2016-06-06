Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      DEPT_COST
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "DEPT_COST"
create or replace view DEPT_COST as
select
     from_date
    ,last_day(from_date) as to_date
    ,table_year
    ,table_month
    ,dept_id
    ,hours_total
    ,prs_duty_hist_id
  from (
        select to_date('01'||trim(to_char(t.table_month,'00'))||trim(to_char(t.table_year,'0000')),'ddmmyyyy') as from_date
              ,t.table_year  as table_year
              ,t.table_month as table_month
              ,t.dept_id  as dept_id
              ,sum(pkg_rpt_timetables.timetable_spec_hours_totals(ts.id)) as hours_total
              ,ts.prs_duty_hist_id as prs_duty_hist_id
          from timetables_tbl t, timetables_specs_tbl ts
         where ts.timetable_id = t.id
           and t.table_type = 0
         group by t.table_year, t.table_month, t.dept_id, ts.prs_duty_hist_id
       )
;
