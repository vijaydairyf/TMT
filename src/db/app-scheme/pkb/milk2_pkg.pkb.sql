create or replace package body MILK2_PKG as

  procedure add_new_dept_register (
    p_dept_id       in number
   ,p_year          in number
   ,p_month         in number
  ) as
    l_id  std.t_pk;
  begin
    l_id := i_milk2.create_dept_register (
      p_dept_id    => p_dept_id
     ,p_year       => p_year
     ,p_month      => p_month
    );
  end add_new_dept_register;


  procedure delete_dept_register (
    p_id  in number
  ) is
  begin
    i_milk2.remove_dept_register (
      p_id => p_id
    );
  end delete_dept_register;


  procedure save_spec (
    p_id         in std.t_pk
   ,p_workoff    in number
  ) is
    l_id std.t_pk;
  begin
    for c1 in (
      select * from milk_specs2 where id = p_id
    ) loop
      l_id := i_milk2.save_dept_spec (
        p_id => p_id
       ,p_register_id => c1.register_id
       ,p_emp_id => c1.emp_id
       ,p_emp_post_id => c1.emp_post_id
       ,p_work_off => p_workoff
      );
    end loop c1;
  end save_spec;


  procedure add_emp_to_dept_spec (
    p_register_id  in std.t_pk
   ,p_emp_id  in std.t_pk
  ) is
    l_spec_id  std.t_pk;
  begin
    for c1 in (
      select null from my_milk2 m
       where m.id = p_register_id
         and not exists (select null from milk_specs2 where register_id = m.id and emp_id = p_emp_id)
    ) loop
      l_spec_id := i_milk2.add_emp_to_dept_register (
        p_register_id  => p_register_id
       ,p_emp_id   => p_emp_id
      );
    end loop c1;
  end add_emp_to_dept_spec;


  procedure delete_from_dept_spec (
   p_spec_id  in number
  ) is
  begin
    i_milk2.remove_dept_spec(p_id => p_spec_id);
  end delete_from_dept_spec;


  procedure check_dept_register_empty (
    p_register_id  in std.t_pk
  ) is
    l_cnt  pls_integer;
  begin
    select count(*)
      into l_cnt
      from milk_specs2
     where register_id = p_register_id
    ;
    --
    if (l_cnt = 0) then
      i_milk2.remove_dept_register(p_id => p_register_id);
    end if;
  end check_dept_register_empty;


  procedure SendToAccounting (
    p_register_id  in number
  ) is
  begin
    i_milk2.SendDeptToAccounting(p_register_id => p_register_id);
  end SendToAccounting;


  procedure RemoveFromAccounting (
    p_register_id  in number
  ) is
  begin
    i_milk2.RemoveDeptFromAccounting(p_register_id => p_register_id);
  end RemoveFromAccounting;


  -- Сохранение данных нормы стоимости молока
  function save_milk_cost2 (
    p_id          in std.T_PK   -- ID
   ,p_cost_year   in number     -- Год
   ,p_cost_month  in number     -- Месяц
   ,p_cost_value  in number     -- Значение
  ) return std.T_PK is
    l_result  std.T_PK;
  begin
    l_result := p_id;
    --
    if (p_id is null) then
      l_result := i_milk2.insert_milk_cost (
        p_cost_year   => p_cost_year
       ,p_cost_month  => p_cost_month
       ,p_cost_value  => p_cost_value
      );
    else
      i_milk2.update_milk_cost (
        p_id          => p_id
       ,p_cost_year   => p_cost_year
       ,p_cost_month  => p_cost_month
       ,p_cost_value  => p_cost_value
      );
    end if;
    --
    return l_result;
  end save_milk_cost2;


  -- Удаление данных Протокола
  procedure remove_milk_cost2 (
    p_id  in std.T_PK  -- ID
  ) is
  begin
    i_milk2.delete_milk_cost (
      p_id => p_id
    );
  end remove_milk_cost2;

end MILK2_PKG;
/
