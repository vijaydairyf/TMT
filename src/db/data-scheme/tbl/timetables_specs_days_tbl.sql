Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Дни спецификации табеля рабочего времени.
Rem
Rem    Short TMSPD
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "TIMETABLES_SPECS_DAYS_TBL"
create table TIMETABLES_SPECS_DAYS_TBL
(
   id                number not null enable
  --
  ,created           timestamp default systimestamp not null enable  -- когда создано
  ,creator           varchar2 (35 char) not null enable              -- кто создал
  ,updated           timestamp default systimestamp not null enable  -- когда последний раз изменялось
  ,updater           varchar2 (35 char) not null enable              -- кто последний изменил
  --
  ,timetable_spec_id number not null enable
  ,day_date          date not null enable
  ,day_type_id       number
  ,prs_day_type_id   number
);

comment on table TIMETABLES_SPECS_DAYS_TBL is 'Дни спецификации табеля рабочего времени';
comment on column TIMETABLES_SPECS_DAYS_TBL.id is 'Идентификатор';
comment on column TIMETABLES_SPECS_DAYS_TBL.timetable_spec_id is 'Идентификатор спецификации табеля';
comment on column TIMETABLES_SPECS_DAYS_TBL.day_type_id is 'Идентификатор типа дня';


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "TMSPD_PK"
alter table TIMETABLES_SPECS_DAYS_TBL add constraint TMSPD_PK primary key (id);
prompt ... creating constraint "TMSPD_UK"
alter table TIMETABLES_SPECS_DAYS_TBL add constraint TMSPD_UK unique (timetable_spec_id, day_date);
