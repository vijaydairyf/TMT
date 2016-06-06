create or replace package PAGE28 as

  procedure add_new_data (
    p_log_level  in number
   ,p_spec_id    in varchar2
   ,p_days       in number
   ,p_date       in date
  );


  procedure delete_data (
    p_log_level  in number
   ,p_id  in varchar2
  );

end PAGE28;
/
