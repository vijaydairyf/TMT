Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Часы спецификации табеля рабочего времени.
Rem
Rem    Short TMSPH
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "TIMETABLES_SPECS_HOURS_TBL"
create table TIMETABLES_SPECS_HOURS_TBL
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
  ,hours_type_id     number not null enable
  ,hours_amount      number default 0 not null enable
  ,prs_hours_amount  number
);

comment on table TIMETABLES_SPECS_HOURS_TBL is 'Часы спецификации табеля рабочего времени';
comment on column TIMETABLES_SPECS_HOURS_TBL.id is 'Идентификатор';
comment on column TIMETABLES_SPECS_HOURS_TBL.timetable_spec_id is 'Идентификатор спецификации табеля';
comment on column TIMETABLES_SPECS_HOURS_TBL.hours_type_id is 'Идентификатор типа часов';
comment on column TIMETABLES_SPECS_HOURS_TBL.hours_amount is 'Количество часов';


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "TMSPH_PK"
alter table TIMETABLES_SPECS_HOURS_TBL add constraint TMSPH_PK primary key (id);
prompt ... creating constraint "TMSPH_UK"
alter table TIMETABLES_SPECS_HOURS_TBL add constraint TMSPH_UK unique (timetable_spec_id, day_date, hours_type_id);
