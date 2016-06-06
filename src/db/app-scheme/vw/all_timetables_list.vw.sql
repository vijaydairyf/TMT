Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem       Список всех табелей.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "ALL_TIMETABLES_LIST"
create or replace view ALL_TIMETABLES_LIST as
select
     tmt.main_id       as main_id      -- первичные табели
    ,tmt.corr_id       as corr_id      -- первичные табели
    ,tmt.company_id    as company_id   -- идентификатор организации в Парус
    ,tmt.dept_id       as dept_id      -- идентификатор подразделения в Парус
    ,d.name            as dept_name    -- наименование подразделения в Парус
    ,tmt.table_year    as table_year   -- за который год табель
    ,tmt.table_month   as table_month  -- за который месяц табель, номер
    ,utils.month_name(tmt.table_month)  as table_month_name  -- за который месяц табель, наименование
    ,tmt.submitted     as submitted    -- когда табель передан в расчётную часть
    ,tmt.accepted      as accepted     -- когда табель принят для расчёта
  from (
        select t.id            as main_id        -- первичные табели
              ,null            as corr_id        -- корректировочный табели
              ,t.company_id    as company_id     -- идентификатор организации в Парус
              ,t.dept_id       as dept_id        -- идентификатор подразделения в Парус
              ,t.table_year    as table_year     -- за который год табель
              ,t.table_month   as table_month    -- за который месяц табель, номер
              ,t.submitted     as submitted      -- когда табель передан в расчётную часть
              ,t.accepted      as accepted       -- когда табель принят для расчёта
          from timetables_tbl t
         where t.table_type = 0   -- первичные
        union all
        select null            as main_id        -- первичные табели
              ,t.id            as corr_id        -- корректировочный табели
              ,t.company_id    as company_id     -- идентификатор организации в Парус
              ,t.dept_id       as dept_id        -- идентификатор подразделения в Парус
              ,t.table_year    as table_year     -- за который год табель
              ,t.table_month   as table_month    -- за который месяц табель, номер
              ,null            as submitted      -- когда табель передан в расчётную часть
              ,null            as accepted       -- когда табель принят для расчёта
          from timetables_tbl t
         where t.table_type = 1   -- корректировочные
        ) tmt, departments_tbl d
 where tmt.dept_id = d.id
   and tmt.company_id in (select ud.company_id from users_depts ud where ud.username = V('APP_USER'))
;
