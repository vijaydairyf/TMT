Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION:
Rem      Trigger "TIMETABLES_BIU1" definition file.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

--------------------------------------------
-- T R I G G E R S
--
prompt ... creating trigger "TIMETABLES_BIU1"
create or replace trigger TIMETABLES_BIU1
  before insert or update on TIMETABLES_TBL for each row
begin
  if (:new.id is null)
  then
    :new.id := std.gen_id_value;
  end if;
  if (inserting)
  then
    :new.created := systimestamp;
    :new.creator := std.get_uname;
  end if;
  :new.updated := systimestamp;
  :new.updater := std.get_uname;
end;
/
