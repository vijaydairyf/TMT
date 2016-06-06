create or replace package body I_PRS_DATA as

  function find_calendar (
    p_company_id  in number
   ,p_schedule_id  in number
   ,p_date  in date
  ) return number is
    l_result number;
  begin
    begin
      select p.rn
        into l_result
        from prs_enperiod p
       where p.company = p_company_id
         and p.schedule = p_schedule_id
         and p_date between p.startdate and p.enddate
      ;
    exception
      when no_data_found then
        l_result := null;
    end;
    --
    return l_result;
  end find_calendar;


  function find_day_type (
    p_company_id in number
   ,p_duty_id in number
   ,p_day_date in date
  ) return number is
    l_result number;
  begin
    prs_pkg_clnpspfmwd.find_day_type (
      ncompany => p_company_id
     ,nrn => p_duty_id
     ,dcurrdate => p_day_date
     ,nusedeviat => 0
     ,ndaystype => l_result
    );
    --
    return l_result;
  end find_day_type;


  function get_main_hours_type_id return number
  is
    l_result  number;
  begin
    begin
      select ht.rn
        into l_result
        from prs_hours_types ht
       where code = 'О'
      ;
    exception
      when no_data_found then
        l_result := null;
    end;
    --
    return l_result;
  end get_main_hours_type_id;


  function find_day_hours_amount (
    p_calendar_id  in number
   ,p_day_date  in date
   ,p_hours_type_id in number
  ) return number is
    l_result  number;
--    l_main_hours_type_id  number;
  begin
--    l_main_hours_type_id := get_main_hours_type_id;
    begin
      select ds.hoursnorm
        into l_result
        from prs_workdays d, prs_workdaystr ds
       where d.prn = p_calendar_id
         and d.days = extract (day from p_day_date)
         and ds.prn = d.rn
         and ds.hourstypes = p_hours_type_id
--         and ds.hourstypes = l_main_hours_type_id
         and ds.hoursnorm <> 0
      ;
    exception
      when no_data_found then
        l_result := null;
    end;
    --
    return l_result;
  end find_day_hours_amount;

end I_PRS_DATA;
/
