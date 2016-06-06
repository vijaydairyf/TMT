create or replace package body PAGE23 as

  procedure add_new_dept_register (
    p_dept_id       in number
   ,p_year          in number
   ,p_month         in number
  ) as
    l_id  std.t_pk;
  begin
    l_id := i_milk.create_dept_register (
      p_dept_id    => p_dept_id
     ,p_year       => p_year
     ,p_month      => p_month
    );
  end add_new_dept_register;

end PAGE23;
/
