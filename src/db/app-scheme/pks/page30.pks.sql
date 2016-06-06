create or replace package PAGE30 as

  procedure add_emp_to_register (
    p_register_id  in std.t_pk
   ,p_emp_id  in std.t_pk
  );

end PAGE30;
/
