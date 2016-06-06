Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Организации.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "COMPANIES_TBL"
create or replace view COMPANIES_TBL as
select
  c.rn         as id
 ,c.name       as code
 ,c.fullname   as name
  from prs_companies c
;
