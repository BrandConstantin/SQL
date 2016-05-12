USE [EJEMPLOEMPRESA]
GO
/****** Object:  Table [dbo].[DEPARTAMENTO]    Script Date: 02/18/2015 17:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DEPARTAMENTO](
	[NUMDE] [int] NOT NULL,
	[NOMDE] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DEPARTAMENTO] PRIMARY KEY CLUSTERED 
(
	[NUMDE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[DEPARTAMENTO] ([NUMDE], [NOMDE]) VALUES (1, N'DEP1')
INSERT [dbo].[DEPARTAMENTO] ([NUMDE], [NOMDE]) VALUES (2, N'DEP2')
INSERT [dbo].[DEPARTAMENTO] ([NUMDE], [NOMDE]) VALUES (3, N'DEP3')
/****** Object:  Table [dbo].[EMPLEADO]    Script Date: 02/18/2015 17:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EMPLEADO](
	[NUMEM] [int] NOT NULL,
	[NOMEM] [varchar](50) NOT NULL,
	[NUMDE] [int] NULL,
 CONSTRAINT [PK_EMPLEADO] PRIMARY KEY CLUSTERED 
(
	[NUMEM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[EMPLEADO] ([NUMEM], [NOMEM], [NUMDE]) VALUES (1, N'EMP1', 1)
INSERT [dbo].[EMPLEADO] ([NUMEM], [NOMEM], [NUMDE]) VALUES (2, N'EMP2', 1)
INSERT [dbo].[EMPLEADO] ([NUMEM], [NOMEM], [NUMDE]) VALUES (3, N'EMP3', 1)
INSERT [dbo].[EMPLEADO] ([NUMEM], [NOMEM], [NUMDE]) VALUES (4, N'EMP4', 2)
INSERT [dbo].[EMPLEADO] ([NUMEM], [NOMEM], [NUMDE]) VALUES (5, N'EMP5', 2)
INSERT [dbo].[EMPLEADO] ([NUMEM], [NOMEM], [NUMDE]) VALUES (6, N'EMP6', 3)
/****** Object:  ForeignKey [FK_EMPLEADO_DEPARTAMENTO]    Script Date: 02/18/2015 17:00:49 ******/
ALTER TABLE [dbo].[EMPLEADO]  WITH CHECK ADD  CONSTRAINT [FK_EMPLEADO_DEPARTAMENTO] FOREIGN KEY([NUMDE])
REFERENCES [dbo].[DEPARTAMENTO] ([NUMDE])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[EMPLEADO] CHECK CONSTRAINT [FK_EMPLEADO_DEPARTAMENTO]
GO
