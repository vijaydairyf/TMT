create or replace package I_MILK2 as

  function days_totals (
    p_spec_id  in number
  ) return number;
  pragma RESTRICT_REFERENCES( days_totals, WNDS );


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
  ) return std.t_pk;


  procedure SendDeptToAccounting (
    p_register_id  in number
  );


  procedure RemoveDeptFromAccounting (
    p_register_id  in number
  );


  function insert_milk_cost (
    p_cost_year   in number
   ,p_cost_month  in number
   ,p_cost_value  in number
  ) return std.T_PK;


  procedure update_milk_cost (
    p_id    in std.T_PK
   ,p_cost_year   in number
   ,p_cost_month  in number
   ,p_cost_value  in number
  );


  procedure delete_milk_cost (
    p_id  in std.T_PK
  );

end I_MILK2;
/
