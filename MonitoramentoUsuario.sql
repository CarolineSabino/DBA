USE [DBDataAdm]
GO

/****** Object:  Table [dbo].[MonitoramentoUsuario]    Script Date: 11/07/2024 14:55:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MonitoramentoUsuario](
	[MUsuBancoDeDados] [varchar](50) NOT NULL,
	[MUsuFuncaoBancoDeDados] [varchar](50) NOT NULL,
	[MUsuUsuario] [varchar](50) NOT NULL,
	[MUsuDataPermissao] [nvarchar](50) NOT NULL,
	[MUsuDataRevogarAcesso] [nvarchar](50) NOT NULL,
	[MUsuDescricao] [varchar](100) NULL
) ON [PRIMARY]
GO


