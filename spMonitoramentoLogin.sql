USE [DBDataAdm]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMonitoramentoLogin]
    @UserLogin NVARCHAR(100) = NULL 
AS
BEGIN
    IF EXISTS (SELECT * FROM TEMPDB.dbo.sysobjects WHERE NAME IN ('##Users')) 
    BEGIN
        DROP TABLE ##Users
    END

    IF EXISTS (SELECT * FROM TEMPDB.dbo.sysobjects WHERE NAME IN (N'##ACESSO')) 
    BEGIN
        DROP TABLE ##ACESSO
    END

    CREATE TABLE ##Users (
        [sid] VARBINARY(100) NULL,
        [Login Name] VARCHAR(100) NULL
    )

    CREATE TABLE ##ACESSO (
        [uSER ID] VARCHAR(MAX), 
        [sERVER LOGIN] VARCHAR(MAX), 
        [DATABASE ROLE] VARCHAR(MAX), 
        [DATABASE] VARCHAR(MAX),
        [LoginDisabled] BIT 
    )

    DECLARE @DBName NVARCHAR(255)
    DECLARE db_cursor CURSOR FOR
    SELECT name FROM sys.databases --WHERE database_id > 4 
    
    OPEN db_cursor
    FETCH NEXT FROM db_cursor INTO @DBName

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @cmd1 NVARCHAR(MAX)
        SET @cmd1 = '
            INSERT INTO ##Users ([sid],[Login Name]) SELECT sid, loginname FROM master.dbo.syslogins;

            INSERT INTO ##ACESSO 
            SELECT 
                su.[name],
                u.[Login Name],
                sug.name,
                @DatabaseName,
                CASE WHEN sp.is_disabled = 1 THEN 1 ELSE 0 END -- Adicionando status de login desativado
            FROM 
                ' + QUOTENAME(@DBName) + '.dbo.sysusers su 
            LEFT OUTER JOIN 
                ##Users u ON su.sid = u.sid 
            LEFT OUTER JOIN 
                (' + QUOTENAME(@DBName) + '.dbo.sysmembers sm  
                INNER JOIN ' + QUOTENAME(@DBName) + '.dbo.sysusers sug ON sm.groupuid = sug.uid) ON su.uid = sm.memberuid  
            LEFT OUTER JOIN 
                master.sys.server_principals sp ON u.[Login Name] = sp.name
            WHERE 
                su.hasdbaccess = 1 
                AND (@UserLogin IS NULL OR (su.[name] != ''dbo'' AND u.[Login Name] = @UserLogin));
        '

      
        EXEC sp_executesql @cmd1, N'@UserLogin NVARCHAR(100), @DatabaseName NVARCHAR(255)', @UserLogin = @UserLogin, @DatabaseName = @DBName

        FETCH NEXT FROM db_cursor INTO @DBName
    END

    CLOSE db_cursor
    DEALLOCATE db_cursor

    SELECT 
        [uSER ID] AS Usuario, 
        [sERVER LOGIN] AS Login, 
        [DATABASE ROLE] AS FuncaoBancoDeDados, 
        [DATABASE] AS BancoDeDados, 
        [LoginDisabled] AS LoginDesabilitado
    FROM ##ACESSO 
    WHERE  [sERVER LOGIN] IS NOT NULL 
    GROUP BY 
        [uSER ID], [sERVER LOGIN], [DATABASE ROLE], [DATABASE], [LoginDisabled]
END