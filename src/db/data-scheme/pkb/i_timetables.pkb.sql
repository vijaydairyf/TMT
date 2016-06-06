create or replace package body I_TIMETABLES as

    g_module constant varchar2(30) := 'I_TIMETABLES';


    procedure remove (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_id             in std.T_PK
    )
    is
        l_action constant varchar2(30) := 'REMOVE';
    begin
        plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
        --
        delete from timetables_tbl where id = p_id;
        --
        plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    exception
        when others then
            plog.error(p_log_ctx);
            raise;
    end remove;


    procedure save_to_parus (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_timetable_id   in std.t_pk
    ) is
        l_action constant varchar2(30) := 'SAVE_TO_PARUS';
    begin
        plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
        --
        for specs in (
            select id
              from timetables_specs_tbl ts
             where ts.timetable_id = p_timetable_id
        ) loop
            i_timetables_specs.save_to_parus(
                 p_log_ctx => p_log_ctx
                ,p_spec_id => specs.id
            );
        end loop specs;
        --
        plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    exception
        when others then
            plog.error(p_log_ctx);
            raise;
    end save_to_parus;


    -- Загрузить данные Табеля из Паруса.
    procedure load_data_from_parus (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_timetable_id   in std.t_pk
    ) is
        l_action constant varchar2(30) := 'LOAD_DATA_FROM_PARUS';
        l_beg_date date;
        l_end_date date;
        l_spec_ids std.t_ids;
    begin
        plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
        plog.assert(p_log_ctx, p_timetable_id is not null,'P_TIMETABLE_ID is null');
        -- Получить данные Табеля.
        for timetable in (
            select id, company_id, dept_id, table_month, table_year
              from timetables_tbl
             where id = p_timetable_id
               for update
        ) loop
            l_beg_date := to_date('01'||to_char(timetable.table_month,'00')||to_char(timetable.table_year,'0000'),'ddmmyyyy');
            l_end_date := last_day(l_beg_date);
            --
            plog.debug ( p_log_ctx, 'Timetable data: '
                ||'id="'||timetable.id
                ||'"; company_id="'||timetable.company_id
                ||'"; dept_id="'||timetable.dept_id
                ||'"; table_month="'||timetable.table_month
                ||'"; table_year="'||timetable.table_year
                ||'"; l_beg_date="'||to_char(l_beg_date,'dd.mm.yyyy')
                ||'"; l_end_date="'||to_char(l_end_date,'dd.mm.yyyy')
                ||'".'
            );
            -- Найти в Табеле Строки, для которых нет Исполнений в Парусе и удалить их из Табеля.
            for duty in (
                select ts.prs_duty_hist_id duty_hist_id
                  from timetables_specs_tbl ts
                 where ts.timetable_id = timetable.id
                minus
                select dh.rn duty_hist_id
                  from prs_duties d, prs_duties_hist dh
                 where d.company = timetable.company_id
                   and d.deptrn = timetable.dept_id
                   and (d.begeng <= l_end_date and (d.endeng is null or d.endeng >= l_beg_date))
                   and dh.prn = d.rn
                   and (dh.do_act_from <= l_end_date and (dh.do_act_to is null or dh.do_act_to >= l_beg_date))
            ) loop
                -- Удалить из Табеля Строки, для которых нет Исполнений в Табеле.
                for spec in (
                    select ts.id
                      from timetables_specs_tbl ts
                     where ts.prs_duty_hist_id = duty.duty_hist_id
                       for update
                ) loop
                    plog.debug ( p_log_ctx, 'Removing obsolete specs: '
                        ||'spec_id="'||spec.id
                        ||'".'
                    );
                    --
                    i_timetables_specs.remove ( p_id => spec.id );
                end loop spec;
            end loop duty;
            -- Найти в Парусе Исполнения, для которых нет строк в Табеле и добавить их в Табель.
            -- Исключить исполнения, где ставка = 0, где тип 'зам'
            for duty in (
                select dh.rn duty_hist_id
                  from prs_duties d, prs_duties_hist dh, duties_types_tbl dt
                 where d.company = timetable.company_id
                   and d.deptrn = timetable.dept_id
                   and d.clnpspfmtypes = dt.id
                   and (d.begeng <= l_end_date and (d.endeng is null or d.endeng >= l_beg_date))
                   and dh.prn = d.rn
                   and (dh.do_act_from <= l_end_date and (dh.do_act_to is null or dh.do_act_to >= l_beg_date))
                   and dh.rateacc <> 0  -- не брать исполнения, где ставка = 0
                   and dt.code not in ('зам') -- не брать исполнения с типом 'зам'
                minus
                select ts.prs_duty_hist_id duty_hist_id
                  from timetables_specs_tbl ts
                 where ts.timetable_id = timetable.id
            ) loop
                -- Для каждного найденного Исполнения:
                -- Создать Строку Табеля на основе данных Исполнения.
                for duty_data in (
                    select d.persrn, d.psdeprn, dh.rateacc
                      from prs_duties d, prs_duties_hist dh
                     where dh.prn = d.rn
                       and dh.rn = duty.duty_hist_id
                       for update
                ) loop
                    plog.debug ( p_log_ctx, 'Creating new specs: '
                        ||'emp_id="'||duty_data.persrn
                        ||'post_id="'||duty_data.psdeprn
                        ||'wage_rate="'||duty_data.rateacc
                        ||'prs_duty_hist_id="'||duty.duty_hist_id
                        ||'".'
                    );
                    --
                    l_spec_ids := i_timetables_specs.save (
                        p_log_ctx            => p_log_ctx
                        ,p_id                => null
                        ,p_updated           => null
                        ,p_timetable_id      => timetable.id
                        ,p_emp_id            => duty_data.persrn
                        ,p_post_id           => duty_data.psdeprn
                        ,p_wage_rate         => duty_data.rateacc
                        ,p_prs_duty_hist_id  => duty.duty_hist_id
                    );
                end loop duty_data;
            end loop duty;
            -- Найти все Строки Табеля.
            for specs in (
                select id
                  from timetables_specs_tbl ts
                 where ts.timetable_id = p_timetable_id
                   for update
            ) loop
                -- Для каждой найденной Строки Табеля:
                -- Загрузить из Паруса данные дней и часов для Строки Табеля.
                plog.debug ( p_log_ctx,
                    'Loading Days and Hours data for spec: '
                    ||'spec_id="'||specs.id
                    ||'".'
                );
                --
                i_timetables_specs.load_data_from_parus (
                     p_log_ctx => p_log_ctx
                    ,p_spec_id => specs.id
                );
            end loop specs;
        end loop timetable;
        --
        plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    exception
        when others then
            plog.error(p_log_ctx);
            raise;
    end load_data_from_parus;


    procedure submit (
        p_timetable_id    in std.t_pk
    ) is
        l_submitted date;
        l_accepted date;
    begin
        select submitted, accepted
          into l_submitted, l_accepted
          from timetables_tbl
         where id = p_timetable_id
        ;
        if ( l_submitted is null and l_accepted is null ) then
            update timetables_tbl
               set submitted = sysdate
             where id = p_timetable_id
               and submitted is null
               and accepted is null
            ;
        elsif ( l_submitted is not null ) then
            raise std.TIMETABLE_ALREADY_SUBMITTED;
        elsif ( l_accepted is not null ) then
            raise std.TIMETABLE_ALREADY_ACCEPTED;
        end if;
    end submit;


    procedure recall (
        p_timetable_id    in std.t_pk
    ) is
        l_submitted date;
        l_accepted date;
    begin
        select submitted, accepted
          into l_submitted, l_accepted
          from timetables_tbl
         where id = p_timetable_id
        ;
        if (l_submitted is not null and l_accepted is null) then
            update timetables_tbl
               set submitted = null
             where id = p_timetable_id
               and submitted is not null
               and accepted is null
            ;
        elsif (l_submitted is null) then
            raise std.TIMETABLE_NOT_SUBMITTED_YET;
        elsif (l_accepted is not null) then
            raise std.TIMETABLE_ALREADY_ACCEPTED;
        end if;
    end recall;


    procedure accept (
        p_timetable_id    in std.t_pk
    ) is
        l_submitted date;
        l_accepted date;
    begin
        select submitted, accepted
          into l_submitted, l_accepted
          from timetables_tbl
         where id = p_timetable_id
        ;
        if (l_submitted is not null and l_accepted is null) then
            update timetables_tbl
               set accepted = sysdate
             where id = p_timetable_id
               and submitted is not null
               and accepted is null
            ;
        elsif (l_submitted is null) then
            raise std.TIMETABLE_NOT_SUBMITTED_YET;
        elsif (l_accepted is not null) then
            raise std.TIMETABLE_ALREADY_ACCEPTED;
        end if;
    end accept;


    procedure reject (
        p_timetable_id    in std.t_pk
    ) is
        l_submitted date;
        l_accepted date;
    begin
        select submitted, accepted
          into l_submitted, l_accepted
          from timetables_tbl
         where id = p_timetable_id
        ;
        if ( l_submitted is not null and l_accepted is not null ) then
            update timetables_tbl
               set accepted = null
             where id = p_timetable_id
               and l_submitted is not null
               and l_accepted is not null
            ;
        elsif (l_submitted is null) then
            raise std.TIMETABLE_NOT_SUBMITTED_YET;
        elsif (l_accepted is null) then
            raise std.TIMETABLE_NOT_ACCEPTED_YET;
        end if;
    end reject;


    function divergence_exists (
        p_timetable_id    in std.t_pk
    ) return boolean
    is
        l_cnt number := 0;
    begin
        for tbl in (
            select t.id, t.company_id, t.dept_id
                  ,to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy') beg_date
                  ,last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')) end_date
                  ,extract(day from last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))) max_day
              from timetables_tbl t
             where t.id = p_timetable_id
        ) loop
            with
            tt_hours as (
                select ts.id, tsh.day_date, ht.rn as hours_type_id, tsh.hours_amount
                  from timetables_specs_tbl ts, prs_hours_types ht, timetables_specs_hours_tbl tsh
                 where ts.timetable_id = tbl.id
                   and ts.id = tsh.timetable_spec_id
                   and tsh.hours_type_id = ht.rn
            ),
            prs_hours as (
                select ts.id, dd.workdate, h.hourstype, h.workedhours
                  from prs_duties_hist dh, prs_duties_days dd, prs_duties_hours h, timetables_specs_tbl ts
                 where dh.prn = dd.prn
                   and dd.rn = h.prn
                   and dh.rn = ts.prs_duty_hist_id
                   and dd.workdate between tbl.beg_date and tbl.end_date
                   and ts.timetable_id = tbl.id
            ),
            tt_days as (
                select sp.id as id, d.day_date as day_date, d.day_type_id as day_type
                  from timetables_specs_tbl sp, timetables_specs_days_tbl d
                 where sp.timetable_id = tbl.id
                   and sp.id = d.timetable_spec_id
                 order by sp.id, d.day_date
            ),
            prs_days as (
                select ts.id as id, dd.workdate as day_date, dd.daystype as day_type
                  from prs_duties_hist dh, prs_duties_days dd, timetables_specs_tbl ts
                 where dh.prn = dd.prn
                   and dh.rn = ts.prs_duty_hist_id
                   and dd.workdate between tbl.beg_date and tbl.end_date
                   and ts.timetable_id = tbl.id
            ),
            days_pool as (
                select ts.id as id, dp.day_date as day_date, null as day_type
                  from timetables_specs_tbl ts
                      ,( SELECT tbl.beg_date + rownum - 1 as day_date FROM (SELECT null FROM dual GROUP BY CUBE(1,2,3,4,5)) WHERE  ROWNUM < tbl.max_day + 1) dp
                 where ts.timetable_id = tbl.id
            )
            select sum(cnt)
              into l_cnt
              from ( select count(*) as cnt from (
                        ( select * from prs_hours minus select * from tt_hours )
                        union all
                        ( select * from tt_hours minus select * from prs_hours )
                     )
                     union all
                     select count(*) as cnt from (
                        ( select * from tt_days minus select * from prs_days )
                        union all
                        ( select * from prs_days minus select * from tt_days )
                        minus
                        select * from days_pool
                        )
                   )
            ;
        end loop tbl;
        return ( l_cnt > 0 );
    end divergence_exists;


    function divergence_mark (
        p_timetable_id    in std.t_pk
    ) return char is
        l_result char(1);
    begin
        if (divergence_exists(p_timetable_id => p_timetable_id)) then
            l_result := '+';
        else
            l_result := '-';
        end if;
        --
        return l_result;
    end divergence_mark;


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
    ) return std.t_ids is
        l_action constant varchar2(30) := 'SAVE';
        l_ids  std.t_ids;
        l_rowid  rowid;
        l_updated  timestamp;
    begin
        plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
        --
        if ( p_id is null ) then
            plog.debug ( p_log_ctx, 'Inserting into TIMETABLES_TBL (ID is null). '
                ||'company_id="'||p_company_id
                ||'"; dept_id="'||p_dept_id
                ||'"; table_year="'||p_table_year
                ||'"; table_month="'||p_table_month
                ||'"; submitted="'||p_submitted
                ||'"; accepted="'||p_accepted
                ||'".'
            );
            --
            insert into timetables_tbl (
                id, updated, updater, company_id, dept_id, table_year, table_month, table_type, submitted, accepted
            )
            values (
                null, null, null, p_company_id, p_dept_id, p_table_year, p_table_month, p_table_type, p_submitted, p_accepted
            )
            returning id, updated into l_ids.id, l_ids.updated;
        else
            select rowid, updated
              into l_rowid, l_updated
              from timetables_tbl
             where id = p_id
               for update
            ;
            --
            if ( l_updated = p_updated ) then
                plog.debug ( p_log_ctx, 'Updating TIMETABLES_TBL. '
                    ||'company_id="'||p_company_id
                    ||'"; dept_id="'||p_dept_id
                    ||'"; table_year="'||p_table_year
                    ||'"; table_month="'||p_table_month
                    ||'"; submitted="'||p_submitted
                    ||'"; accepted="'||p_accepted
                    ||'".'
                );
                --
                update timetables_tbl set
                     company_id = p_company_id
                    ,dept_id = p_dept_id
                    ,table_year = p_table_year
                    ,table_month = p_table_month
                    ,submitted = p_submitted
                    ,accepted = p_accepted
                 where rowid = l_rowid
                returning id, updated into l_ids.id, l_ids.updated
                ;
            else
                raise std.LOST_UPDATED_FOUND;
            end if;
        end if;
        --
        plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
        return l_ids;
    exception
        when others then
            plog.error(p_log_ctx);
            raise;
    end save;


    procedure create_timetable (
         p_log_ctx        in out nocopy plogparam.log_ctx
        ,p_company_id     in number
        ,p_year           in number
        ,p_month          in number
        ,p_dept_id        in number
    ) is
        l_action constant varchar2(30) := 'CREATE_TIMETABLE';
        l_tt_ids std.t_ids;
    begin
        plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
        --
        l_tt_ids := i_timetables.save (
             p_log_ctx => p_log_ctx
            ,p_id => null
            ,p_updated => null
            ,p_company_id => p_company_id
            ,p_dept_id => p_dept_id
            ,p_table_year => p_year
            ,p_table_month => p_month
            ,p_table_type => 0
            ,p_submitted => null
            ,p_accepted => null
        );
        --
        load_data_from_parus (
             p_log_ctx => p_log_ctx
            ,p_timetable_id => l_tt_ids.id
        );
        --
        plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    exception
        when others then
            plog.error(p_log_ctx);
            raise;
    end create_timetable;


    function create_correction (
         p_log_ctx          in out nocopy plogparam.log_ctx
        ,p_timetable_id     in number
    ) return std.t_ids is
        l_action constant varchar2(30) := 'CREATE_CORRECTION';
        l_tt_ids std.t_ids;
    begin
        plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);

        for tmt in (
            select company_id, dept_id, table_year, table_month
              from timetables_tbl
             where id = p_timetable_id
        ) loop
            l_tt_ids := i_timetables.save (
                 p_log_ctx => p_log_ctx
                ,p_id => null
                ,p_updated => null
                ,p_company_id => tmt.company_id
                ,p_dept_id => tmt.dept_id
                ,p_table_year => tmt.table_year
                ,p_table_month => tmt.table_month
                ,p_table_type => 1
                ,p_submitted => null
                ,p_accepted => null
            );

            load_data_from_parus (
                 p_log_ctx => p_log_ctx
                ,p_timetable_id => l_tt_ids.id
            );
        end loop tmt;

        plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);

        return l_tt_ids;
    exception
        when others then
            plog.error(p_log_ctx);
            raise;
    end create_correction;

end I_TIMETABLES;
/
