Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      USERSLIST
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "USERSLIST"
create or replace view USERSLIST as
select
  u.id                as id
 ,u.updated          as updated
 ,u.updater           as updater
 ,u.username          as username
 ,u.fullname          as fullname
 ,u.created           as created
 ,u.is_admin          as is_admin
 ,u.is_accounter      as is_accounter
 ,u.is_timekeeper     as is_timekeeper
 ,u.is_holischeduler  as is_holischeduler
 ,u.is_dept_milk      as is_dept_milk
 ,u.is_ent_milk       as is_ent_milk
 ,u.is_hr             as is_hr
 ,u.expires           as expires
 ,u.phone             as phone
 ,u.room              as room
 ,u.notes             as notes
 from users u
;
