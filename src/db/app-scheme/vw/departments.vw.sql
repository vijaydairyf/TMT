Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      DEPARTMENTS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "DEPARTMENTS"
create or replace view DEPARTMENTS as
select
  d.id          as id
 ,d.company_id  as company_id
 ,d.code        as code
 ,d.name        as name
 ,d.resp_id     as resp_id
  from departments_tbl d
;
