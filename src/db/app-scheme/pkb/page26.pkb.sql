create or replace package body PAGE26 as

  procedure create_holidays_schedule (
    p_log_level   in number
   ,p_company_id  in number
   ,p_dept_id     in number
   ,p_year        in number
  ) is
    l_log_ctx  plogparam.log_ctx := plog.init(plevel => p_log_level);
    l_id  std.t_pk;
  begin
    l_id := i_holidays_schedules.create_schedule (
      p_log_ctx     => l_log_ctx
     ,p_company_id  => p_company_id
     ,p_dept_id     => p_dept_id
     ,p_year        => p_year
    );
  end create_holidays_schedule;

end PAGE26;
/
