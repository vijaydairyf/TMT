create or replace package body I_TIMETABLES_SPECS_DAYS as

  g_module constant varchar2(30) := 'I_TIMETABLES_SPECS_DAYS';

-----------------------------------------------------------------------------
-- If timetable is readonly raises std.TIMETABLE_IS_READONLY exception.
-----------------------------------------------------------------------------
  procedure check_if_readonly_timetable (
    p_log_ctx in out nocopy plogparam.log_ctx
   ,p_spec_id in std.T_PK
  ) is
    l_cnt integer;
  begin
    select count(*)
      into l_cnt
      from timetables_tbl t, timetables_specs_tbl ts
     where t.id = ts.timetable_id
       and ts.id = p_spec_id
       and t.submitted is null
       and t.accepted is null
    ;
    if (l_cnt = 0) then
      plog.error(p_log_ctx, 'Saving into readonly timetable attempts. Not allowed.');
      raise std.TIMETABLE_IS_READONLY;
    end if;
  end check_if_readonly_timetable;


-----------------------------------------------------------------------------
-- Set value of prs_day_type_id == day_type_id
-----------------------------------------------------------------------------
  procedure reset_prs_day_type (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_spec_id  in std.T_PK
   ,p_date  in date
  )
  is
	  l_action constant varchar2(30) := 'SAVE PRS_DAY_TYPE';
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    update timetables_specs_days_tbl tsd
       set prs_day_type_id = day_type_id
     where tsd.timetable_spec_id = p_spec_id
       and tsd.day_date = p_date
    ;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end reset_prs_day_type;


-----------------------------------------------------------------------------
-- Deletes data from TIMETABLE_SPECS_DAYS_TBL table.
-----------------------------------------------------------------------------
  procedure remove (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id in std.T_PK
  )
  is
	  l_action constant varchar2(30) := 'REMOVE';
    l_spec_id std.T_PK;
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    plog.assert(p_log_ctx, p_id is not null, 'P_ID is null');
    --
    select tsd.timetable_spec_id
      into l_spec_id
      from timetables_specs_days_tbl tsd
     where tsd.id = p_id
    ;
    check_if_readonly_timetable (p_log_ctx => p_log_ctx, p_spec_id => l_spec_id);
    --
    delete
      from timetables_specs_days_tbl
     where id = p_id
    ;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end remove;

