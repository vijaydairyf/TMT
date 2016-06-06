Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "TIMETABLES_SPECS_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "TIMETABLES_SPECS_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "TMSP_TIMETABLE"
create index TMSP_TIMETABLE on TIMETABLES_SPECS_TBL (timetable_id)


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "TMSP_TIMNETABLE_FK"
alter table TIMETABLES_SPECS_TBL add constraint TMSP_TIMNETABLE_FK foreign key (timetable_id)
    references TIMETABLES_TBL (id) on delete cascade deferrable initially immediate;
