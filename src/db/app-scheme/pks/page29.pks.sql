create or replace package PAGE29 as

  procedure delete_dept_spec (
   p_spec_id  in number
  );


  procedure check_dept_register_empty (
    p_register_id  in std.t_pk
  );

end PAGE29;
/
