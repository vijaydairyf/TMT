Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem    Creates foreign key constraints for "HOLISCHED_SPECS_DATA_TBL" table.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating foreign keys constraints for "HOLISCHED_SPECS_DATA_TBL"

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "HLSP_SPEC"
create index HLSP_SPEC on HOLISCHED_SPECS_DATA_TBL (spec_id);


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "HLSP_SPEC_FK"
alter table HOLISCHED_SPECS_DATA_TBL add constraint HLSP_SPEC_FK foreign key (spec_id)
    references HOLISCHED_SPECS_TBL on delete cascade deferrable initially immediate;
