Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      USERS_DEPTS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "USERS_DEPTS"
create or replace view USERS_DEPTS
(id, updated, updater, user_id, username, company_id, company_name, dept_id, dept_name)
as
select
  ud.id          as id
 ,ud.updated     as updated
 ,ud.updater     as updater
 ,ud.user_id     as user_id
 ,u.username     as username
 ,ud.company_id  as company_id
 ,c.name         as company_name
 ,ud.dept_id     as dept_id
 ,d.name         as dept_name
 from users_depts_tbl ud, users u, companies c, departments d
where ud.user_id = u.id
  and ud.company_id = c.id
  and ud.dept_id = d.id
;
