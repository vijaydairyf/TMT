Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved. 
Rem
Rem    DESCRIPTION
Rem      Create database objects in data scheme.
Rem
Rem    NOTES
Rem      Assumes the connection as SYS or SYSTEM user.
Rem
Rem    Arguments:
Rem      1 - DATA_SCHEME   => Data scheme name
Rem      2 - TABLESPACE    => Data tablespace name
Rem      3 - PARUS_SCHEME  => Parus scheme name
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

define DATA_SCHEME       = '^1'
define TABLESPACE        = '^2'
define PARUS_SCHEME      = '^3'
define PATH = '@'

@^PATH.set-logfile.sql data

timing start "Installation data scheme"

whenever sqlerror continue

prompt 
prompt Removing data scheme.
drop user ^DATA_SCHEME cascade;

whenever sqlerror exit failure

prompt 
prompt Creating data scheme.
@^PATH.create-scheme.sql ^DATA_SCHEME ^TABLESPACE

prompt 
prompt  Data scheme objects installation.
prompt *************************************************************************
prompt 
@^PATH.data-scheme/create-scheme-objects.sql ^DATA_SCHEME ^PARUS_SCHEME ^PATH

timing stop "Installation data scheme"

spool off

exit
