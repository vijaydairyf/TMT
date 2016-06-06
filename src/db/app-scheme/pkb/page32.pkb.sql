create or replace package body PAGE32 as

  procedure save_order (
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
  end save_order;


  procedure save_register (
    p_id        in std.t_pk
   ,p_workoff    in number
   ,p_milk_norm  in number
   ,p_give_out  in number
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
       ,p_on_order => c1.on_order
       ,p_received   => p_give_out
      );
    end loop c1;
  end save_register;


  procedure corr_register (
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
       ,p_on_order => c1.on_order
       ,p_received   => c1.received
      );
    end loop c1;
  end corr_register;


  procedure set_received_as_ordered (
    p_register_id  in std.t_pk
  )is
    l_id std.t_pk;
    l_received number := 0;
  begin
    for c1 in (
      select * from milk_specs where register_id = p_register_id
    ) loop
      if (c1.received = 0) then
        l_received := c1.on_order;
      else
        l_received := c1.received;
      end if;
      l_id := i_milk.save_dept_spec (
        p_id          => c1.id
       ,p_register_id => c1.register_id
       ,p_emp_id      => c1.emp_id
       ,p_emp_post_id => c1.emp_post_id
       ,p_work_off    => c1.work_off
       ,p_milk_norm   => c1.milk_norm
       ,p_on_order    => c1.on_order
       ,p_received    => l_received
      );
    end loop c1;
  end set_received_as_ordered;

end PAGE32;
/
