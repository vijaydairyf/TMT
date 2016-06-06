Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Пользователи.
Rem
Rem    Short USR
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "USERS_TBL"
create table USERS_TBL 
( 
   id               number not null enable
  --
  ,created      timestamp default systimestamp not null enable  -- когда создано
  ,creator      varchar2 (35 char) not null enable              -- кто создал
  ,updated      timestamp default systimestamp not null enable  -- когда последний раз изменялось
  ,updater      varchar2 (35 char) not null enable              -- кто последний изменил
  --
  ,username         varchar2(250 char) not null enable
  ,userpass         varchar2(250 char) not null enable
  ,fullname         varchar2(250 char) not null enable
  ,is_admin         char(1 char) default '-' not null enable
  ,is_accounter     char(1 char) default '-' not null enable
  ,is_timekeeper    char(1 char) default '+' not null enable
  ,is_holischeduler char(1 char) default '+' not null enable
  ,is_dept_milk     char(1 char) default '-' not null enable
  ,is_ent_milk      char(1 char) default '-' not null enable
  ,is_hr            char(1 char) default '-' not null enable
  ,expires          date
  ,phone            varchar2(33)
  ,room             varchar2(30)
  ,notes            varchar2(4000 char)
);

comment on table USERS_TBL is 'Пользователи';
comment on column USERS_TBL.id is 'Идентификатор пользователя';
comment on column USERS_TBL.username is 'Имя пользователя';
comment on column USERS_TBL.userpass is 'Пароль пользователя';
comment on column USERS_TBL.fullname is 'Полное имя пользователя';
comment on column USERS_TBL.created is 'Дата создания пользователя';
comment on column USERS_TBL.is_admin is 'Пользователь является администратором';
comment on column USERS_TBL.is_accounter is 'Пользователь является сотрудником расчётного отдела бухгалтерии';
comment on column USERS_TBL.is_timekeeper is 'Пользователь является табельщиком';
comment on column USERS_TBL.expires is 'Дата окончания действия';
comment on column USERS_TBL.notes is 'Примечания';
comment on column USERS_TBL.is_holischeduler is 'Пользователь составляет графики отпусков';
comment on column USERS_TBL.is_dept_milk is 'Пользователь ответственный за спецпитания по подразделению';
comment on column USERS_TBL.is_ent_milk is 'Пользователь ответственный за спецпитания по предприятию';
comment on column USERS_TBL.is_hr is 'Пользователь является сотрудником отдела кадров';


--------------------------------------------
-- I N D E X E S
--


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "USR_PK"
alter table USERS_TBL add constraint USR_PK primary key (id);
prompt ... creating constraint "USR_UNAME_UK"
alter table USERS_TBL add constraint USR_UNAME_UK unique (username);
prompt ... creating constraint "USR_IS_ACCOUNTER"
alter table USERS_TBL add constraint USR_IS_ACCOUNTER check (is_accounter in ('-','+'));
prompt ... creating constraint "USR_IS_ADMIN"
alter table USERS_TBL add constraint USR_IS_ADMIN check (is_admin in ('-','+'));
prompt ... creating constraint "USR_IS_TIMEKEEPER"
alter table USERS_TBL add constraint USR_IS_TIMEKEEPER check (is_timekeeper in ('-','+'));
