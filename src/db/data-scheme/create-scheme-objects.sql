Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem  DESCRIPTION
Rem    Создание объектов приложения.
Rem
Rem  NOTES
Rem    Assumes the connection as SYS user database.
Rem
Rem    Arguments:
Rem      1 - DATA_SCHEME      = Data scheme name
Rem      2 - PARUS_SCHEME     = Parus scheme name
Rem      3 - PATH             = Files path
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created

set define '^'
set verify off

define DATA_SCHEME      = '^1'
define PARUS_SCHEME     = '^2'
define PATH             = '^3'


grant create database link to ^DATA_SCHEME;
grant create any context to ^DATA_SCHEME;
grant drop any context to ^DATA_SCHEME;
grant execute on sys.dbms_system to ^DATA_SCHEME;


prompt
prompt **********************************************
prompt  G R A N T S   F O R   P A R U S   O B J E C T S
prompt
@^PATH.data-scheme/parus-to-data-scheme.sql ^PARUS_SCHEME ^DATA_SCHEME

alter session set current_schema = ^DATA_SCHEME
/

prompt
prompt **********************************************
prompt  S E Q U E N C E S
prompt
create sequence SQ_STG minvalue 1 increment by 1 cache 100;


prompt
prompt **********************************************
prompt               T A B L E S
prompt
@^PATH.data-scheme/tbl/collections_tbl.sql
prompt
@^PATH.data-scheme/tbl/depts_properties_tbl.sql
prompt
@^PATH.data-scheme/tbl/holidays_schedules_tbl.sql
prompt
@^PATH.data-scheme/tbl/holisched_specs_data_tbl.sql
prompt
@^PATH.data-scheme/tbl/holisched_specs_tbl.sql
prompt
@^PATH.data-scheme/tbl/milk_cost2_tbl.sql
prompt
@^PATH.data-scheme/tbl/milk_dept_register_tbl.sql
prompt
@^PATH.data-scheme/tbl/milk_dept_register2_tbl.sql
prompt
@^PATH.data-scheme/tbl/milk_dept_specs_tbl.sql
prompt
@^PATH.data-scheme/tbl/milk_dept_specs2_tbl.sql
prompt
@^PATH.data-scheme/tbl/milk_ent_register_tbl.sql
prompt
@^PATH.data-scheme/tbl/timetables_specs_days_tbl.sql
prompt
@^PATH.data-scheme/tbl/timetables_specs_hours_tbl.sql
prompt
@^PATH.data-scheme/tbl/timetables_specs_tbl.sql
prompt
@^PATH.data-scheme/tbl/timetables_tbl.sql
prompt
@^PATH.data-scheme/tbl/tlog.sql
prompt
@^PATH.data-scheme/tbl/tloglevel.sql
prompt
@^PATH.data-scheme/tbl/users_depts_tbl.sql
prompt
@^PATH.data-scheme/tbl/users_tbl.sql
prompt
@^PATH.data-scheme/tbl/workdays_tbl.sql
prompt


prompt
prompt **********************************************
prompt            F O R E I G N  K E Y S
prompt
@^PATH.data-scheme/fk/depts_properties.fk.sql
prompt
@^PATH.data-scheme/fk/holidays_schedules.fk.sql
prompt
@^PATH.data-scheme/fk/holisched_specs_data.fk.sql
prompt
@^PATH.data-scheme/fk/holisched_specs.fk.sql
prompt
@^PATH.data-scheme/fk/milk_dept_register.fk.sql
prompt
@^PATH.data-scheme/fk/milk_dept_register2.fk.sql
prompt
@^PATH.data-scheme/fk/milk_dept_specs.fk.sql
prompt
@^PATH.data-scheme/fk/milk_dept_specs2.fk.sql
prompt
@^PATH.data-scheme/fk/timetables_specs_days.fk.sql
prompt
@^PATH.data-scheme/fk/timetables_specs_hours.fk.sql
prompt
@^PATH.data-scheme/fk/timetables_specs.fk.sql
prompt


prompt
prompt **********************************************
prompt              F U N C T I O N S
prompt


