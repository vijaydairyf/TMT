create or replace package body I_HOLIDAYS_SCHEDULES as

  g_module constant varchar2(30) := 'I_HOLIDAYS_SCHEDULES';


  function save_spec_data (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id           in std.t_pk
   ,p_spec_id      in std.t_pk
   ,p_beg_date     in date
   ,p_days_amount  in number
  ) return std.t_pk is
	  l_action  constant varchar2(30) := 'SAVE_SPEC_DATA';
    l_result  std.t_pk;
  begin
    l_result := p_id;
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    if (p_id is null) then
      insert into holisched_specs_data_tbl (spec_id, beg_date, days_amount)
      values (p_spec_id, p_beg_date, p_days_amount)
      returning id into l_result;
    else
      update holisched_specs_data_tbl
         set spec_id = p_spec_id
            ,beg_date = p_beg_date
            ,days_amount = p_days_amount
       where id = p_id
      ;
      --
      if (sql%rowcount = 0) then
        raise std.DATA_NOT_SAVED;
      end if;
    end if;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    return l_result;
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end save_spec_data;


  procedure remove_spec_data (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.T_PK
  ) is
	  l_action constant varchar2(30) := 'REMOVE_SPEC_DATA';
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    delete
      from holisched_specs_data_tbl
     where id = p_id
    ;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end remove_spec_data;


  function save_spec (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id           in std.t_pk
   ,p_schedule_id  in std.t_pk
   ,p_emp_id       in number
   ,p_post_id      in number
  ) return std.t_pk is
	  l_action  constant varchar2(30) := 'SAVE_SPEC';
    l_result  std.t_pk;
  begin
    l_result := p_id;
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    if (p_id is null) then
      insert into holisched_specs_tbl (schedule_id, emp_id, post_id)
      values (p_schedule_id, p_emp_id, p_post_id)
      returning id into l_result;
    else
      update holisched_specs_tbl
         set schedule_id = p_schedule_id
            ,emp_id = p_emp_id
            ,post_id = p_post_id
       where id = p_id
      ;
      --
      if (sql%rowcount = 0) then
        raise std.DATA_NOT_SAVED;
      end if;
    end if;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    return l_result;
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end save_spec;


  procedure remove_spec (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.T_PK
  ) is
	  l_action constant varchar2(30) := 'REMOVE_SPEC';
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    delete
      from holisched_specs_tbl
     where id = p_id
    ;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end remove_spec;


  function save_schedule (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id          in std.t_pk
   ,p_company_id  in number
   ,p_dept_id     in number
   ,p_year        in number
  ) return std.t_pk is
	  l_action  constant varchar2(30) := 'SAVE_SCHEDULE';
    l_result  std.t_pk;
  begin
    l_result := p_id;
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    if (p_id is null) then
      insert into holidays_schedules_tbl (company_id, dept_id, schedule_year)
      values (p_company_id, p_dept_id, p_year)
      returning id into l_result;
    else
      update holidays_schedules_tbl
         set company_id = p_company_id
            ,dept_id = p_dept_id
            ,schedule_year = p_year
       where id = p_id
      ;
      --
      if (sql%rowcount = 0) then
        raise std.DATA_NOT_SAVED;
      end if;
    end if;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    return l_result;
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end save_schedule;


  procedure remove_schedule (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id in std.T_PK
  ) is
	  l_action constant varchar2(30) := 'REMOVE_SCHEDULE';
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    delete
      from holidays_schedules_tbl
     where id = p_id
    ;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end remove_schedule;


  function create_schedule (
    p_log_ctx  in out nocopy plogparam.log_ctx
	 ,p_company_id       in number
	 ,p_dept_id          in number
	 ,p_year             in number
  ) return std.t_pk is
	  l_action constant varchar2(30) := 'CREATE_SCHEDULE';
	  l_beg_date date := to_date('0101'||to_char(p_year,'0000'),'ddmmyyyy');
--	  l_end_date date := last_day(l_beg_date);
	  l_end_date date := to_date('3112'||to_char(p_year,'0000'),'ddmmyyyy');
	  l_schedule_id  std.t_pk;
	  l_spec_id std.t_pk;
	begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
	  l_schedule_id := save_schedule (
	    p_log_ctx => p_log_ctx
	   ,p_id  => null
	   ,p_company_id  => p_company_id
	   ,p_dept_id  => p_dept_id
	   ,p_year  => p_year
	  );
		--
    for duties in (
			select d.rn, d.persrn, d.psdeprn
			from prs_duties d, duties_types_tbl dt
       where d.clnpspfmtypes = dt.id
         and dt.code = 'осн'
         and d.company = p_company_id
			   and d.deptrn = p_dept_id
				 and (d.begeng <= l_end_date and (d.endeng is null or d.endeng >= l_beg_date))
		) loop
		  l_spec_id := save_spec (
  	    p_log_ctx => p_log_ctx
		   ,p_id  => null
		   ,p_schedule_id => l_schedule_id
		   ,p_emp_id => duties.persrn
		   ,p_post_id => duties.psdeprn
		  );
		end loop duties;
		--
		return l_schedule_id;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
	end create_schedule;


  procedure refresh_schedule (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id      in number
  ) is
	  l_action constant varchar2(30) := 'REFRESH_SCHEDULE';
	  l_beg_date date;
	  l_end_date date;
	  l_spec_id std.t_pk;
	begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    for schedule in (
      select * from holidays_schedules_tbl
       where id = p_id
    ) loop
	    l_beg_date := to_date('0101'||to_char(schedule.schedule_year,'0000'),'ddmmyyyy');
	    l_end_date := to_date('3112'||to_char(schedule.schedule_year,'0000'),'ddmmyyyy');
      for duties in (
        select d.rn, d.persrn, d.psdeprn
        from prs_duties d, duties_types_tbl dt
         where d.clnpspfmtypes = dt.id
           and dt.code = 'осн'
           and d.company = schedule.company_id
           and d.deptrn = schedule.dept_id
           and (d.begeng <= l_end_date and (d.endeng is null or d.endeng >= l_beg_date))
           and not exists (select null from holisched_specs_tbl
                            where schedule_id = schedule.id
                              and emp_id = d.persrn
                              and post_id = d.psdeprn
                          )
      ) loop
        l_spec_id := save_spec (
          p_log_ctx => p_log_ctx
         ,p_id  => null
         ,p_schedule_id => schedule.id
         ,p_emp_id => duties.persrn
         ,p_post_id => duties.psdeprn
        );
      end loop duties;
    end loop schedule;
		--
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
	end refresh_schedule;

end I_HOLIDAYS_SCHEDULES;
/
