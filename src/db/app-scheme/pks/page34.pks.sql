create or replace package PAGE34 as

  function save_report (
    p_id             in std.t_pk
   ,p_year           in number
   ,p_month          in number
   ,p_received       in number
   ,p_received_from  in varchar2
  ) return std.t_pk;


  procedure give_out_milk_to_dept (
    p_dpt_register_id  in std.t_pk
   ,p_given_out  in number
  );


  procedure DeleteEntRegister (
    pId  in std.t_pk
  );


  procedure AddOrderToReport (
    pDeptRegisterId  in std.t_pk
   ,pEntRegisterId   in std.t_pk
  );


  procedure RemoveOrderFromReport (
    pDeptRegisterId   in std.t_pk
  );


  procedure RemoveEntFromAccounting (
    pId  in number
  );

end PAGE34;
/
