Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "SPEC_HOURS_DIVERGENCE"
create or replace view SPEC_HOURS_DIVERGENCE as
select spec_id, emp_id, post_id, wage_rate, day_date, prs_hours_type_id, table_hours_type_id
      ,sum(prs_hours_amount) as prs_hours_amount, sum(table_hours_amount) as table_hours_amount
  from (
  select spec_id, emp_id, post_id, wage_rate, day_date,
         hours_type_id as prs_hours_type_id, hours_amount as prs_hours_amount, null as table_hours_type_id, null as table_hours_amount
    from (
    select ts.id spec_id, d.persrn emp_id, d.psdeprn post_id, dh.rateacc wage_rate, dd.workdate day_date,
           ddh.hourstype as hours_type_id, ddh.workedhours as hours_amount
      from prs_duties_days dd, prs_duties d, prs_duties_hist dh, timetables_tbl t, timetables_specs_tbl ts, prs_duties_hours ddh
     where dd.prn = d.rn
       and dh.prn = d.rn
       and ddh.prn = dd.rn
       and ts.timetable_id = t.id
       and ts.emp_id = d.persrn
       and ts.wage_rate = dh.rateacc
       and ts.post_id = d.psdeprn
       and d.company = t.company_id
       and d.deptrn = t.dept_id
       and d.begeng <= last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and (d.endeng is null or d.endeng >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dh.do_act_from <= last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and (dh.do_act_to is null or dh.do_act_to >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dd.workdate between to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
                       and last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
    minus
    select ts.id spec_id, ts.emp_id, ts.post_id, ts.wage_rate, tsh.day_date, tsh.hours_type_id as hours_type_id, tsh.hours_amount as hours_amount
      from timetables_specs_tbl ts, timetables_specs_hours_tbl tsh
     where ts.id = tsh.timetable_spec_id
    )
  union
  select spec_id, emp_id, post_id, wage_rate, day_date,
         null as prs_hours_type_id, null as prs_hours_amount, hours_type_id as table_hours_type_id, hours_amount as table_hours_amount
    from (
    select ts.id spec_id, ts.emp_id, ts.post_id, ts.wage_rate, tsh.day_date, tsh.hours_type_id as hours_type_id, tsh.hours_amount as hours_amount
      from timetables_specs_tbl ts, timetables_specs_hours_tbl tsh
     where ts.id = tsh.timetable_spec_id
    minus
    select ts.id spec_id, d.persrn emp_id, d.psdeprn post_id, dh.rateacc wage_rate, dd.workdate day_date,
           ddh.hourstype as hours_type_id, ddh.workedhours as hours_amount
      from prs_duties_days dd, prs_duties d, prs_duties_hist dh, timetables_tbl t, timetables_specs_tbl ts, prs_duties_hours ddh
     where dd.prn = d.rn
       and dh.prn = d.rn
       and ddh.prn = dd.rn
       and ts.timetable_id = t.id
       and ts.emp_id = d.persrn
       and ts.wage_rate = dh.rateacc
       and ts.post_id = d.psdeprn
       and d.company = t.company_id
       and d.deptrn = t.dept_id
       and d.begeng <= last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and (d.endeng is null or d.endeng >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dh.do_act_from <= last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and (dh.do_act_to is null or dh.do_act_to >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dd.workdate between to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
                       and last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
    )
  )
 group by spec_id, emp_id, post_id, wage_rate, day_date, prs_hours_type_id, table_hours_type_id
;
