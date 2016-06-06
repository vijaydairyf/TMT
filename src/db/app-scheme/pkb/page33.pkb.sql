create or replace package body PAGE33 as

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


  function CreateEntRegister (
    pYear  in number
   ,pMonth in number
  ) return std.t_pk is
    l_result  std.t_pk := null;
  begin
    begin
      select id
        into l_result
        from milk_ent_registers
       where register_year = pYear
         and register_month = pMonth
      ;
    exception
      when no_data_found then
        l_result := null;
    end;
    --
    if (l_result is null) then
      l_result := i_milk.save_ent_register (
        p_id  => null
       ,p_year  => pYear
       ,p_month  => pMonth
       ,p_received  => 0
       ,p_received_from  => null
      );
      --
      for ord in (
        select id
          from all_milk_orders
         where register_year = pYear
           and register_month = pMonth
           and register_status >= 11
           and ent_register_id is null
      ) loop
        AddOrderToReport (
          pDeptRegisterId => ord.id
         ,pEntRegisterId  => l_result
        );
      end loop ord;
    end if;
    --
    return l_result;
  end CreateEntRegister;


  procedure SendEntToAccounting (
    pId  in number
  ) is
  begin
    i_milk.SendEntToAccounting(p_register_id => pId);
  end SendEntToAccounting;


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

end PAGE33;
/
