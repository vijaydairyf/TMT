Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "TIMETABLE_DAYS_DIVERGENCE"
create or replace view TIMETABLE_DAYS_DIVERGENCE as
select timetable_id, spec_id, emp_id, post_id, wage_rate, day_date,
       max(prs_day_type_id) as prs_day_type_id, max(table_day_type_id) as table_day_type_id
  from (
  select timetable_id, spec_id, emp_id, post_id, wage_rate, day_date,
         day_type_id as prs_day_type_id, null as table_day_type_id
    from (
    select t.id as timetable_id, ts.id as spec_id, d.persrn as emp_id, d.psdeprn as post_id, dh.rateacc as wage_rate,
           dd.workdate as day_date, dd.daystype as day_type_id
      from prs_duties_days dd, prs_duties d, prs_duties_hist dh, timetables_tbl t, timetables_specs_tbl ts
     where dd.prn = d.rn
       and dh.prn = d.rn
       and d.company = t.company_id
       and d.deptrn = t.dept_id
       and ts.timetable_id = t.id
       and ts.emp_id = d.persrn
       and ts.wage_rate = dh.rateacc
       and ts.post_id = d.psdeprn
       and d.begeng <= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
       and (d.endeng is null or d.endeng >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dh.do_act_from <= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
       and (dh.do_act_to is null or dh.do_act_to >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dd.workdate between to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
                           and last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dd.daystype is not null
    minus
    select t.id as timetable_id, ts.id as spec_id, ts.emp_id, ts.post_id, ts.wage_rate, tsd.day_date, tsd.day_type_id
      from timetables_tbl t, timetables_specs_tbl ts, timetables_specs_days_tbl tsd
     where ts.id = tsd.timetable_spec_id
       and t.id = ts.timetable_id
       and tsd.day_type_id is not null
    )
  union
  select timetable_id, spec_id, emp_id, post_id, wage_rate, day_date,
         null as prs_day_type_id, day_type_id as table_day_type_id
    from (
    select t.id as timetable_id, ts.id as spec_id, ts.emp_id, ts.post_id, ts.wage_rate, tsd.day_date, tsd.day_type_id
      from timetables_tbl t, timetables_specs_tbl ts, timetables_specs_days_tbl tsd
     where ts.id = tsd.timetable_spec_id
       and t.id = ts.timetable_id
       and tsd.day_type_id is not null
    minus
    select t.id as timetable_id, ts.id as spec_id, d.persrn as emp_id, d.psdeprn as post_id, dh.rateacc as wage_rate,
           dd.workdate as day_date, dd.daystype as day_type_id
      from prs_duties_days dd, prs_duties d, prs_duties_hist dh, timetables_tbl t, timetables_specs_tbl ts
     where dd.prn = d.rn
       and dh.prn = d.rn
       and d.company = t.company_id
       and d.deptrn = t.dept_id
       and ts.timetable_id = t.id
       and ts.emp_id = d.persrn
       and ts.wage_rate = dh.rateacc
       and ts.post_id = d.psdeprn
       and d.begeng <= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
       and (d.endeng is null or d.endeng >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dh.do_act_from <= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
       and (dh.do_act_to is null or dh.do_act_to >= to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dd.workdate between to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')
                           and last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))
       and dd.daystype is not null
    )
  )
 group by timetable_id, spec_id, emp_id, post_id, wage_rate, day_date
;