prompt
prompt **********************************************
prompt                  V I E W S
prompt
@^PATH.data-scheme/vw/companies_tbl.vw.sql
show errors
@^PATH.data-scheme/vw/days_types_tbl.vw.sql
show errors
@^PATH.data-scheme/vw/days_types.vw.sql
show errors
@^PATH.data-scheme/vw/departments_tbl.vw.sql
show errors
@^PATH.data-scheme/vw/duties_hist_tbl.vw.sql
show errors
@^PATH.data-scheme/vw/duties_tbl.vw.sql
show errors
@^PATH.data-scheme/vw/duties_types_tbl.vw.sql
show errors
@^PATH.data-scheme/vw/employees_tbl.vw.sql
show errors
@^PATH.data-scheme/vw/hours_types_tbl.vw.sql
show errors
@^PATH.data-scheme/vw/log_levels.vw.sql
show errors
@^PATH.data-scheme/vw/persons_tbl.vw.sql
show errors
@^PATH.data-scheme/vw/posts_tbl.vw.sql
show errors
@^PATH.data-scheme/vw/spec_days_divergence.vw.sql
show errors
@^PATH.data-scheme/vw/spec_hours_divergence.vw.sql
show errors
@^PATH.data-scheme/vw/timetable_days_divergence.vw.sql
show errors
@^PATH.data-scheme/vw/timetable_hours_divergence.vw.sql
show errors
@^PATH.data-scheme/vw/users.vw.sql
show errors
@^PATH.data-scheme/vw/users_depts.vw.sql
show errors
@^PATH.data-scheme/vw/vlog.vw.sql
show errors


prompt
prompt **********************************************
prompt         P A C K A G E   S P E C S
prompt
prompt ... creating package spec "PLOGPARAM"
@^PATH.data-scheme/pks/plogparam.pks.sql
show errors
prompt ... creating package spec "PLOG"
@^PATH.data-scheme/pks/plog.pks.sql
show errors
prompt ... creating package spec "PLOG_INTERFACE"
@^PATH.data-scheme/pks/plog_interface.pks.sql
show errors
prompt ... creating package spec "PLOG_OUT_ALERT"
@^PATH.data-scheme/pks/plog_out_alert.pks.sql
show errors
prompt ... creating package spec "PLOG_OUT_DBMS_OUTPUT"
@^PATH.data-scheme/pks/plog_out_dbms_output.pks.sql
show errors
prompt ... creating package spec "PLOG_OUT_SESSION"
@^PATH.data-scheme/pks/plog_out_session.pks.sql
show errors
prompt ... creating package spec "PLOG_OUT_TLOG"
@^PATH.data-scheme/pks/plog_out_tlog.pks.sql
show errors
prompt ... creating package spec "PLOG_OUT_TRACE"
@^PATH.data-scheme/pks/plog_out_trace.pks.sql
show errors
prompt ... creating package spec "STD"
@^PATH.data-scheme/pks/std.pks.sql
show errors
prompt ... creating package spec "UTILS"
@^PATH.data-scheme/pks/utils.pks.sql
show errors
prompt ... creating package spec "I_APPINFO"
@^PATH.data-scheme/pks/i_appinfo.pks.sql
show errors
prompt ... creating package spec "I_DEPTS_PROPERTIES"
@^PATH.data-scheme/pks/i_depts_properties.pks.sql
show errors
prompt ... creating package spec "I_HOLIDAYS_SCHEDULES"
@^PATH.data-scheme/pks/i_holidays_schedules.pks.sql
show errors
prompt ... creating package spec "I_MILK"
@^PATH.data-scheme/pks/i_milk.pks.sql
show errors
prompt ... creating package spec "I_MILK2"
@^PATH.data-scheme/pks/i_milk2.pks.sql
show errors
prompt ... creating package spec "I_PRS_DATA"
@^PATH.data-scheme/pks/i_prs_data.pks.sql
show errors
prompt ... creating package spec "I_TIMETABLES"
@^PATH.data-scheme/pks/i_timetables.pks.sql
show errors
prompt ... creating package spec "I_TIMETABLES_SPECS"
@^PATH.data-scheme/pks/i_timetables_specs.pks.sql
show errors
prompt ... creating package spec "I_TIMETABLES_SPECS_DAYS"
@^PATH.data-scheme/pks/i_timetables_specs_days.pks.sql
show errors
prompt ... creating package spec "I_TIMETABLES_SPECS_HOURS"
@^PATH.data-scheme/pks/i_timetables_specs_hours.pks.sql
show errors
prompt ... creating package spec "I_USERS"
@^PATH.data-scheme/pks/i_users.pks.sql
show errors
prompt ... creating package spec "I_USERS_DEPTS"
@^PATH.data-scheme/pks/i_users_depts.pks.sql
show errors
prompt ... creating package spec "I_WORKDAYS"
@^PATH.data-scheme/pks/i_workdays.pks.sql
show errors


