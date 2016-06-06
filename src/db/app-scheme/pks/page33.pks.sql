create or replace package PAGE33 as

  procedure AddOrderToReport (
    pDeptRegisterId  in std.t_pk
   ,pEntRegisterId   in std.t_pk
  );


  function CreateEntRegister (
    pYear  in number
   ,pMonth in number
  ) return std.t_pk;


  procedure DeleteEntRegister (
    pId  in std.t_pk
  );


  procedure SendEntToAccounting (
    pId  in number
  );

end PAGE33;
/
