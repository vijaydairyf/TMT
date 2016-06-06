Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "MILK_DEPT_SPECS_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "MILK_DEPT_SPECS_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "MDSP_EMP"
create index MDSP_EMP on MILK_DEPT_SPECS_TBL (emp_id)
prompt ... creating index "MDSP_EMP_POST"
create index MDSP_EMP_POST on MILK_DEPT_SPECS_TBL (emp_post_id)
prompt ... creating index "MDSP_REGISTER"
create index MDSP_REGISTER on MILK_DEPT_SPECS_TBL (dpt_register_id)


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "MDSP_EMP_FK"
alter table MILK_DEPT_SPECS_TBL add constraint MDSP_EMP_FK foreign key (emp_id)
    references PARUS.CLNPERSONS (rn) deferrable initially immediate;
prompt ... creating constraint "MDSP_EMP_POST_FK"
alter table MILK_DEPT_SPECS_TBL add constraint MDSP_EMP_POST_FK foreign key (emp_post_id)
    references PARUS.CLNPSDEP (rn) deferrable initially immediate;
prompt ... creating constraint "MDSP_MLKTBL_FK"
alter table MILK_DEPT_SPECS_TBL add constraint MDSP_MLKTBL_FK foreign key (dpt_register_id)
    references MILK_DEPT_REGISTER_TBL (id) on delete cascade deferrable initially immediate;
