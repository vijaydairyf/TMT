create or replace package body PAGE28 as

  procedure add_new_data (
    p_log_level  in number
   ,p_spec_id    in varchar2
   ,p_days       in number
   ,p_date       in date
  ) is
    l_log_ctx  plogparam.log_ctx := plog.init(plevel => p_log_level);
    l_id  std.t_pk;
  begin
    l_id := i_holidays_schedules.save_spec_data (
      p_log_ctx      => l_log_ctx
     ,p_id           => null
     ,p_spec_id      => p_spec_id
     ,p_beg_date     => p_date
     ,p_days_amount  => p_days
    );
  end add_new_data;


  procedure delete_data (
    p_log_level  in number
   ,p_id  in varchar2
  ) is
    l_log_ctx  plogparam.log_ctx := plog.init(plevel => p_log_level);
  begin
    i_holidays_schedules.remove_spec_data (
      p_log_ctx      => l_log_ctx
     ,p_id           => p_id
    );      
  end delete_data;
  
end PAGE28;
/
