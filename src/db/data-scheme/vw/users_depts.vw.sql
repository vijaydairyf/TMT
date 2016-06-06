Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "USERS_DEPTS"
create or replace view USERS_DEPTS as
select
  t.id
 ,t.updated
 ,t.updater
 ,t.user_id
 ,t.company_id
 ,t.dept_id
 from users_depts_tbl t
;
