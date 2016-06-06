Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "MILK_DEPT_REGISTER2_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "MILK_DEPT_REGISTER2_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "MDREG2_DEPT"
create index MDREG2_DEPT on MILK_DEPT_REGISTER2_TBL (dept_id);


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "MDREG2_DEPT_FK"
alter table MILK_DEPT_REGISTER2_TBL add constraint MDREG2_DEPT_FK foreign key (dept_id)
    references PARUS.INS_DEPARTMENT (rn) deferrable initially immediate;
