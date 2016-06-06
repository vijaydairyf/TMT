create or replace package body I_MILK as

  g_module constant varchar2(30) := 'I_MILK';
  g_milk_norm  number := 0.5;


  function save_dept_spec (
    p_id            in std.t_pk
   ,p_register_id   in std.t_pk
   ,p_emp_id        in std.t_pk
   ,p_emp_post_id   in std.t_pk
   ,p_work_off      in number
   ,p_milk_norm     in number
   ,p_on_order      in number
   ,p_received      in number
  ) return std.t_pk is
	  l_action  constant varchar2(30) := 'SAVE_SPEC';
    l_result  std.t_pk;
    l_earned  number;
  begin
    l_result := p_id;
--	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    for reg in (
      select year_month from milk_dept_register_tbl where id = p_register_id
    ) loop
      if (p_id is null) then
        insert into milk_dept_specs_tbl (
          dpt_register_id
         ,year_month
         ,emp_id
         ,emp_post_id
         ,work_off
         ,milk_norm
         ,on_order
         ,received
        ) values (
          p_register_id
         ,reg.year_month
         ,p_emp_id
         ,p_emp_post_id
         ,p_work_off
         ,p_milk_norm
         ,p_on_order
         ,p_received
        ) returning id into l_result
        ;
      else
        update milk_dept_specs_tbl
           set dpt_register_id = p_register_id
              ,year_month = reg.year_month
              ,emp_id = p_emp_id
              ,emp_post_id = p_emp_post_id
              ,work_off = p_work_off
              ,milk_norm = p_milk_norm
              ,on_order = p_on_order
              ,received = p_received
         where id = p_id
        ;
        --
        if (sql%rowcount = 0) then
          raise std.DATA_NOT_SAVED;
        end if;
      end if;
    end loop reg;
    --
--	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
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
      from milk_dept_specs_tbl
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
   ,p_received         in number
  ) return std.t_pk is
	  l_action  constant varchar2(30) := 'SAVE_REGISTER';
    l_status  pls_integer := 10;  -- Заявка
    l_result  std.t_pk;
  begin
--	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    l_result := p_id;
    --
    if (p_id is null) then
      insert into milk_dept_register_tbl (
        dept_id
       ,year_month
       ,register_year
       ,register_month
       ,register_status
       ,register_timemark
       ,received
      ) values (
        p_dept_id
       ,to_number(to_char(p_year,'fm0000')||to_char(p_month,'fm00'))
       ,p_year
       ,p_month
       ,l_status
       ,sysdate
       ,p_received
      ) returning id into l_result
      ;
    else
      update milk_dept_register_tbl
         set dept_id = p_dept_id
            ,year_month = to_number(to_char(p_year,'fm0000')||to_char(p_month,'fm00'))
            ,register_year = p_year
            ,register_month = p_month
            ,received = p_received
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
      from milk_dept_register_tbl
     where id = p_id
    ;
    --
--    plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
  exception
    when others then
