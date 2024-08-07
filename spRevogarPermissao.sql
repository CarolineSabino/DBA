USE [DBDataAdm]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRevogarPermissao]
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM MonitoramentoUsuario
        WHERE CONVERT(DATE, MUsuDataRevogarAcesso, 103) = CONVERT(DATE, GETDATE(), 103)
    )
    BEGIN
        
             EXEC msdb.dbo.sp_send_dbmail
         @profile_name = 'MSSQLSERVER',
         @recipients = 'EmailDestinatario',
         @subject = 'Revogar permissão - Instancia',
         @body = 'Há permissão em Instancia.Banco.dbo.MonitoramentoUsuario para ser revogada na data de hoje',
         @body_format = 'TEXT'; 

	END
END
