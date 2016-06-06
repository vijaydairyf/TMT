create or replace package PAGE26 as

  procedure create_holidays_schedule (
    p_log_level   in number
   ,p_company_id  in number
   ,p_dept_id     in number
   ,p_year        in number
  );

end PAGE26;
/
