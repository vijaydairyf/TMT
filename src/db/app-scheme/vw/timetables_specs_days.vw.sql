Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      TIMETABLES_SPECS_DAYS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "TIMETABLES_SPECS_DAYS"
create or replace view TIMETABLES_SPECS_DAYS as
select
  ts.timetable_id         as timetable_id
 ,tsd.timetable_spec_id   as timetable_spec_id
 ,max(decode(to_char(tsd.day_date,'dd'),'01',dt.code,null))  as d1
 ,max(decode(to_char(tsd.day_date,'dd'),'02',dt.code,null))  as d2
 ,max(decode(to_char(tsd.day_date,'dd'),'03',dt.code,null))  as d3
 ,max(decode(to_char(tsd.day_date,'dd'),'04',dt.code,null))  as d4
 ,max(decode(to_char(tsd.day_date,'dd'),'05',dt.code,null))  as d5
 ,max(decode(to_char(tsd.day_date,'dd'),'06',dt.code,null))  as d6
 ,max(decode(to_char(tsd.day_date,'dd'),'07',dt.code,null))  as d7
 ,max(decode(to_char(tsd.day_date,'dd'),'08',dt.code,null))  as d8
 ,max(decode(to_char(tsd.day_date,'dd'),'09',dt.code,null))  as d9
 ,max(decode(to_char(tsd.day_date,'dd'),'10',dt.code,null))  as d10
 ,max(decode(to_char(tsd.day_date,'dd'),'11',dt.code,null))  as d11
 ,max(decode(to_char(tsd.day_date,'dd'),'12',dt.code,null))  as d12
 ,max(decode(to_char(tsd.day_date,'dd'),'13',dt.code,null))  as d13
 ,max(decode(to_char(tsd.day_date,'dd'),'14',dt.code,null))  as d14
 ,max(decode(to_char(tsd.day_date,'dd'),'15',dt.code,null))  as d15
 ,max(decode(to_char(tsd.day_date,'dd'),'16',dt.code,null))  as d16
 ,max(decode(to_char(tsd.day_date,'dd'),'17',dt.code,null))  as d17
 ,max(decode(to_char(tsd.day_date,'dd'),'18',dt.code,null))  as d18
 ,max(decode(to_char(tsd.day_date,'dd'),'19',dt.code,null))  as d19
 ,max(decode(to_char(tsd.day_date,'dd'),'20',dt.code,null))  as d20
 ,max(decode(to_char(tsd.day_date,'dd'),'21',dt.code,null))  as d21
 ,max(decode(to_char(tsd.day_date,'dd'),'22',dt.code,null))  as d22
 ,max(decode(to_char(tsd.day_date,'dd'),'23',dt.code,null))  as d23
 ,max(decode(to_char(tsd.day_date,'dd'),'24',dt.code,null))  as d24
 ,max(decode(to_char(tsd.day_date,'dd'),'25',dt.code,null))  as d25
 ,max(decode(to_char(tsd.day_date,'dd'),'26',dt.code,null))  as d26
 ,max(decode(to_char(tsd.day_date,'dd'),'27',dt.code,null))  as d27
 ,max(decode(to_char(tsd.day_date,'dd'),'28',dt.code,null))  as d28
 ,max(decode(to_char(tsd.day_date,'dd'),'29',dt.code,null))  as d29
 ,max(decode(to_char(tsd.day_date,'dd'),'30',dt.code,null))  as d30
 ,max(decode(to_char(tsd.day_date,'dd'),'31',dt.code,null))  as d31
  from timetables_specs_tbl ts, timetables_specs_days_tbl tsd, days_types_tbl dt
 where tsd.timetable_spec_id = ts.id
   and tsd.day_type_id = dt.id(+)
   and dt.code <> 'Суббота'  -- Этот тип дня не показываеть в табеле, вместо него часы
 group by ts.timetable_id, tsd.timetable_spec_id
;
