Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "TIMETABLES_SPECS_DAYS_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "TIMETABLES_SPECS_DAYS_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "TMSPD_DAY_TYPE"
create index TMSPD_DAY_TYPE on TIMETABLES_SPECS_DAYS_TBL (day_type_id)
prompt ... creating index "TMSPD_SPEC"
create index TMSPD_SPEC on TIMETABLES_SPECS_DAYS_TBL (timetable_spec_id)


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "TMSPD_SPEC_FK"
alter table TIMETABLES_SPECS_DAYS_TBL add constraint TMSPD_SPEC_FK foreign key (timetable_spec_id)
    references TIMETABLES_SPECS_TBL (id) on delete cascade deferrable initially immediate;
