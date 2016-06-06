Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Табели рабочего времени.
Rem
Rem    Short TM
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "TIMETABLES_TBL"
create table TIMETABLES_TBL
(
     id           number not null enable
    --
    ,created      timestamp default systimestamp not null enable  -- когда создано
    ,creator      varchar2 (35 char) not null enable              -- кто создал
    ,updated      timestamp default systimestamp not null enable  -- когда последний раз изменялось
    ,updater      varchar2 (35 char) not null enable              -- кто последний изменил
    --
    ,company_id   number not null enable     -- идентификатор организации в Парус
    ,dept_id      number not null enable     -- идентификатор подразделения в Парус
    ,table_year   number not null enable     -- за который год табель
    ,table_month  number not null enable     -- за который месяц табель
    ,table_type   number not null enable     -- вид табеля: 0 - первичный; 1 - корректировочный
    ,submitted    date                       -- когда табель передан в расчётную часть
    ,accepted     date                       -- когда табель принят для расчёта
);

comment on table TIMETABLES_TBL is 'Табели рабочего времени';
comment on column TIMETABLES_TBL.id is 'Идентификатор табеля';
comment on column TIMETABLES_TBL.company_id is 'Идентификатор организации в Парус';
comment on column TIMETABLES_TBL.dept_id is 'Идентификатор подразделения в Парус';
comment on column TIMETABLES_TBL.table_year is 'За который год табель';
comment on column TIMETABLES_TBL.table_month is 'За который месяц табель';
comment on column TIMETABLES_TBL.submitted is 'Когда табель передан в расчётную часть';
comment on column TIMETABLES_TBL.accepted is 'Когда табель принят для расчёта';
comment on column TIMETABLES_TBL.table_type is 'Вид табеля: 0 - первичный; 1 - корректировочный';


--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "TM_COMPANY"
create index TM_COMPANY on TIMETABLES_TBL ( company_id );
prompt ... creating index "TM_DEPT"
create index TM_DEPT on TIMETABLES_TBL ( dept_id );
prompt ... creating index "TM_MY"
create index TM_MY on TIMETABLES_TBL ( table_year, table_month );


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "TM_PK"
alter table TIMETABLES_TBL add constraint TM_PK primary key ( id );
prompt ... creating constraint "TM_UK"
alter table TIMETABLES_TBL add constraint TM_UK unique ( company_id, dept_id, table_month, table_year, table_type );
prompt ... creating constraint "TM_TYPE_CHK"
alter table TIMETABLES_TBL add constraint TM_TYPE_CHK check ( table_type in ( 0, 1 ));
