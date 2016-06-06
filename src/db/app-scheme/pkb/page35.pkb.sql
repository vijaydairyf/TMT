create or replace package body PAGE35 as

  function freport (
    p_register_id  in std.t_pk
  ) return std.t_text is
    l_result std.t_text;
    l_str std.t_text;
  begin
    for reg in (
      select * from my_milk where id = p_register_id
    ) loop
      l_str := null;
      l_str := l_str||'<table style="width:18cm;">';
      l_str := l_str||'<tr>';
      l_str := l_str||'<td style="font-weight:bold;font-size:16pt;text-align:center;">';
      l_str := l_str||'Ведомость на получение молока сотрудниками подразделения<br/>"'||reg.dept_name||'"</br>';
      l_str := l_str||'<font style="font-size:12pt;">за '||reg.register_month_name||' '||reg.register_year||' года</font>';
      l_str := l_str||'</td>';
      l_str := l_str||'</tr>';
      l_str := l_str||'<tr><td style="height:1cm"></td></tr>';
      l_str := l_str||'<tr><td>';
      l_str := l_str||'<table class="myReportTable">';
      l_str := l_str||'<colgroup>';
      l_str := l_str||'<col style="width:5mm;"/>';
      l_str := l_str||'<col style="width:40mm;"/>';
      l_str := l_str||'<col style="width:40mm;"/>';
      l_str := l_str||'<col style="width:10mm;"/>';
      l_str := l_str||'<col style="width:25mm;"/>';
      l_str := l_str||'<col style="width:25mm;"/>';
      l_str := l_str||'<col style="width:35mm;"/>';
      l_str := l_str||'</colgroup>';
      l_str := l_str||'<thead">';
      l_str := l_str||'<tr>';
      l_str := l_str||'<th>№</th>';
      l_str := l_str||'<th>Ф.И.О</th>';
      l_str := l_str||'<th>Должность</th>';
      l_str := l_str||'<th>Норма молока (литров)</th>';
      l_str := l_str||'<th>Кол-во фактически отработанных дней с учётом корректировки за предыдущий месяц</th>';
      l_str := l_str||'<th>Кол-во молока к выдаче с учётом корректировки за предыдущий месяц (литров)</th>';
      l_str := l_str||'<th>Подпись получающих молоко</th>';
      l_str := l_str||'</tr>';
      l_str := l_str||'</thead>';
      for spec in (
        select rownum as rno, emp_name, emp_post_name, milk_norm, work_off, on_order
          from (
            select emp_name, emp_post_name, milk_norm, work_off, on_order
              from milk_specs
             where register_id = reg.id
             order by emp_name
          )
      ) loop
        l_str := l_str||'<tr>';
        l_str := l_str||'<td class="number">'||spec.rno||'</td>';
        l_str := l_str||'<td class="text">'||spec.emp_name||'</td>';
        l_str := l_str||'<td class="text">'||spec.emp_post_name||'</td>';
        l_str := l_str||'<td class="number">'||to_char(spec.milk_norm,'990D9')||'</td>';
        l_str := l_str||'<td class="number">'||to_char(spec.work_off,'990D9')||'</td>';
        l_str := l_str||'<td class="number">'||to_char(spec.on_order,'990D9')||'</td>';
        l_str := l_str||'<td class="text"></td>';
        l_str := l_str||'</tr>';
      end loop;
      l_str := l_str||'</table>';
      l_str := l_str||'</td></tr>';
      l_str := l_str||'<tr><td style="height:1cm"></td></tr>';
      l_str := l_str||'<tr><td style="text-align:right;height:1cm">С табелем рабочего времени сверено _________________________</td></tr>';
      l_str := l_str||'<tr><td style="text-align:right;height:1cm">Зав _________________________ Дергачёва Е.В.</td></tr>';
      l_str := l_str||'<tr><td style="text-align:right;height:1cm">Ст.медсестра _________________________ Вараксина Е.В.</td></tr>';
      l_str := l_str||'</table>';
    end loop;
    --
--    l_result := l_str;
--    l_str := 'aaa <table style="width:18cm;">';
    return l_str;
  end;


  procedure preport (
    p_register_id  in std.t_pk
  ) is
  begin
    HTP.P(freport(p_register_id => p_register_id));
  end;

end PAGE35;
/
