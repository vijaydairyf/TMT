Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      MILK_COST2
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "MILK_COST2"
create or replace view MILK_COST2 as
select
   id          as id
  ,updated     as updated
  ,updater     as updater
  ,cost_year   as cost_year
  ,cost_month  as cost_month
  ,cost_value  as cost_value
  from milk_cost2_tbl
;
