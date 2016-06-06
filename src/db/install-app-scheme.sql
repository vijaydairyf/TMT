Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.  
Rem
Rem    DESCRIPTION
Rem      Create database objects in application scheme. 
Rem
Rem    NOTES
Rem      Assumes the connection as SYS or SYSTEM user.
Rem
Rem    Arguments:
Rem      1 - APP_SCHEME        = Application scheme name
Rem      2 - DATA_SCHEME       = Data scheme name
Rem      3 - TABLESPACE        = Data tablespace name
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created

set define '^'
set concat on
set concat .
set verify off
set termout off
set feedback off
spool off
set serveroutput on
set termout on
set timing off

define APP_SCHEME        = '^1'
define DATA_SCHEME       = '^2'
define TABLESPACE        = '^3'
define PATH = '@'

@^PATH.set-logfile.sql app

timing start "Installation application scheme"

whenever sqlerror continue

prompt 
prompt Removing application scheme.
drop user ^APP_SCHEME cascade;

whenever sqlerror exit failure

prompt 
prompt Creating application scheme.
@^PATH.create-scheme.sql ^APP_SCHEME ^TABLESPACE

prompt 
prompt  Application scheme objects installation.
prompt *************************************************************************
prompt 
@^PATH.app-scheme/create-scheme-objects.sql ^APP_SCHEME ^DATA_SCHEME ^PATH

timing stop "Installation application scheme"

spool off

exit
