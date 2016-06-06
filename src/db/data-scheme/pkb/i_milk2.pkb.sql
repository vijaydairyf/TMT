create or replace package body I_MILK2 as

  g_module constant varchar2(30) := 'I_MILK2';
  g_milk_norm  number := 0.5;


  function save_dept_spec (
    p_id            in std.t_pk
   ,p_register_id   in std.t_pk
   ,p_emp_id        in std.t_pk
   ,p_emp_post_id   in std.t_pk
   ,p_work_off      in number
  ) return std.t_pk is
	  l_action  constant varchar2(30) := 'SAVE_SPEC';
    l_result  std.t_pk;
    l_earned  number;
  begin
    l_result := p_id;
    --
    for reg in (
      select year_month from milk_dept_register2_tbl where id = p_register_id
    ) loop
      if (p_id is null) then
        insert into milk_dept_specs2_tbl (
          dpt_register_id
         ,year_month
         ,emp_id
         ,emp_post_id
         ,work_off
        ) values (
          p_register_id
         ,reg.year_month
         ,p_emp_id
         ,p_emp_post_id
         ,p_work_off
        ) returning id into l_result
        ;
      else
        update milk_dept_specs2_tbl
           set dpt_register_id = p_register_id
              ,year_month = reg.year_month
              ,emp_id = p_emp_id
              ,emp_post_id = p_emp_post_id
              ,work_off = p_work_off
         where id = p_id
        ;
        --
        if (sql%rowcount = 0) then
          raise std.DATA_NOT_SAVED;
        end if;
      end if;
    end loop reg;
    --
    return l_result;
	exception
	  when others then
--	    plog.error(p_log_ctx);
	    raise;
  end save_dept_spec;


  procedure remove_dept_spec (
    p_id  in std.T_PK
  ) is
	  l_action constant varchar2(30) := 'REMOVE_SPEC';
  begin
--	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    delete
      from milk_dept_specs2_tbl
     where id = p_id
    ;
    --
--	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
--	    plog.error(p_log_ctx);
	    raise;
  end remove_dept_spec;


  function save_dept_register (
    p_id               in std.t_pk
   ,p_dept_id          in number
   ,p_year             in number
   ,p_month            in number
  ) return std.t_pk is
	  l_action  constant varchar2(30) := 'SAVE_REGISTER';
    l_status  pls_integer := 20;  -- Ведомость
    l_result  std.t_pk;
  begin
--	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    l_result := p_id;
    --
    if (p_id is null) then
      insert into milk_dept_register2_tbl (
        dept_id
       ,year_month
       ,register_year
       ,register_month
       ,register_status
       ,register_timemark
      ) values (
        p_dept_id
       ,to_number(to_char(p_year,'fm0000')||to_char(p_month,'fm00'))
       ,p_year
       ,p_month
       ,l_status
       ,sysdate
      ) returning id into l_result
      ;
    else
      update milk_dept_register2_tbl
         set dept_id = p_dept_id
            ,year_month = to_number(to_char(p_year,'fm0000')||to_char(p_month,'fm00'))
            ,register_year = p_year
            ,register_month = p_month
       where id = p_id
      ;
      --
      if (sql%rowcount = 0) then
        raise std.DATA_NOT_SAVED;
      end if;
    end if;
    --
--    plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    return l_result;
  exception
    when others then
--      plog.error(p_log_ctx);
      raise;
  end save_dept_register;


  procedure remove_dept_register (
    p_id in std.T_PK
  ) is
    l_action constant varchar2(30) := 'REMOVE_REGISTER';
  begin
--    plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    delete
      from milk_dept_register2_tbl
     where id = p_id
    ;
    --
--    plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
  exception
    when others then
--      plog.error(p_log_ctx);
      raise;
  end remove_dept_register;


  function days_totals (
    p_spec_id  in number
  ) return number is
    l_result number := 0;
  begin
    select decode(count(*),0,null,count(*))
      into l_result
      from (
        select tsh.day_date
          from timetables_specs_hours_tbl tsh, hours_types_tbl ht
         where tsh.timetable_spec_id = p_spec_id
           and tsh.hours_type_id = ht.id
           and ht.code = 'О'
           and tsh.hours_amount > 0
        union
        select tsd.day_date
          from timetables_specs_days_tbl tsd, days_types dt
         where tsd.timetable_spec_id = p_spec_id
           and tsd.day_type_id = dt.id
           and dt.absence = 0
        minus
        select tsd.day_date
          from timetables_specs_days_tbl tsd, days_types dt
         where tsd.timetable_spec_id = p_spec_id
           and tsd.day_type_id = dt.id
           and ((dt.absence = 1) or (dt.code = 'ИО')))
    ;
    return l_result;
  end days_totals;


  function add_emp_to_dept_register (
    p_register_id  in std.t_pk
   ,p_emp_id   in std.t_pk
  ) return std.t_pk is
    l_result  std.t_pk := null;
    HOURS_IN_DAY  pls_integer := 8;
  begin
    for m in (
      select id, dept_id, register_year, register_month
        from milk_dept_register2_tbl
       where id = p_register_id
         and not exists (select null from milk_dept_specs2_tbl where dpt_register_id = p_register_id and emp_id = p_emp_id)
    ) loop
      for tt in (
        -- Список работников из табеля, только основные должности
        select tts.emp_id as emp_id, tts.post_id as emp_post_id, days_totals(tts.id) days_total
          from timetables_tbl tt, timetables_specs_tbl tts, duties_hist_tbl dh, duties_tbl d, duties_types_tbl dt
         where tt.id = tts.timetable_id
           and tts.prs_duty_hist_id = dh.id
           and dh.duty_id = d.id
           and d.duty_type_id = dt.id
--           and dt.is_primary = 1
           and tt.table_year = m.register_year
           and tt.table_month = m.register_month
           and tt.dept_id = m.dept_id
           and tts.emp_id = p_emp_id
      ) loop
        l_result := save_dept_spec (
          p_id  => null
         ,p_register_id => p_register_id
         ,p_emp_id => tt.emp_id
         ,p_emp_post_id => tt.emp_post_id
         ,p_work_off => nvl(tt.days_total,0)
        );
      end loop tt;
    end loop m;
    --
    return l_result;
  end add_emp_to_dept_register;


  function create_dept_register (
    p_dept_id       in number
   ,p_year          in number
   ,p_month         in number
  ) return std.t_pk is
    l_action constant varchar2(30) := 'CREATE_DEPT_REGISTER';
    l_register_id   std.t_pk;
    l_spec_id       std.t_pk;
    l_prev_register_id  std.t_pk;
  begin
