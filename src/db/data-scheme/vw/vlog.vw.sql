Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "VLOG"
create or replace view VLOG as
select '['||to_char(LDATE, 'Mon DD, HH24:MI:SS')||':'||LTRIM(to_char(mod(LHSECS,100),'09'))||']'||
--       '['||plogparam.getLevelInText(llevel)||']['||
       '['||(select lvl_name from log_levels where lvl_no = llevel)||']['||
       LUSER||']['||
       LTEXT||']' log
  from (select * from (select * from tlog order by id desc) where rownum < 1000)
 order by ID DESC
;
