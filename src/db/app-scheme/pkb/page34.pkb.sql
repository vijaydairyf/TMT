create or replace package body PAGE34 as

  function save_report (
    p_id             in std.t_pk
   ,p_year           in number
   ,p_month          in number
   ,p_received       in number
   ,p_received_from  in varchar2
  ) return std.t_pk is
    l_result std.t_pk;
  begin
    l_result := i_milk.save_ent_register (
      p_id  => p_id
     ,p_year  => p_year
     ,p_month  => p_month
     ,p_received  => p_received
     ,p_received_from  => p_received_from
    );
    --
    return l_result;
  end save_report;


  procedure give_out_milk_to_dept (
    p_dpt_register_id  in std.t_pk
   ,p_given_out  in number
  ) is
    l_id  std.t_pk;
  begin
    for c1 in (
      select *
        from milk_dept_register_tbl m
       where id = p_dpt_register_id
    ) loop
      l_id := i_milk.save_dept_register (
        p_id       => c1.id
       ,p_dept_id  => c1.dept_id
       ,p_year     => c1.register_year
       ,p_month    => c1.register_month
       ,p_received => p_given_out
      );
    end loop c1;
  end give_out_milk_to_dept;


  procedure AddOrderToReport (
    pDeptRegisterId  in std.t_pk
   ,pEntRegisterId   in std.t_pk
  ) is
  begin
    i_milk.AddDeptToEntRegister (
      pDeptRegisterId  => pDeptRegisterId
     ,pEntRegisterId   => pEntRegisterId
    );
  end AddOrderToReport;


  procedure RemoveOrderFromReport (
    pDeptRegisterId   in std.t_pk
  ) is
  begin
    i_milk.RemoveDeptFromEntRegister (
      pDeptRegisterId  => pDeptRegisterId
    );
  end RemoveOrderFromReport;


  procedure DeleteEntRegister (
    pId  in std.t_pk
  ) is
  begin
    for ord in (
      select *
        from milk_dept_register_tbl
       where ent_register_id = pId
    ) loop
      RemoveOrderFromReport (
        pDeptRegisterId  => ord.id
      );
    end loop ord;
    --
    i_milk.remove_ent_register (
      p_id  => pId
    );
  end DeleteEntRegister;


  procedure RemoveEntFromAccounting (
    pId  in number
  ) is
  begin
    i_milk.RemoveEntFromAccounting(p_register_id => pId);
  end RemoveEntFromAccounting;

end PAGE34;
/
