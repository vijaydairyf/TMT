create or replace package I_USERS_DEPTS as

  subtype t_data is users_depts_tbl%rowtype;

  procedure create_users_depts (
    p_data in out nocopy t_data
  );

  procedure update_users_depts (
	  p_data in out nocopy t_data
	);

  procedure remove_users_depts (
    p_id in std.T_PK
  );

end I_USERS_DEPTS;
/
