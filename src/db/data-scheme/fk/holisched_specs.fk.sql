Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "HOLISCHED_SPECS_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "HOLISCHED_SPECS_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "HLSP_SCHEDULE"
create index HLSP_SCHEDULE on HOLISCHED_SPECS_TBL (schedule_id);
prompt ... creating index "HLSP_EMP"
create index HLSP_EMP on HOLISCHED_SPECS_TBL (emp_id)
prompt ... creating index "HLSP_POST"
create index HLSP_POST on HOLISCHED_SPECS_TBL (post_id)


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "HLSP_SCHEDULE_FK"
alter table HOLISCHED_SPECS_TBL add constraint HLSP_SCHEDULE_FK foreign key (schedule_id)
    references HOLIDAYS_SCHEDULES_TBL on delete cascade deferrable initially immediate;
prompt ... creating constraint "HLSP_EMP_FK"
alter table HOLISCHED_SPECS_TBL add constraint HLSP_EMP_FK foreign key (emp_id)
    references PARUS.CLNPERSONS (rn) deferrable initially immediate;
prompt ... creating constraint "HLSP_POST_FK"
alter table HOLISCHED_SPECS_TBL add constraint HLSP_POST_FK foreign key (post_id)
    references PARUS.CLNPSDEP (rn) deferrable initially immediate;
