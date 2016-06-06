create or replace package body I_DEPTS_PROPERTIES as

  g_module constant varchar2(30) := 'I_DEPTS_PROPERTIES';

  function save (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.t_pk
   ,p_updated  in timestamp
   ,p_dept_id  in number
   ,p_curator_post    in varchar2
   ,p_curator_name    in varchar2
   ,p_manager_name    in varchar2
   ,p_milk_resp_name  in varchar2
  ) return std.t_ids is
	  l_action constant varchar2(30) := 'SAVE';
    l_ids  std.t_ids;
    l_rowid  rowid;
    l_updated  timestamp;
  begin
	  plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    if (p_id is null) then
      --
 	    plog.debug(p_log_ctx, 'Inserting into I_DEPTS_PROPERTIES_TBL (ID is null). '
        ||' dept_id="'||p_dept_id
        ||'"; curator_post="'||p_curator_post
        ||'"; curator_name="'||p_curator_name
        ||'"; manager_name="'||p_manager_name
        ||'".');
      --
      insert into depts_properties_tbl (
        id, updated, updater, dept_id, curator_post, curator_name, manager_name, milk_resp_name
      )
      values (
        null, null, null, p_dept_id, p_curator_post, p_curator_name, p_manager_name, p_milk_resp_name
      )
      returning id, updated into l_ids.id, l_ids.updated;
    else
      select rowid, updated
        into l_rowid, l_updated
        from depts_properties_tbl
       where id = p_id
      for update
      ;
      --
--      if (l_updated = p_updated) then
      if (true) then
        --
        plog.debug(p_log_ctx, 'Updating DEPTS_PROPERTIES_TBL. '
          ||' dept_id="'||p_dept_id
          ||'"; curator_post="'||p_curator_post
          ||'"; curator_name="'||p_curator_name
          ||'"; manager_name="'||p_manager_name
          ||'".');
        --
        update depts_properties_tbl set
          dept_id = p_dept_id
         ,curator_post = p_curator_post
         ,curator_name = p_curator_name
         ,manager_name = p_manager_name
         ,milk_resp_name = p_milk_resp_name
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


  procedure remove (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.t_pk
  ) is
    l_action constant varchar2(30) := 'REMOVE';
  begin
    plog.info(p_log_ctx, 'Entering '||g_module||'.'||l_action);
    --
    delete
      from depts_properties_tbl
     where id = p_id
    ;
    --
    plog.info(p_log_ctx, 'Exit '||g_module||'.'||l_action);
  exception
    when others then
      plog.error(p_log_ctx);
      raise;
  end remove;

end I_DEPTS_PROPERTIES;
/
