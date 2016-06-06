create or replace package I_APPINFO as

  subtype t_info_value is varchar2(50);

  procedure set_application_info (
    p_module  in t_info_value
   ,p_action  in t_info_value
  );

  procedure push_application_info (
    p_module  in t_info_value
   ,p_action  in t_info_value
  );

  procedure pop_application_info;

end I_APPINFO;
/
