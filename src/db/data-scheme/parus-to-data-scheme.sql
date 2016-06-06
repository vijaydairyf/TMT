Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Creates synonyms and grants.
Rem
Rem    Arguments:
Rem      1 - PARUS_SCHEME   = Parus scheme name
Rem      2 - DATA_SCHEME    = Data scheme name
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created

set define '^'
set verify off

define PARUS_SCHEME   = '^1'
define DATA_SCHEME    = '^2'


--------------------------------------------
-- S Y N O N Y M S
--
prompt ... create synonym "^DATA_SCHEME..PRS_COMPANIES"
create synonym ^DATA_SCHEME..PRS_COMPANIES for ^PARUS_SCHEME..COMPANIES;
prompt ... create synonym "^DATA_SCHEME..PRS_DAYS_TYPES"
create synonym ^DATA_SCHEME..PRS_DAYS_TYPES for ^PARUS_SCHEME..SLDAYSTYPE;
prompt ... create synonym "^DATA_SCHEME..PRS_DEPARTMENTS"
create synonym ^DATA_SCHEME..PRS_DEPARTMENTS for ^PARUS_SCHEME..INS_DEPARTMENT;
prompt ... create synonym "^DATA_SCHEME..PRS_DUTIES"
create synonym ^DATA_SCHEME..PRS_DUTIES for ^PARUS_SCHEME..CLNPSPFM;
prompt ... create synonym "^DATA_SCHEME..PRS_DUTIES_DAYS"
create synonym ^DATA_SCHEME..PRS_DUTIES_DAYS for ^PARUS_SCHEME..CLNPSPFMWD;
prompt ... create synonym "^DATA_SCHEME..PRS_DUTIES_HIST"
create synonym ^DATA_SCHEME..PRS_DUTIES_HIST for ^PARUS_SCHEME..CLNPSPFMHS;
prompt ... create synonym "^DATA_SCHEME..PRS_DUTIES_HOURS"
create synonym ^DATA_SCHEME..PRS_DUTIES_HOURS for ^PARUS_SCHEME..CLNPSPFMWH;
prompt ... create synonym "^DATA_SCHEME..PRS_DUTIES_TYPES"
create synonym ^DATA_SCHEME..PRS_DUTIES_TYPES for ^PARUS_SCHEME..CLNPSPFMTYPES;
prompt ... create synonym "^DATA_SCHEME..PRS_EMPLOYEES"
create synonym ^DATA_SCHEME..PRS_EMPLOYEES for ^PARUS_SCHEME..CLNPERSONS;
prompt ... create synonym "^DATA_SCHEME..PRS_ENPERIOD"
create synonym ^DATA_SCHEME..PRS_ENPERIOD for ^PARUS_SCHEME..ENPERIOD;
prompt ... create synonym "^DATA_SCHEME..PRS_HOURS_TYPES"
create synonym ^DATA_SCHEME..PRS_HOURS_TYPES for ^PARUS_SCHEME..SL_HOURS_TYPES;
prompt ... create synonym "^DATA_SCHEME..PRS_LEGAL_PERSONS"
create synonym ^DATA_SCHEME..PRS_LEGAL_PERSONS for ^PARUS_SCHEME..JURPERSONS;
prompt ... create synonym "^DATA_SCHEME..PRS_P_CLNPSPFMWD_DELETE"
create synonym ^DATA_SCHEME..PRS_P_CLNPSPFMWD_DELETE for ^PARUS_SCHEME..P_CLNPSPFMWD_BASE_DELETE;
prompt ... create synonym "^DATA_SCHEME..PRS_P_CLNPSPFMWD_INSERT"
create synonym ^DATA_SCHEME..PRS_P_CLNPSPFMWD_INSERT for ^PARUS_SCHEME..P_CLNPSPFMWD_BASE_INSERT;
prompt ... create synonym "^DATA_SCHEME..PRS_P_CLNPSPFMWD_UPDATE"
create synonym ^DATA_SCHEME..PRS_P_CLNPSPFMWD_UPDATE for ^PARUS_SCHEME..P_CLNPSPFMWD_BASE_UPDATE;
prompt ... create synonym "^DATA_SCHEME..PRS_P_CLNPSPFMWH_DELETE"
create synonym ^DATA_SCHEME..PRS_P_CLNPSPFMWH_DELETE for ^PARUS_SCHEME..P_CLNPSPFMWH_BASE_DELETE;
prompt ... create synonym "^DATA_SCHEME..PRS_P_CLNPSPFMWH_INSERT"
create synonym ^DATA_SCHEME..PRS_P_CLNPSPFMWH_INSERT for ^PARUS_SCHEME..P_CLNPSPFMWH_BASE_INSERT;
prompt ... create synonym "^DATA_SCHEME..PRS_P_CLNPSPFMWH_UPDATE"
create synonym ^DATA_SCHEME..PRS_P_CLNPSPFMWH_UPDATE for ^PARUS_SCHEME..P_CLNPSPFMWH_BASE_UPDATE;
prompt ... create synonym "^DATA_SCHEME..PRS_PERSONS"
create synonym ^DATA_SCHEME..PRS_PERSONS for ^PARUS_SCHEME..AGNLIST;
prompt ... create synonym "^DATA_SCHEME..PRS_PKG_CLNPSPFMWD"
create synonym ^DATA_SCHEME..PRS_PKG_CLNPSPFMWD for ^PARUS_SCHEME..PKG_CLNPSPFMWD;
prompt ... create synonym "^DATA_SCHEME..PRS_POSTS"
create synonym ^DATA_SCHEME..PRS_POSTS for ^PARUS_SCHEME..CLNPSDEP;
prompt ... create synonym "^DATA_SCHEME..PRS_SLSCHEDULE"
create synonym ^DATA_SCHEME..PRS_SLSCHEDULE for ^PARUS_SCHEME..SLSCHEDULE;
prompt ... create synonym "^DATA_SCHEME..PRS_WORKDAYS"
create synonym ^DATA_SCHEME..PRS_WORKDAYS for ^PARUS_SCHEME..WORKDAYS;
prompt ... create synonym "^DATA_SCHEME..PRS_WORKDAYSTR"
create synonym ^DATA_SCHEME..PRS_WORKDAYSTR for ^PARUS_SCHEME..WORKDAYSTR;


