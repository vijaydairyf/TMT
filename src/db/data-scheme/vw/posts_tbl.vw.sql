Rem  Copyright (c) Apsida 2012-2016. All Rights Reserved.
Rem
Rem    DESCRIPTION
Rem      Виды дней.
Rem
Rem    MODIFIED   (YYMMDD)
Rem    appler      160516 - Created.

prompt ... creating view "POSTS_TBL"
create or replace view POSTS_TBL as
select
  p.rn           as id
 ,p.psdep_name   as name
  from prs_posts p
;
