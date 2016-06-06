create or replace package body I_USERS as

  g_module constant varchar2(30) := 'I_USERS';

  function is_admin (
    p_username in varchar2 default null
  ) return boolean is
    l_cnt number := 0;
    l_result boolean;
  begin
    select count(*) into l_cnt
      from users_tbl t
     where t.username = nvl(p_username, v('APP_USER'))
       and t.is_admin = '+'
    ;
    if (l_cnt > 0) then
      l_result := true;
    else
      l_result := false;
    end if;
    return l_result;
  end is_admin;


  function is_accounter (
    p_username in varchar2 default null
  ) return boolean is
    l_cnt number := 0;
    l_result boolean;
  begin
    select count(*) into l_cnt
      from users_tbl t
     where t.username = nvl(p_username, v('APP_USER'))
       and t.is_accounter = '+'
    ;
    if (l_cnt > 0) then
      l_result := true;
    else
      l_result := false;
    end if;
    return l_result;
  end is_accounter;


  function is_timekeeper (
    p_username in varchar2 default null
  ) return boolean is
    l_cnt number := 0;
    l_result boolean;
  begin
    select count(*) into l_cnt
      from users_tbl t
     where t.username = nvl(p_username, v('APP_USER'))
       and t.is_timekeeper = '+'
    ;
    if (l_cnt > 0) then
      l_result := true;
    else
      l_result := false;
    end if;
    return l_result;
  end is_timekeeper;


  function is_holischeduler (
    p_username in varchar2 default null
  ) return boolean is
    l_cnt number := 0;
    l_result boolean;
  begin
    select count(*) into l_cnt
      from users_tbl t
     where t.username = nvl(p_username, v('APP_USER'))
       and t.is_holischeduler = '+'
    ;
    if (l_cnt > 0) then
      l_result := true;
    else
      l_result := false;
    end if;
    return l_result;
  end is_holischeduler;


  function is_dept_milk (
    p_username in varchar2 default null
  ) return boolean is
    l_cnt number := 0;
    l_result boolean;
  begin
    select count(*) into l_cnt
      from users_tbl t
     where t.username = nvl(p_username, v('APP_USER'))
       and t.is_dept_milk = '+'
    ;
    if (l_cnt > 0) then
      l_result := true;
    else
      l_result := false;
    end if;
    return l_result;
  end is_dept_milk;


  function is_ent_milk (
    p_username in varchar2 default null
  ) return boolean is
    l_cnt number := 0;
    l_result boolean;
  begin
    select count(*) into l_cnt
      from users_tbl t
     where t.username = nvl(p_username, v('APP_USER'))
       and t.is_ent_milk = '+'
    ;
    if (l_cnt > 0) then
      l_result := true;
    else
      l_result := false;
    end if;
    return l_result;
  end is_ent_milk;


  function is_hr (
    p_username in varchar2 default null
  ) return boolean is
    l_cnt number := 0;
    l_result boolean;
  begin
    select count(*) into l_cnt
      from users_tbl t
     where t.username = nvl(p_username, v('APP_USER'))
       and t.is_hr = '+'
    ;
    if (l_cnt > 0) then
      l_result := true;
    else
      l_result := false;
    end if;
    return l_result;
  end is_hr;


  function custom_hash (
    p_username in varchar2
   ,p_password in varchar2
  ) return varchar2
  is
    l_password varchar2(4000);
    l_salt varchar2(4000) := 'R38U12DMKEN5BR9Z04VP0T289ONY4L';
  begin
    -- This function should be wrapped, as the hash algorhythm is exposed here.
    -- You can change the value of l_salt or the method of which to call the
    -- DBMS_OBFUSCATOIN toolkit, but you much reset all of your passwords
    -- if you choose to do this.
    l_password := utl_raw.cast_to_raw(dbms_obfuscation_toolkit.md5(input_string => p_password||substr(l_salt,10,13)||p_username||substr(l_salt, 4,10)));
    return l_password;
  end custom_hash;


  function custom_auth (
    p_username in VARCHAR2
   ,p_password in VARCHAR2
  ) return BOOLEAN
  is
    l_password users_tbl.userpass%type;
    l_stored_password users_tbl.userpass%type;
    l_expires_on users_tbl.expires%type;
    l_count number;
  begin
    -- First, check to see if the user is in the user table
    select count(*) into l_count from users_tbl where username = p_username;
    if (l_count > 0) then
      -- First, we fetch the stored hashed password and expire date
      select userpass, expires into l_stored_password, l_expires_on
        from users_tbl where username = p_username;
      -- Next, we check to see if the user's account is expired
      -- If it is, return FALSE
      if (l_expires_on > sysdate or l_expires_on is null) then
        -- If the account is not expired, we have to apply the custom hash
        -- function to the password
        l_password := custom_hash(p_username, p_password);
        -- Finally, we compare them to see if they are the same and return
			  -- either TRUE or FALSE
  			if (l_password = l_stored_password) then
	  			return true;
		  	else
			  	return false;
  			end if;
	  	else
		  	return false;
  		end if;
	  else
  		-- The username provided is not in the USERS_TBL table
	  	return false;
  	end if;
  end custom_auth;


  procedure create_user (
    p_data in out nocopy t_data
	 ,p_password in varchar2
  )
  is
	  l_action constant varchar2(30) := 'CREATE_USER';
	  l_userpass users_tbl.userpass%type;
  begin
	  plog.info('Entering '||g_module||'.'||l_action);
	  if (is_admin) then
  	  l_userpass := custom_hash(p_username => p_data.username, p_password => p_password);
      insert into users_tbl (
          username, userpass, fullname, created, is_admin, is_accounter, is_timekeeper
         ,is_holischeduler, is_dept_milk, is_ent_milk, is_hr, expires, phone, room, notes)
        values (
          p_data.username, l_userpass, p_data.fullname, sysdate, p_data.is_admin
         ,p_data.is_accounter, p_data.is_timekeeper, p_data.is_holischeduler
         ,p_data.is_dept_milk, p_data.is_ent_milk, p_data.is_hr, p_data.expires
         ,p_data.phone, p_data.room, p_data.notes
        )
        returning id, updated, updater into p_data.id, p_data.updated, p_data.updater;
	  else
  			raise std.AUTHORIZATION_FAILED;
	  end if;
	  plog.info('Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error;
	    raise;
  end create_user;


  procedure update_user (
    p_data in out nocopy t_data
  )
  is
	  l_action constant varchar2(30) := 'UPDATE_USER';
  begin
	  plog.info('Entering '||g_module||'.'||l_action);
	  if (is_admin) then
      update users_tbl set
  	 	       username = p_data.username
	  				,fullname = p_data.fullname
		  			,is_admin = p_data.is_admin
						,is_accounter = p_data.is_accounter
						,is_timekeeper = p_data.is_timekeeper
						,is_holischeduler = p_data.is_holischeduler
            ,is_dept_milk = p_data.is_dept_milk
            ,is_ent_milk = p_data.is_ent_milk
            ,is_hr = p_data.is_hr
			  		,expires = p_data.expires
			  		,phone = p_data.phone
			  		,room = p_data.room
					  ,notes = p_data.notes
       where id = p_data.id
         and updated = p_data.updated
      ;
      if (sql%rowcount = 0) then
        raise std.DATA_NOT_SAVED;
      end if;
	  else
			raise std.AUTHORIZATION_FAILED;
	  end if;
	  plog.info('Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error;
	    raise;
  end update_user;


  procedure remove_user (
    p_id in std.T_PK
  )
  is
	  l_action constant varchar2(30) := 'REMOVE_USER';
  begin
	  plog.info('Entering '||g_module||'.'||l_action);
	  if (is_admin) then
      delete
        from users_tbl
       where id = p_id
      ;
	  else
			raise std.AUTHORIZATION_FAILED;
	  end if;
	  plog.info('Exit '||g_module||'.'||l_action);
	exception
	  when others then
	    plog.error;
	    raise;
  end remove_user;


  procedure change_password (
	  p_username in varchar2
	 ,p_old_password in varchar2
	 ,p_new_password in varchar2
	)
  is
	  l_userpass users_tbl.userpass%type;
	begin
			if (custom_auth(p_username => p_username, p_password => p_old_password)) then
				l_userpass := custom_hash(p_username => p_username, p_password => p_new_password);
				update users_tbl set userpass = l_userpass where username = p_username;
			else
				raise std.AUTHENTICATION_FAILED;
			end if;
	end change_password;


  procedure reset_password (
	  p_username in varchar2
	)
  is
	  l_userpass users_tbl.userpass%type;
	begin
	  if (is_admin) then
				l_userpass := custom_hash(p_username => p_username, p_password => p_username);
				update users_tbl set userpass = l_userpass where username = p_username;
	  else
			raise std.AUTHORIZATION_FAILED;
	  end if;
	end reset_password;

end I_USERS;
/