--------------------------------------------
-- G R A N T S
--
prompt ... grant on "^PARUS_SCHEME..COMPANIES"
grant select, references on ^PARUS_SCHEME..COMPANIES to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..SLDAYSTYPE"
grant select, references on ^PARUS_SCHEME..SLDAYSTYPE to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..INS_DEPARTMENT"
grant select, references on ^PARUS_SCHEME..INS_DEPARTMENT to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..CLNPSPFM"
grant select, references on ^PARUS_SCHEME..CLNPSPFM to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..CLNPSPFMWD"
grant select, references on ^PARUS_SCHEME..CLNPSPFMWD to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..CLNPSPFMHS"
grant select, references on ^PARUS_SCHEME..CLNPSPFMHS to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..CLNPSPFMWH"
grant select, references on ^PARUS_SCHEME..CLNPSPFMWH to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..CLNPSPFMTYPES"
grant select, references on ^PARUS_SCHEME..CLNPSPFMTYPES to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..CLNPERSONS"
grant select, references on ^PARUS_SCHEME..CLNPERSONS to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..ENPERIOD"
grant select, references on ^PARUS_SCHEME..ENPERIOD to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..SL_HOURS_TYPES"
grant select, references on ^PARUS_SCHEME..SL_HOURS_TYPES to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..JURPERSONS"
grant select, references on ^PARUS_SCHEME..JURPERSONS to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..P_CLNPSPFMWD_BASE_DELETE"
grant execute on ^PARUS_SCHEME..P_CLNPSPFMWD_BASE_DELETE to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..P_CLNPSPFMWD_BASE_INSERT"
grant execute on ^PARUS_SCHEME..P_CLNPSPFMWD_BASE_INSERT to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..P_CLNPSPFMWD_BASE_UPDATE"
grant execute on ^PARUS_SCHEME..P_CLNPSPFMWD_BASE_UPDATE to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..P_CLNPSPFMWH_BASE_DELETE"
grant execute on ^PARUS_SCHEME..P_CLNPSPFMWH_BASE_DELETE to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..P_CLNPSPFMWH_BASE_INSERT"
grant execute on ^PARUS_SCHEME..P_CLNPSPFMWH_BASE_INSERT to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..P_CLNPSPFMWH_BASE_UPDATE"
grant execute on ^PARUS_SCHEME..P_CLNPSPFMWH_BASE_UPDATE to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..AGNLIST"
grant select, references on ^PARUS_SCHEME..AGNLIST to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..PKG_CLNPSPFMWD"
grant execute on ^PARUS_SCHEME..PKG_CLNPSPFMWD to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..CLNPSDEP"
grant select, references on ^PARUS_SCHEME..CLNPSDEP to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..SLSCHEDULE"
grant select, references on ^PARUS_SCHEME..SLSCHEDULE to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..WORKDAYS"
grant select, references on ^PARUS_SCHEME..WORKDAYS to ^DATA_SCHEME with grant option;
prompt ... grant on "^PARUS_SCHEME..WORKDAYSTR"
grant select, references on ^PARUS_SCHEME..WORKDAYSTR to ^DATA_SCHEME with grant option;
