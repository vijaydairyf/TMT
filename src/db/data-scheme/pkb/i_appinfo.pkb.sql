create or replace package body I_APPINFO as

  type t_stack is table of t_info_value;

  g_modules_stack t_stack := t_stack();
  g_actions_stack t_stack := t_stack();


  procedure push (
    p_stack  in out t_stack
   ,p_value  in t_info_value
  )
  is
  begin
    p_stack.extend;
    p_stack(p_stack.last) := p_value;
  end;


  function pop (
    p_stack  in out t_stack
  )
  return t_info_value
  is
    l_result t_info_value := null;
    l_ndx integer := null;
  begin
    p_stack.trim;
    l_ndx := p_stack.last;
    if (l_ndx is not null) then
      l_result := p_stack(l_ndx);
    else
      l_result := null;
    end if;
    return l_result;
  end;


  procedure set_application_info (
    p_module  in t_info_value
   ,p_action  in t_info_value
  )
  is
  begin
    dbms_application_info.set_module (
      module_name => p_module
     ,action_name => p_action
    );
  end set_application_info;


  procedure push_application_info (
    p_module  in t_info_value
   ,p_action  in t_info_value
  )
  is
  begin
    push (
      p_stack => g_modules_stack
     ,p_value => p_module
    );
    push (
      p_stack => g_actions_stack
     ,p_value => p_action
    );
    set_application_info (
      p_module => p_module
     ,p_action => p_action
    );
  end push_application_info;


  procedure pop_application_info
  is
    l_module t_info_value := null;
    l_action t_info_value := null;
  begin
    l_module := pop(p_stack => g_modules_stack);
    l_action := pop(p_stack => g_actions_stack);

    set_application_info (
      p_module => l_module
     ,p_action => l_action
    );
  end;

END I_APPINFO;
/
