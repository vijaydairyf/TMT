Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Данные графика отпусков.
Rem
Rem    Short HLSPDT
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T A B L E S
--
prompt ... creating table "HOLISCHED_SPECS_DATA_TBL"
create table HOLISCHED_SPECS_DATA_TBL 
( 
   id            number not null enable
  --
  ,created       timestamp default systimestamp not null enable  -- Когда создано
  ,creator       varchar2 (35 char) not null enable              -- Кто создал
  ,updated       timestamp default systimestamp not null enable  -- Когда последний раз изменялось
  ,updater       varchar2 (35 char) not null enable              -- Кто последний изменил
  --
  ,spec_id       number not null enable    -- Состав графика отпусков
  ,beg_date      date not null enable      -- Дата начала отпуска
  ,days_amount   number not null enable    -- Количество дней
);

comment on table HOLISCHED_SPECS_DATA_TBL is 'Данные графика отпусков';


--------------------------------------------
-- C O N S T R A I N T S
--
prompt ... creating constraint "HLSPDT_PK"
alter table HOLISCHED_SPECS_DATA_TBL add constraint HLSPDT_pk primary key (id);
prompt ... creating constraint "HLSPDT_BEG_DATE_UK"
alter table HOLISCHED_SPECS_DATA_TBL add constraint HLSPDT_BEG_DATE_UK unique (spec_id, beg_date);
