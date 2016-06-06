create or replace package I_MILK as

  function create_dept_register (
    p_dept_id       in number
   ,p_year          in number
   ,p_month         in number
  ) return std.t_pk;


  function save_dept_register (
    p_id               in std.t_pk
   ,p_dept_id          in number
   ,p_year             in number
   ,p_month            in number
   ,p_received         in number
  ) return std.t_pk;


  procedure remove_dept_register (
    p_id  in std.T_PK
  );


  procedure remove_dept_spec (
    p_id  in std.T_PK
  );


  function add_emp_to_dept_register (
    p_register_id  in std.t_pk
   ,p_emp_id   in std.t_pk
  ) return std.t_pk;


  function save_dept_spec (
    p_id            in std.t_pk
   ,p_register_id   in std.t_pk
   ,p_emp_id        in std.t_pk
   ,p_emp_post_id   in std.t_pk
   ,p_work_off      in number
   ,p_milk_norm     in number
   ,p_on_order      in number
   ,p_received      in number
  ) return std.t_pk;


  function save_ent_register (
    p_id        in std.t_pk
   ,p_year      in number
   ,p_month     in number
   ,p_received  in number
   ,p_received_from  in varchar2
  ) return std.t_pk;


  procedure remove_ent_register (
    p_id in std.T_PK
  );


  procedure send_order (
    p_register_id  in number
  );


  procedure recall_order (
    p_register_id  in number
  );


  procedure AddDeptToEntRegister (
    pDeptRegisterId  in std.t_pk
   ,pEntRegisterId   in std.t_pk
  );


  procedure RemoveDeptFromEntRegister (
    pDeptRegisterId  in std.t_pk
  );


  procedure SendDeptToAccounting (
    p_register_id  in number
  );


  procedure RemoveDeptFromAccounting (
    p_register_id  in number
  );


  procedure SendEntToAccounting (
    p_register_id  in number
  );


  procedure RemoveEntFromAccounting (
    p_register_id  in number
  );

end I_MILK;
/
