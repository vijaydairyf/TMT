create or replace package I_WORKDAYS as

  subtype t_data is workdays_tbl%rowtype;

  procedure save (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_year    in number
   ,p_month   in number
   ,p_workdays in number
  );

  procedure remove (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_year  in number
   ,p_month in number
  );

end I_WORKDAYS;
/
