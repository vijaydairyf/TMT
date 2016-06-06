Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Creates application scheme objects in Oracle database.
Rem
Rem    NOTES
Rem      Assumes the connection as SYS or SYSTEM user.
Rem
Rem    Arguments:
Rem      1 - APP_SCHEME   => Application scheme name
Rem      2 - DATA_SCHEME	=> Data scheme name
Rem      3 - PATH         => Files path
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created


define APP_SCHEME    = '^1'
define DATA_SCHEME   = '^2'
define PATH          = '^3'

prompt
prompt **********************************************
prompt  G R A N T S   T O   D A T A   O B J E C T S
prompt
@^PATH.app-scheme/data-to-app-scheme.sql ^DATA_SCHEME ^APP_SCHEME

alter session set current_schema = ^APP_SCHEME
/

prompt
prompt **********************************************
prompt               T A B L E S
prompt


prompt
prompt **********************************************
prompt         P A C K A G E   S P E C S
prompt
prompt ... creating package spec "MILK2_PKG";
@^PATH.app-scheme/pks/milk2_pkg.pks.sql
show errors
prompt ... creating package spec "PAGE23";
@^PATH.app-scheme/pks/page23.pks.sql
show errors
prompt ... creating package spec "PAGE24";
@^PATH.app-scheme/pks/page24.pks.sql
show errors
prompt ... creating package spec "PAGE26";
@^PATH.app-scheme/pks/page26.pks.sql
show errors
prompt ... creating package spec "PAGE27";
@^PATH.app-scheme/pks/page27.pks.sql
show errors
prompt ... creating package spec "PAGE28";
@^PATH.app-scheme/pks/page28.pks.sql
show errors
prompt ... creating package spec "PAGE29";
@^PATH.app-scheme/pks/page29.pks.sql
show errors
prompt ... creating package spec "PAGE30";
@^PATH.app-scheme/pks/page30.pks.sql
show errors
prompt ... creating package spec "PAGE31";
@^PATH.app-scheme/pks/page31.pks.sql
show errors
prompt ... creating package spec "PAGE32";
@^PATH.app-scheme/pks/page32.pks.sql
show errors
prompt ... creating package spec "PAGE33";
@^PATH.app-scheme/pks/page33.pks.sql
show errors
prompt ... creating package spec "PAGE34";
@^PATH.app-scheme/pks/page34.pks.sql
show errors
prompt ... creating package spec "PAGE35";
@^PATH.app-scheme/pks/page35.pks.sql
show errors
prompt ... creating package spec "PKG_RPT_TIMETABLES";
@^PATH.app-scheme/pks/pkg_rpt_timetables.pks.sql
show errors
prompt ... creating package spec "PKG_TIMETABLES";
@^PATH.app-scheme/pks/pkg_timetables.pks.sql
show errors
prompt ... creating package spec "PKG_USERS";
@^PATH.app-scheme/pks/pkg_users.pks.sql
show errors


