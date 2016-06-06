create or replace package body PAGE24 as

  procedure delete_dept_register (
    p_id  in number
  ) is
  begin
    i_milk.remove_dept_register (
      p_id => p_id
    );
  end delete_dept_register;


  procedure send_order (
    p_register_id  in number
  ) is
  begin
    i_milk.send_order (
      p_register_id => p_register_id
    );
  end send_order;


  procedure recall_order (
    p_register_id  in number
  ) is
  begin
    i_milk.recall_order (
      p_register_id => p_register_id
    );
  end recall_order;


  procedure SendToAccounting (
    p_register_id  in number
  ) is
  begin
    i_milk.SendDeptToAccounting(p_register_id => p_register_id);
  end SendToAccounting;


  procedure RemoveFromAccounting (
    p_register_id  in number
  ) is
  begin
    i_milk.RemoveDeptFromAccounting(p_register_id => p_register_id);
  end RemoveFromAccounting;

end PAGE24;
/