prompt
prompt **********************************************
prompt         P A C K A G E   B O D I E S
prompt
prompt ... creating package "STD"
@^PATH.data-scheme/pkb/std.pkb.sql
show errors
prompt ... creating package "UTILS"
@^PATH.data-scheme/pkb/utils.pkb.sql
show errors
prompt ... creating package "I_APPINFO"
@^PATH.data-scheme/pkb/i_appinfo.pkb.sql
show errors
prompt ... creating package "I_DEPTS_PROPERTIES"
@^PATH.data-scheme/pkb/i_depts_properties.pkb.sql
show errors
prompt ... creating package "I_HOLIDAYS_SCHEDULES"
@^PATH.data-scheme/pkb/i_holidays_schedules.pkb.sql
show errors
prompt ... creating package "I_MILK"
@^PATH.data-scheme/pkb/i_milk.pkb.sql
show errors
prompt ... creating package "I_MILK2"
@^PATH.data-scheme/pkb/i_milk2.pkb.sql
show errors
prompt ... creating package "I_PRS_DATA"
@^PATH.data-scheme/pkb/i_prs_data.pkb.sql
show errors
prompt ... creating package "I_TIMETABLES"
@^PATH.data-scheme/pkb/i_timetables.pkb.sql
show errors
prompt ... creating package "I_TIMETABLES_SPECS"
@^PATH.data-scheme/pkb/i_timetables_specs.pkb.sql
show errors
prompt ... creating package "I_TIMETABLES_SPECS_DAYS"
@^PATH.data-scheme/pkb/i_timetables_specs_days.pkb.sql
show errors
prompt ... creating package "I_TIMETABLES_SPECS_HOURS"
@^PATH.data-scheme/pkb/i_timetables_specs_hours.pkb.sql
show errors
prompt ... creating package "I_USERS"
@^PATH.data-scheme/pkb/i_users.pkb.sql
show errors
prompt ... creating package "I_USERS_DEPTS"
@^PATH.data-scheme/pkb/i_users_depts.pkb.sql
show errors
prompt ... creating package "I_WORKDAYS"
@^PATH.data-scheme/pkb/i_workdays.pkb.sql
show errors
prompt ... creating package "PLOG"
@^PATH.data-scheme/pkb/plog.pkb.sql
show errors
prompt ... creating package "PLOG_INTERFACE"
@^PATH.data-scheme/pkb/plog_interface.pkb.sql
show errors
prompt ... creating package "PLOG_OUT_ALERT"
@^PATH.data-scheme/pkb/plog_out_alert.pkb.sql
show errors
prompt ... creating package "PLOG_OUT_DBMS_OUTPUT"
@^PATH.data-scheme/pkb/plog_out_dbms_output.pkb.sql
show errors
prompt ... creating package "PLOG_OUT_SESSION"
@^PATH.data-scheme/pkb/plog_out_session.pkb.sql
show errors
prompt ... creating package "PLOG_OUT_TLOG"
@^PATH.data-scheme/pkb/plog_out_tlog.pkb.sql
show errors
prompt ... creating package "PLOG_OUT_TRACE"
@^PATH.data-scheme/pkb/plog_out_trace.pkb.sql
show errors
prompt ... creating package "PLOGPARAM"
@^PATH.data-scheme/pkb/plogparam.pkb.sql
show errors


prompt
prompt **********************************************
prompt               T R I G G E R S
prompt
@^PATH.data-scheme/trg/depts_properties_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/holidays_schedules_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/holisched_specs_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/holisched_specs_data_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/mikl_dept_register_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/milk_cost2_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/milk_dept_register2_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/milk_dept_specs_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/milk_dept_specs2_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/milk_ent_register_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/timetables_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/timetables_specs_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/timetables_specs_days_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/timetables_specs_hours_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/users_biu1.trg.sql
show errors
@^PATH.data-scheme/trg/users_depts_biu1.trg.sql
show errors


--prompt
--prompt  Security application context creation.
--prompt *************************************************************************
--prompt
--exec ^DATA_SCHEME..i_application.create_app_context
--/


prompt
prompt **********************************************
prompt        I N I T I A L I Z A T I O N
prompt


prompt
prompt **********************************************
prompt       T E S T  D A T A  L O A D I N G
prompt


prompt
prompt **********************************************
prompt      E N D   I N S T A L L A T I O N
prompt
prompt
