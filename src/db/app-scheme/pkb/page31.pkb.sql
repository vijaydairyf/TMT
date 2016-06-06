create or replace package body PAGE31 as

  procedure save_data (
    p_id         in std.t_pk
   ,p_workoff    in number
   ,p_milk_norm  in number
  ) is
    l_id std.t_pk;
  begin
    for c1 in (
      select * from milk_specs where id = p_id
    ) loop
      l_id := i_milk.save_dept_spec (
        p_id => p_id
       ,p_register_id => c1.register_id
       ,p_emp_id => c1.emp_id
       ,p_emp_post_id => c1.emp_post_id
       ,p_work_off => p_workoff
       ,p_milk_norm  => p_milk_norm
       ,p_on_order => 0
       ,p_received   => 0
      );
    end loop c1;
  end save_data;

end PAGE31;
/
