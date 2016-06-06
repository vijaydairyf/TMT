create or replace package I_USERS as

  subtype t_data is users%rowtype;

  procedure create_user (
    p_data in out nocopy t_data
	 ,p_password in varchar2
  );

  procedure update_user (
	  p_data in out nocopy t_data
	);

	procedure change_password (
	  p_username in varchar2
	 ,p_old_password in varchar2
	 ,p_new_password in varchar2
	);

  procedure reset_password (
    p_username in varchar2
  );

  procedure remove_user (
    p_id in std.T_PK
  );

  function custom_auth (
    p_username in VARCHAR2
   ,p_password in VARCHAR2
  ) return BOOLEAN;

  function is_admin (
    p_username in varchar2 default null
  ) return boolean;

  function is_accounter (
    p_username in varchar2 default null
  ) return boolean;

  function is_timekeeper (
    p_username in varchar2 default null
  ) return boolean;

  function is_holischeduler (
    p_username in varchar2 default null
  ) return boolean;

  function is_dept_milk (
    p_username in varchar2 default null
  ) return boolean;

  function is_ent_milk (
    p_username in varchar2 default null
  ) return boolean;

  function is_hr (
    p_username in varchar2 default null
  ) return boolean;

end I_USERS;
/
