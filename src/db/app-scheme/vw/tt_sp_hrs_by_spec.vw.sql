Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      TT_SP_HRS_BY_SPEC
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "TT_SP_HRS_BY_SPEC"
create or replace view TT_SP_HRS_BY_SPEC as
select
  tsh.timetable_spec_id    as timetable_spec_id
 ,decode(to_char(tsh.day_date,'dd'),'01',tsh.hours_amount,null)  as d1
 ,decode(to_char(tsh.day_date,'dd'),'02',tsh.hours_amount,null)  as d2
 ,decode(to_char(tsh.day_date,'dd'),'03',tsh.hours_amount,null)  as d3
 ,decode(to_char(tsh.day_date,'dd'),'04',tsh.hours_amount,null)  as d4
 ,decode(to_char(tsh.day_date,'dd'),'05',tsh.hours_amount,null)  as d5
 ,decode(to_char(tsh.day_date,'dd'),'06',tsh.hours_amount,null)  as d6
 ,decode(to_char(tsh.day_date,'dd'),'07',tsh.hours_amount,null)  as d7
 ,decode(to_char(tsh.day_date,'dd'),'08',tsh.hours_amount,null)  as d8
 ,decode(to_char(tsh.day_date,'dd'),'09',tsh.hours_amount,null)  as d9
 ,decode(to_char(tsh.day_date,'dd'),'10',tsh.hours_amount,null)  as d10
 ,decode(to_char(tsh.day_date,'dd'),'11',tsh.hours_amount,null)  as d11
 ,decode(to_char(tsh.day_date,'dd'),'12',tsh.hours_amount,null)  as d12
 ,decode(to_char(tsh.day_date,'dd'),'13',tsh.hours_amount,null)  as d13
 ,decode(to_char(tsh.day_date,'dd'),'14',tsh.hours_amount,null)  as d14
 ,decode(to_char(tsh.day_date,'dd'),'15',tsh.hours_amount,null)  as d15
 ,decode(to_char(tsh.day_date,'dd'),'16',tsh.hours_amount,null)  as d16
 ,decode(to_char(tsh.day_date,'dd'),'17',tsh.hours_amount,null)  as d17
 ,decode(to_char(tsh.day_date,'dd'),'18',tsh.hours_amount,null)  as d18
 ,decode(to_char(tsh.day_date,'dd'),'19',tsh.hours_amount,null)  as d19
 ,decode(to_char(tsh.day_date,'dd'),'20',tsh.hours_amount,null)  as d20
 ,decode(to_char(tsh.day_date,'dd'),'21',tsh.hours_amount,null)  as d21
 ,decode(to_char(tsh.day_date,'dd'),'22',tsh.hours_amount,null)  as d22
 ,decode(to_char(tsh.day_date,'dd'),'23',tsh.hours_amount,null)  as d23
 ,decode(to_char(tsh.day_date,'dd'),'24',tsh.hours_amount,null)  as d24
 ,decode(to_char(tsh.day_date,'dd'),'25',tsh.hours_amount,null)  as d25
 ,decode(to_char(tsh.day_date,'dd'),'26',tsh.hours_amount,null)  as d26
 ,decode(to_char(tsh.day_date,'dd'),'27',tsh.hours_amount,null)  as d27
 ,decode(to_char(tsh.day_date,'dd'),'28',tsh.hours_amount,null)  as d28
 ,decode(to_char(tsh.day_date,'dd'),'29',tsh.hours_amount,null)  as d29
 ,decode(to_char(tsh.day_date,'dd'),'30',tsh.hours_amount,null)  as d30
 ,decode(to_char(tsh.day_date,'dd'),'31',tsh.hours_amount,null)  as d31
  from timetables_specs_hours_tbl tsh
 where tsh.hours_type_id in (select id from hours_types_tbl where upper(trim(code)) in ('О'))
;
