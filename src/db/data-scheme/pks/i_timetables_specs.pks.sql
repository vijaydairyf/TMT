create or replace package I_TIMETABLES_SPECS as

  subtype t_data is timetables_specs_tbl%rowtype;

/*
  procedure save (
    p_data in out nocopy t_data
  );
*/

/*
  function load_spec_data (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_timetable_id  in std.t_pk
   ,p_duty_hist_id  in number
   ,p_beg_date  in date
   ,p_end_date  in date
  ) return std.t_ids;
*/


/*
  procedure import_from_parus (
    p_log_ctx  in out nocopy plogparam.log_ctx
	 ,p_spec_id  in std.t_pk
	);
*/



  function save (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.t_pk
   ,p_updated  in timestamp
   ,p_timetable_id  in std.t_pk
   ,p_emp_id  in number
   ,p_post_id  in number
   ,p_wage_rate  in number
   ,p_prs_duty_hist_id  in number
  ) return std.t_ids;


  procedure remove (
    p_id in std.T_PK
  );

  procedure load_data_from_parus (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_spec_id  in std.t_pk
  );

  procedure save_to_parus (
    p_log_ctx  in out nocopy plogparam.log_ctx
	 ,p_spec_id  in std.t_pk
	);

  function divergence_exists (
    p_spec_id  in std.t_pk
  ) return boolean;


  function get_workoff_days (
    p_spec_id  in number
  ) return number;

  function get_workoff_hours (
    p_spec_id  in number
  ) return number;

end I_TIMETABLES_SPECS;
/
