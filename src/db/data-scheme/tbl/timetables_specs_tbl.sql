Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Спецификация табеля рабочего времени.
Rem
Rem    Short TMSP
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "TIMETABLES_SPECS_TBL"
create table TIMETABLES_SPECS_TBL
(
   id               number not null enable
  --
  ,created           timestamp default systimestamp not null enable  -- когда создано
  ,creator           varchar2 (35 char) not null enable              -- кто создал
  ,updated           timestamp default systimestamp not null enable  -- когда последний раз изменялось
  ,updater           varchar2 (35 char) not null enable              -- кто последний изменил
  --
  ,timetable_id     number not null enable
  ,emp_id           number not null enable
  ,post_id          number not null enable
  ,wage_rate        number not null enable
  ,prs_duty_hist_id number not null enable
);

comment on table TIMETABLES_SPECS_TBL is 'Спецификация табеля рабочего времени';
comment on column TIMETABLES_SPECS_TBL.id is 'Идентификатор спецификации табеля';
comment on column TIMETABLES_SPECS_TBL.timetable_id is 'Идентификатор табеля';
comment on column TIMETABLES_SPECS_TBL.emp_id is 'Идентификатор сотрудника в Парус';


--------------------------------------------
-- I N D E X E S
--
prompt ... creating index "TMSP_EMP"
create index TMSP_EMP on TIMETABLES_SPECS_TBL (emp_id);
prompt ... creating index "TMSP_HIST"
create index TMSP_HIST on TIMETABLES_SPECS_TBL (prs_duty_hist_id);

--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "TMSP_PK"
alter table TIMETABLES_SPECS_TBL add constraint TMSP_PK primary key (id);
prompt ... creating constraint "TMSP_UK"
alter table TIMETABLES_SPECS_TBL add constraint TMSP_UK unique (timetable_id, prs_duty_hist_id);
