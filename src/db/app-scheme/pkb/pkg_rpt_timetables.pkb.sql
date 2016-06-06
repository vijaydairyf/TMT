create or replace package body PKG_RPT_TIMETABLES as

  g_module constant varchar2(30) := 'PKG_RPT_TIMETABLES';


  function timetable_spec_days_totals (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
  begin
    select decode(count(*),0,null,count(*))
      into l_result
      from (
        select tsh.day_date
          from timetables_specs_hours_tbl tsh, hours_types_tbl ht
         where tsh.timetable_spec_id = p_spec_id
           and tsh.hours_type_id = ht.id
           and ht.code = 'О'
           and tsh.hours_amount > 0
        union
        select tsd.day_date
          from timetables_specs_days_tbl tsd, days_types dt
         where tsd.timetable_spec_id = p_spec_id
           and tsd.day_type_id = dt.id
           and dt.absence = 0
        minus
        select tsd.day_date
          from timetables_specs_days_tbl tsd, days_types dt
         where tsd.timetable_spec_id = p_spec_id
           and tsd.day_type_id = dt.id
           and ((dt.absence = 1) or (dt.code = 'ИО')))
    ;
    return l_result;
  end timetable_spec_days_totals;


  function days_15_totals (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
  begin
    select decode(count(*),0,null,count(*))
      into l_result
      from (
        select tsh.day_date
          from timetables_specs_hours_tbl tsh, hours_types_tbl ht
         where tsh.timetable_spec_id = p_spec_id
           and tsh.hours_type_id = ht.id
           and ht.code = 'О'
           and tsh.hours_amount > 0
           and extract (day from tsh.day_date) <= 15
        union
        select tsd.day_date
          from timetables_specs_days_tbl tsd, days_types dt
         where tsd.timetable_spec_id = p_spec_id
           and tsd.day_type_id = dt.id
           and extract (day from tsd.day_date) <= 15
           and dt.absence = 0
        minus
        select tsd.day_date
          from timetables_specs_days_tbl tsd, days_types dt
         where tsd.timetable_spec_id = p_spec_id
           and tsd.day_type_id = dt.id
           and extract (day from tsd.day_date) <= 15
           and ((dt.absence = 1) or (dt.code = 'ИО')))
    ;
    return l_result;
  end days_15_totals;


  function timetable_spec_hours_totals (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
    l_main_hours_type_id number;
  begin
    l_main_hours_type_id := i_prs_data.get_main_hours_type_id;
    --
    select sum(tsh.hours_amount)
      into l_result
      from timetables_specs_hours_tbl tsh
     where tsh.timetable_spec_id = p_spec_id
       and tsh.hours_type_id = l_main_hours_type_id
       and not exists (
         select null from timetables_specs_days_tbl tsd, days_types_tbl dt
          where tsd.timetable_spec_id = p_spec_id
            and tsd.day_date = tsh.day_date
            and tsd.day_type_id = dt.id
            and ((dt.absence = 1) or (dt.code = 'ИО') or (dt.code = 'Р'))
         )
    ;
    return l_result;
  end timetable_spec_hours_totals;


  function hours_15_totals (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
    l_main_hours_type_id number;
  begin
    l_main_hours_type_id := i_prs_data.get_main_hours_type_id;
    --
    select sum(tsh.hours_amount)
      into l_result
      from timetables_specs_hours_tbl tsh
     where tsh.timetable_spec_id = p_spec_id
       and tsh.hours_type_id = l_main_hours_type_id
       and extract (day from tsh.day_date) <= 15
       and not exists (
         select null from timetables_specs_days_tbl tsd, days_types_tbl dt
          where tsd.timetable_spec_id = p_spec_id
            and tsd.day_date = tsh.day_date
            and tsd.day_type_id = dt.id
            and ((dt.absence = 1) or (dt.code = 'ИО') or (dt.code = 'Р'))
         )
    ;
    return l_result;
  end hours_15_totals;


  function timetable_spec_hours_night (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
  begin
    select sum(hours_amount)
      into l_result
      from timetables_specs_hours_tbl tsh1, hours_types_tbl ht1
     where tsh1.hours_type_id = ht1.id
       and tsh1.timetable_spec_id = p_spec_id
       and upper(trim(ht1.code)) in ('Н')
    ;
    return l_result;
  end timetable_spec_hours_night;


  function timetable_spec_hazard (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
  begin
    select sum(hours_amount)
      into l_result
      from timetables_specs_hours_tbl tsh, hours_types_tbl ht
     where tsh.hours_type_id = ht.id
       and tsh.timetable_spec_id = p_spec_id
       and upper(trim(ht.code)) in ('ВРД')
       and not exists (
         select null from timetables_specs_days_tbl tsd, days_types_tbl dt
          where tsd.timetable_spec_id = p_spec_id
            and tsd.day_date = tsh.day_date
            and tsd.day_type_id = dt.id
            and ((dt.absence = 1) or (dt.code = 'ИО') or (dt.code = 'Р'))
         )
    ;
    return l_result;
  end timetable_spec_hazard;


  function timetable_spec_hazard_prev (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
  begin
    select sum(hours_amount)
      into l_result
      from timetables_specs_hours_tbl tsh, hours_types_tbl ht
     where tsh.hours_type_id = ht.id
       and tsh.timetable_spec_id = p_spec_id
       and upper(trim(ht.code)) in ('ВРДП')
    ;
    return l_result;
  end timetable_spec_hazard_prev;


  function timetable_spec_holidays (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
  begin
    select sum(hours_amount)
      into l_result
      from timetables_specs_hours_tbl tsh
     where tsh.timetable_spec_id = p_spec_id
       and tsh.hours_type_id in (select id from hours_types_tbl where upper(code) in ('П'))
    ;
    return l_result;
   end timetable_spec_holidays;


  function timetable_spec_dayoffs (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
  begin
    select sum(hours_amount)
      into l_result
      from timetables_specs_hours_tbl tsh
     where tsh.timetable_spec_id = p_spec_id
       and tsh.hours_type_id in (select id from hours_types_tbl where upper(code) in ('В'))
    ;
    return l_result;
   end timetable_spec_dayoffs;


  function timetable_spec_edu (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
    l_main_hours_type_id number;
  begin
    l_main_hours_type_id := i_prs_data.get_main_hours_type_id;
    --
    select sum(hours_amount)
      into l_result
      from timetables_specs_hours_tbl tsh, timetables_specs_days_tbl tsd, days_types_tbl dt
     where tsh.day_date = tsd.day_date
       and tsh.timetable_spec_id = p_spec_id
       and tsd.timetable_spec_id = p_spec_id
       and tsd.day_type_id = dt.id
       and tsh.hours_type_id = l_main_hours_type_id
       and upper(trim(dt.code)) in ('У','УО','УБ','Д')
    ;
    return l_result;
  end timetable_spec_edu;

end PKG_RPT_TIMETABLES;
/
