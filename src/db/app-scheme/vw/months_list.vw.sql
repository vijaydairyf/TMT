Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      MONTHS_LIST
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "MONTHS_LIST"
create or replace view MONTHS_LIST as
select
   rownum                    as month_no
  ,utils.month_name(rownum)  as month_name
  from (select 1 From Dual Group By Cube(1, 1, 1, 1))
 where rownum < 13
;
