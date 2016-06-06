Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Ведомости на спецпитание (молоко).
Rem
Rem    Short MDREG2
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "MILK_DEPT_REGISTER2_TBL"
create table MILK_DEPT_REGISTER2_TBL
(
   id                number not null enable
  --
  ,created           timestamp default systimestamp not null enable  -- Когда создано
  ,creator           varchar2 (35 char) not null enable              -- Кто создал
  ,updated           timestamp default systimestamp not null enable  -- Когда последний раз изменялось
  ,updater           varchar2 (35 char) not null enable              -- Кто последний изменил
  --
  ,dept_id           number not null enable
  ,register_year     number not null enable
  ,register_month    number not null enable
  ,year_month        number not null enable
  ,register_status   number default 10 not null enable
  ,register_timemark date default sysdate not null enable
);

comment on table MILK_DEPT_REGISTER2_TBL is 'Ведомости на спецпитание (молоко)';
comment on column MILK_DEPT_REGISTER2_TBL.id is 'Идентификатор записи';
comment on column MILK_DEPT_REGISTER2_TBL.dept_id is 'Идентификатор подразделения в Парус';
comment on column MILK_DEPT_REGISTER2_TBL.register_year is 'Год ведомости';
comment on column MILK_DEPT_REGISTER2_TBL.register_month is 'Месяц ведомости';
comment on column MILK_DEPT_REGISTER2_TBL.register_status is 'Состояние - Заявка/Ведомость/Закрыто';
comment on column MILK_DEPT_REGISTER2_TBL.register_timemark is 'Дата и время смены состояния ведомости';


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "MDREG2_PK"
alter table MILK_DEPT_REGISTER2_TBL add constraint MDREG2_PK primary key (id);
prompt ... creating constraint "MDREG2_YEAR_MONTH_UK"
alter table MILK_DEPT_REGISTER2_TBL add constraint MDREG2_YEAR_MONTH_UK unique (register_year, register_month, dept_id);

--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "MDREG2_YEAR_MONTH"
create index MDREG2_YEAR_MONTH on MILK_DEPT_REGISTER2_TBL (year_month);
