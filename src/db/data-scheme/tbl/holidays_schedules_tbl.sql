Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Графики отпусков.
Rem
Rem    Short HLSCH
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "HOLIDAYS_SCHEDULES_TBL"
create table HOLIDAYS_SCHEDULES_TBL 
( 
   id               number not null enable
  --
  ,created          timestamp default systimestamp not null enable  -- Когда создано
  ,creator          varchar2 (35 char) not null enable              -- Кто создал
  ,updated          timestamp default systimestamp not null enable  -- Когда последний раз изменялось
  ,updater          varchar2 (35 char) not null enable              -- Кто последний изменил
  --
  ,company_id       number not null enable    -- Компания
  ,dept_id          number not null enable    -- Подразделение
  ,schedule_year    number not null enable    -- Год графика
);

comment on table HOLIDAYS_SCHEDULES_TBL is 'Графики отпусков';


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "HLSCH_PK"
alter table HOLIDAYS_SCHEDULES_TBL add constraint HLSCH_PK primary key (id);
prompt ... creating constraint "HLSCH_YEAR_UK"
alter table HOLIDAYS_SCHEDULES_TBL add constraint HLSCH_YEAR_UK unique (company_id, dept_id, schedule_year);
