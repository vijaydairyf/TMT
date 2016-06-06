create or replace package PKG_RPT_TIMETABLES as

  function timetable_spec_hours_totals (
    p_spec_id  in number
  ) return number;

  function timetable_spec_days_totals (
    p_spec_id  in number
  ) return number;

  function days_15_totals (
    p_spec_id  in number
  ) return number;

  function timetable_spec_hours_night (
    p_spec_id  in number
  ) return number;

  function hours_15_totals (
    p_spec_id  in number
  ) return number;

  function timetable_spec_hazard (
    p_spec_id  in number
  ) return number;

  function timetable_spec_hazard_prev (
    p_spec_id  in number
  ) return number;

  function timetable_spec_holidays (
    p_spec_id  in number
  ) return number;

  function timetable_spec_dayoffs (
    p_spec_id  in number
  ) return number;

  function timetable_spec_edu (
    p_spec_id  in number
  ) return number;

end PKG_RPT_TIMETABLES;
/
