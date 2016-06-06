create or replace package PKG_TIMETABLES as

    procedure create_timetable (
         p_log_ctx      in out nocopy plogparam.log_ctx
        ,p_company_id   in number
        ,p_year         in number
        ,p_month        in number
        ,p_dept_id      in number
    );


    function create_correction (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_timetable_id   in number
    ) return number;


    procedure remove_timetable (
         p_log_ctx          in out nocopy plogparam.log_ctx
        ,p_timetable_id     in std.t_pk
    );


    procedure save_timetable_spec_data (
         p_log_ctx                  in out nocopy plogparam.log_ctx
        ,p_spec_id                  in std.t_pk
        ,p_day_date                 in date
        ,p_day_type_id              in number
        ,p_main_hours_amount        in number
        ,p_night_hours_amount       in number
        ,p_dayoff_hours_amount      in number
        ,p_holiday_hours_amount     in number
        ,p_hazard_hours_amount      in number
        ,p_hazard_old_hours_amount  in number
    );


    procedure remove_timetable_spec_data (
        p_spec_id   in std.t_pk
    );


    procedure save_timetable_to_parus (
         p_log_ctx          in out nocopy plogparam.log_ctx
        ,p_timetable_id     in std.t_pk
    );


    procedure save_spec_to_parus (
         p_log_ctx      in out nocopy plogparam.log_ctx
        ,p_spec_id      in std.t_pk
    );


    procedure import_timetable_from_parus (
         p_log_ctx          in out nocopy plogparam.log_ctx
        ,p_timetable_id     in std.t_pk
    );


    procedure import_spec_from_parus (
         p_log_ctx      in out nocopy plogparam.log_ctx
        ,p_spec_id      in std.t_pk
    );


    procedure submit (
        p_timetable_id  in std.t_pk
    );


    function is_submited (
        p_timetable_id  in std.t_pk
    ) return boolean;


    procedure recall (
        p_timetable_id  in std.t_pk
    );


    procedure accept (
        p_timetable_id  in std.t_pk
    );


    function is_accepted (
        p_timetable_id  in std.t_pk
    ) return boolean;


    procedure reject (
        p_timetable_id  in std.t_pk
    );


    function timetable_divergence_exists (
        p_timetable_id  in std.t_pk
    ) return boolean;


    function spec_divergence_exists (
        p_spec_id       in std.t_pk
    ) return boolean;


    function timetable_divergence_mark (
        p_timetable_id  in std.t_pk
    ) return char;


    function spec_divergence_mark (
        p_spec_id       in std.t_pk
    ) return char;


    procedure save_workdays (
         p_log_ctx      in out nocopy plogparam.log_ctx
        ,p_year         in number
        ,p_month        in number
        ,p_workdays     in number
    );


    procedure remove_workdays (
         p_log_ctx      in out nocopy plogparam.log_ctx
        ,p_year         in number
        ,p_month        in number
    );


    function save_depts_properties (
         p_log_ctx          in out nocopy plogparam.log_ctx
        ,p_id               in std.t_pk
        ,p_updated          in timestamp
        ,p_dept_id          in number
        ,p_curator_post     in varchar2
        ,p_curator_name     in varchar2
        ,p_manager_name     in varchar2
        ,p_milk_resp_name   in varchar2
    ) return std.t_ids;


    procedure remove_depts_properties (
         p_log_ctx      in out nocopy plogparam.log_ctx
        ,p_id           in std.t_pk
    );

end PKG_TIMETABLES;
/
