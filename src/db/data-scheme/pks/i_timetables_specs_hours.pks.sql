create or replace package I_TIMETABLES_SPECS_HOURS as

  subtype t_data is timetables_specs_hours_tbl%rowtype;

  procedure save_hours (
    p_log_ctx  in out nocopy plogparam.log_ctx
	 ,p_timetable_spec_id  in std.t_pk
	 ,p_year  in number
	 ,p_month in number
	 ,p_day   in number
	 ,p_hours_type_id in number
	 ,p_hours_amount  in number
	);

  procedure remove (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id in std.T_PK
  );


  function save (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.t_pk
   ,p_updated  in timestamp
   ,p_timetable_spec_id  in std.t_pk
   ,p_day_date  in date
   ,p_hours_type_id  in number
   ,p_hours_amount  in number
   ,p_prs_hours_amount  in number
  ) return std.t_ids;


  function find_hours_data (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_timetable_spec_id  in std.t_pk
   ,p_date  in date
   ,p_hours_type_id  in number
  ) return t_data;

end I_TIMETABLES_SPECS_HOURS;
/
