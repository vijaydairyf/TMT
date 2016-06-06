create or replace package body UTILS as

  function month_name (
    p_month_no in number
  ) return varchar2
  as
    l_month_name varchar2(30);
  begin
    case p_month_no
    when 1 then
      l_month_name := 'Январь';
    when 2 then
      l_month_name := 'Февраль';
    when 3 then
      l_month_name := 'Март';
    when 4 then
      l_month_name := 'Апрель';
    when 5 then
      l_month_name := 'Май';
    when 6 then
      l_month_name := 'Июнь';
    when 7 then
      l_month_name := 'Июль';
    when 8 then
      l_month_name := 'Август';
    when 9 then
      l_month_name := 'Сентябрь';
    when 10 then
      l_month_name := 'Октябрь';
    when 11 then
      l_month_name := 'Ноябрь';
    when 12 then
      l_month_name := 'Декабрь';
    else
      l_month_name := null;
    end case;
    --
    return l_month_name;
  end month_name;


  function month_name_gen (
    p_month_no in number
  ) return varchar2
  as
    l_month_name varchar2(30);
  begin
    case p_month_no
    when 1 then
      l_month_name := 'Января';
    when 2 then
      l_month_name := 'Февраля';
    when 3 then
      l_month_name := 'Марта';
    when 4 then
      l_month_name := 'Апреля';
    when 5 then
      l_month_name := 'Мая';
    when 6 then
      l_month_name := 'Июня';
    when 7 then
      l_month_name := 'Июля';
    when 8 then
      l_month_name := 'Августа';
    when 9 then
      l_month_name := 'Сентября';
    when 10 then
      l_month_name := 'Октября';
    when 11 then
      l_month_name := 'Ноября';
    when 12 then
      l_month_name := 'Декабря';
    else
      l_month_name := null;
    end case;
    --
    return l_month_name;
  end month_name_gen;


  function to_base(
    p_dec in number,
    p_base in number
  ) return varchar2
  is
    l_str varchar2(255) default NULL;
    l_num number        default p_dec;
    l_hex varchar2(16)  default '0123456789ABCDEF';
  begin
    if (
      p_dec is null or p_base is null
    ) then
        return null;
    end if;
    if (
      trunc(p_dec) <> p_dec OR p_dec < 0
    ) then
      raise PROGRAM_ERROR;
    end if;
    loop
      l_str := substr(l_hex, mod(l_num,p_base)+1, 1 ) || l_str;
      l_num := trunc( l_num/p_base );
      exit when ( l_num = 0 );
    end loop;
    return l_str;
  end to_base;


  function to_dec(
    p_str in varchar2,
    p_from_base in number default 16
  ) return number is
    l_num   number default 0;
    l_hex   varchar2(16) default '0123456789ABCDEF';
  begin
    if (
      p_str is null or p_from_base is null
    ) then
      return null;
    end if;
    for i in 1 .. length(p_str) loop
      l_num := l_num * p_from_base + instr(l_hex,upper(substr(p_str,i,1)))-1;
    end loop;
    return l_num;
  end to_dec;


  function to_hex(
    p_dec in number
  ) return varchar2 is
  begin
    return to_base( p_dec, 16 );
  end to_hex;


  function to_bin(
    p_dec in number
  ) return varchar2 is
  begin
    return to_base( p_dec, 2 );
  end to_bin;


  function to_oct(
    p_dec in number
  ) return varchar2 is
  begin
    return to_base( p_dec, 8 );
  end to_oct;


  function apex_value (
    p_value in varchar2
  ) return varchar2 is
  begin
    if (p_value = std.C_APEX_NULL) then
      return null;
    else
      return p_value;
    end if;
  end apex_value;


  function to_number_value(
    p_str in varchar2
  ) return number is
  begin
    return to_number(replace(replace(p_str,' '),',','.'),'999999999999999D99', 'NLS_NUMERIC_CHARACTERS=.,');
  end to_number_value;

end UTILS;
/
