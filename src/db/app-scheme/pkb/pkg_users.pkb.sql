create or replace package body PKG_USERS as

  procedure create_new_user (
    p_data in out nocopy t_user_data
   ,p_password in varchar2
  ) is
  begin
    if (p_data.is_admin is null) then
      p_data.is_admin := '-';
    end if;
    if (p_data.is_accounter is null) then
      p_data.is_accounter := '-';
    end if;
    if (p_data.is_timekeeper is null) then
      p_data.is_timekeeper := '-';
    end if;
    if (p_data.is_holischeduler is null) then
      p_data.is_holischeduler := '-';
    end if;
    if (p_data.is_dept_milk is null) then
      p_data.is_dept_milk := '-';
    end if;
    if (p_data.is_ent_milk is null) then
      p_data.is_ent_milk := '-';
    end if;
    if (p_data.is_hr is null) then
      p_data.is_hr := '-';
    end if;
    --
    i_users.create_user (
      p_data => p_data
     ,p_password => p_password
    );
  end create_new_user;


  procedure modify_user_data (
    p_data in out nocopy t_user_data
  ) is
  begin
    if (p_data.is_admin is null) then
      p_data.is_admin := '-';
    end if;
    if (p_data.is_accounter is null) then
      p_data.is_accounter := '-';
    end if;
    if (p_data.is_timekeeper is null) then
      p_data.is_timekeeper := '-';
    end if;
    if (p_data.is_holischeduler is null) then
      p_data.is_holischeduler := '-';
    end if;
    if (p_data.is_dept_milk is null) then
      p_data.is_dept_milk := '-';
    end if;
    if (p_data.is_ent_milk is null) then
      p_data.is_ent_milk := '-';
    end if;
    if (p_data.is_hr is null) then
      p_data.is_hr := '-';
    end if;
    --
    i_users.update_user (
      p_data => p_data
    );
  end modify_user_data;


  procedure remove_user (
    p_id in std.t_pk
  ) is
  begin
    i_users.remove_user (
      p_id => p_id
    );
  end remove_user;


  procedure change_password (
    p_username in varchar2
   ,p_old_password in varchar2
   ,p_new_password in varchar2
  ) is
  begin
    i_users.change_password (
      p_username => p_username
     ,p_old_password => p_old_password
     ,p_new_password => p_new_password
    );
  end change_password;


  procedure reset_password (
    p_username in varchar2
  ) is
  begin
    i_users.reset_password (
      p_username => p_username
    );
  exception
    when std.AUTHENTICATION_FAILED then
      apex_application.show_error_message(APEX_LANG.MESSAGE('AUTHENTICATION_FAILED_MSG'));
    when std.AUTHORIZATION_FAILED then
      apex_application.show_error_message(APEX_LANG.MESSAGE('AUTHORIZATION_FAILED_MSG'));
  end reset_password;


  function add_user_department (
    p_user_id  in std.T_PK
   ,p_company_id  in number
   ,p_dept_id  in number
  ) return std.T_PK is
    l_data  users_depts_tbl%rowtype;
  begin
    l_data.id := null;
    l_data.updater := null;
    l_data.updated := null;
    l_data.user_id := p_user_id;
    l_data.company_id := p_company_id;
    l_data.dept_id := p_dept_id;
    i_users_depts.create_users_depts (
      p_data => l_data
    );
    return l_data.id;
  end add_user_department;

  procedure delete_user_department (
    p_id  in std.T_PK
  ) is
  begin
    i_users_depts.remove_users_depts (
      p_id => p_id
    );
  end delete_user_department;

end PKG_USERS;
/
