create or replace package PAGE24 as

  procedure delete_dept_register (
    p_id  in number
  );


  procedure send_order (
    p_register_id  in number
  );


  procedure recall_order (
    p_register_id  in number
  );


  procedure SendToAccounting (
    p_register_id  in number
  );


  procedure RemoveFromAccounting (
    p_register_id  in number
  );

end PAGE24;
/
