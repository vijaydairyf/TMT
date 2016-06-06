create or replace package PAGE27 as

  procedure remove_schedule (
    p_log_level    in number
   ,p_schedule_id  in std.t_pk
  );


  procedure refresh_schedule (
    p_log_level    in number
   ,p_schedule_id  in std.t_pk
  );


  function get_holidays_list (
    p_spec_id  in std.t_pk
  ) return varchar2;

end PAGE27;
/
