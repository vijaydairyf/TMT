Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      TIMETABLES_SPECS_DATA
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "TIMETABLES_SPECS_DATA"
create or replace view TIMETABLES_SPECS_DATA as
select t.id                             as timetable_spec_id
      ,t.day_date                       as day_date
      ,extract(day from t.day_date)     as day_day
      ,to_char(t.day_date,'d')          as week_day
      ,days.day_type_id                 as day_type_id
      ,decode(hours.main_hours,0,to_number(null),hours.main_hours)              as main_hours
      ,decode(hours.night_hours,0,to_number(null),hours.night_hours)            as night_hours
      ,decode(hours.dayoff_hours,0,to_number(null),hours.dayoff_hours)          as dayoff_hours
      ,decode(hours.holiday_hours,0,to_number(null),hours.holiday_hours)        as holiday_hours
      ,decode(hours.hazard_hours,0,to_number(null),hours.hazard_hours)          as hazard_hours
      ,decode(hours.hazard_old_hours,0,to_number(null),hours.hazard_old_hours)  as hazard_old_hours
  from (
      select id, beg_date + day_no - 1 as day_date, last_day(beg_date) as end_date
        from
          (
          select to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy') as beg_date
                 ,ts.id as id
                 ,days_pool.day_no as day_no
            from timetables_tbl t, timetables_specs_tbl ts
                 ,(SELECT rownum day_no FROM (SELECT null FROM dual GROUP BY CUBE(1,2,3,4,5)) WHERE  ROWNUM < 32) days_pool
           where ts.timetable_id = t.id
          )
       ) t,
       (
       select h.timetable_spec_id, h.day_date
             ,sum(decode(ht.code,'О',h.hours_amount,0)) as main_hours
             ,sum(decode(ht.code,'Н',h.hours_amount,0)) as night_hours
             ,sum(decode(ht.code,'В',h.hours_amount,0)) as dayoff_hours
             ,sum(decode(ht.code,'П',h.hours_amount,0)) as holiday_hours
             ,sum(decode(ht.code,'Врд',h.hours_amount,0)) as hazard_hours
             ,sum(decode(ht.code,'ВрдП',h.hours_amount,0)) as hazard_old_hours
         from timetables_specs_hours_tbl h, hours_types_tbl ht
        where h.hours_type_id = ht.id
        group by h.timetable_spec_id, h.day_date
      ) hours,
      timetables_specs_days_tbl days
 where t.day_date <= t.end_date
   and t.id = days.timetable_spec_id(+)
   and t.day_date = days.day_date(+)
   and t.id = hours.timetable_spec_id(+)
   and t.day_date = hours.day_date(+)
;
