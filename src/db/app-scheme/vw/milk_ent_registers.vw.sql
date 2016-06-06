Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      MILK_ENT_REGISTERS
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "MILK_ENT_REGISTERS"
create or replace view MILK_ENT_REGISTERS as
select
  m.id                as id
 ,m.updated           as updated
 ,m.updater           as updater
 ,m.register_year     as register_year
 ,m.register_month    as register_month
 ,utils.month_name(m.register_month)  as register_month_name
 ,m.register_status   as register_status
 ,c.value_name        as register_status_name
 ,m.register_timemark as register_timemark
 ,m.received          as received
 ,m.received_from     as received_from
 ,nvl((select sum(received)
     from milk_dept_register_tbl
    where ent_register_id = m.id
  ),0)                as given_out
from milk_ent_register_tbl m, collections_tbl c
where m.register_status = c.value_no
  and c.category = 'MILK-REGISTER-STATUS'
;
