create or replace package body I_TIMETABLES_SPECS as

-- todo
-- Создать табель чтобы во всём месяце были данные в днях.
-- Затем изменить дату действия исполнения - уменьшить до полумесяца.
-- Затем "Импорт из Парус". Ожидается, что данные в днях, где исполнение
-- перестало действовать удалятся, а они остаются и их придётся удалять
-- вручную.

  g_module constant varchar2(30) := 'I_TIMETABLES_SPECS';


  procedure remove (
    p_id in std.T_PK
  )
  is
  begin
    delete
      from timetables_specs_tbl
     where id = p_id
    ;
  end remove;


  function divergence_exists (
    p_spec_id  in std.t_pk
  ) return boolean
  is
    l_cnt number := 0;
  begin
    for tbl in (
      select ts.id, t.company_id, ts.emp_id, t.dept_id, ts.wage_rate, ts.post_id
            ,to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy') beg_date
            ,last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy')) end_date
            ,extract(day from last_day(to_date('01'||to_char(t.table_month,'00')||to_char(t.table_year,'0000'),'ddmmyyyy'))) max_day
        from timetables_tbl t, timetables_specs_tbl ts
       where t.id = ts.timetable_id and ts.id = p_spec_id
    ) loop
      with tt_hours as (
        select ts.id, tsh.day_date, ht.rn as hours_type_id, tsh.hours_amount
          from timetables_specs_tbl ts, prs_hours_types ht, timetables_specs_hours_tbl tsh
         where ts.id = tbl.id
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
           and ts.id = tbl.id
        ),
        tt_days as (
        select sp.id as id, d.day_date as day_date, d.day_type_id as day_type
          from timetables_specs_tbl sp, timetables_specs_days_tbl d
         where sp.id = tbl.id
           and sp.id = d.timetable_spec_id
           order by sp.id, d.day_date
        ),
        prs_days as (
        select ts.id as id, dd.workdate as day_date, dd.daystype as day_type
          from prs_duties_hist dh, prs_duties_days dd, timetables_specs_tbl ts
         where dh.prn = dd.prn
           and dh.rn = ts.prs_duty_hist_id
           and dd.workdate between tbl.beg_date and tbl.end_date
           and ts.id = tbl.id
        ),
        days_pool as (
        select ts.id as id, dp.day_date as day_date, null as day_type
          from timetables_specs_tbl ts
              ,(SELECT tbl.beg_date + rownum - 1 as day_date
                  FROM (SELECT null FROM dual GROUP BY CUBE(1,2,3,4,5)) WHERE  ROWNUM < tbl.max_day + 1) dp
         where ts.id = tbl.id
        )
      select sum(cnt)
        into l_cnt
        from (
          select count(*) as cnt from (
            (
            select * from prs_hours
            minus
            select * from tt_hours
            )
            union all
            (
            select * from tt_hours
            minus
            select * from prs_hours
            )
          )
          union all
          select count(*) as cnt from (
            (
            select * from tt_days
            minus
            select * from prs_days
            )
            union all
            (
            select * from prs_days
            minus
            select * from tt_days
            )
            minus
            select * from days_pool
          )
        )
      ;
    end loop;
    return (l_cnt > 0);
  end divergence_exists;


  function divergence_mark (
    p_spec_id  in std.t_pk
  ) return char is
    l_result char(1);
  begin
    if (divergence_exists(p_spec_id => p_spec_id)) then
      l_result := '+';
    else
      l_result := '-';
    end if;
    --
    return l_result;
  end divergence_mark;


  function save (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.t_pk
   ,p_updated  in timestamp
   ,p_timetable_id  in std.t_pk
   ,p_emp_id  in number
   ,p_post_id  in number
   ,p_wage_rate  in number
   ,p_prs_duty_hist_id  in number
  ) return std.t_ids
  is
	  l_action constant varchar2(30) := 'SAVE';
    l_ids  std.t_ids;
    l_rowid  rowid;
    l_updated  timestamp;
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    if (p_id is null) then
      --
 	    plog.debug(p_log_ctx, 'Inserting into TIMETABLES_SPECS_TBL (ID is null). '
        ||'timetable_id="'||p_timetable_id
        ||'"; emp_id="'||p_emp_id
        ||'"; post_id="'||p_post_id
        ||'"; wage_rate="'||p_wage_rate
        ||'"; prs_duty_hist_id="'||p_prs_duty_hist_id
        ||'".');
      --
      insert into timetables_specs_tbl (
        id, updated, updater, timetable_id, emp_id, post_id, wage_rate, prs_duty_hist_id
      )
      values (null, null, null, p_timetable_id, p_emp_id, p_post_id, p_wage_rate, p_prs_duty_hist_id)
      returning id, updated into l_ids.id, l_ids.updated;
    else
      select rowid, updated
        into l_rowid, l_updated
        from timetables_specs_tbl
       where id = p_id
       for update
      ;
      if (l_updated = p_updated) then
        --
        plog.debug(p_log_ctx, 'Updating TIMETABLES_SPECS_TBL (ID is not null). '
          ||'id="'||p_id
          ||'"; updated="'||p_updated
          ||'"; timetable_id="'||p_timetable_id
          ||'"; emp_id="'||p_emp_id
          ||'"; post_id="'||p_post_id
          ||'"; wage_rate="'||p_wage_rate
          ||'"; prs_duty_hist_id="'||p_prs_duty_hist_id
          ||'".');
        --
        update timetables_specs_tbl set
          timetable_id = p_timetable_id
         ,emp_id = p_emp_id
         ,post_id = p_post_id
         ,wage_rate = p_wage_rate
         ,prs_duty_hist_id = p_prs_duty_hist_id
         where rowid = l_rowid
         returning id, updated into l_ids.id, l_ids.updated
        ;
      else
        raise std.LOST_UPDATED_FOUND;
      end if;
    end if;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    --
    return l_ids;
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end save;


  -- Установить в Строке Табеля тип дня.
  procedure set_day_data_from_parus (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_spec_id in std.T_PK
   ,p_date in date
   ,p_prs_day_type_id in number
  ) is
      l_tt_data i_timetables_specs_days.t_data;
      l_prs_changed boolean;
      l_ids std.t_ids;
  begin
    -- Получить данные Дня Строки Табеля.
    l_tt_data := i_timetables_specs_days.find_day_data (
      p_log_ctx => p_log_ctx
     ,p_timetable_spec_id => p_spec_id
     ,p_date => p_date
    );
    -- Сравнить данные Дня Паруса и Строки Табеля
    -- Правило: если данные Паруса изменились, то изменить данные Строки Табеля.
    l_prs_changed := nvl(l_tt_data.prs_day_type_id,0) <> nvl(p_prs_day_type_id,0);
    if (l_prs_changed) then
      l_ids := i_timetables_specs_days.save (
        p_log_ctx  => p_log_ctx
       ,p_id  => l_tt_data.id
       ,p_updated  => l_tt_data.updated
       ,p_timetable_spec_id  => p_spec_id
       ,p_day_date  => p_date
       ,p_day_type_id  => p_prs_day_type_id
       ,p_prs_day_type_id  => p_prs_day_type_id
      );
    end if;
  end set_day_data_from_parus;


  -- Установить в Строке Табеля количество часов.
  procedure set_hours_data_from_parus (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_spec_id in std.T_PK
   ,p_date in date
   ,p_prs_hours_amount in number
   ,p_hours_type_id in number
  ) is
    l_tt_data i_timetables_specs_hours.t_data;
    l_prs_changed boolean;
    l_ids std.t_ids;
