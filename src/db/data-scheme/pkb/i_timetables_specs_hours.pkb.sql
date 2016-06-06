create or replace package body I_TIMETABLES_SPECS_HOURS as

  g_module constant varchar2(30) := 'I_TIMETABLES_SPECS_HOURS';


  procedure remove (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id in std.T_PK
  )
  is
	  l_action constant varchar2(30) := 'REMOVE';
    l_cnt integer;
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    select count(*)
      into l_cnt
      from timetables_tbl t, timetables_specs_tbl ts, timetables_specs_hours_tbl tsh
     where t.id = ts.timetable_id
       and ts.id = tsh.timetable_spec_id
       and tsh.id = p_id
       and t.submitted is null
       and t.accepted is null
    ;
    if (l_cnt = 0) then
      plog.error(p_log_ctx, 'Removing from readonly timetable attempts. Not allowed.');
      raise std.TIMETABLE_IS_READONLY;
    end if;
    --
    delete
      from timetables_specs_hours_tbl
     where id = p_id
    ;
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end remove;



  function save (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.t_pk
   ,p_updated  in timestamp
   ,p_timetable_spec_id  in std.t_pk
   ,p_day_date  in date
   ,p_hours_type_id  in number
   ,p_hours_amount  in number
   ,p_prs_hours_amount  in number
  ) return std.t_ids
  is
	  l_action constant varchar2(30) := 'SAVE';
    l_ids  std.t_ids;
    l_rowid  rowid;
    l_updated  timestamp;
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
	  plog.assert(p_log_ctx, p_timetable_spec_id is not null,'P_TIMETABLE_SPEC_ID is null');
    --
    plog.debug(p_log_ctx,
      'Parameters: '
      ||'p_id="'||p_id
      ||'"; p_timetable_spec_id="'||p_timetable_spec_id
      ||'"; p_day_date="'||to_char(p_day_date, 'dd.mm.yyyy')
      ||'"; hours_type_id="'||p_hours_type_id
      ||'"; hours_amount="'||p_hours_amount
      ||'"; prs_hours_amount="'||p_prs_hours_amount
      ||'".');
    --
    if (p_id is null and p_hours_type_id is not null and ((p_hours_amount is not null) or (p_prs_hours_amount is not null))) then
      --
 	    plog.debug(p_log_ctx, 'Inserting into TIMETABLES_SPECS_HOURS_TBL (ID is null). '
        ||'timetable_spec_id="'||p_timetable_spec_id
        ||'"; day_date="'||to_char(p_day_date, 'dd.mm.yyyy')
        ||'"; hours_type_id="'||p_hours_type_id
        ||'"; hours_amount="'||p_hours_amount
        ||'"; prs_hours_amount="'||p_prs_hours_amount
        ||'".');
      --
      insert into timetables_specs_hours_tbl (
        id, updated, updater, timetable_spec_id, day_date, hours_type_id, hours_amount, prs_hours_amount
      )
      values (
        null, null, null, p_timetable_spec_id, p_day_date, p_hours_type_id, nvl(p_hours_amount,0), nvl(p_prs_hours_amount,0)
      )
      returning id, updated into l_ids.id, l_ids.updated;
    else
      if (p_id is not null and ((p_hours_type_id is null) or (p_hours_amount is null and p_prs_hours_amount is null))) then
        -- All valuable data is null. Remove record now.
        --
        plog.debug(p_log_ctx,
          'Hours values is null. Record will be deleted. '
          ||'id="'||p_id
          ||'"; p_timetable_spec_id="'||p_timetable_spec_id
          ||'"; p_day_date="'||to_char(p_day_date,'dd.mm.yyyy')
          ||'".');
        --
        i_timetables_specs_hours.remove(p_log_ctx => p_log_ctx, p_id => p_id);
      elsif (p_id is not null and p_hours_type_id is not null and ((p_hours_amount is not null) or (p_prs_hours_amount is not null))) then
        select rowid, updated
          into l_rowid, l_updated
          from timetables_specs_hours_tbl
         where id = p_id
         for update
        ;
