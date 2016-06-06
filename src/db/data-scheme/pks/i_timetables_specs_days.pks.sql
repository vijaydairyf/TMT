create or replace package I_TIMETABLES_SPECS_DAYS as

  subtype t_data is timetables_specs_days_tbl%rowtype;

-----------------------------------------------------------------------------
-- Deletes data from TIMETABLE_SPECS_DAYS_TBL table.
-----------------------------------------------------------------------------
  procedure remove (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id in std.T_PK
  );

-----------------------------------------------------------------------------
-- Set value of prs_day_type_id == day_type_id
-----------------------------------------------------------------------------
  procedure reset_prs_day_type (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_spec_id  in std.T_PK
   ,p_date  in date
  );


-----------------------------------------------------------------------------
-- Saves day data.
-----------------------------------------------------------------------------
  procedure save_day (
    p_log_ctx  in out nocopy plogparam.log_ctx
	 ,p_timetable_spec_id  in std.t_pk
	 ,p_year  in number
	 ,p_month in number
	 ,p_day   in number
	 ,p_day_type_id  in number
	);


-----------------------------------------------------------------------------
-- If DAY_TYPE_ID or PRS_DAY_TYPE_ID values is not null, then saves data into
-- TIMETABLE_SPECS_DAYS_TBL table. Else deletes record if exists.
-----------------------------------------------------------------------------
  function save (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.t_pk
   ,p_updated  in timestamp
	 ,p_timetable_spec_id  in std.t_pk
   ,p_day_date  in date
	 ,p_day_type_id  in number
	 ,p_prs_day_type_id  in number
	) return std.t_ids;


-----------------------------------------------------------------------------
-- Finds and returns day data record.
-----------------------------------------------------------------------------
  function find_day_data (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_timetable_spec_id  in std.t_pk
   ,p_date  in date
  ) return t_data;


end I_TIMETABLES_SPECS_DAYS;
/
