Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      MILK_ENT_REGISTER_TBL.
Rem
Rem    Short MEREG
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "MILK_ENT_REGISTER_TBL"
create table MILK_ENT_REGISTER_TBL
(
   id                  number not null enable
  --
  ,created             timestamp default systimestamp not null enable  -- Когда создано
  ,creator             varchar2 (35 char) not null enable              -- Кто создал
  ,updated             timestamp default systimestamp not null enable  -- Когда последний раз изменялось
  ,updater             varchar2 (35 char) not null enable              -- Кто последний изменил
  --
  ,register_year       number not null enable
  ,register_month      number not null enable
  ,register_status     number default 20 not null enable
  ,register_timemark   date default sysdate not null enable
  ,year_month          number not null enable
  ,received            number default 0 not null enable
  ,received_from       varchar2(250)
);


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "MEREG_PK"
alter table MILK_ENT_REGISTER_TBL add constraint MEREG_PK primary key (id);
prompt ... creating constraint "MEREG_UK"
alter table MILK_ENT_REGISTER_TBL add constraint MEREG_UK unique (register_year, register_month);


--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "MEREG_YEAR_MONTH"
create index MEREG_YEAR_MONTH on MILK_ENT_REGISTER_TBL (year_month);
