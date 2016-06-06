Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Состав графиков отпусков.
Rem
Rem    Short HLSP
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "HOLISCHED_SPECS_TBL"
create table HOLISCHED_SPECS_TBL 
( 
   id             number not null enable
  --
  ,created        timestamp default systimestamp not null enable  -- Когда создано
  ,creator        varchar2 (35 char) not null enable              -- Кто создал
  ,updated        timestamp default systimestamp not null enable  -- Когда последний раз изменялось
  ,updater        varchar2 (35 char) not null enable              -- Кто последний изменил
  --
  ,schedule_id    number not null enable     -- График отпусков
  ,emp_id         number not null enable     -- Сотрудник
  ,post_id        number not null enable     -- Должность
);

comment on table HOLISCHED_SPECS_TBL is 'Состав графиков отпусков';


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "HLSP_PK"
alter table HOLISCHED_SPECS_TBL add constraint HLSP_pk primary key (id);
