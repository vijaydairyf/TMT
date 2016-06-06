Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      TT_SP_DAYS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "TT_SP_DAYS"
create or replace view TT_SP_DAYS as
select
  tsd.timetable_spec_id   as timetable_spec_id
 ,decode(to_char(tsd.day_date,'dd'),'01',dt.code,null)  as d1
 ,decode(to_char(tsd.day_date,'dd'),'02',dt.code,null)  as d2
 ,decode(to_char(tsd.day_date,'dd'),'03',dt.code,null)  as d3
 ,decode(to_char(tsd.day_date,'dd'),'04',dt.code,null)  as d4
 ,decode(to_char(tsd.day_date,'dd'),'05',dt.code,null)  as d5
 ,decode(to_char(tsd.day_date,'dd'),'06',dt.code,null)  as d6
 ,decode(to_char(tsd.day_date,'dd'),'07',dt.code,null)  as d7
 ,decode(to_char(tsd.day_date,'dd'),'08',dt.code,null)  as d8
 ,decode(to_char(tsd.day_date,'dd'),'09',dt.code,null)  as d9
 ,decode(to_char(tsd.day_date,'dd'),'10',dt.code,null)  as d10
 ,decode(to_char(tsd.day_date,'dd'),'11',dt.code,null)  as d11
 ,decode(to_char(tsd.day_date,'dd'),'12',dt.code,null)  as d12
 ,decode(to_char(tsd.day_date,'dd'),'13',dt.code,null)  as d13
 ,decode(to_char(tsd.day_date,'dd'),'14',dt.code,null)  as d14
 ,decode(to_char(tsd.day_date,'dd'),'15',dt.code,null)  as d15
 ,decode(to_char(tsd.day_date,'dd'),'16',dt.code,null)  as d16
 ,decode(to_char(tsd.day_date,'dd'),'17',dt.code,null)  as d17
 ,decode(to_char(tsd.day_date,'dd'),'18',dt.code,null)  as d18
 ,decode(to_char(tsd.day_date,'dd'),'19',dt.code,null)  as d19
 ,decode(to_char(tsd.day_date,'dd'),'20',dt.code,null)  as d20
 ,decode(to_char(tsd.day_date,'dd'),'21',dt.code,null)  as d21
 ,decode(to_char(tsd.day_date,'dd'),'22',dt.code,null)  as d22
 ,decode(to_char(tsd.day_date,'dd'),'23',dt.code,null)  as d23
 ,decode(to_char(tsd.day_date,'dd'),'24',dt.code,null)  as d24
 ,decode(to_char(tsd.day_date,'dd'),'25',dt.code,null)  as d25
 ,decode(to_char(tsd.day_date,'dd'),'26',dt.code,null)  as d26
 ,decode(to_char(tsd.day_date,'dd'),'27',dt.code,null)  as d27
 ,decode(to_char(tsd.day_date,'dd'),'28',dt.code,null)  as d28
 ,decode(to_char(tsd.day_date,'dd'),'29',dt.code,null)  as d29
 ,decode(to_char(tsd.day_date,'dd'),'30',dt.code,null)  as d30
 ,decode(to_char(tsd.day_date,'dd'),'31',dt.code,null)  as d31
  from timetables_specs_days_tbl tsd, days_types_tbl dt
 where tsd.day_type_id = dt.id(+)
;
