create or replace package I_DEPTS_PROPERTIES as

  subtype t_data is depts_properties_tbl%rowtype;

  function save (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.t_pk
   ,p_updated  in timestamp
   ,p_dept_id  in number
   ,p_curator_post    in varchar2
   ,p_curator_name    in varchar2
   ,p_manager_name    in varchar2
   ,p_milk_resp_name  in varchar2
  ) return std.t_ids;


  procedure remove (
    p_log_ctx  in out nocopy plogparam.log_ctx
   ,p_id  in std.t_pk
  );

end I_DEPTS_PROPERTIES;
/
