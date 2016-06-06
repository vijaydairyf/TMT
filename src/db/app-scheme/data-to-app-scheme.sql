Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Creates synonyms and grants.
Rem
Rem    Arguments:
Rem      1 - DATA_SCHEME  = Data scheme name
Rem      2 - APP_SCHEME   = Data scheme name
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created

set define '^'
set verify off

define DATA_SCHEME    = '^1'
define APP_SCHEME     = '^2'


--------------------------------------------
-- S Y N O N Y M S
--
prompt ... create synonym "^APP_SCHEME..COLLECTIONS_TBL"
create or replace synonym ^APP_SCHEME..COLLECTIONS_TBL for ^DATA_SCHEME..COLLECTIONS_TBL;
prompt ... create synonym "^APP_SCHEME..COMPANIES_TBL"
create or replace synonym ^APP_SCHEME..COMPANIES_TBL for ^DATA_SCHEME..COMPANIES_TBL;
prompt ... create synonym "^APP_SCHEME..DAYS_TYPES_TBL"
create or replace synonym ^APP_SCHEME..DAYS_TYPES_TBL for ^DATA_SCHEME..DAYS_TYPES_TBL;
prompt ... create synonym "^APP_SCHEME..DEPARTMENTS_TBL"
create or replace synonym ^APP_SCHEME..DEPARTMENTS_TBL for ^DATA_SCHEME..DEPARTMENTS_TBL;
prompt ... create synonym "^APP_SCHEME..DEPTS_PROPERTIES_TBL"
create or replace synonym ^APP_SCHEME..DEPTS_PROPERTIES_TBL for ^DATA_SCHEME..DEPTS_PROPERTIES_TBL;
prompt ... create synonym "^APP_SCHEME..DUTIES_HIST_TBL"
create or replace synonym ^APP_SCHEME..DUTIES_HIST_TBL for ^DATA_SCHEME..DUTIES_HIST_TBL;
prompt ... create synonym "^APP_SCHEME..DUTIES_TBL"
create or replace synonym ^APP_SCHEME..DUTIES_TBL for ^DATA_SCHEME..DUTIES_TBL;
prompt ... create synonym "^APP_SCHEME..DUTIES_TYPES_TBL"
create or replace synonym ^APP_SCHEME..DUTIES_TYPES_TBL for ^DATA_SCHEME..DUTIES_TYPES_TBL;
prompt ... create synonym "^APP_SCHEME..EMPLOYEES_TBL"
create or replace synonym ^APP_SCHEME..EMPLOYEES_TBL for ^DATA_SCHEME..EMPLOYEES_TBL;
prompt ... create synonym "^APP_SCHEME..HOLIDAYS_SCHEDULES_TBL"
create or replace synonym ^APP_SCHEME..HOLIDAYS_SCHEDULES_TBL for ^DATA_SCHEME..HOLIDAYS_SCHEDULES_TBL;
prompt ... create synonym "^APP_SCHEME..HOLISCHED_SPECS_DATA_TBL"
create or replace synonym ^APP_SCHEME..HOLISCHED_SPECS_DATA_TBL for ^DATA_SCHEME..HOLISCHED_SPECS_DATA_TBL;
prompt ... create synonym "^APP_SCHEME..HOLISCHED_SPECS_TBL"
create or replace synonym ^APP_SCHEME..HOLISCHED_SPECS_TBL for ^DATA_SCHEME..HOLISCHED_SPECS_TBL;
prompt ... create synonym "^APP_SCHEME..HOURS_TYPES_TBL"
create or replace synonym ^APP_SCHEME..HOURS_TYPES_TBL for ^DATA_SCHEME..HOURS_TYPES_TBL;
prompt ... create synonym "^APP_SCHEME..I_APPINFO"
create or replace synonym ^APP_SCHEME..I_APPINFO for ^DATA_SCHEME..I_APPINFO;
prompt ... create synonym "^APP_SCHEME..I_DEPTS_PROPERTIES"
create or replace synonym ^APP_SCHEME..I_DEPTS_PROPERTIES for ^DATA_SCHEME..I_DEPTS_PROPERTIES;
prompt ... create synonym "^APP_SCHEME..I_HOLIDAYS_SCHEDULES"
create or replace synonym ^APP_SCHEME..I_HOLIDAYS_SCHEDULES for ^DATA_SCHEME..I_HOLIDAYS_SCHEDULES;
prompt ... create synonym "^APP_SCHEME..I_MILK"
create or replace synonym ^APP_SCHEME..I_MILK for ^DATA_SCHEME..I_MILK;
prompt ... create synonym "^APP_SCHEME..I_MILK2"
create or replace synonym ^APP_SCHEME..I_MILK2 for ^DATA_SCHEME..I_MILK2;
prompt ... create synonym "^APP_SCHEME..I_PRS_DATA"
create or replace synonym ^APP_SCHEME..I_PRS_DATA for ^DATA_SCHEME..I_PRS_DATA;
prompt ... create synonym "^APP_SCHEME..I_TIMETABLES"
create or replace synonym ^APP_SCHEME..I_TIMETABLES for ^DATA_SCHEME..I_TIMETABLES;
prompt ... create synonym "^APP_SCHEME..I_TIMETABLES_SPECS"
create or replace synonym ^APP_SCHEME..I_TIMETABLES_SPECS for ^DATA_SCHEME..I_TIMETABLES_SPECS;
prompt ... create synonym "^APP_SCHEME..I_TIMETABLES_SPECS_DAYS"
create or replace synonym ^APP_SCHEME..I_TIMETABLES_SPECS_DAYS for ^DATA_SCHEME..I_TIMETABLES_SPECS_DAYS;
prompt ... create synonym "^APP_SCHEME..I_TIMETABLES_SPECS_HOURS"
create or replace synonym ^APP_SCHEME..I_TIMETABLES_SPECS_HOURS for ^DATA_SCHEME..I_TIMETABLES_SPECS_HOURS;
prompt ... create synonym "^APP_SCHEME..I_USERS"
create or replace synonym ^APP_SCHEME..I_USERS for ^DATA_SCHEME..I_USERS;
prompt ... create synonym "^APP_SCHEME..I_USERS_DEPTS"
create or replace synonym ^APP_SCHEME..I_USERS_DEPTS for ^DATA_SCHEME..I_USERS_DEPTS;
prompt ... create synonym "^APP_SCHEME..I_WORKDAYS"
create or replace synonym ^APP_SCHEME..I_WORKDAYS for ^DATA_SCHEME..I_WORKDAYS;
prompt ... create synonym "^APP_SCHEME..LOG_LEVELS"
create or replace synonym ^APP_SCHEME..LOG_LEVELS for ^DATA_SCHEME..LOG_LEVELS;
prompt ... create synonym "^APP_SCHEME..MILK_COST2_TBL"
create or replace synonym ^APP_SCHEME..MILK_COST2_TBL for ^DATA_SCHEME..MILK_COST2_TBL;
prompt ... create synonym "^APP_SCHEME..MILK_DEPT_REGISTER_TBL"
create or replace synonym ^APP_SCHEME..MILK_DEPT_REGISTER_TBL for ^DATA_SCHEME..MILK_DEPT_REGISTER_TBL;
prompt ... create synonym "^APP_SCHEME..MILK_DEPT_REGISTER2_TBL"
create or replace synonym ^APP_SCHEME..MILK_DEPT_REGISTER2_TBL for ^DATA_SCHEME..MILK_DEPT_REGISTER_TBL;
prompt ... create synonym "^APP_SCHEME..MILK_DEPT_SPECS_TBL"
create or replace synonym ^APP_SCHEME..MILK_DEPT_SPECS_TBL for ^DATA_SCHEME..MILK_DEPT_SPECS_TBL;
prompt ... create synonym "^APP_SCHEME..MILK_DEPT_SPECS2_TBL"
create or replace synonym ^APP_SCHEME..MILK_DEPT_SPECS2_TBL for ^DATA_SCHEME..MILK_DEPT_SPECS2_TBL;
prompt ... create synonym "^APP_SCHEME..MILK_ENT_REGISTER_TBL"
create or replace synonym ^APP_SCHEME..MILK_ENT_REGISTER_TBL for ^DATA_SCHEME..MILK_ENT_REGISTER_TBL;
prompt ... create synonym "^APP_SCHEME..PERSONS_TBL"
create or replace synonym ^APP_SCHEME..PERSONS_TBL for ^DATA_SCHEME..PERSONS_TBL;
prompt ... create synonym "^APP_SCHEME..PLOG"
create or replace synonym ^APP_SCHEME..PLOG for ^DATA_SCHEME..PLOG;
prompt ... create synonym "^APP_SCHEME..PLOGPARAM"
create or replace synonym ^APP_SCHEME..PLOGPARAM for ^DATA_SCHEME..PLOGPARAM;
prompt ... create synonym "^APP_SCHEME..POSTS_TBL"
create or replace synonym ^APP_SCHEME..POSTS_TBL for ^DATA_SCHEME..POSTS_TBL;
prompt ... create synonym "^APP_SCHEME..SPEC_DAYS_DIVERGENCE"
create or replace synonym ^APP_SCHEME..SPEC_DAYS_DIVERGENCE for ^DATA_SCHEME..SPEC_DAYS_DIVERGENCE;
prompt ... create synonym "^APP_SCHEME..SPEC_HOURS_DIVERGENCE"
create or replace synonym ^APP_SCHEME..SPEC_HOURS_DIVERGENCE for ^DATA_SCHEME..SPEC_HOURS_DIVERGENCE;
prompt ... create synonym "^APP_SCHEME..STD"
create or replace synonym ^APP_SCHEME..STD for ^DATA_SCHEME..STD;
prompt ... create synonym "^APP_SCHEME..TIMETABLE_DAYS_DIVERGENCE"
create or replace synonym ^APP_SCHEME..TIMETABLE_DAYS_DIVERGENCE for ^DATA_SCHEME..TIMETABLE_DAYS_DIVERGENCE;
prompt ... create synonym "^APP_SCHEME..TIMETABLE_HOURS_DIVERGENCE"
create or replace synonym ^APP_SCHEME..TIMETABLE_HOURS_DIVERGENCE for ^DATA_SCHEME..TIMETABLE_HOURS_DIVERGENCE;
prompt ... create synonym "^APP_SCHEME..TIMETABLES_SPECS_DAYS_TBL"
create or replace synonym ^APP_SCHEME..TIMETABLES_SPECS_DAYS_TBL for ^DATA_SCHEME..TIMETABLES_SPECS_DAYS_TBL;
prompt ... create synonym "^APP_SCHEME..TIMETABLES_SPECS_HOURS_TBL"
create or replace synonym ^APP_SCHEME..TIMETABLES_SPECS_HOURS_TBL for ^DATA_SCHEME..TIMETABLES_SPECS_HOURS_TBL;
prompt ... create synonym "^APP_SCHEME..TIMETABLES_SPECS_TBL"
create or replace synonym ^APP_SCHEME..TIMETABLES_SPECS_TBL for ^DATA_SCHEME..TIMETABLES_SPECS_TBL;
prompt ... create synonym "^APP_SCHEME..TIMETABLES_TBL"
create or replace synonym ^APP_SCHEME..TIMETABLES_TBL for ^DATA_SCHEME..TIMETABLES_TBL;
prompt ... create synonym "^APP_SCHEME..USERS"
create or replace synonym ^APP_SCHEME..USERS for ^DATA_SCHEME..USERS;
prompt ... create synonym "^APP_SCHEME..USERS_DEPTS_TBL"
create or replace synonym ^APP_SCHEME..USERS_DEPTS_TBL for ^DATA_SCHEME..USERS_DEPTS_TBL;
prompt ... create synonym "^APP_SCHEME..UTILS"
create or replace synonym ^APP_SCHEME..UTILS for ^DATA_SCHEME..UTILS;
prompt ... create synonym "^APP_SCHEME..VLOG"
create or replace synonym ^APP_SCHEME..VLOG for ^DATA_SCHEME..VLOG;
prompt ... create synonym "^APP_SCHEME..WORKDAYS_TBL"
create or replace synonym ^APP_SCHEME..WORKDAYS_TBL for ^DATA_SCHEME..WORKDAYS_TBL;
prompt ... create synonym "^APP_SCHEME..WORKDAYS_TBL"
create or replace synonym ^APP_SCHEME..WORKDAYS_TBL for ^DATA_SCHEME..WORKDAYS_TBL;


