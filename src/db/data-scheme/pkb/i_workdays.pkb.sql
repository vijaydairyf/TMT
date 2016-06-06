create or replace package body I_WORKDAYS as

  g_module constant varchar2(30) := 'I_WORKDAYS';

  procedure save (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_year    in number
   ,p_month   in number
   ,p_workdays in number
  ) is
	  l_action constant varchar2(30) := 'SAVE';
    l_rowid rowid;
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    begin
      select rowid
        into l_rowid
        from workdays_tbl w
       where work_year = p_year
         and work_month = p_month
      ;
    exception
      when no_data_found then
        l_rowid := null;
    end;
    --
    if (l_rowid is null) then
      insert into workdays_tbl (work_year, work_month, workdays)
        values (p_year, p_month, p_workdays)
      ;
    else
      update workdays_tbl
         set work_year = p_year
            ,work_month = p_month
            ,workdays = p_workdays
       where rowid = l_rowid
      ;
    end if;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end save;


  procedure remove (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_year  in number
   ,p_month in number
  ) is
	  l_action constant varchar2(30) := 'REMOVE';
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    delete from workdays_tbl where work_year = p_year and work_month = p_month;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end remove;

end I_WORKDAYS;
/
