Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      WORKDAYS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "WORKDAYS"
create or replace view WORKDAYS as
select work_year   as work_year
      ,work_month  as work_month
      ,utils.month_name(work_month) as work_month_name
      ,workdays    as workdays
  from workdays_tbl
;
