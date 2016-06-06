create or replace package body PAGE29 as

  procedure delete_dept_spec (
   p_spec_id  in number
  ) is
  begin
    i_milk.remove_dept_spec(p_id => p_spec_id);
  end delete_dept_spec;


  procedure check_dept_register_empty (
    p_register_id  in std.t_pk
  ) is
    l_cnt  pls_integer;
  begin
    select count(*)
      into l_cnt
      from milk_specs
     where register_id = p_register_id
    ;
    --
    if (l_cnt = 0) then
      i_milk.remove_dept_register(p_id => p_register_id);
    end if;
  end check_dept_register_empty;

end PAGE29;
/
