create or replace package body I_USERS_DEPTS as

  g_module constant varchar2(30) := 'I_USERS_DEPTS';


  procedure create_users_depts (
    p_data in out nocopy t_data
  )
  is
	  l_action constant varchar2(30) := 'CREATE_USERS_DEPTS';
  begin
	  plog.info('Entering '||g_module||'.'||l_action);
    insert into users_depts_tbl
    values p_data
    returning id, updated, updater into p_data.id, p_data.updated, p_data.updater;
	  plog.info('Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error;
	    raise;
  end create_users_depts;


  procedure update_users_depts (
    p_data in out nocopy t_data
  )
  is
	  l_action constant varchar2(30) := 'UPDATE_USERS_DEPTS';
  begin
	  plog.info('Entering '||g_module||'.'||l_action);
    update users_depts_tbl set row = p_data
     where id = p_data.id
       and updated = p_data.updated
    ;
    if (sql%rowcount = 0) then
      raise std.DATA_NOT_SAVED;
    end if;
	  plog.info('Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error;
	    raise;
  end update_users_depts;


  procedure remove_users_depts (
    p_id in std.T_PK
  )
  is
	  l_action constant varchar2(30) := 'REMOVE_USERS_DEPTS';
  begin
	  plog.info('Entering '||g_module||'.'||l_action);
    delete
      from users_depts_tbl
     where id = p_id
    ;
	  plog.info('Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error;
	    raise;
  end remove_users_depts;


end I_USERS_DEPTS;
/
