-- Monitor de Licenças Consumidas
USE MASTER

IF object_id (N'tempdb..#tmpPHC_Lic') IS NOT NULL
    BEGIN
        DROP TABLE #tmpPHC_Lic
    END

GO

CREATE TABLE #tmpPHC_Lic
    (
      SPID CHAR (5)
    , Status NVARCHAR (30)
    , Login NVARCHAR (50)
    , HostName NVARCHAR (24)
    , BlkBy VARCHAR (5)
    , DBName NVARCHAR (24)
    , Command NVARCHAR (26)
    , CPUTime VARCHAR (6)
    , DiskIO VARCHAR (6)
    , LastBatch VARCHAR (14)
    , ProgramName NVARCHAR (58)
    , SPID2 CHAR (5)
    , REQUESTID CHAR (5)
    )

INSERT INTO #tmpPHC_Lic
EXEC sp_who2
SELECT row_number () OVER (ORDER BY SPID DESC) AS LicNumber
    , login
    , hostname
    , dbname
FROM #tmpPHC_Lic
WHERE dbname IN
-- verificar todas as bases de dados que contêm tabela fi2 
    (SELECT [name] AS [database_name]
     FROM sys.databases
     WHERE CASE
               WHEN state_desc = 'ONLINE' THEN object_id (quotename ([name]) + '.[dbo].[fi2]', 'U')
           END IS NOT NULL)
    AND ProgramName = ''
ORDER BY LicNumber ASC
-- Cleanup
    DROP TABLE #tmpPHC_Lic