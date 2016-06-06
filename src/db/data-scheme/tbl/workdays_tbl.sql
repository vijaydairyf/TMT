Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      WORKDAYS_TBL.
Rem
Rem    Short WD
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "WORKDAYS_TBL"
create table WORKDAYS_TBL
(
   work_year  NUMBER not null
  ,work_month NUMBER not null
  ,workdays   NUMBER not null
);


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "WD_PK"
alter table WORKDAYS_TBL add constraint WD_PK primary key (work_year, work_month);
prompt ... creating constraint "WD_WORKDAYS_CHK"
alter table WORKDAYS_TBL add constraint WORKDAYS_CHK check (workdays between 1 and 31);
prompt ... creating constraint "WD_WORK_MONTH_CHK"
alter table WORKDAYS_TBL add constraint WD_WORK_MONTH_CHK check (work_month between 1 and 12);
