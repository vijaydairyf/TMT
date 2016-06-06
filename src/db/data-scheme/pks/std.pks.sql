create or replace package std
as

  pragma RESTRICT_REFERENCES ( STD, WNDS );

  -- max string in sql
  subtype T_STR   is varchar2( 4000 );

  -- max string in pl/sql
  subtype T_TEXT  is varchar2( 32767 );

  -- max sql text
  subtype T_SQL   is varchar2( 32767 );

  -- max object name length
  subtype T_OBJECT_NAME is varchar2( 30 );

  -- primary key type
  subtype T_PK is number;

  -- hash value type
  subtype T_HASH is number;

  -- identifier of row
  type T_IDS is record (
    id       T_PK
   ,updated  timestamp
  );


  -- EXCEPTIONS
  -- unique constraint violation
  UNIQUE_RECORD_FOUND exception;
  pragma exception_init(UNIQUE_RECORD_FOUND,-00001 );

  -- child records exists (when deleting parent attempts)
  CHILD_RECORD_FOUND  exception;
  pragma exception_init( CHILD_RECORD_FOUND,-02292 );

  -- user exception
  USER_EXCEPTION  exception;
  pragma exception_init (USER_EXCEPTION,-20111);

  -- lost updates
  DATA_NOT_SAVED  exception;
  pragma exception_init (DATA_NOT_SAVED,-20112);

  -- lost updates
  LOST_UPDATED_FOUND  exception;
  pragma exception_init (LOST_UPDATED_FOUND,-20112);

	-- authentification failed
	AUTHENTICATION_FAILED exception;
	pragma exception_init (AUTHENTICATION_FAILED,-20113);

	-- authorization failed
	AUTHORIZATION_FAILED exception;
	pragma exception_init (AUTHORIZATION_FAILED,-20114);

	-- general application error
	APP_ERROR exception;
	pragma exception_init (APP_ERROR,-20115);

  -- timetable already submitted
  TIMETABLE_ALREADY_SUBMITTED exception;
	pragma exception_init (TIMETABLE_ALREADY_SUBMITTED,-20116);

  -- timetable not submitted yet
  TIMETABLE_NOT_SUBMITTED_YET exception;
	pragma exception_init (TIMETABLE_NOT_SUBMITTED_YET,-20117);

  -- timetable already accepted
  TIMETABLE_ALREADY_ACCEPTED exception;
	pragma exception_init (TIMETABLE_ALREADY_ACCEPTED,-20118);

  -- timetable not accepted yet
  TIMETABLE_NOT_ACCEPTED_YET exception;
	pragma exception_init (TIMETABLE_NOT_ACCEPTED_YET,-20119);

  -- timetable is readonly
  TIMETABLE_IS_READONLY exception;
  pragma exception_init (TIMETABLE_IS_READONLY,-20120);

  -- not valid date
  NOT_VALID_DATE exception;
  pragma exception_init (NOT_VALID_DATE,-01839);



  -- CONSTANTS
  C_MAX_STRING_LENGTH constant integer   := 4000;
    function MAX_STRING_LENGTH return integer;
    pragma RESTRICT_REFERENCES( MAX_STRING_LENGTH, WNDS );

  C_MAX_TEXT_LENGTH constant integer   := 32767;
    function MAX_TEXT_LENGTH return integer;
    pragma RESTRICT_REFERENCES( MAX_TEXT_LENGTH, WNDS );

  C_MAX_SQL_LENGTH  constant integer   := 32767;
    function MAX_SQL_LENGTH return integer;
    pragma RESTRICT_REFERENCES( MAX_SQL_LENGTH, WNDS );

  C_MAX_OBJECT_NAME_LENGTH  constant integer   := 30;
    function MAX_OBJECT_NAME_LENGTH return integer;
    pragma RESTRICT_REFERENCES( MAX_OBJECT_NAME_LENGTH, WNDS );

  C_MAX_NUMBER_PRECISION    constant integer   := 38;
    function MAX_NUMBER_PRECISION return integer;
    pragma RESTRICT_REFERENCES( MAX_NUMBER_PRECISION, WNDS );

  -- useful symbols
  C_LIKE_MULTI_SYMB  constant char(1) := '%';
    function LIKE_MULTI_SYMB return char;
    pragma RESTRICT_REFERENCES( LIKE_MULTI_SYMB, WNDS );

  C_LIKE_SINGL_SYMB  constant char(1) := '_';
    function LIKE_SINGL_SYMB return char;
    pragma RESTRICT_REFERENCES( LIKE_SINGL_SYMB, WNDS );

  C_APEX_NULL  constant char(6) := '%null%';
    function APEX_NULL return char;
    pragma RESTRICT_REFERENCES( APEX_NULL, WNDS );

  C_NULL_HASH  constant NUMBER := to_number(0,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    function NULL_HASH return char;
    pragma RESTRICT_REFERENCES( NULL_HASH, WNDS );

  -- formats
    C_GUID_CAST_MASK  constant char(32) := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        function GUID_CAST_MASK return char;
        pragma RESTRICT_REFERENCES( GUID_CAST_MASK, WNDS );

  C_D_FMT     constant varchar2(30) := 'DD.MM.YYYY';
    function D_FMT return varchar2;
    pragma RESTRICT_REFERENCES( D_FMT, WNDS );

  C_DT_FMT    constant varchar2(30) := 'DD.MM.YYYY HH24:MI';
    function DT_FMT return varchar2;
    pragma RESTRICT_REFERENCES( DT_FMT, WNDS );

  C_DTS_FMT   constant varchar2(30) := 'DD.MM.YYYY HH24:MI:SS';
    function DTS_FMT return varchar2;
    pragma RESTRICT_REFERENCES( DTS_FMT, WNDS );

  C_TST_FMT   constant varchar2(30) := 'DD.MM.YYYY HH24:MI:SS:FF';
    function TST_FMT return varchar2;
    pragma RESTRICT_REFERENCES( TST_FMT, WNDS );

  C_T_FMT     constant varchar2(30) := 'HH24:MI';
    function T_FMT return varchar2;
    pragma RESTRICT_REFERENCES( T_FMT, WNDS );

  C_TS_FMT    constant varchar2(30) := 'HH24:MI:SS';
    function TS_FMT return varchar2;
    pragma RESTRICT_REFERENCES(TS_FMT, WNDS);

  -- new ID generation function
  function get_new_id return number;
  pragma RESTRICT_REFERENCES(get_new_id, WNDS);

  function get_updater return varchar2;
  
    function gen_id_value  return std.T_PK;
        pragma RESTRICT_REFERENCES(gen_id_value, WNDS);

    function get_session_id return varchar2;

    function get_uname return varchar2;
end STD;
/