--        if (l_updated = p_updated) then
          --
          plog.debug(p_log_ctx,
            'Updating TIMETABLES_SPECS_HOURS_TBL. '
            ||'id="'||p_id
            ||'"; timetable_spec_id="'||p_timetable_spec_id
            ||'"; p_day_date="'||to_char(p_day_date,'dd.mm.yyyy')
            ||'"; hours_type_id="'||p_hours_type_id
            ||'"; hours_amount="'||p_hours_amount
            ||'"; prs_hours_amount="'||p_prs_hours_amount
            ||'".');
          --
          update timetables_specs_hours_tbl set
            timetable_spec_id = p_timetable_spec_id
           ,day_date = p_day_date
           ,hours_type_id = p_hours_type_id
           ,hours_amount = nvl(p_hours_amount,0)
           ,prs_hours_amount = nvl(p_prs_hours_amount,0)
           where rowid = l_rowid
--           returning id, updated into l_ids.id, l_ids.updated
          ;
--        else
--          raise std.LOST_UPDATED_FOUND;
--        end if;
      else
        --
        plog.debug(p_log_ctx, 'Nothing to do.');
        --
      end if;
    end if;
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    return l_ids;
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end save;



-----------------------------------------------------------------------------
-- Finds and returns day data record.
-----------------------------------------------------------------------------
  function find_hours_data (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_timetable_spec_id  in std.t_pk
   ,p_date  in date
   ,p_hours_type_id  in number
  ) return t_data is
	  l_action constant varchar2(30) := 'FIND_HOURS_DATA';
    l_result t_data;
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    begin
      select *
        into l_result
        from timetables_specs_hours_tbl tsd
       where tsd.timetable_spec_id = p_timetable_spec_id
         and tsd.day_date = p_date
         and tsd.hours_type_id = p_hours_type_id
      ;
    exception
      when no_data_found then
        l_result := null;
    end;
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    return l_result;
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
	end find_hours_data;


  procedure save_hours (
    p_log_ctx  in out nocopy plogparam.log_ctx
	 ,p_timetable_spec_id  in std.t_pk
	 ,p_year  in number
	 ,p_month in number
	 ,p_day   in number
	 ,p_hours_type_id in number
	 ,p_hours_amount  in number
	) is
	  l_action constant varchar2(30) := 'SAVE';
    l_tt_hours_data  t_data;
	  l_day_date date;
    l_ids  std.t_ids;
	begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
	  plog.assert(p_log_ctx, p_timetable_spec_id is not null,'P_TIMETABLE_SPEC_ID is not null');
	  plog.assert(p_log_ctx, p_year is not null, 'P_YEAR is not null');
	  plog.assert(p_log_ctx, p_month is not null, 'P_MONTH is not null');
	  plog.assert(p_log_ctx, p_day is not null, 'P_DAY is not null');
	  plog.assert(p_log_ctx, p_hours_type_id is not null, 'P_HOURS_TYPE_ID is not null');
	  --
	  begin
	    l_day_date := to_date(to_char(p_day,'00')||to_char(p_month,'00')||to_char(p_year,'0000'),'ddmmyyyy');
	  exception
	    when std.NOT_VALID_DATE then
	      return;
	  end;
    --
    l_tt_hours_data := find_hours_data (
      p_log_ctx  => p_log_ctx
     ,p_timetable_spec_id  => p_timetable_spec_id
     ,p_date  => l_day_date
     ,p_hours_type_id => p_hours_type_id
    );
    --
    l_ids := save (
      p_log_ctx  => p_log_ctx
     ,p_id  => l_tt_hours_data.id
     ,p_updated  => l_tt_hours_data.updated
     ,p_timetable_spec_id  => p_timetable_spec_id
     ,p_day_date  => l_day_date
     ,p_hours_type_id  => p_hours_type_id
     ,p_hours_amount  => p_hours_amount
     ,p_prs_hours_amount  => l_tt_hours_data.prs_hours_amount
    );
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
	end save_hours;



end I_TIMETABLES_SPECS_HOURS;
/
