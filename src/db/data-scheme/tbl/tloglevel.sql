Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      TLOGLEVEL.
Rem
Rem    Short TLOGLEVEL
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "TLOGLEVEL"
create table TLOGLEVEL
(
   llevel       NUMBER(4) not null
  ,ljlevel      NUMBER(5)
  ,lsyslogequiv NUMBER(4)
  ,lcode        VARCHAR2(10)
  ,ldesc        VARCHAR2(255)
);

--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "TLOGLEVEL_PK"
alter table TLOGLEVEL add constraint TLOGLEVEL_PK primary key (LLEVEL);
