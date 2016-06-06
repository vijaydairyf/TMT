create or replace package I_TIMETABLES as

    subtype t_data is timetables_tbl%rowtype;


    procedure create_timetable (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_company_id     in number
        ,p_year           in number
        ,p_month          in number
        ,p_dept_id        in number
    );


    function create_correction (
         p_log_ctx          in out nocopy plogparam.log_ctx
        ,p_timetable_id     in number
    ) return std.t_ids;


    function save (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_id             in std.t_pk
        ,p_updated        in timestamp
        ,p_company_id     in number
        ,p_dept_id        in number
        ,p_table_year     in number
        ,p_table_month    in number
        ,p_table_type     in number
        ,p_submitted      in date
        ,p_accepted       in date
    ) return std.t_ids;


    procedure remove (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_id             in std.T_PK
    );

    procedure load_data_from_parus (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_timetable_id   in std.t_pk
    );

    procedure save_to_parus (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_timetable_id   in std.t_pk
    );

    procedure submit (
        p_timetable_id    in std.t_pk
    );

    procedure recall (
        p_timetable_id    in std.t_pk
    );

    procedure accept (
        p_timetable_id    in std.t_pk
    );

    procedure reject (
        p_timetable_id    in std.t_pk
    );

    function divergence_exists (
        p_timetable_id    in std.t_pk
    ) return boolean;

end I_TIMETABLES;
/