--    plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    l_register_id := save_dept_register (
      p_id  => null
     ,p_dept_id  => p_dept_id
     ,p_year  => p_year
     ,p_month => p_month
    );
    -- найди предшествующую ведомость
    begin
      select id
        into l_prev_register_id
        from (
          select m.id
                ,year_month
            from milk_dept_register2_tbl m
           where m.dept_id = p_dept_id
             and year_month < to_number(to_char(p_year,'fm0000')||to_char(p_month,'fm00'))
           order by year_month desc
        ) where rownum < 2
      ;
    exception
      when no_data_found then
        l_prev_register_id := null;
    end;
    --
    if (l_prev_register_id is null) then
      -- предшествующая ведомость не найдена, значит возьми всех из табеля
      for t in (
        select ts.emp_id as emp_id
          from timetables_tbl t, timetables_specs_tbl ts
         where ts.timetable_id = t.id
           and t.table_year = p_year
           and t.table_month = p_month
           and t.dept_id = p_dept_id
      ) loop
        l_spec_id := add_emp_to_dept_register (
          p_register_id  => l_register_id
         ,p_emp_id   => t.emp_id
        );
      end loop t;
    else
      -- возьми всех, кто в предыдущей ведомости и одновременно есть в табеле
      for t in (
        select ts.emp_id as emp_id
          from timetables_tbl t, timetables_specs_tbl ts
         where ts.timetable_id = t.id
           and t.table_year = p_year
           and t.table_month = p_month
           and t.dept_id = p_dept_id
        intersect
        select ms.emp_id
          from milk_dept_specs2_tbl ms where ms.dpt_register_id = l_prev_register_id
      ) loop
        l_spec_id := add_emp_to_dept_register (
          p_register_id  => l_register_id
         ,p_emp_id   => t.emp_id
        );
      end loop t;
    end if;
    --
    return l_register_id;
    --
--    plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
  exception
    when others then
--      plog.error(p_log_ctx);
      raise;
  end create_dept_register;


  procedure SetDeptRegisterStatus (
    pRegisterId  in std.t_pk
   ,pFromStatus  in pls_integer
   ,pToStatus    in pls_integer
  ) is
  begin
    update milk_dept_register2_tbl
       set register_status = pToStatus
          ,register_timemark = systimestamp
     where id = pRegisterId
       and register_status = pFromStatus
    ;
  end SetDeptRegisterStatus;


  procedure SendDeptToAccounting (
    p_register_id  in number
  ) is
    lFromStatus  pls_integer := 20;  -- Ведомость
    lToStatus    pls_integer := 30;  -- Ведомость в бухгалтерии
  begin
    SetDeptRegisterStatus(pRegisterId => p_register_id, pFromStatus => lFromStatus, pToStatus => lToStatus);
  end SendDeptToAccounting;


  procedure RemoveDeptFromAccounting (
    p_register_id  in number
  ) is
    lFromStatus  pls_integer := 30;  -- Ведомость в бухгалтерии
    lToStatus    pls_integer := 20;  -- Ведомость
  begin
    SetDeptRegisterStatus(pRegisterId => p_register_id, pFromStatus => lFromStatus, pToStatus => lToStatus);
  end RemoveDeptFromAccounting;


  function insert_milk_cost (
    p_cost_year   in number
   ,p_cost_month  in number
   ,p_cost_value  in number
  ) return std.t_pk is
    l_action  constant varchar2(30) := 'SAVE_MILK_COST';
    l_result  std.t_pk;
  begin
    --
    insert into milk_cost2_tbl (
      cost_year, cost_month, cost_value, year_month
    ) values (
      p_cost_year
     ,p_cost_month
     ,p_cost_value
     ,to_number(to_char(p_cost_year,'fm0000')||to_char(p_cost_month,'fm00'))
    ) returning id into l_result;
    --
    return l_result;
  exception
    when others then
--      plog.error(p_log_ctx);
      raise;
  end insert_milk_cost;


  procedure update_milk_cost (
    p_id    in std.T_PK
   ,p_cost_year   in number
   ,p_cost_month  in number
   ,p_cost_value  in number
  ) is
  begin
    update milk_cost2_tbl
       set cost_year  = p_cost_year
          ,cost_month = p_cost_month
          ,cost_value = p_cost_value
          ,year_month = to_number(to_char(p_cost_year,'fm0000')||to_char(p_cost_month,'fm00'))
     where id = p_id
    ;
  end update_milk_cost;


  procedure delete_milk_cost (
    p_id  in std.T_PK
  ) is
  begin
    delete from milk_cost2_tbl
     where id = p_id
    ;
  end delete_milk_cost;

end I_MILK2;
/
