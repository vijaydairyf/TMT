Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "PERSONS_TBL"
create or replace view PERSONS_TBL as
select
  rn        as id
 ,agnabbr   as code
 ,agnname   as name
  from prs_persons p
 where agntype = 1
;
