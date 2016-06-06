Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "TIMETABLE_HOURS_DIVERGENCE"
create or replace view TIMETABLE_HOURS_DIVERGENCE as
select timetable_id, emp_id, post_id, wage_rate, day_date, max(prs_hours_type_id) prs_hours_type_id,
       max(prs_hours_amount) prs_hours_amount, max(table_hours_type_id) table_hours_type_id, max(table_hours_amount) table_hours_amount
from (
  select timetable_id, emp_id, post_id, wage_rate, day_date,
         hours_type_id prs_hours_type_id, hours_amount prs_hours_amount, null table_hours_type_id, null table_hours_amount
    from (
    select t.id timetable_id, d.persrn emp_id, d.psdeprn post_id, dh.rateacc wage_rate, dd.workdate day_date,
           ddh.hourstype hours_type_id, ddh.workedhours hours_amount
      from prs_duties_days dd, prs_duties d, prs_duties_hist dh, timetables_tbl t, prs_duties_hours ddh
     where dd.prn = d.rn
       and dh.prn = d.rn
       and ddh.prn = dd.rn
       and d.company = t.company_id
       and d.deptrn = t.dept_id
       and d.begeng <= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
       and (d.endeng is null or d.endeng >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dh.do_act_from <= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
       and (dh.do_act_to is null or dh.do_act_to >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dd.workdate between to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
                           and last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       minus
       select t.id timetable_id, ts.emp_id, ts.post_id, ts.wage_rate, tsh.day_date, tsh.hours_type_id, tsh.hours_amount
       from timetables_tbl t, timetables_specs_tbl ts, timetables_specs_hours_tbl tsh
       where ts.id = tsh.timetable_spec_id
       and t.id = ts.timetable_id
    )
  union
  select timetable_id, emp_id, post_id, wage_rate, day_date,
         null prs_hours_type_id, null prs_hours_amount, hours_type_id table_day_type_id, hours_amount table_hours_amount
    from (
    select t.id timetable_id, ts.emp_id, ts.post_id, ts.wage_rate, tsh.day_date, tsh.hours_type_id, tsh.hours_amount
      from timetables_tbl t, timetables_specs_tbl ts, timetables_specs_hours_tbl tsh
     where ts.id = tsh.timetable_spec_id
       and t.id = ts.timetable_id
    minus
    select t.id timetable_id, d.persrn emp_id, d.psdeprn post_id, dh.rateacc wage_rate, dd.workdate day_date,
           ddh.hourstype hours_type_id, ddh.workedhours hours_amount
      from prs_duties_days dd, prs_duties d, prs_duties_hist dh, timetables_tbl t, prs_duties_hours ddh
     where dd.prn = d.rn
       and dh.prn = d.rn
       and ddh.prn = dd.rn
       and d.company = t.company_id
       and d.deptrn = t.dept_id
       and d.begeng <= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
       and (d.endeng is null or d.endeng >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dh.do_act_from <= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
       and (dh.do_act_to is null or dh.do_act_to >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dd.workdate between to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
                           and last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
    )
  )
 group by timetable_id, emp_id, post_id, wage_rate, day_date
;
