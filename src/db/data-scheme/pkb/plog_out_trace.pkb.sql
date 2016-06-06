CREATE OR REPLACE PACKAGE BODY PLOG_OUT_TRACE AS

--*******************************************************************************
--   NAME:   PLOG_OUT_TRACE (body)
--
--   writes the log information into the file ora.trc trough the public procedure log()
--
--   Ver    Date        Autor             Comment
--   -----  ----------  ----------------  ---------------------------------------
--   1.0    14.04.2008  Bertrand Caradec  First version
--*******************************************************************************

  PROCEDURE log
(
    pCTX        IN       PLOGPARAM.LOG_CTX                     ,
    pID         IN       TLOG.id%TYPE                      ,
    pLDate      IN       TLOG.ldate%TYPE                   ,
    pLHSECS     IN       TLOG.lhsecs%TYPE                  ,
    pLLEVEL     IN       TLOG.llevel%TYPE                  ,
    pLSECTION   IN       TLOG.lsection%TYPE                ,
    pLUSER      IN       TLOG.luser%TYPE                   ,
    pLTEXT      IN       TLOG.LTEXT%TYPE
)
--*******************************************************************************
--   NAME:   log
--
--   PARAMETERS:
--
--      pCTX               log context
--      pID                ID of the log message, generated by the sequence
--      pLDate             Date of the log message (SYSDATE)
--      pLHSECS            Number of seconds since the beginning of the epoch
--      pLLEVEL            Log level as numeric value
--      pLSection          formated call stack
--      pLUSER             database user (SYSUSER)
--      pLTEXT             log text
--
--   Public. Add the log information into the ora.trc file.
--
--   Ver    Date        Autor             Comment
--   -----  ----------  ---------------   ----------------------------------------
--   1.0    14.04.2008  Bertrand Caradec  Initial version
--*******************************************************************************

AS
BEGIN
    IF pCTX.USE_TRACE = TRUE THEN
        sys.dbms_system.ksdwrt(1,'PLOG:'||TO_CHAR(pLDATE, 'YYYY-MM-DD HH24:MI:SS')||':'||
        LTRIM(TO_CHAR(MOD(pLHSECS,100),'09'))||
        ' user: '||PLUSER||' level: '||PLOGPARAM.getLevelInText(pLLEVEL)||
        ' logid: '||pID ||' '||pLSECTION);

        sys.dbms_system.ksdwrt(1,substr(pLTEXT,0,1000));


        IF LENGTH(pLTEXT) >= 1000 THEN
          sys.dbms_system.ksdwrt(1,SUBSTR(pLTEXT,1000));
        END IF;
    END IF;
END log;

-- end of the package
END;
/