--------------------------------------------
-- G R A N T S
--
prompt ... grant on "^DATA_SCHEME..COLLECTIONS_TBL"
grant select on ^DATA_SCHEME..COLLECTIONS_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..COMPANIES_TBL"
grant select on ^DATA_SCHEME..COMPANIES_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..DAYS_TYPES_TBL"
grant select on ^DATA_SCHEME..DAYS_TYPES_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..DEPARTMENTS_TBL"
grant select on ^DATA_SCHEME..DEPARTMENTS_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..DEPTS_PROPERTIES_TBL"
grant select on ^DATA_SCHEME..DEPTS_PROPERTIES_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..DUTIES_HIST_TBL"
grant select on ^DATA_SCHEME..DUTIES_HIST_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..DUTIES_TBL";
grant select on ^DATA_SCHEME..DUTIES_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..DUTIES_TYPES_TBL";
grant select on ^DATA_SCHEME..DUTIES_TYPES_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..EMPLOYEES_TBL"
grant select on ^DATA_SCHEME..EMPLOYEES_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..HOLIDAYS_SCHEDULES_TBL"
grant select on ^DATA_SCHEME..HOLIDAYS_SCHEDULES_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..HOLISCHED_SPECS_DATA_TBL"
grant select on ^DATA_SCHEME..HOLISCHED_SPECS_DATA_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..HOLISCHED_SPECS_TBL"
grant select on ^DATA_SCHEME..HOLISCHED_SPECS_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..HOURS_TYPES_TBL"
grant select on ^DATA_SCHEME..HOURS_TYPES_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_APPINFO"
grant execute on ^DATA_SCHEME..I_APPINFO to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_DEPTS_PROPERTIES"
grant execute on ^DATA_SCHEME..I_DEPTS_PROPERTIES to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_HOLIDAYS_SCHEDULES"
grant execute on ^DATA_SCHEME..I_HOLIDAYS_SCHEDULES to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_MILK"
grant execute on ^DATA_SCHEME..I_MILK to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_MILK2"
grant execute on ^DATA_SCHEME..I_MILK2 to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_PRS_DATA"
grant execute on ^DATA_SCHEME..I_PRS_DATA to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_TIMETABLES"
grant execute on ^DATA_SCHEME..I_TIMETABLES to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_TIMETABLES_SPECS"
grant execute on ^DATA_SCHEME..I_TIMETABLES_SPECS to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_TIMETABLES_SPECS_DAYS"
grant execute on ^DATA_SCHEME..I_TIMETABLES_SPECS_DAYS to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_TIMETABLES_SPECS_HOURS"
grant execute on ^DATA_SCHEME..I_TIMETABLES_SPECS_HOURS to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_USERS"
grant execute on ^DATA_SCHEME..I_USERS to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_USERS_DEPTS"
grant execute on ^DATA_SCHEME..I_USERS_DEPTS to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..I_WORKDAYS"
grant execute on ^DATA_SCHEME..I_WORKDAYS to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..LOG_LEVELS"
grant select on ^DATA_SCHEME..LOG_LEVELS to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..MILK_COST2_TBL"
grant select on ^DATA_SCHEME..MILK_COST2_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..MILK_DEPT_REGISTER_TBL"
grant select on ^DATA_SCHEME..MILK_DEPT_REGISTER_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..MILK_DEPT_REGISTER2_TBL"
grant select on ^DATA_SCHEME..MILK_DEPT_REGISTER2_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..MILK_DEPT_SPECS_TBL"
grant select on ^DATA_SCHEME..MILK_DEPT_SPECS_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..MILK_DEPT_SPECS2_TBL"
grant select on ^DATA_SCHEME..MILK_DEPT_SPECS2_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..MILK_ENT_REGISTER_TBL"
grant select on ^DATA_SCHEME..MILK_ENT_REGISTER_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..PERSONS_TBL"
grant select on ^DATA_SCHEME..PERSONS_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..PLOG"
grant execute on ^DATA_SCHEME..PLOG to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..PLOGPARAM"
grant execute on ^DATA_SCHEME..PLOGPARAM to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..POSTS_TBL"
grant select on ^DATA_SCHEME..POSTS_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..SPEC_DAYS_DIVERGENCE"
grant select on ^DATA_SCHEME..SPEC_DAYS_DIVERGENCE to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..SPEC_HOURS_DIVERGENCE"
grant select on ^DATA_SCHEME..SPEC_HOURS_DIVERGENCE to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..STD"
grant execute on ^DATA_SCHEME..STD to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..TIMETABLE_DAYS_DIVERGENCE"
grant select on ^DATA_SCHEME..TIMETABLE_DAYS_DIVERGENCE to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..TIMETABLE_HOURS_DIVERGENCE"
grant select on ^DATA_SCHEME..TIMETABLE_HOURS_DIVERGENCE to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..TIMETABLES_SPECS_DAYS_TBL"
grant select on ^DATA_SCHEME..TIMETABLES_SPECS_DAYS_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..TIMETABLES_SPECS_HOURS_TBL"
grant select on ^DATA_SCHEME..TIMETABLES_SPECS_HOURS_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..TIMETABLES_SPECS_TBL"
grant select on ^DATA_SCHEME..TIMETABLES_SPECS_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..TIMETABLES_TBL"
grant select on ^DATA_SCHEME..TIMETABLES_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..USERS"
grant select on ^DATA_SCHEME..USERS to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..USERS_DEPTS_TBL"
grant select on ^DATA_SCHEME..USERS_DEPTS_TBL to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..UTILS"
grant execute on ^DATA_SCHEME..UTILS to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..VLOG"
grant select on ^DATA_SCHEME..VLOG to ^APP_SCHEME;
prompt ... grant on "^DATA_SCHEME..WORKDAYS_TBL"
grant select on ^DATA_SCHEME..WORKDAYS_TBL to ^APP_SCHEME;
