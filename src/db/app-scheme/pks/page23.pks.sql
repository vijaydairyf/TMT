create or replace package PAGE23 as

  procedure add_new_dept_register (
    p_dept_id       in number
   ,p_year          in number
   ,p_month         in number
  );

end PAGE23;
/