-----------------------------------------------------------------------------
-- If DAY_TYPE_ID or PRS_DAY_TYPE_ID values is not null, then saves data into
-- TIMETABLE_SPECS_DAYS_TBL table. Else deletes record if exists.
-----------------------------------------------------------------------------
  function save (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.t_pk
   ,p_updated  in timestamp
	 ,p_timetable_spec_id  in std.t_pk
   ,p_day_date  in date
	 ,p_day_type_id  in number
	 ,p_prs_day_type_id  in number
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
    if (p_id is null and (p_day_type_id is not null or p_prs_day_type_id is not null)) then
      plog.debug(p_log_ctx,
        'Inserting into TIMETABLES_SPECS_DAYS_TBL. '
          ||'timetable_spec_id="'||p_timetable_spec_id
          ||'"; p_day_date="'||to_char(p_day_date,'dd.mm.yyyy')
          ||'"; day_type_id="'||p_day_type_id
          ||'"; prs_day_type_id="'||p_prs_day_type_id
          ||'".');
      insert into timetables_specs_days_tbl (
        id, updated, updater, timetable_spec_id, day_date, day_type_id, prs_day_type_id
      )
      values (
        null, null, null, p_timetable_spec_id, p_day_date, p_day_type_id, p_prs_day_type_id
      )
      returning id, updated into l_ids.id, l_ids.updated;
    else
      if (p_id is not null and p_day_type_id is null and p_prs_day_type_id is null) then
        -- All valuable data is null. Remove record now.
        plog.debug(p_log_ctx,
          'Day type values is null. Record will be deleted. '
          ||'id="'||p_id
          ||'"; p_timetable_spec_id="'||p_timetable_spec_id
          ||'"; p_day_date="'||to_char(p_day_date,'dd.mm.yyyy')
          ||'".');
        i_timetables_specs_days.remove(p_log_ctx => p_log_ctx, p_id => p_id);
      elsif (p_id is not null and (p_day_type_id is not null or p_prs_day_type_id is not null)) then
        select rowid, updated
          into l_rowid, l_updated
          from timetables_specs_days_tbl
         where id = p_id
         for update
        ;
        --
--        if (l_updated = p_updated) then
          plog.debug(p_log_ctx,
            'Updating TIMETABLES_SPECS_DAYS_TBL. '
              ||'id="'||p_id
              ||'"; timetable_spec_id="'||p_timetable_spec_id
              ||'"; p_day_date="'||to_char(p_day_date,'dd.mm.yyyy')
              ||'"; day_type_id="'||p_day_type_id
              ||'"; prs_day_type_id="'||p_prs_day_type_id
              ||'".');
          update timetables_specs_days_tbl set
            timetable_spec_id = p_timetable_spec_id
           ,day_date = p_day_date
           ,day_type_id = p_day_type_id
           ,prs_day_type_id = p_prs_day_type_id
           where rowid = l_rowid
--          returning id, updated into l_ids.id, l_ids.updated
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
    --
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
  function find_day_data (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_timetable_spec_id  in std.t_pk
   ,p_date  in date
  ) return t_data
  is
	  l_action constant varchar2(30) := 'FIND_DAY_DATA';
    l_result t_data;
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    begin
      select *
        into l_result
        from timetables_specs_days_tbl tsd
       where tsd.timetable_spec_id = p_timetable_spec_id
         and tsd.day_date = p_date
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
	end find_day_data;



-----------------------------------------------------------------------------
-- Finds and returns day type id.
-----------------------------------------------------------------------------
  function find_day_type_id (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_day_type_code  in varchar2
  ) return number is
	  l_action constant varchar2(30) := 'FIND_DAY_TYPE_ID';
    l_result  number;
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    begin
      if (p_day_type_code is not null) then
        select id
	 	  		into l_result
	  	  	from days_types_tbl dt
  		   where code = trim(p_day_type_code)
	  		;
      else
        l_result := null;
      end if;
    exception
      when no_data_found then
        l_result := null;
    end;
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
    return l_result;
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
  end find_day_type_id;



-----------------------------------------------------------------------------
-- Saves day data.
-----------------------------------------------------------------------------
  procedure save_day (
    p_log_ctx  in out nocopy plogparam.log_ctx
	 ,p_timetable_spec_id  in std.t_pk
	 ,p_year  in number
	 ,p_month in number
	 ,p_day   in number
	 ,p_day_type_id  in number
	) is
	  l_action constant varchar2(30) := 'SAVE_DAY';
    l_data  t_data;
	  l_day_date  date;
    l_ids  std.t_ids;
	begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
	  plog.assert(p_log_ctx, p_timetable_spec_id is not null,'P_TIMETABLE_SPEC_ID is null');
	  plog.assert(p_log_ctx, p_year is not null, 'P_YEAR is null');
	  plog.assert(p_log_ctx, p_month is not null, 'P_MONTH is null');
	  plog.assert(p_log_ctx, p_day is not null, 'P_DAY is null');
	  --
    -- Checs if saving allowed.
--    check_if_readonly_timetable (p_log_ctx => p_log_ctx, p_spec_id => p_timetable_spec_id);
--    plog.debug(p_log_ctx, 'Timetable in read/write status.');
    --
	  begin
	    l_day_date := to_date(to_char(p_day,'00')||to_char(p_month,'00')||to_char(p_year,'0000'),'ddmmyyyy');
	  exception
	    when std.NOT_VALID_DATE then
	      return;
	  end;
    --
    l_data := find_day_data (
      p_log_ctx  => p_log_ctx
     ,p_timetable_spec_id  => p_timetable_spec_id
     ,p_date  => l_day_date
    );
    --
    plog.debug(p_log_ctx,
      'Saving into TIMETABLES_SPECS_DAYS_TBL. '
        ||'id="'||l_data.id
--        ||'"; updated="'||to_char(l_data.updated,'dd.mm.yyyy hh24:mi:ss')
        ||'"; timetable_spec_id="'||p_timetable_spec_id
        ||'"; day_date="'||l_day_date
        ||'"; day_type_id="'||p_day_type_id
        ||'"; prs_day_type_id="'||l_data.prs_day_type_id
        ||'".');
    --
    l_ids := save (
      p_log_ctx  => p_log_ctx
     ,p_id  => l_data.id
     ,p_updated  => l_data.updated
     ,p_timetable_spec_id  => p_timetable_spec_id
     ,p_day_date  => l_day_date
     ,p_day_type_id  => p_day_type_id
     ,p_prs_day_type_id  => l_data.prs_day_type_id
    );
    --
	  plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error(p_log_ctx);
	    raise;
	end save_day;



end I_TIMETABLES_SPECS_DAYS;
/
