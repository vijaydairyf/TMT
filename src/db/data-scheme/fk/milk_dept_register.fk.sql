Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "MILK_DEPT_REGISTER_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "MILK_DEPT_REGISTER_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "MDREG_DEPT"
create index MDREG_DEPT on MILK_DEPT_REGISTER_TBL (dept_id);
prompt ... creating index "MDREG_ENT_REGISTER"
create index MDREG_ENT_REGISTER on MILK_DEPT_REGISTER_TBL (ent_register_id);


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "MDREG_DEPT_FK"
alter table MILK_DEPT_REGISTER_TBL add constraint MDREG_DEPT_FK foreign key (dept_id)
    references PARUS.INS_DEPARTMENT (rn) deferrable initially immediate;
prompt ... creating constraint "MDREG_ENT_REGISTER_FK"
alter table MILK_DEPT_REGISTER_TBL add constraint MDREG_ENT_REGISTER_FK foreign key (ent_register_id)
    references MILK_ENT_REGISTER_TBL (id) on delete set null deferrable initially immediate;
