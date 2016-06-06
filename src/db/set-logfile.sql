Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved. 
Rem
Rem    DESCRIPTION
Rem      Create unique name for logfile and turns on spooling.
Rem
Rem    Arguments:
Rem      1 - LOG_PREFIX => Prefix for logfile name
Rem
Rem    MODIFIED   (YYYYMMDD)
Rem    appler      160516 - Created

set define '^'
set concat on
set concat .
set verify off
set termout off
set feedback off
set serveroutput on
set termout on

define LOG_PREFIX  = '^1'

column "Current log file" new_val LOG
--select 'install-'||to_char(sysdate,'YYMMDD-HH24MISS')||'.log' "Current log file" from dual
select './logs/^LOG_PREFIX'||'-installation.log' "Current log file" from dual
/

SPOOL ^LOG
