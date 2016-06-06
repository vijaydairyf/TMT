Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Подразделения Пользователей.
Rem
Rem    Short USDPT
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "USERS_DEPTS_TBL"
create table USERS_DEPTS_TBL
(
   id         NUMBER not null
  --
  ,created      timestamp default systimestamp not null enable  -- когда создано
  ,creator      varchar2 (35 char) not null enable              -- кто создал
  ,updated      timestamp default systimestamp not null enable  -- когда последний раз изменялось
  ,updater      varchar2 (35 char) not null enable              -- кто последний изменил
  --
  ,user_id    NUMBER not null
  ,company_id NUMBER not null
  ,dept_id    NUMBER not null
);

comment on table USERS_DEPTS_TBL is 'Подразделения Пользователей';
comment on column USERS_DEPTS_TBL.id is 'Идентификатор записи';
comment on column USERS_DEPTS_TBL.user_id is 'Идентификатор пользователя';
comment on column USERS_DEPTS_TBL.company_id is 'Идентификатор организации в Парус';
comment on column USERS_DEPTS_TBL.dept_id is 'Идентификатор подразделения в Парус';


--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "USDPT_COMPANY"
create index USDPT_COMPANY on USERS_DEPTS_TBL (company_id);
prompt ... creating index "USDPT_DEPT"
create index USDPT_DEPT on USERS_DEPTS_TBL (dept_id);


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "USDPT_PK"
alter table USERS_DEPTS_TBL add constraint USDPT_PK primary key (id);
