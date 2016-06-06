Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      SPEC_DAYS_DIVS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "SPEC_DAYS_DIVS"
create or replace view SPEC_DAYS_DIVS as
select
  dd.spec_id              as spec_id
 ,dd.emp_id               as emp_id
 ,dd.post_id              as post_id
 ,dd.wage_rate            as wage_rate
 ,dd.day_date             as day_date
 ,dd.prs_day_type_id      as prs_day_type_id
 ,dd.table_day_type_id    as table_day_type_id
 ,dt1.code                as prs_day_type
 ,dt2.code                as timetable_day_type
  from spec_days_divergence dd, days_types_tbl dt1, days_types_tbl dt2
 where dd.prs_day_type_id = dt1.id(+)
   and dd.table_day_type_id = dt2.id(+)
;
