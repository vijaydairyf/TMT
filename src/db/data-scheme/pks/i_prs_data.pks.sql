create or replace package I_PRS_DATA as

  subtype t_prs_days_data is prs_duties_days%rowtype;

  function find_calendar (
    p_company_id  in number
   ,p_schedule_id  in number
   ,p_date  in date
  ) return number;


  function find_day_type (
    p_company_id in number
   ,p_duty_id in number
   ,p_day_date in date
  ) return number;


  function find_day_hours_amount (
    p_calendar_id  in number
   ,p_day_date  in date
   ,p_hours_type_id in number
  ) return number;

  function get_main_hours_type_id return number;

end I_PRS_DATA;
/