--      plog.error(p_log_ctx);
      raise;
  end remove_dept_register;


  function add_emp_to_dept_register (
    p_register_id  in std.t_pk
   ,p_emp_id   in std.t_pk
  ) return std.t_pk is
    l_result  std.t_pk := null;
    HOURS_IN_DAY  pls_integer := 8;
  begin
    for m in (
      select id, dept_id, register_year, register_month
        from milk_dept_register_tbl
       where id = p_register_id
         and not exists (select null from milk_dept_specs_tbl where dpt_register_id = p_register_id and emp_id = p_emp_id)
    ) loop
      for tt in (
        -- Список работников из табеля, только основные должности
        select tts.emp_id as emp_id, tts.post_id as emp_post_id
              ,round(i_timetables_specs.get_workoff_hours(tts.id)/HOURS_IN_DAY) days_total
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
         ,p_milk_norm => g_milk_norm
         ,p_on_order => 0
         ,p_received => 0
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
    l_status        pls_integer := 10;  -- Заявка
    l_prev_register_id  std.t_pk;
  begin
--    plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    l_register_id := save_dept_register (
      p_id  => null
     ,p_dept_id  => p_dept_id
     ,p_year  => p_year
     ,p_month => p_month
     ,p_received => 0
    );
    -- найди предшествующую ведомость
    begin
      select id
        into l_prev_register_id
        from (
          select m.id
                ,year_month
            from milk_dept_register_tbl m
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
          from milk_dept_specs_tbl ms where ms.dpt_register_id = l_prev_register_id
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
    update milk_dept_register_tbl
       set register_status = pToStatus
          ,register_timemark = systimestamp
     where id = pRegisterId
       and register_status = pFromStatus
    ;
  end SetDeptRegisterStatus;


  procedure send_order (
    p_register_id  in number
  ) is
    lFromStatus    pls_integer := 10;  -- Заявка
    lToStatus  pls_integer := 11;      -- Заявка отправлена
    l_spec_id  number := null;
  begin
    SetDeptRegisterStatus(pRegisterId => p_register_id, pFromStatus => lFromStatus, pToStatus => lToStatus);
    for spec in (
      select ms.id, ms.dpt_register_id, ms.emp_id, ms.emp_post_id, ms.work_off, ms.milk_norm
            ,nvl((select sum((work_off * milk_norm) - received) from milk_dept_specs_tbl t
                   where t.emp_id = ms.emp_id and t.year_month < ms.year_month
            ),0) as debt
        from milk_dept_specs_tbl ms
       where ms.dpt_register_id = p_register_id
    ) loop
      l_spec_id := save_dept_spec (
        p_id            => spec.id
       ,p_register_id   => spec.dpt_register_id
       ,p_emp_id        => spec.emp_id
       ,p_emp_post_id   => spec.emp_post_id
       ,p_work_off      => spec.work_off
       ,p_milk_norm     => spec.milk_norm
       ,p_on_order      => (spec.work_off * spec.milk_norm) + spec.debt
       ,p_received      => (spec.work_off * spec.milk_norm) + spec.debt
      );
    end loop;
  end send_order;


  procedure recall_order (
    p_register_id  in number
  ) is
    lFromStatus  pls_integer := 11;  -- Заявка отправлена
    lToStatus    pls_integer := 10;  -- Заявка
    l_spec_id  number := null;
  begin
    SetDeptRegisterStatus(pRegisterId => p_register_id, pFromStatus => lFromStatus, pToStatus => lToStatus);
    for spec in (
      select id, dpt_register_id, emp_id, emp_post_id, work_off, milk_norm
        from milk_dept_specs_tbl
       where dpt_register_id = p_register_id
    ) loop
      l_spec_id := save_dept_spec (
        p_id            => spec.id
       ,p_register_id   => spec.dpt_register_id
       ,p_emp_id        => spec.emp_id
       ,p_emp_post_id   => spec.emp_post_id
       ,p_work_off      => spec.work_off
       ,p_milk_norm     => spec.milk_norm
       ,p_on_order      => 0
       ,p_received      => 0
      );
    end loop;
  end recall_order;


  procedure AddDeptToEntRegister (
    pDeptRegisterId  in std.t_pk
   ,pEntRegisterId   in std.t_pk
  ) is
    lFromStatus  pls_integer := 11;  -- Заявка отправлена
    lToStatus    pls_integer := 20;  -- Ведомость
  begin
    SetDeptRegisterStatus(pRegisterId => pDeptRegisterId, pFromStatus => lFromStatus, pToStatus => lToStatus);
    update milk_dept_register_tbl
       set ent_register_id = pEntRegisterId
     where id = pDeptRegisterId
    ;
  end AddDeptToEntRegister;


  procedure RemoveDeptFromEntRegister (
    pDeptRegisterId  in std.t_pk
  ) is
    lFromStatus  pls_integer := 20;  -- Ведомость
    lToStatus  pls_integer := 11;    -- Заявка отправлена
  begin
    SetDeptRegisterStatus(pRegisterId => pDeptRegisterId, pFromStatus => lFromStatus, pToStatus => lToStatus);
    update milk_dept_register_tbl
       set ent_register_id = null
          ,received = decode(register_status,30,received,0)      -- Выдано = 0 если не передано в бух.
     where id = pDeptRegisterId
    ;
  end RemoveDeptFromEntRegister;


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


  function save_ent_register (
    p_id        in std.t_pk
   ,p_year      in number
   ,p_month     in number
   ,p_received  in number
   ,p_received_from  in varchar2
  ) return std.t_pk is
    l_result  std.t_pk;
    l_status  pls_integer := 20;  -- Ведомость
  begin
    if (p_id is null) then
      insert into milk_ent_register_tbl (
        id
       ,register_year
       ,register_month
       ,register_status
       ,register_timemark
       ,year_month
       ,received
       ,received_from
      ) values (
        null
       ,p_year
       ,p_month
       ,l_status
       ,sysdate
       ,to_number(to_char(p_year,'fm0000')||to_char(p_month,'fm00'))
       ,p_received
       ,p_received_from
      ) returning id into l_result;
    else
      update milk_ent_register_tbl
         set register_year = p_year
            ,register_month = p_month
            ,year_month = to_number(to_char(p_year,'fm0000')||to_char(p_month,'fm00'))
            ,received = p_received
            ,received_from = p_received_from
       where id = p_id
      ;
      l_result := p_id;
    end if;
    --
    return l_result;
  end save_ent_register;


  procedure remove_ent_register (
    p_id in std.T_PK
  ) is
    l_action constant varchar2(30) := 'REMOVE_END_REGISTER';
  begin
--    plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    delete
      from milk_ent_register_tbl
     where id = p_id
    ;
    --
--    plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
  exception
    when others then
--      plog.error(p_log_ctx);
      raise;
  end remove_ent_register;


  procedure SetEntRegisterStatus (
    pRegisterId  in std.t_pk
   ,pFromStatus  in pls_integer
   ,pToStatus    in pls_integer
  ) is
  begin
    update milk_ent_register_tbl
       set register_status = pToStatus
          ,register_timemark = systimestamp
     where id = pRegisterId
       and register_status = pFromStatus
    ;
  end SetEntRegisterStatus;


  procedure SendEntToAccounting (
    p_register_id  in number
  ) is
    lFromStatus  pls_integer := 20;  -- Ведомость
    lToStatus    pls_integer := 30;  -- Ведомость в бухгалтерии
  begin
    SetEntRegisterStatus(pRegisterId => p_register_id, pFromStatus => lFromStatus, pToStatus => lToStatus);
  end SendEntToAccounting;


  procedure RemoveEntFromAccounting (
    p_register_id  in number
  ) is
    lFromStatus  pls_integer := 30;  -- Ведомость в бухгалтерии
    lToStatus    pls_integer := 20;  -- Ведомость
  begin
    SetEntRegisterStatus(pRegisterId => p_register_id, pFromStatus => lFromStatus, pToStatus => lToStatus);
  end RemoveEntFromAccounting;

end I_MILK;
/
