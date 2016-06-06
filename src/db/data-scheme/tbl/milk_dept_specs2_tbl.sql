Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Спецификация ведомости на спецпитание.
Rem
Rem    Short MDSP2
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "MILK_DEPT_SPECS2_TBL"
create table MILK_DEPT_SPECS2_TBL
(
   id                number not null enable
  --
  ,created           timestamp default systimestamp not null enable  -- Когда создано
  ,creator           varchar2 (35 char) not null enable              -- Кто создал
  ,updated           timestamp default systimestamp not null enable  -- Когда последний раз изменялось
  ,updater           varchar2 (35 char) not null enable              -- Кто последний изменил
  --
  ,year_month        number not null enable
  ,dpt_register_id   number not null enable
  ,emp_id            number not null enable
  ,emp_post_id       number not null enable
  ,work_off          number default 0 not null enable
);

comment on table MILK_DEPT_SPECS2_TBL is 'Спецификация ведомости на спецпитание';
comment on column MILK_DEPT_SPECS2_TBL.id is 'Идентификатор записи';
comment on column MILK_DEPT_SPECS2_TBL.dpt_register_id is 'Идентификатор ведомости на спецпитание';
comment on column MILK_DEPT_SPECS2_TBL.emp_id is 'Идентификатор сотрудника в Парус';
comment on column MILK_DEPT_SPECS2_TBL.emp_post_id is 'Идентификатор должности сотрудника в Парус.';
comment on column MILK_DEPT_SPECS2_TBL.work_off is 'Отработано (смен)';


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "MDSP2_PK"
alter table MILK_DEPT_SPECS2_TBL add constraint MDSP2_PK primary key (id);


--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "MDSP2_YEAR_MONTH"
create index MDSP2_YEAR_MONTH on MILK_DEPT_SPECS2_TBL (year_month);
