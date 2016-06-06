Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      TIMETABLES_SPECS_HOURS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "TIMETABLES_SPECS_HOURS"
create or replace view TIMETABLES_SPECS_HOURS as
select
  tsh.timetable_spec_id   as timetable_spec_id
 ,tsh.hours_type_id       as hours_type_id
 ,sum(decode(to_char(tsh.day_date,'dd'),'01',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d1
 ,sum(decode(to_char(tsh.day_date,'dd'),'02',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d2
 ,sum(decode(to_char(tsh.day_date,'dd'),'03',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d3
 ,sum(decode(to_char(tsh.day_date,'dd'),'04',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d4
 ,sum(decode(to_char(tsh.day_date,'dd'),'05',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d5
 ,sum(decode(to_char(tsh.day_date,'dd'),'06',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d6
 ,sum(decode(to_char(tsh.day_date,'dd'),'07',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d7
 ,sum(decode(to_char(tsh.day_date,'dd'),'08',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d8
 ,sum(decode(to_char(tsh.day_date,'dd'),'09',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d9
 ,sum(decode(to_char(tsh.day_date,'dd'),'10',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d10
 ,sum(decode(to_char(tsh.day_date,'dd'),'11',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d11
 ,sum(decode(to_char(tsh.day_date,'dd'),'12',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d12
 ,sum(decode(to_char(tsh.day_date,'dd'),'13',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d13
 ,sum(decode(to_char(tsh.day_date,'dd'),'14',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d14
 ,sum(decode(to_char(tsh.day_date,'dd'),'15',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d15
 ,sum(decode(to_char(tsh.day_date,'dd'),'16',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d16
 ,sum(decode(to_char(tsh.day_date,'dd'),'17',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d17
 ,sum(decode(to_char(tsh.day_date,'dd'),'18',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d18
 ,sum(decode(to_char(tsh.day_date,'dd'),'19',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d19
 ,sum(decode(to_char(tsh.day_date,'dd'),'20',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d20
 ,sum(decode(to_char(tsh.day_date,'dd'),'21',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d21
 ,sum(decode(to_char(tsh.day_date,'dd'),'22',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d22
 ,sum(decode(to_char(tsh.day_date,'dd'),'23',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d23
 ,sum(decode(to_char(tsh.day_date,'dd'),'24',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d24
 ,sum(decode(to_char(tsh.day_date,'dd'),'25',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d25
 ,sum(decode(to_char(tsh.day_date,'dd'),'26',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d26
 ,sum(decode(to_char(tsh.day_date,'dd'),'27',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d27
 ,sum(decode(to_char(tsh.day_date,'dd'),'28',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d28
 ,sum(decode(to_char(tsh.day_date,'dd'),'29',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d29
 ,sum(decode(to_char(tsh.day_date,'dd'),'30',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d30
 ,sum(decode(to_char(tsh.day_date,'dd'),'31',decode(tsh.hours_amount,0,null,tsh.hours_amount),null))  as d31
  from timetables_specs_hours_tbl tsh
 group by tsh.timetable_spec_id, tsh.hours_type_id
;
