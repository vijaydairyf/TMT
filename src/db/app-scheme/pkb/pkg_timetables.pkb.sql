create or replace package body PKG_TIMETABLES as

    g_module constant varchar2(30) := 'PKG_TIMETABLES';


    procedure create_timetable (
         p_log_ctx      in out nocopy plogparam.log_ctx
        ,p_company_id   in number
        ,p_year         in number
        ,p_month        in number
        ,p_dept_id      in number
    ) is
        l_action constant varchar2(30) := 'CREATE_TIMETABLE';
    begin
        plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);

        i_timetables.create_timetable (
             p_log_ctx      => p_log_ctx
            ,p_company_id   => p_company_id
            ,p_year         => p_year
            ,p_month        => p_month
            ,p_dept_id      => p_dept_id
        );

        plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    end create_timetable;


    function create_correction (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_timetable_id   in number
    ) return number is
        l_action constant varchar2(30) := 'CREATE_CORRECTION';
        l_result std.t_ids;
    begin
        plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);

        l_result := i_timetables.create_correction (
             p_log_ctx        => p_log_ctx
            ,p_timetable_id   => p_timetable_id
        );

        plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);

        return l_result.id;
    end create_correction;


    procedure remove_timetable (
         p_log_ctx          in out nocopy plogparam.log_ctx
        ,p_timetable_id     in std.t_pk
    ) is
        l_action constant varchar2(30) := 'REMOVE_TIMETABLE';
    begin
        plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);

        i_timetables.remove (
             p_log_ctx  => p_log_ctx
            ,p_id       => p_timetable_id
        );

        plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    end remove_timetable;


    procedure save_timetable_spec_data (
         p_log_ctx  in out nocopy plogparam.log_ctx
        ,p_spec_id  in std.t_pk
        ,p_day_date in date
        ,p_day_type_id in number
        ,p_main_hours_amount in number
        ,p_night_hours_amount in number
        ,p_dayoff_hours_amount in number
        ,p_holiday_hours_amount in number
        ,p_hazard_hours_amount in number
        ,p_hazard_old_hours_amount in number
    ) is
        l_action constant varchar2(30) := 'SAVE_TIMETABLE_SPEC_DATA';
    begin
        plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);

        plog.debug ( p_log_ctx, 'Saving Spec data. '
            ||'p_spec_id="'||p_spec_id
            ||'"; p_day_date="'||to_char(p_day_date,'dd.mm.yyyy')
            ||'"; p_day_type_id="'||p_day_type_id
            ||'"; p_main_hours_amount="'||p_main_hours_amount
            ||'"; p_night_hours_amount="'||p_night_hours_amount
            ||'"; p_dayoff_hours_amount="'||p_dayoff_hours_amount
            ||'".'
        );

        for timetable in (
            select table_month, table_year
              from timetables_tbl t, timetables_specs_tbl ts
             where t.id = ts.timetable_id
               and ts.id = p_spec_id
        ) loop
            i_timetables_specs_days.save_day (
                 p_log_ctx              => p_log_ctx
                ,p_timetable_spec_id    => p_spec_id
                ,p_year                 => timetable.table_year
                ,p_month                => timetable.table_month
                ,p_day                  => extract(day from p_day_date)
                ,p_day_type_id          => p_day_type_id
            );
            for hours_types in (
                select id, code from hours_types_tbl
            ) loop
                if ( hours_types.code = 'О' ) then
                    i_timetables_specs_hours.save_hours (
                         p_log_ctx              => p_log_ctx
                        ,p_timetable_spec_id    => p_spec_id
                        ,p_year                 => timetable.table_year
                        ,p_month                => timetable.table_month
                        ,p_day                  => extract(day from p_day_date)
                        ,p_hours_type_id        => hours_types.id
                        ,p_hours_amount         => p_main_hours_amount
                    );
                elsif ( hours_types.code = 'Н' ) then
                    i_timetables_specs_hours.save_hours (
                         p_log_ctx              => p_log_ctx
                        ,p_timetable_spec_id    => p_spec_id
                        ,p_year                 => timetable.table_year
                        ,p_month                => timetable.table_month
                        ,p_day                  => extract(day from p_day_date)
                        ,p_hours_type_id        => hours_types.id
                        ,p_hours_amount         => p_night_hours_amount
                    );
                elsif ( hours_types.code = 'П' ) then
                    i_timetables_specs_hours.save_hours (
                         p_log_ctx              => p_log_ctx
                        ,p_timetable_spec_id    => p_spec_id
                        ,p_year                 => timetable.table_year
                        ,p_month                => timetable.table_month
                        ,p_day                  => extract(day from p_day_date)
                        ,p_hours_type_id        => hours_types.id
                        ,p_hours_amount         => p_holiday_hours_amount
                    );
                elsif ( hours_types.code = 'В' ) then
                    i_timetables_specs_hours.save_hours (
                         p_log_ctx              => p_log_ctx
                        ,p_timetable_spec_id    => p_spec_id
                        ,p_year                 => timetable.table_year
                        ,p_month                => timetable.table_month
                        ,p_day                  => extract(day from p_day_date)
                        ,p_hours_type_id        => hours_types.id
                        ,p_hours_amount         => p_dayoff_hours_amount
                    );
                elsif ( hours_types.code = 'Врд' ) then
                    i_timetables_specs_hours.save_hours (
                         p_log_ctx              => p_log_ctx
                        ,p_timetable_spec_id    => p_spec_id
                        ,p_year                 => timetable.table_year
                        ,p_month                => timetable.table_month
                        ,p_day                  => extract(day from p_day_date)
                        ,p_hours_type_id        => hours_types.id
                        ,p_hours_amount         => p_hazard_hours_amount
                    );
                elsif ( hours_types.code = 'ВрдП' ) then
                    i_timetables_specs_hours.save_hours (
                         p_log_ctx              => p_log_ctx
                        ,p_timetable_spec_id    => p_spec_id
                        ,p_year                 => timetable.table_year
                        ,p_month                => timetable.table_month
                        ,p_day                  => extract(day from p_day_date)
                        ,p_hours_type_id        => hours_types.id
                        ,p_hours_amount         => p_hazard_old_hours_amount
                    );
                end if;
            end loop hours_types;
        end loop timetable;
        plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    exception
        when others then
            plog.error(p_log_ctx);
            raise;
    end save_timetable_spec_data;


    procedure remove_timetable_spec_data (
        p_spec_id   in std.t_pk
    ) is
    begin
        i_timetables_specs.remove (
            p_id  => p_spec_id
        );
    end remove_timetable_spec_data;


    procedure save_timetable_to_parus (
         p_log_ctx          in out nocopy plogparam.log_ctx
        ,p_timetable_id     in std.t_pk
    ) is
    begin
        i_timetables.save_to_parus (
             p_log_ctx          => p_log_ctx
            ,p_timetable_id     => p_timetable_id
        );
    end save_timetable_to_parus;


    procedure save_spec_to_parus (
         p_log_ctx      in out nocopy plogparam.log_ctx
        ,p_spec_id      in std.t_pk
    ) is
    begin
        i_timetables_specs.save_to_parus (
             p_log_ctx  => p_log_ctx
            ,p_spec_id  => p_spec_id
        );
    end save_spec_to_parus;


    procedure import_timetable_from_parus (
         p_log_ctx          in out nocopy plogparam.log_ctx
        ,p_timetable_id     in std.t_pk
    ) is
    begin
        i_timetables.load_data_from_parus (
             p_log_ctx          => p_log_ctx
            ,p_timetable_id     => p_timetable_id
        );
    end import_timetable_from_parus;


    -- Issue: Когда после создания табеля срок действия исполнения сужается
    -- в Парусе и после этого выполняется импорт из Паруса, то те дни,
    -- которые в табеле остались за границами дат срока действия
    -- соответствующего исполнения не обновляются.
    procedure import_spec_from_parus (
         p_log_ctx      in out nocopy plogparam.log_ctx
        ,p_spec_id      in std.t_pk
    ) is
    begin
        i_timetables_specs.load_data_from_parus (
             p_log_ctx  => p_log_ctx
            ,p_spec_id  => p_spec_id
        );
    end import_spec_from_parus;


    procedure submit (
        p_timetable_id in std.t_pk
    ) is
    begin
        i_timetables.submit(p_timetable_id => p_timetable_id);
    exception
        when std.TIMETABLE_ALREADY_SUBMITTED then
            apex_application.show_error_message ( apex_lang.message ( 'TIMETABLE_ALREADY_SUBMITTED_MSG' ));
        when std.TIMETABLE_ALREADY_ACCEPTED then
            apex_application.show_error_message ( apex_lang.message ( 'TIMETABLE_ALREADY_ACCEPTED_MSG' ));
    end submit;


    function is_submited (
        p_timetable_id in std.t_pk
    ) return boolean is
        l_cnt integer := 0;
    begin
        select count(*)
          into l_cnt
          from timetables_tbl t
         where t.id = p_timetable_id
           and t.submitted is not null
        ;
        return (l_cnt > 0);
    end is_submited;


    procedure recall (
        p_timetable_id in std.t_pk
    ) is
    begin
        i_timetables.recall(p_timetable_id => p_timetable_id);
    exception
        when std.TIMETABLE_NOT_SUBMITTED_YET then
            apex_application.show_error_message ( apex_lang.message ( 'TIMETABLE_NOT_SUBMITTED_YET_MSG' ));
        when std.TIMETABLE_ALREADY_ACCEPTED THEN
            apex_application.show_error_message ( apex_lang.message ( 'TIMETABLE_ALREADY_ACCEPTED_MSG' ));
    end recall;


    procedure accept (
        p_timetable_id in std.t_pk
    ) is
    begin
        i_timetables.accept (p_timetable_id => p_timetable_id);
    exception
        when std.TIMETABLE_NOT_SUBMITTED_YET then
            apex_application.show_error_message ( apex_lang.message ( 'TIMETABLE_NOT_SUBMITTED_YET_MSG' ));
        when std.TIMETABLE_ALREADY_ACCEPTED then
            apex_application.show_error_message ( apex_lang.message ( 'TIMETABLE_ALREADY_ACCEPTED_MSG' ));
    end accept;


    function is_accepted (
        p_timetable_id in std.t_pk
    ) return boolean is
        l_cnt integer := 0;
    begin
        select count(*)
          into l_cnt
          from timetables_tbl t
         where t.id = p_timetable_id
           and t.accepted is not null
        ;
        return (l_cnt > 0);
    end is_accepted;


    procedure reject (
        p_timetable_id in std.t_pk
    ) is
    begin
        i_timetables.reject(p_timetable_id => p_timetable_id);
    exception
        when std.TIMETABLE_NOT_SUBMITTED_YET then
            apex_application.show_error_message ( apex_lang.message ( 'TIMETABLE_NOT_SUBMITTED_YET_MSG' ));
        when std.TIMETABLE_NOT_ACCEPTED_YET then
            apex_application.show_error_message ( apex_lang.message ( 'TIMETABLE_NOT_ACCEPTED_YET_MSG' ));
    end reject;


    function timetable_divergence_exists (
        p_timetable_id  in std.t_pk
    ) return boolean
    is
    begin
        return i_timetables.divergence_exists(
            p_timetable_id => p_timetable_id
        );
    end timetable_divergence_exists;


    function spec_divergence_exists (
        p_spec_id  in std.t_pk
    ) return boolean
    is
    begin
        return i_timetables_specs.divergence_exists (
            p_spec_id => p_spec_id
        );
    end spec_divergence_exists;


    function timetable_divergence_mark (
        p_timetable_id  in std.t_pk
    ) return char is
        l_result char(1);
    begin
        if ( timetable_divergence_exists ( p_timetable_id => p_timetable_id )) then
            l_result := '+';
        else
            l_result := '-';
        end if;
        return l_result;
    end timetable_divergence_mark;


    function spec_divergence_mark (
        p_spec_id  in std.t_pk
    ) return char is
        l_result char(1);
    begin
        if ( spec_divergence_exists ( p_spec_id => p_spec_id )) then
            l_result := '+';
        else
            l_result := '-';
        end if;
        return l_result;
    end spec_divergence_mark;


    procedure save_workdays (
         p_log_ctx  in out nocopy plogparam.log_ctx
        ,p_year    in number
        ,p_month   in number
        ,p_workdays in number
    ) is
    begin
        i_workdays.save (
             p_log_ctx      => p_log_ctx
            ,p_year         => p_year
            ,p_month        => p_month
            ,p_workdays     => p_workdays
        );
    end save_workdays;


    procedure remove_workdays (
         p_log_ctx  in out nocopy plogparam.log_ctx
        ,p_year     in number
        ,p_month    in number
    ) is
    begin
        i_workdays.remove (
             p_log_ctx  => p_log_ctx
            ,p_year     => p_year
            ,p_month    => p_month
        );
    end remove_workdays;


    function save_depts_properties (
         p_log_ctx          in out nocopy plogparam.log_ctx
        ,p_id               in std.t_pk
        ,p_updated          in timestamp
        ,p_dept_id          in number
        ,p_curator_post     in varchar2
        ,p_curator_name     in varchar2
        ,p_manager_name     in varchar2
        ,p_milk_resp_name   in varchar2
    ) return std.t_ids is
        l_ids  std.t_ids;
    begin
        l_ids := i_depts_properties.save (
             p_log_ctx  => p_log_ctx
            ,p_id  => p_id
            ,p_updated  => p_updated
            ,p_dept_id  => p_dept_id
            ,p_curator_post  => p_curator_post
            ,p_curator_name  => p_curator_name
            ,p_manager_name  => p_manager_name
            ,p_milk_resp_name  => p_milk_resp_name
        );
        return l_ids;
    end save_depts_properties;


    procedure remove_depts_properties (
         p_log_ctx  in out nocopy plogparam.log_ctx
        ,p_id       in std.t_pk
    ) is
    begin
        i_depts_properties.remove (
             p_log_ctx  => p_log_ctx
            ,p_id       => p_id
        );
    end remove_depts_properties;

end PKG_TIMETABLES;
/
