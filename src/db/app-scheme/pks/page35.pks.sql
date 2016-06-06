create or replace package PAGE35 as

  function freport (
    p_register_id  in std.t_pk
  ) return std.t_text;


  procedure preport (
    p_register_id  in std.t_pk
  );

end PAGE35;
/
