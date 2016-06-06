CREATE OR REPLACE PACKAGE BODY PLOG_INTERFACE AS
--*******************************************************************************
--   NAME:   PLOG_INTERFACE (body)
--
--   Interface between the main log package PLOG and the output packages.
--   This body is dynamically built during the installation. The log functions of the
--   output packages are called if the corresponding packages have been installed.
--
--   Ver    Date        Autor             Comment
--   -----  ----------  ----------------  ---------------------------------------
--   1.0    17.04.2008  Bertrand Caradec  First version
--*******************************************************************************


  PROCEDURE log
(
    pCTX        IN    OUT NOCOPY   PLOGPARAM.LOG_CTX           ,
    pID         IN        TLOG.id%TYPE                      ,
    pLDate      IN        TLOG.ldate%TYPE                   ,
    pLHSECS     IN        TLOG.lhsecs%TYPE                  ,
    pLLEVEL     IN        TLOG.llevel%TYPE                  ,
    pLSECTION   IN        TLOG.lsection%TYPE                ,
    pLUSER      IN        TLOG.luser%TYPE                   ,
    pLTEXT      IN        TLOG.LTEXT%TYPE
) AS
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
--   Public. Function created dynamically during the installation.
--   Calls the log functions of the packages that have been installed.
--
--   Ver    Date        Autor             Comment
--   -----  ----------  ---------------   ----------------------------------------
--   1.0    17.04.2008  Bertrand Caradec  Initial version
--*******************************************************************************
BEGIN

  PLOG_OUT_SESSION.log(pCTX, pID, pLDate, pLHSECS, pLLEVEL, pLSECTION, pLUSER, pLTEXT);

  PLOG_OUT_DBMS_OUTPUT.log(pCTX, pID, pLDate, pLHSECS, pLLEVEL, pLSECTION, pLUSER, pLTEXT);

  PLOG_OUT_ALERT.log(pCTX, pID, pLDate, pLHSECS, pLLEVEL, pLSECTION, pLUSER, pLTEXT);

  PLOG_OUT_TRACE.log(pCTX, pID, pLDate, pLHSECS, pLLEVEL, pLSECTION, pLUSER, pLTEXT);

  PLOG_OUT_TLOG.log(pCTX, pID, pLDate, pLHSECS, pLLEVEL, pLSECTION, pLUSER, pLTEXT);


END log;


 PROCEDURE purge
(
    pMaxDate IN DATE DEFAULT NULL
) AS
--******************************************************************************
--   NAME:   purge
--
--   PARAMETERS:
--
--      pMaxDate    Date before which records are deleted
--
--   Public. Function created dynamically during the installation.
--   Calls the purge functions of the packages that have been installed.
--
--   Ver    Date        Autor             Comment
--   -----  ----------  ---------------   --------------------------------------
--   1.0    17.04.2008  Bertrand Caradec  Initial version
--******************************************************************************
BEGIN

  PLOG_OUT_TLOG.purge(pMaxDate);


END purge;

END;
/