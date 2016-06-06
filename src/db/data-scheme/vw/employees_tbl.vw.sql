Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "EMPLOYEES_TBL"
create or replace view EMPLOYEES_TBL as
select
  e.rn        as id
 ,e.tab_numb  as emp_no
 ,p.agnname   as name
  from prs_employees e, prs_persons p
 where e.pers_agent = p.rn
;
