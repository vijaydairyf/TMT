Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Разные именованные коллекции.
Rem
Rem    Short CLCT
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "COLLECTIONS_TBL"
create table COLLECTIONS_TBL
(
   id         number not null
  ,value_no   number not null
  ,category  varchar2(30) not null
  ,value_name varchar2(250) not null
);

comment on table COLLECTIONS_TBL is 'Разные именованные коллекции';
comment on column COLLECTIONS_TBL.id is 'Идентификатор';
comment on column COLLECTIONS_TBL.category is 'Категория коллекции';
comment on column COLLECTIONS_TBL.value_no is 'Номер значения';
comment on column COLLECTIONS_TBL.value_name is 'Наименование значения';


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "CLCT_PK"
alter table COLLECTIONS_TBL add constraint CLCT_PK primary key (ID);
prompt ... creating constraint "CLCT_CATNO_UK"
alter table COLLECTIONS_TBL add constraint CLCT_CATNO_UK unique (CATEGORY, VALUE_NO);
