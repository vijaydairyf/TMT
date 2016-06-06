Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "USERS"
create or replace view USERS as
select
  t.id                as id
 ,t.updated           as updated
 ,t.updater           as updater
 ,t.username          as username
 ,t.fullname          as fullname
 ,t.created           as created
 ,t.is_admin          as is_admin
 ,t.is_accounter      as is_accounter
 ,t.is_timekeeper     as is_timekeeper
 ,t.is_holischeduler  as is_holischeduler
 ,t.is_dept_milk      as is_dept_milk
 ,t.is_ent_milk       as is_ent_milk
 ,t.is_hr             as is_hr
 ,t.expires           as expires
 ,t.phone             as phone
 ,t.room              as room
 ,t.notes             as notes
 from users_tbl t
;
