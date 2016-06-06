create or replace package body PAGE30 as

  procedure add_emp_to_register (
    p_register_id  in std.t_pk
   ,p_emp_id  in std.t_pk
  ) is
    l_spec_id  std.t_pk;
  begin
    for c1 in (
      select null from my_milk m
       where m.id = p_register_id
         and not exists (select null from milk_specs where register_id = m.id and emp_id = p_emp_id)
    ) loop
      l_spec_id := i_milk.add_emp_to_dept_register (
        p_register_id  => p_register_id
       ,p_emp_id   => p_emp_id
      );
    end loop c1;
  end add_emp_to_register;

end PAGE30;
/
