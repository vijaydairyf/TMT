Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "DAYS_TYPES"
create or replace view DAYS_TYPES as
select
  id       as id
 ,code     as code
 ,name     as name
 ,absence  as absence
  from days_types_tbl
 where code not in ('БС', 'КС', 'Уб', 'ч')
;
