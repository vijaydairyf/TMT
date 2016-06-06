create or replace package I_HOLIDAYS_SCHEDULES as

  function create_schedule (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_company_id       in number
   ,p_dept_id          in number
   ,p_year             in number
  ) return std.t_pk;


  procedure refresh_schedule (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id      in number
  );


  procedure remove_schedule (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.T_PK
  );


  function save_spec_data (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id           in std.t_pk
   ,p_spec_id      in std.t_pk
   ,p_beg_date     in date
   ,p_days_amount  in number
  ) return std.t_pk;


  procedure remove_spec_data (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.T_PK
  );

end I_HOLIDAYS_SCHEDULES;
/
