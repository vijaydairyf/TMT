Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      HOLISCHED_SPECS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "HOLISCHED_SPECS"
create or replace view HOLISCHED_SPECS as
select
  hss.id            as id
 ,hss.schedule_id   as schedule_id
 ,hss.emp_id        as emp_id
 ,e.emp_no          as emp_no
 ,e.name            as emp_name
 ,hss.post_id       as post_id
 ,p.name            as post_name
  from holisched_specs_tbl hss, employees_tbl e, posts_tbl p
 where hss.emp_id = e.id
   and hss.post_id = p.id
;
