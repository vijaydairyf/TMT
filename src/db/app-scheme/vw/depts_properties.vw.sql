Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      DEPTS_PROPERTIES
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "DEPTS_PROPERTIES"
create or replace view DEPTS_PROPERTIES as
select
  id              as id
 ,updated         as updated
 ,updater         as updater
 ,dept_id         as dept_id
 ,curator_post    as curator_post
 ,curator_name    as curator_name
 ,manager_name    as manager_name
 ,milk_resp_name  as milk_resp_name
from depts_properties_tbl
;
