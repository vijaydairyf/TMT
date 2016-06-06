create or replace package body std
as

  function MAX_STRING_LENGTH      return integer  is begin return C_MAX_STRING_LENGTH;      end MAX_STRING_LENGTH;
  function MAX_TEXT_LENGTH        return integer  is begin return C_MAX_TEXT_LENGTH;        end MAX_TEXT_LENGTH;
  function MAX_SQL_LENGTH         return integer  is begin return C_MAX_SQL_LENGTH;         end MAX_SQL_LENGTH;
  function MAX_OBJECT_NAME_LENGTH return integer  is begin return C_MAX_OBJECT_NAME_LENGTH; end MAX_OBJECT_NAME_LENGTH;
  function MAX_NUMBER_PRECISION   return integer  is begin return C_MAX_NUMBER_PRECISION;   end MAX_NUMBER_PRECISION;

  function LIKE_MULTI_SYMB  return char is begin return C_LIKE_MULTI_SYMB;  end LIKE_MULTI_SYMB;
  function LIKE_SINGL_SYMB  return char is begin return C_LIKE_SINGL_SYMB;  end LIKE_SINGL_SYMB;
  function APEX_NULL        return char is begin return C_APEX_NULL;        end APEX_NULL;
  function NULL_HASH        return char is begin return C_NULL_HASH;        end NULL_HASH;

    function GUID_CAST_MASK   return char as begin return C_GUID_CAST_MASK; end GUID_CAST_MASK;
  function D_FMT    return varchar2 is begin return C_D_FMT;    end D_FMT;
  function DT_FMT   return varchar2 is begin return C_DT_FMT;   end DT_FMT;
  function DTS_FMT  return varchar2 is begin return C_DTS_FMT;  end DTS_FMT;
  function TST_FMT  return varchar2 is begin return C_TST_FMT;  end TST_FMT;
  function T_FMT    return varchar2 is begin return C_T_FMT;    end T_FMT;
  function TS_FMT   return varchar2 is begin return C_TS_FMT;   end TS_FMT;

  function get_new_id   return number is begin return to_number(sys_guid(),'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'); end get_new_id;
  function get_updater  return varchar2 is begin return nvl(v('APP_USER'),'ORA:'||user); end get_updater;

    function gen_id_value  return std.T_PK as begin return to_number(sys_guid(),std.C_GUID_CAST_MASK); end gen_id_value;

    function get_session_id return varchar2 as begin  return v('APP_SESSION'); end get_session_id;

    function get_uname return varchar2 as begin  return nvl(v('APP_USER'),'ORA:'||user); end get_uname;

end STD;
/
