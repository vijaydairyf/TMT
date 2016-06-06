Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      TIMETABLES_SPECS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "TIMETABLES_SPECS"
create or replace view TIMETABLES_SPECS as
select
  ts.id                         as id
 ,ts.timetable_id               as timetable_id
 ,ts.emp_id                     as emp_id
 ,e.name                        as emp_name
 ,ts.post_id                    as post_id
 ,p.name                        as post_name
 ,ts.prs_duty_hist_id           as prs_duty_hist_id
 ,to_char(ts.wage_rate,'0D00')  as wage_rate
 ,nvl2(tsd.d1,tsd.d1,decode(tsh.d1,0,null,tsh.d1))       as d1
 ,nvl2(tsd.d2,tsd.d2,decode(tsh.d2,0,null,tsh.d2))       as d2
 ,nvl2(tsd.d3,tsd.d3,decode(tsh.d3,0,null,tsh.d3))       as d3
 ,nvl2(tsd.d4,tsd.d4,decode(tsh.d4,0,null,tsh.d4))       as d4
 ,nvl2(tsd.d5,tsd.d5,decode(tsh.d5,0,null,tsh.d5))       as d5
 ,nvl2(tsd.d6,tsd.d6,decode(tsh.d6,0,null,tsh.d6))       as d6
 ,nvl2(tsd.d7,tsd.d7,decode(tsh.d7,0,null,tsh.d7))       as d7
 ,nvl2(tsd.d8,tsd.d8,decode(tsh.d8,0,null,tsh.d8))       as d8
 ,nvl2(tsd.d9,tsd.d9,decode(tsh.d9,0,null,tsh.d9))       as d9
 ,nvl2(tsd.d10,tsd.d10,decode(tsh.d10,0,null,tsh.d10))   as d10
 ,nvl2(tsd.d11,tsd.d11,decode(tsh.d11,0,null,tsh.d11))   as d11
 ,nvl2(tsd.d12,tsd.d12,decode(tsh.d12,0,null,tsh.d12))   as d12
 ,nvl2(tsd.d13,tsd.d13,decode(tsh.d13,0,null,tsh.d13))   as d13
 ,nvl2(tsd.d14,tsd.d14,decode(tsh.d14,0,null,tsh.d14))   as d14
 ,nvl2(tsd.d15,tsd.d15,decode(tsh.d15,0,null,tsh.d15))   as d15
 ,nvl2(tsd.d16,tsd.d16,decode(tsh.d16,0,null,tsh.d16))   as d16
 ,nvl2(tsd.d17,tsd.d17,decode(tsh.d17,0,null,tsh.d17))   as d17
 ,nvl2(tsd.d18,tsd.d18,decode(tsh.d18,0,null,tsh.d18))   as d18
 ,nvl2(tsd.d19,tsd.d19,decode(tsh.d19,0,null,tsh.d19))   as d19
 ,nvl2(tsd.d20,tsd.d20,decode(tsh.d20,0,null,tsh.d20))   as d20
 ,nvl2(tsd.d21,tsd.d21,decode(tsh.d21,0,null,tsh.d21))   as d21
 ,nvl2(tsd.d22,tsd.d22,decode(tsh.d22,0,null,tsh.d22))   as d22
 ,nvl2(tsd.d23,tsd.d23,decode(tsh.d23,0,null,tsh.d23))   as d23
 ,nvl2(tsd.d24,tsd.d24,decode(tsh.d24,0,null,tsh.d24))   as d24
 ,nvl2(tsd.d25,tsd.d25,decode(tsh.d25,0,null,tsh.d25))   as d25
 ,nvl2(tsd.d26,tsd.d26,decode(tsh.d26,0,null,tsh.d26))   as d26
 ,nvl2(tsd.d27,tsd.d27,decode(tsh.d27,0,null,tsh.d27))   as d27
 ,nvl2(tsd.d28,tsd.d28,decode(tsh.d28,0,null,tsh.d28))   as d28
 ,nvl2(tsd.d29,tsd.d29,decode(tsh.d29,0,null,tsh.d29))   as d29
 ,nvl2(tsd.d30,tsd.d30,decode(tsh.d30,0,null,tsh.d30))   as d30
 ,nvl2(tsd.d31,tsd.d31,decode(tsh.d31,0,null,tsh.d31))   as d31
 from timetables_specs_tbl ts, employees_tbl e, posts_tbl p, timetables_specs_days tsd, timetables_specs_hours_by_spec tsh
 where ts.emp_id = e.id
   and ts.post_id = p.id
   and ts.timetable_id = tsd.timetable_id(+)
   and ts.timetable_id = tsh.timetable_id(+)
   and ts.id = tsd.timetable_spec_id(+)
   and ts.id = tsh.timetable_spec_id(+)
;
