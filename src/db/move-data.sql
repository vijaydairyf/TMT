Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Move data.
Rem
Rem    NOTES
Rem      Assumes the connection as SYS or SYSTEM user.
Rem
Rem    Arguments:
Rem      1 - SOURCE_SCHEME     = Source data scheme name
Rem      2 - DATA_SCHEME       = Data scheme name
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created

set define '^'
set concat on
set concat .
set verify off
set termout off
spool off
set serveroutput on
set termout on
set timing off
set feedback on

define SOURCE_SCHEME  = '^1'
define DATA_SCHEME    = '^2'
define PATH = '@'

@^PATH.set-logfile.sql move-data

timing start "Move data"

set constraints all deferred;

whenever sqlerror exit rollback;

prompt ... move COLLECTIONS_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..collections_tbl ( id, value_no, category, value_name )
    select id, value_no, cathegory, value_name from ^SOURCE_SCHEME..collections_tbl
;

prompt ... move DEPTS_PROPERTIES_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..depts_properties_tbl ( id, created, creator, updated, updater, dept_id, curator_post, curator_name, manager_name, milk_resp_name )
    select id, updated, updater, updated, updater, dept_id, curator_post, curator_name, manager_name, milk_resp_name
      from ^SOURCE_SCHEME..depts_properties_tbl
;

prompt ... move HOLIDAYS_SCHEDULES_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..holidays_schedules_tbl ( id, created, creator, updated, updater, company_id, dept_id, schedule_year )
    select id, updated, updater, updated, updater, company_id, dept_id, schedule_year
      from ^SOURCE_SCHEME..holidays_schedules_tbl
;

prompt ... move HOLISCHED_SPECS_DATA_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..holisched_specs_data_tbl ( id, created, creator, updated, updater, spec_id, beg_date, days_amount )
    select id, updated, updater, updated, updater, holisched_spec_id, beg_date, days_amount
      from ^SOURCE_SCHEME..holisched_specs_data_tbl
;

prompt ... move HOLISCHED_SPECS_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..holisched_specs_tbl ( id, created, creator, updated, updater, schedule_id, emp_id, post_id )
    select id, updated, updater, updated, updater, schedule_id, emp_id, post_id
      from ^SOURCE_SCHEME..holisched_specs_tbl
;

prompt ... move MILK_COST2_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..milk_cost2_tbl ( id, created, creator, updated, updater, year_month, cost_year, cost_month, cost_value )
    select id, updated, updater, updated, updater, year_month, cost_year, cost_month, cost_value
      from ^SOURCE_SCHEME..milk_cost2_tbl
;

prompt ... move MILK_DEPT_REGISTER_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..milk_dept_register_tbl ( id, created, creator, updated, updater, dept_id, register_year, register_month, year_month, register_status, register_timemark, received,ent_register_id )
    select id, updated, updater, updated, updater, dept_id, register_year, register_month, year_month, register_status, register_timemark, received,ent_register_id
      from ^SOURCE_SCHEME..milk_dept_register_tbl
;

prompt ... move MILK_DEPT_REGISTER2_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..milk_dept_register2_tbl ( id, created, creator, updated, updater, dept_id, register_year, register_month, year_month, register_status, register_timemark )
    select id, updated, updater, updated, updater, dept_id, register_year, register_month, year_month, register_status, register_timemark
      from ^SOURCE_SCHEME..milk_dept_register2_tbl
;

prompt ... move MILK_DEPT_SPECS_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..milk_dept_specs_tbl ( id, created, creator, updated, updater, year_month, dpt_register_id, emp_id, emp_post_id, work_off, milk_norm, on_order, give_out, received )
    select id, updated, updater, updated, updater, year_month, dpt_register_id, emp_id, emp_post_id, work_off, milk_norm, on_order, give_out, received
      from ^SOURCE_SCHEME..milk_dept_specs_tbl
;

