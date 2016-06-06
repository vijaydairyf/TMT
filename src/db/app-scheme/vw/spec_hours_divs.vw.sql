Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      SPEC_HOURS_DIVS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "SPEC_HOURS_DIVS"
create or replace view SPEC_HOURS_DIVS
(spec_id, emp_id, post_id, wage_rate, day_date, prs_hours_type_id, timetable_hours_type_id, prs_hours_type, prs_hours_amount, timetable_hours_type, timetable_hours_amount, parus_value, timetable_value)
as
select
    hd.spec_id              as spec_id
   ,hd.emp_id               as emp_id
   ,hd.post_id              as post_id
   ,hd.wage_rate            as wage_rate
   ,hd.day_date             as day_date
   ,hd.prs_hours_type_id    as prs_hours_type_id
   ,hd.table_hours_type_id  as timetable_hours_type_id
   ,ht1.name                as prs_hours_type
   ,hd.prs_hours_amount     as prs_hours_amount
   ,ht2.name                as timetable_hours_type
   ,hd.table_hours_amount   as timetable_hours_amount
   ,nvl2(ht1.code,ht1.code||nvl2(hd.prs_hours_amount,', '||hd.prs_hours_amount,null),hd.prs_hours_amount)        as parus_valus
   ,nvl2(ht2.code,ht2.code||nvl2(hd.table_hours_amount,', '||hd.table_hours_amount,null),hd.table_hours_amount)  as timetable_value
    from spec_hours_divergence hd, hours_types_tbl ht1, hours_types_tbl ht2
   where hd.prs_hours_type_id = ht1.id(+)
     and hd.table_hours_type_id = ht2.id(+)
;
