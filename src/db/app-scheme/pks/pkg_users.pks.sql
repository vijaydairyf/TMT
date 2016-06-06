create or replace package PKG_USERS as
  
  subtype t_user_data is users%rowtype;

  procedure create_new_user (
    p_data in out nocopy t_user_data
   ,p_password in varchar2
  );

  procedure modify_user_data (
    p_data in out nocopy t_user_data
  );

  procedure remove_user (
    p_id in std.t_pk
  );

	procedure change_password (
	  p_username in varchar2
	 ,p_old_password in varchar2
	 ,p_new_password in varchar2
	);

	procedure reset_password (
	  p_username in varchar2
	);

  function add_user_department (
    p_user_id  in std.T_PK
   ,p_company_id  in number
   ,p_dept_id  in number
  ) return std.T_PK;

  procedure delete_user_department (
    p_id  in std.T_PK
  );

end PKG_USERS;
/
