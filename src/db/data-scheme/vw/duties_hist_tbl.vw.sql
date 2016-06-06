Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "DUTIES_HIST_TBL"
create or replace view DUTIES_HIST_TBL as
select
  t.rn   as id
 ,t.prn  as duty_id
  from prs_duties_hist t
;
