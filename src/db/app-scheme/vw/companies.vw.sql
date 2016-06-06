Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      COMPANIES
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "COMPANIES"
create or replace view COMPANIES as
select
  c.id      as id
 ,c.code    as code
 ,c.name    as name
  from companies_tbl c
;
