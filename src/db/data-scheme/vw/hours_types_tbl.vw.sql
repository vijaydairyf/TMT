Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "HOURS_TYPES_TBL"
create or replace view HOURS_TYPES_TBL as
select
  ht.rn     as id
 ,ht.numb   as no
 ,ht.code   as code
 ,ht.name   as name
  from prs_hours_types ht
;
