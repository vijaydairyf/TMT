create or replace package UTILS as

  function month_name (
    p_month_no in number
  ) return varchar2;

  function month_name_gen (
    p_month_no in number
  ) return varchar2;

  function to_oct(
    p_dec in number
  ) return varchar2;

  function to_bin(
    p_dec in number
  ) return varchar2;

  function to_hex(
    p_dec in number
  ) return varchar2;

  function apex_value (
    p_value in varchar2
  ) return varchar2;

  function to_number_value(
    p_str in varchar2
  ) return number;

end UTILS;
/