prompt ... move MILK_DEPT_SPECS2_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..milk_dept_specs2_tbl ( id, created, creator, updated, updater, year_month, dpt_register_id, emp_id, emp_post_id, work_off )
    select id, updated, updater, updated, updater, year_month, dpt_register_id, emp_id, emp_post_id, work_off
      from ^SOURCE_SCHEME..milk_dept_specs2_tbl
;

prompt ... move MILK_ENT_REGISTER_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..milk_ent_register_tbl ( id, created, creator, updated, updater, register_year, register_month, register_status, register_timemark, year_month, received, received_from )
    select id, updated, updater, updated, updater, register_year, register_month, register_status, register_timemark, year_month, received, received_from
      from ^SOURCE_SCHEME..milk_ent_register_tbl
;

prompt ... move TIMETABLES_SPECS_DAYS_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..timetables_specs_days_tbl ( id, created, creator, updated, updater, timetable_spec_id, day_date, day_type_id, prs_day_type_id )
    select id, updated, updater, updated, updater, timetable_spec_id, day_date, day_type_id, prs_day_type_id
      from ^SOURCE_SCHEME..timetables_specs_days_tbl
;

prompt ... move TIMETABLES_SPECS_HOURS_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..timetables_specs_hours_tbl ( id, created, creator, updated, updater, timetable_spec_id, day_date, hours_type_id, hours_amount, prs_hours_amount )
    select id, updated, updater, updated, updater, timetable_spec_id, day_date, hours_type_id, hours_amount, prs_hours_amount
      from ^SOURCE_SCHEME..timetables_specs_hours_tbl
;

prompt ... move TIMETABLES_SPECS_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..timetables_specs_tbl ( id, created, creator, updated, updater, timetable_id, emp_id, post_id, wage_rate, prs_duty_hist_id )
    select id, updated, updater, updated, updater, timetable_id, emp_id, post_id, wage_rate, prs_duty_hist_id
      from ^SOURCE_SCHEME..timetables_specs_tbl
;

prompt ... move TIMETABLES_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..timetables_tbl ( id, created, creator, updated, updater, company_id, dept_id, table_year, table_month, table_type, submitted, accepted )
    select id, updated, updater, updated, updater, company_id, dept_id, table_year, table_month, 0, submitted, accepted
      from ^SOURCE_SCHEME..timetables_tbl
;

prompt ... move TLOG data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..tlog ( id, ldate, lhsecs, llevel, lsection, ltext, luser )
    select id, ldate, lhsecs, llevel, lsection, ltext, luser
      from ^SOURCE_SCHEME..tlog
;

prompt ... move TLOGLEVEL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..tloglevel ( llevel, ljlevel, lsyslogequiv, lcode, ldesc )
    select llevel, ljlevel, lsyslogequiv, lcode, ldesc
      from ^SOURCE_SCHEME..tloglevel
;

prompt ... move USERS_DEPTS_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..users_depts_tbl ( id, created, creator, updated, updater, user_id, company_id, dept_id )
    select id, updated, updater, updated, updater, user_id, company_id, dept_id
      from ^SOURCE_SCHEME..users_depts_tbl
;

prompt ... move USERS_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..users_tbl ( id, created, creator, updated, updater, username, userpass
, fullname, is_admin, is_accounter, is_timekeeper, is_holischeduler, is_dept_milk, is_ent_milk
, is_hr, expires, phone, room, notes )
    select id, updated, updater, updated, updater, username, userpass, fullname, is_admin
         , is_accounter, is_timekeeper, is_holischeduler, is_dept_milk, is_ent_milk, is_hr
         , expires, phone, room, notes
      from ^SOURCE_SCHEME..users_tbl
;

prompt ... move WORKDAYS_TBL data from ^SOURCE_SCHEME to ^DATA_SCHEME
insert into ^DATA_SCHEME..workdays_tbl ( work_year, work_month, workdays )
    select work_year, work_month, workdays
      from ^SOURCE_SCHEME..workdays_tbl
;

commit;

set constraints all immediate;

timing stop "Move data"

spool off

exit