prompt
prompt **********************************************
prompt               V I E W S
prompt
@^PATH.app-scheme/vw/userslist.vw.sql
show errors
@^PATH.app-scheme/vw/companies.vw.sql
show errors
@^PATH.app-scheme/vw/departments.vw.sql
show errors
@^PATH.app-scheme/vw/users_depts.vw.sql
show errors
@^PATH.app-scheme/vw/all_holidays_schedules.vw.sql
show errors
@^PATH.app-scheme/vw/all_milk.vw.sql
show errors
@^PATH.app-scheme/vw/milk_specs.vw.sql
show errors
@^PATH.app-scheme/vw/milk_specs2.vw.sql
show errors
@^PATH.app-scheme/vw/all_milk_orders.vw.sql
show errors
@^PATH.app-scheme/vw/all_milk_orders2.vw.sql
show errors
@^PATH.app-scheme/vw/all_milk2.vw.sql
show errors
@^PATH.app-scheme/vw/all_timetables_list.vw.sql
show errors
@^PATH.app-scheme/vw/all_timetables.vw.sql
show errors
@^PATH.app-scheme/vw/days_types.vw.sql
show errors
@^PATH.app-scheme/vw/dept_cost.vw.sql
show errors
@^PATH.app-scheme/vw/depts_properties.vw.sql
show errors
@^PATH.app-scheme/vw/holisched_specs.vw.sql
show errors
@^PATH.app-scheme/vw/holisched_specs_data.vw.sql
show errors
@^PATH.app-scheme/vw/hours_types.vw.sql
show errors
@^PATH.app-scheme/vw/milk_cost2.vw.sql
show errors
@^PATH.app-scheme/vw/milk_ent_registers.vw.sql
show errors
@^PATH.app-scheme/vw/months_list.vw.sql
show errors
@^PATH.app-scheme/vw/my_departments.vw.sql
show errors
@^PATH.app-scheme/vw/my_holidays_schedules.vw.sql
show errors
@^PATH.app-scheme/vw/my_milk.vw.sql
show errors
@^PATH.app-scheme/vw/my_milk2.vw.sql
show errors
@^PATH.app-scheme/vw/my_timetables_list.vw.sql
show errors
@^PATH.app-scheme/vw/my_timetables.vw.sql
show errors
@^PATH.app-scheme/vw/spec_days_divs.vw.sql
show errors
@^PATH.app-scheme/vw/spec_hours_divs.vw.sql
show errors
@^PATH.app-scheme/vw/timetables_specs_data.vw.sql
show errors
@^PATH.app-scheme/vw/timetables_specs_days.vw.sql
show errors
@^PATH.app-scheme/vw/timetables_specs_hours.vw.sql
show errors
@^PATH.app-scheme/vw/timetables_specs_hours_by_spec.vw.sql
show errors
@^PATH.app-scheme/vw/timetables_specs.vw.sql
show errors
@^PATH.app-scheme/vw/rpt_timetables.vw.sql
show errors
@^PATH.app-scheme/vw/rpt_timetables_specs.vw.sql
show errors
--@^PATH.app-scheme/vw/tmp_all_timetables.vw.sql
--show errors
@^PATH.app-scheme/vw/absent_emp_in_register.vw.sql
show errors
--@^PATH.app-scheme/vw/absent_emp_in_register_t.vw.sql
--show errors
@^PATH.app-scheme/vw/absent_emp_in_register2.vw.sql
show errors
@^PATH.app-scheme/vw/tt_sp_days.vw.sql
show errors
@^PATH.app-scheme/vw/tt_sp_hrs_by_spec.vw.sql
show errors
@^PATH.app-scheme/vw/workdays.vw.sql
show errors


prompt
prompt **********************************************
prompt         F U N C T I O N S
prompt


prompt
prompt **********************************************
prompt         P R O C E D U R E S
prompt


prompt
prompt **********************************************
prompt         P A C K A G E   B O D I E S
prompt
prompt ... creating package "MILK2_PKG";
@^PATH.app-scheme/pkb/milk2_pkg.pkb.sql
show errors
prompt ... creating package "PAGE23";
@^PATH.app-scheme/pkb/page23.pkb.sql
show errors
prompt ... creating package "PAGE24";
@^PATH.app-scheme/pkb/page24.pkb.sql
show errors
prompt ... creating package "PAGE26";
@^PATH.app-scheme/pkb/page26.pkb.sql
show errors
prompt ... creating package "PAGE27";
@^PATH.app-scheme/pkb/page27.pkb.sql
show errors
prompt ... creating package "PAGE28";
@^PATH.app-scheme/pkb/page28.pkb.sql
show errors
prompt ... creating package "PAGE29";
@^PATH.app-scheme/pkb/page29.pkb.sql
show errors
prompt ... creating package "PAGE30";
@^PATH.app-scheme/pkb/page30.pkb.sql
show errors
prompt ... creating package "PAGE31";
@^PATH.app-scheme/pkb/page31.pkb.sql
show errors
prompt ... creating package "PAGE32";
@^PATH.app-scheme/pkb/page32.pkb.sql
show errors
prompt ... creating package "PAGE33";
@^PATH.app-scheme/pkb/page33.pkb.sql
show errors
prompt ... creating package "PAGE34";
@^PATH.app-scheme/pkb/page34.pkb.sql
show errors
prompt ... creating package "PAGE35";
@^PATH.app-scheme/pkb/page35.pkb.sql
show errors
prompt ... creating package "PKG_RPT_TIMETABLES";
@^PATH.app-scheme/pkb/pkg_rpt_timetables.pkb.sql
show errors
prompt ... creating package "PKG_TIMETABLES";
@^PATH.app-scheme/pkb/pkg_timetables.pkb.sql
show errors
prompt ... creating package "PKG_USERS";
@^PATH.app-scheme/pkb/pkg_users.pkb.sql
show errors


prompt
prompt **********************************************
prompt               T R I G G E R S
prompt


prompt
prompt **********************************************
prompt               S C R I P T S
prompt


prompt
prompt **********************************************
prompt      E N D   I N S T A L L A T I O N
prompt
prompt
