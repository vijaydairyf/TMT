Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved. 
Rem
Rem    DESCRIPTION
Rem      Creates empty scheme in Oracle server.
Rem
Rem    Arguments:
Rem      1 - SCHEME           = Scheme name
Rem      2 - TABLESPACE       = Tablespace name
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created


define SCHEME           = '^1'
define TABLESPACE       = '^2'

column :pass new_value SCHEME_PASSWORD NOPRINT
variable pass varchar2(30)

begin
--    :pass := dbms_random.string('X',30);
	:pass := 'tmt';
end;
/

select :pass from dual
/

prompt ... create oracle scheme ^SCHEME
create user ^SCHEME identified by "^SCHEME_PASSWORD" default tablespace ^TABLESPACE
/

prompt ... grants to created scheme ^SCHEME
grant connect, resource to ^SCHEME
/
grant create view to ^SCHEME
/
grant execute on sys.dbms_crypto to ^SCHEME
/
