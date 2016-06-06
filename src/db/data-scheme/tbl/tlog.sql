Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      TLOG.
Rem
Rem    Short TLOG
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "TLOG"
create table TLOG
(
   id       number not null
  ,ldate    date default sysdate
  ,lhsecs   number(38)
  ,llevel   number(38)
  ,lsection varchar2(2000)
  ,ltext    varchar2(2000)
  ,luser    varchar2(30)
);


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "TLOG_PK"
alter table TLOG add constraint TLOG_PK primary key (id);
