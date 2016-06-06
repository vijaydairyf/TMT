Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Аттрибуты подразделений.
Rem
Rem    Short DEPTS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "DEPTS_PROPERTIES_TBL"
create table DEPTS_PROPERTIES_TBL
(
   id             number not null
  --
  ,created        timestamp default systimestamp not null enable  -- Когда создано
  ,creator        varchar2 (35 char) not null enable              -- Кто создал
  ,updated        timestamp default systimestamp not null enable  -- Когда последний раз изменялось
  ,updater        varchar2 (35 char) not null enable              -- Кто последний изменил
  --
  ,dept_id        number not null
  ,curator_post   varchar2(250) not null
  ,curator_name   varchar2(250) not null
  ,manager_name   varchar2(250)
  ,milk_resp_name varchar2(250)
);

comment on table DEPTS_PROPERTIES_TBL is 'Аттрибуты подразделений';
comment on column DEPTS_PROPERTIES_TBL.id is 'Идентификатор записи';
comment on column DEPTS_PROPERTIES_TBL.dept_id is 'Идентификатор подразделения в Парус';
comment on column DEPTS_PROPERTIES_TBL.curator_post is 'Должность куратора подразделения.';
comment on column DEPTS_PROPERTIES_TBL.curator_name is 'Куратор подразделения.';
comment on column DEPTS_PROPERTIES_TBL.manager_name is 'Руководитель подразделения.';
comment on column DEPTS_PROPERTIES_TBL.milk_resp_name is 'Ответственный за спецпитание по подразделению.';

--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "DEPTS_PROPS_PK"
alter table DEPTS_PROPERTIES_TBL add constraint DEPTS_PROPS_PK primary key (ID);
