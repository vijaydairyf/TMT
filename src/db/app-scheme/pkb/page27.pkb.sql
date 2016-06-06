create or replace package body PAGE27 as

  procedure remove_schedule (
    p_log_level    in number
   ,p_schedule_id  in std.t_pk
  ) is
    l_log_ctx  plogparam.log_ctx := plog.init(plevel => p_log_level);
  begin
    i_holidays_schedules.remove_schedule (
      p_log_ctx  => l_log_ctx
     ,p_id  => p_schedule_id
    );
  end remove_schedule;


  procedure refresh_schedule (
    p_log_level    in number
   ,p_schedule_id  in std.t_pk
  ) is
    l_log_ctx  plogparam.log_ctx := plog.init(plevel => p_log_level);
  begin
    i_holidays_schedules.refresh_schedule (
      p_log_ctx  => l_log_ctx
     ,p_id  => p_schedule_id
    );
  end refresh_schedule;


  function get_holidays_list (
    p_spec_id  in std.t_pk
  ) return varchar2 is
    l_result std.t_text;
  begin
    for c1 in (
      select days_amount, beg_date 
        from holisched_specs_data
       where spec_id = p_spec_id
       order by beg_date
    ) loop
      if (l_result is not null) then
        l_result := l_result||'<br>';
      end if;
      l_result := l_result||c1.days_amount||' к/д с '||to_char(c1.beg_date,'dd.mm.yyyy');
    end loop;
    --
    return l_result;
  end get_holidays_list;
  
end PAGE27;
/
