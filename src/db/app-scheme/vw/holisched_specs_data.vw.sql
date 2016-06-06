Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      HOLISCHED_SPECS_DATA
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "HOLISCHED_SPECS_DATA"
create or replace view HOLISCHED_SPECS_DATA as
select
  hssd.id            as id
 ,hssd.spec_id       as spec_id
 ,hssd.beg_date      as beg_date
 ,hssd.days_amount   as days_amount
  from holisched_specs_data_tbl hssd
;
