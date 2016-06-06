Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "DEPTS_PROPERTIES_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "DEPTS_PROPERTIES_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "DEPTS_PROPS_DEPT"
create index DEPTS_PROPS_DEPT on DEPTS_PROPERTIES_TBL (dept_id);


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "DEPTS_PROPS_DEPT_FK"
alter table DEPTS_PROPERTIES_TBL add constraint DEPTS_PROPS_DEPT_FK foreign key (dept_id)
    references PARUS.INS_DEPARTMENT (RN) on delete cascade deferrable initially immediate;
