create or replace package PAGE32 as

  procedure save_order (
    p_id         in std.t_pk
   ,p_workoff    in number
   ,p_milk_norm  in number
  );


  procedure save_register (
    p_id        in std.t_pk
   ,p_workoff    in number
   ,p_milk_norm  in number
   ,p_give_out  in number
  );


  procedure corr_register (
    p_id         in std.t_pk
   ,p_workoff    in number
   ,p_milk_norm  in number
  );


  procedure set_received_as_ordered (
    p_register_id  in std.t_pk
  );

end PAGE32;
/
