USE [DBDataAdm]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInserirDadosMonitoramentoUsuario] (
    @BancoDeDados varchar(50),
    @FuncaoBancoDeDados varchar(50),
    @Usuario varchar(50),
    @DataRevogarAcesso nvarchar(50),
    @Descricao varchar(100) = NULL
)
AS
BEGIN
    DECLARE @DataPermissao nvarchar(50) = FORMAT(GETDATE(), 'dd/MM/yyyy')
 

    -- Inserir os dados na tabela MonitoramentoUsuario
    INSERT INTO MonitoramentoUsuario (MUsuBancoDeDados, MUsuFuncaoBancoDeDados, MUsuUsuario, MUsuDataPermissao, MUsuDataRevogarAcesso, MUsuDescricao)
    VALUES (@BancoDeDados, @FuncaoBancoDeDados, @Usuario, @DataPermissao, @DataRevogarAcesso, @Descricao)
END


