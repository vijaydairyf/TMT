create or replace package MILK2_PKG as

  procedure add_new_dept_register (
    p_dept_id       in number
   ,p_year          in number
   ,p_month         in number
  );


  procedure delete_dept_register (
    p_id  in number
  );


  procedure save_spec (
    p_id         in std.t_pk
   ,p_workoff    in number
  );


  procedure add_emp_to_dept_spec (
    p_register_id  in std.t_pk
   ,p_emp_id  in std.t_pk
  );


  procedure delete_from_dept_spec (
   p_spec_id  in number
  );


  procedure check_dept_register_empty (
    p_register_id  in std.t_pk
  );


  procedure SendToAccounting (
    p_register_id  in number
  );


  procedure RemoveFromAccounting (
    p_register_id  in number
  );

  -- Сохранение данных нормы стоимости молока
  function save_milk_cost2 (
    p_id          in std.T_PK   -- ID
   ,p_cost_year   in number     -- Год
   ,p_cost_month  in number     -- Месяц
   ,p_cost_value  in number     -- Значение
  ) return std.T_PK;

  -- Удаление данных Протокола
  procedure remove_milk_cost2 (
    p_id  in std.T_PK  -- ID
  );

end MILK2_PKG;
/
