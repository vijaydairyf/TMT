Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Норма стоимости литра молока.
Rem
Rem    Short MCST2
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "MILK_COST2_TBL"
create table MILK_COST2_TBL 
( 
   id          number not null enable
  --
  ,created     timestamp default systimestamp not null enable  -- Когда создано
  ,creator     varchar2 (35 char) not null enable              -- Кто создал
  ,updated     timestamp default systimestamp not null enable  -- Когда последний раз изменялось
  ,updater     varchar2 (35 char) not null enable              -- Кто последний изменил
  --
  ,year_month  number not null enable
  ,cost_year   number not null enable
  ,cost_month  number not null enable
  ,cost_value  number not null enable
);

comment on table MILK_COST2_TBL is 'Норма стоимости литра молока';

--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "MCST2_PK"
alter table MILK_COST2_TBL add constraint MCST2_PK primary key (id);

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "MCST2_MONTH_YEAR"
create unique index MCST2_MONTH_YEAR on MILK_COST2_TBL (cost_year, cost_month);
prompt ... creating index "MCST2_YEAR_MONTH"
create index MCST2_YEAR_MONTH on MILK_COST2_TBL (year_month);
