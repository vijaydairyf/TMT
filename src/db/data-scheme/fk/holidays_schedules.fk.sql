Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "HOLIDAYS_SCHEDULES_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "HOLIDAYS_SCHEDULES_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "HLSCH_COMPANY"
create index HLSCH_COMPANY on HOLIDAYS_SCHEDULES_TBL (company_id)
prompt ... creating index "HLSCH_DEPT"
create index HLSCH_DEPT on HOLIDAYS_SCHEDULES_TBL (dept_id)


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "HLSCH_COMPANY_FK"
alter table HOLIDAYS_SCHEDULES_TBL add constraint HLSCH_COMPANY_FK foreign key (company_id)
    references PARUS.COMPANIES (rn)  deferrable initially immediate;
prompt ... creating constraint "HLSCH_DEPT_FK"
alter table HOLIDAYS_SCHEDULES_TBL add constraint HLSCH_DEPT_FK foreign key (dept_id)
    references PARUS.INS_DEPARTMENT (rn) deferrable initially immediate;
