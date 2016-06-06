create or replace package PAGE31 as

  procedure save_data (
    p_id         in std.t_pk
   ,p_workoff    in number
   ,p_milk_norm  in number
  );

end PAGE31;
/