--    l_main_hours_type_id  number;
  begin
--    l_main_hours_type_id := i_prs_data.get_main_hours_type_id;
    -- Получить данные Дня Строки Табеля.
    l_tt_data := i_timetables_specs_hours.find_hours_data (
      p_log_ctx => p_log_ctx
     ,p_timetable_spec_id => p_spec_id
     ,p_date => p_date
--     ,p_hours_type_id => l_main_hours_type_id
     ,p_hours_type_id => p_hours_type_id
    );
    -- Сравнить данные Часов Дня Паруса и Строки Табеля
    -- Правило: если данные Паруса изменились, то изменить данные Строки Табеля.
    l_prs_changed := nvl(l_tt_data.prs_hours_amount,0) <> nvl(p_prs_hours_amount,0);
    if (l_prs_changed) then
      l_ids := i_timetables_specs_hours.save (
        p_log_ctx  => p_log_ctx
       ,p_id  => l_tt_data.id
       ,p_updated  => l_tt_data.updated
       ,p_timetable_spec_id  => p_spec_id
       ,p_day_date  => p_date
--       ,p_hours_type_id  => l_main_hours_type_id
       ,p_hours_type_id  => p_hours_type_id
       ,p_hours_amount  => p_prs_hours_amount
       ,p_prs_hours_amount  => p_prs_hours_amount
      );
    end if;
  end set_hours_data_from_parus;


  function find_day_type (
    p_code  in varchar2
  ) return number is
    l_result  number;
  begin
    begin
      select id
        into l_result
        from days_types_tbl
       where code = p_code
      ;
    exception
      when no_data_found then
        l_result := null;
    end;
    --
    return l_result;
  end find_day_type;


  -- Загрузить из Паруса данные дней и часов для Строки Табеля
  procedure load_data_from_parus (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_spec_id  in std.t_pk
  ) is
	  l_action constant varchar2(30) := 'LOAD_DATA_FROM_PARUS';
	  l_beg_date date;
		l_end_date date;
    l_date date;
    l_prs_day_type_id  number;
    l_calendar_id  number;
    l_prs_hours_amount  number;
    l_r_day_type_id  number;
    l_main_hours_type_id  number;
    l_main_hours_amount number;
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    -- Определить тип Основых Часов
    l_main_hours_type_id := i_prs_data.get_main_hours_type_id;
    -- Получить данные Строки Табеля
	  for spec in (
			select t.company_id, dh.prn duty_id, t.table_year, t.table_month, ts.id
             ,dh.do_act_from beg_date, dh.do_act_to end_date, dh.schedule, dt.code duty_type
			  from timetables_specs_tbl ts, timetables_tbl t, prs_duties_hist dh, duties_types_tbl dt, prs_duties d
			 where ts.id = p_spec_id
         and ts.timetable_id = t.id
         and ts.prs_duty_hist_id = dh.rn
         and dh.prn = d.rn
         and d.clnpspfmtypes = dt.id
      for update
		) loop
	    plog.debug(p_log_ctx, 'Found Timetable Spec ID="'||p_spec_id||'".');
      -- Установить граничные даты
      l_beg_date := greatest(spec.beg_date, to_date('01'||to_char(spec.table_month,'00')||to_char(spec.table_year,'0000'),'ddmmyyyy'));
      l_end_date := least(nvl(spec.end_date,last_day(l_beg_date)), last_day(l_beg_date));
      -- Найти календарь
      l_calendar_id := i_prs_data.find_calendar (
        p_company_id  => spec.company_id
       ,p_schedule_id => spec.schedule
       ,p_date  => l_beg_date
      );
      -- Найти специальный тип дня 'Р' (подработка)
      l_r_day_type_id := find_day_type ('Р');
      -- Цикл по всем дням между граничными датами.
      l_date := l_beg_date;
      while (l_date <= l_end_date)
      loop
        -- Для каждого дня:
        -- Загрузить Часы
        for hours_type in (
          select ht.rn as id from prs_hours_types ht
        ) loop
          -- Определить из Паруса количество Часов для Дня.
          l_prs_hours_amount := i_prs_data.find_day_hours_amount (
            p_calendar_id  => l_calendar_id
           ,p_day_date  => l_date
           ,p_hours_type_id => hours_type.id
          );
          -- Сохранить количество основных часов (понадобится при загрузке дней)
          if (hours_type.id = l_main_hours_type_id) then
            l_main_hours_amount := l_prs_hours_amount;
          end if;
          -- Установить в Строке Табеля количество Часов для Дня.
          if (spec.duty_type not in ('сов', 'УОР')) then
            set_hours_data_from_parus (
              p_log_ctx  => p_log_ctx
             ,p_spec_id => p_spec_id
             ,p_date => l_date
             ,p_prs_hours_amount => l_prs_hours_amount
             ,p_hours_type_id => hours_type.id
            );
          end if;
        end loop hours_type;
        -- Загрузить Дни
        -- Определить из Паруса тип Дня.
        l_prs_day_type_id := i_prs_data.find_day_type (
          p_company_id => spec.company_id
         ,p_duty_id => spec.duty_id
         ,p_day_date => l_date
        );
