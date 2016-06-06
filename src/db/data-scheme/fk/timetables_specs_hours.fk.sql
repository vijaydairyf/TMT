Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "TIMETABLES_SPECS_HOURS_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "TIMETABLES_SPECS_HOURS_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "TMSPH_HOURS_TYPE"
create index TMSPH_HOURS_TYPE on TIMETABLES_SPECS_HOURS_TBL (hours_type_id)
prompt ... creating index "TMSPH_SPEC"
create index TMSPH_SPEC on TIMETABLES_SPECS_HOURS_TBL (timetable_spec_id)


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "TMSPH_SPEC_FK"
alter table TIMETABLES_SPECS_HOURS_TBL add constraint TMSPH_SPEC_FK foreign key (timetable_spec_id)
    references TIMETABLES_SPECS_TBL (id) on delete cascade deferrable initially immediate;
