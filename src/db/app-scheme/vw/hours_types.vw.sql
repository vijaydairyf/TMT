Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      HOURS_TYPES
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "HOURS_TYPES"
create or replace view HOURS_TYPES as
select
  id      as id
 ,no      as no
 ,code    as code
 ,name    as name
from hours_types_tbl
where code not in ('ПН', 'ВН', 'совместительство', 'заместительство')
;