--if (spec.duty_id = 122703268) then
--plog.error(p_log_ctx, 'spec id = '||p_spec_id||'; duty id = '||spec.duty_id||'; day = '||to_char(l_date,'dd.mm.yyyy')||'; day type = '||l_prs_day_type_id);
--end if;
        -- Для оснований совмещения ('сов', 'УОР') ставится специальный тип для "Р" в датах где есть часы.
        if (l_prs_day_type_id is null and spec.duty_type in ('сов', 'УОР') and l_main_hours_amount <> 0) then
          l_prs_day_type_id := l_r_day_type_id;
        end if;
        -- Установить в Строке Табеля тип Дня.
        set_day_data_from_parus (
          p_log_ctx  => p_log_ctx
         ,p_spec_id => p_spec_id
         ,p_date => l_date
         ,p_prs_day_type_id => l_prs_day_type_id
        );
        l_date := l_date + 1;
      end loop while;
    end loop spec;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    --
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end load_data_from_parus;


  procedure save_to_parus (
    p_log_ctx  in out nocopy plogparam.log_ctx
	 ,p_spec_id  in std.t_pk
	) is
	  l_action constant varchar2(30) := 'SAVE_TO_PARUS';
	  l_beg_date date;
		l_end_date date;
    l_date date;
		l_rn number;
		--
		function find_prs_hours (
		  p_prs_day_rn in number
		 ,p_hours_type_id in number
		) return number is
		  l_result number;
		begin
		  begin
			  select rn
				  into l_result
					from prs_duties_hours dh
				 where dh.prn = p_prs_day_rn
				   and dh.hourstype = p_hours_type_id
					 ;
			exception
			  when no_data_found then
				  l_result := null;
		  end;
			return l_result;
		end find_prs_hours;
		--
		procedure find_prs_day_data (
		  p_duty_rn in number
		 ,p_date in date
     ,p_id in out number
     ,p_day_type_id in out number
		) is
		begin
		  begin
  		  select rn, daystype
				  into p_id, p_day_type_id
				  from prs_duties_days
				 where prn = p_duty_rn
				   and workdate = p_date
				;
		  exception
			  when no_data_found then
				  p_id := null;
          p_day_type_id := null;
			end;
		end find_prs_day_data;
		--
    -- Compare parus and timetable data for each day between l_beg_date and l_end_date.
    procedure save_prs_day_data (
      p_spec_id in std.T_PK
		 ,p_company_id in number
		 ,p_duty_rn in number
		 ,p_date in date
		) is
      l_tt_day_type_id number;
		  l_prs_id number;
      l_prs_day_type_id number;
		begin
      -- Find timetable day data.
      begin
        select day_type_id
          into l_tt_day_type_id
          from timetables_specs_days_tbl tsd
         where tsd.timetable_spec_id = p_spec_id
           and tsd.day_date = p_date
        ;
      exception
        when no_data_found then
          l_tt_day_type_id := null;
      end;
      --
      -- Find parus day data.
      find_prs_day_data (
        p_duty_rn => p_duty_rn
       ,p_date => p_date
       ,p_id => l_prs_id
       ,p_day_type_id => l_prs_day_type_id
      );
      --
      -- Update parus data.
      if (l_prs_id is null) then
        plog.debug(p_log_ctx, 'Insert parus data duty.rn="'||p_duty_rn||'"; p_date="'||p_date||'"; day_type="'||l_tt_day_type_id||'"; parus rn="'||l_prs_id||'".');
        prs_p_clnpspfmwd_insert (
          ncompany => p_company_id
         ,nprn => p_duty_rn
         ,ndaystype => l_tt_day_type_id
         ,dworkdate => p_date
         ,nrn => l_prs_id
        );
      else
        plog.debug(p_log_ctx, 'Update parus data parus rn=="'||l_prs_id||'"; p_date="'||p_date||'"; day_type="'||l_tt_day_type_id||'".');
        prs_p_clnpspfmwd_update (
          ncompany => p_company_id
         ,nrn => l_prs_id
         ,ndaystype => l_tt_day_type_id
         ,dworkdate => p_date
        );
      end if;
    end save_prs_day_data;
    --
    function save_prs_hours (
      p_company_id in number
     ,p_duty_rn in number
     ,p_date in date
     ,p_hours_type_id in number
     ,p_amount in number
    ) return number is
      l_day_rn number;
      l_day_type_id number;
      l_result number;
    begin
      find_prs_day_data (p_duty_rn => p_duty_rn, p_date => p_date, p_id => l_day_rn, p_day_type_id => l_day_type_id);
      if (l_day_rn is null) then
        prs_p_clnpspfmwd_insert (
          ncompany => p_company_id
         ,nprn => p_duty_rn
          ,ndaystype => null
          ,dworkdate => p_date
         ,nrn => l_day_rn
        );
      end if;
      l_result := find_prs_hours (p_prs_day_rn => l_day_rn, p_hours_type_id => p_hours_type_id);
      if (l_result is null) then
         prs_p_clnpspfmwh_insert (
          ncompany => p_company_id
         ,nprn => l_day_rn
         ,nhourstype => p_hours_type_id
         ,nworkedhours => p_amount
         ,nrn => l_result
        );
      else
        prs_p_clnpspfmwh_update (
          ncompany => p_company_id
         ,nrn => l_result
         ,nhourstype => p_hours_type_id
         ,nworkedhours => p_amount
        );
      end if;
      return l_result;
    end save_prs_hours;
    --
  begin  -- save_to_parus
    plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    plog.assert(p_log_ctx, p_spec_id is not null, 'P_SPEC_ID is null');
    --
    -- Finding Timetable Spec data.
    for spec in (
      select ts.prs_duty_hist_id, t.table_year, t.table_month, t.company_id,
             dh.do_act_from beg_date, dh.do_act_to end_date
        from timetables_specs_tbl ts, timetables_tbl t, prs_duties_hist dh
       where ts.id = p_spec_id
         and ts.timetable_id = t.id
         and ts.prs_duty_hist_id = dh.rn
         for update
    ) loop
       plog.debug(p_log_ctx, 'Spec found. '
        ||'spec id="'||p_spec_id
        ||'"; prs_duty_hist_id="'||spec.prs_duty_hist_id
        ||'"; beg_date="'||to_date(spec.beg_date,'dd.mm.yyyy')
        ||'"; end_date="'||to_date(spec.end_date,'dd.mm.yyyy')
        ||'".');
      l_beg_date := greatest(spec.beg_date, to_date('01'||to_char(spec.table_month,'00')||to_char(spec.table_year,'0000'),'ddmmyyyy'));
      l_end_date := least(nvl(spec.end_date,last_day(l_beg_date)), last_day(l_beg_date));
      -- Finding parus Duty data.
      for prs_duty in (
        select d.*
          from prs_duties d, prs_duties_hist dh
         where dh.prn = d.rn
           and dh.rn = spec.prs_duty_hist_id
           for update
      ) loop
        plog.debug(p_log_ctx, 'Duty found. '
          ||'duty id="'||prs_duty.rn
          ||'".');
        -- Updating parus Days data.
        l_date := l_beg_date;
        while (l_date <= l_end_date)
        loop
          plog.debug(p_log_ctx, 'Save day data. '
            ||'spec id="'||p_spec_id
            ||'"; company_id="'||spec.company_id
            ||'"; duty_id="'||prs_duty.rn
            ||'"; date="'||l_date
            ||'".');
          save_prs_day_data (
            p_spec_id => p_spec_id
           ,p_company_id => spec.company_id
           ,p_duty_rn => prs_duty.rn
           ,p_date => l_date
          );
          --
          l_date := l_date + 1;
        end loop;
        --
        -- Deleting parus Hours data.
        plog.debug(p_log_ctx, 'Deleting all parus Hours data. '
          ||'from date="'||to_date(l_beg_date,'dd.mm.yyyy')
          ||'"; to date="'||to_date(l_end_date,'dd.mm.yyyy')
          ||'".');
        for prs_hours in (
          select dh.*
            from prs_duties_hours dh, prs_duties_days dd
           where dh.prn = dd.rn
             and dd.prn = prs_duty.rn
             and dd.workdate between l_beg_date and l_end_date
        ) loop
          prs_p_clnpspfmwh_delete (
            ncompany => spec.company_id
           ,nrn => prs_hours.rn
          );
        end loop prs_hours;
        --
        -- Inserting parus Hours data.
        plog.debug(p_log_ctx, 'Saving Hours data to parus. '
          ||'from date="'||to_date(l_beg_date,'dd.mm.yyyy')
          ||'"; to date="'||to_date(l_end_date,'dd.mm.yyyy')
          ||'".');
        for hours in (
          select h.day_date, h.hours_type_id, h.hours_amount
            from timetables_specs_hours_tbl h
           where h.timetable_spec_id = p_spec_id
             and h.day_date between l_beg_date and l_end_date
        ) loop
          plog.debug(p_log_ctx, 'Save Hours data. '
            ||'day_date="'||to_date(hours.day_date,'dd.mm.yyyy')
            ||'"; hours_type_id ="'||hours.hours_type_id
            ||'"; hours_amount="'||hours.hours_amount
            ||'".');
          l_rn := save_prs_hours (
            p_company_id => spec.company_id
           ,p_duty_rn => prs_duty.rn
           ,p_date => hours.day_date
           ,p_hours_type_id => hours.hours_type_id
           ,p_amount => hours.hours_amount
          );
          plog.info(p_log_ctx, 'Saved hours data rn='||l_rn);
        end loop hours;
        plog.debug(p_log_ctx, 'Complete saving data for duty rn="'||prs_duty.rn||'".');
      end loop prs_duty;
    end loop spec;
    plog.debug(p_log_ctx, 'Complete saving data for spec ID="'||p_spec_id||'".');
    --
    plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
  exception
    when others then
      plog.error(p_log_ctx);
      raise;
  end save_to_parus;


  function get_workoff_days (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
  begin
    begin
      select count(*)
        into l_result
        from timetables_specs_hours_tbl tsh
       where timetable_spec_id = p_spec_id
         and tsh.hours_type_id in (select id from hours_types_tbl where code = 'О')
         and tsh.hours_amount > 0
         and not exists (
           select null from timetables_specs_days_tbl tsd, days_types_tbl dt
            where tsd.day_type_id = dt.id and dt.absence = 1
              and tsd.timetable_spec_id = p_spec_id and tsd.day_date = tsh.day_date
           )
      ;
    exception
      when no_data_found then
        l_result := 0;
    end;
    --
    return l_result;
  end get_workoff_days;


  function get_workoff_hours (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
  begin
    begin
      select sum(tsh.hours_amount)
        into l_result
        from timetables_specs_hours_tbl tsh
       where timetable_spec_id = p_spec_id
         and tsh.hours_type_id in (select id from hours_types_tbl where code = 'О')
         and tsh.hours_amount > 0
         and not exists (
           select null from timetables_specs_days_tbl tsd, days_types_tbl dt
            where tsd.day_type_id = dt.id and dt.absence = 1
              and tsd.timetable_spec_id = p_spec_id and tsd.day_date = tsh.day_date
           )
      ;
    exception
      when no_data_found then
        l_result := 0;
    end;
    --
    return l_result;
  end get_workoff_hours;

end I_TIMETABLES_SPECS;
/
