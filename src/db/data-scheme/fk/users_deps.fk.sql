Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "USERS_DEPTS_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "USERS_DEPTS_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "USDPT_USER"
create index USDPT_USER on USERS_DEPTS_TBL (user_id);


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "USDPT_USER_FK"
alter table USERS_DEPTS_TBL add constraint USDPT_USER_FK foreign key (user_id)
    references USERS_TBL (id) on delete cascade deferrable initially immediate;
