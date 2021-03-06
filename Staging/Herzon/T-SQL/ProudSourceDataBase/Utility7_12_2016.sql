USE [master]
GO
/****** Object:  Database [Utility]    Script Date: 7/12/2016 2:34:54 PM ******/
CREATE DATABASE [Utility]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Utility', FILENAME = N'D:\RDSDBDATA\DATA\Utility.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'Utility_log', FILENAME = N'D:\RDSDBDATA\DATA\Utility_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Utility] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Utility].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Utility] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Utility] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Utility] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Utility] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Utility] SET ARITHABORT OFF 
GO
ALTER DATABASE [Utility] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Utility] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Utility] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Utility] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Utility] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Utility] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Utility] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Utility] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Utility] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Utility] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Utility] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Utility] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Utility] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Utility] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Utility] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Utility] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Utility] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Utility] SET RECOVERY FULL 
GO
ALTER DATABASE [Utility] SET  MULTI_USER 
GO
ALTER DATABASE [Utility] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Utility] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Utility] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Utility] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Utility] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Utility]
GO
/****** Object:  User [PSSqlDeveloper]    Script Date: 7/12/2016 2:34:55 PM ******/
CREATE USER [PSSqlDeveloper] FOR LOGIN [PSSqlDeveloper] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [PSSqlDeveloper]
GO
/****** Object:  Table [dbo].[StoredProcedure_Logs]    Script Date: 7/12/2016 2:34:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StoredProcedure_Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DataBase_Id] [int] NULL,
	[Object_Id] [int] NULL,
	[LogDate] [datetime] NOT NULL,
	[ProcedureName] [nvarchar](400) NULL,
	[ErrorLine] [nvarchar](max) NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[UserName] [nvarchar](400) NULL,
	[HostName] [nvarchar](4000) NULL,
	[ApplicationName] [nvarchar](400) NULL,
	[IP_Address] [varchar](100) NULL,
	[SPID] [int] NULL,
	[Additional_Info] [nvarchar](max) NULL,
 CONSTRAINT [PK_StoredProcedure_Logs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[StoredProcedure_Logs] ADD  CONSTRAINT [DF_StoredProcedure_Logs_LogDate]  DEFAULT (getdate()) FOR [LogDate]
GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 7/12/2016 2:34:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [rds_deny_backups_trigger] ON DATABASE WITH EXECUTE AS 'dbo' FOR
 ADD_ROLE_MEMBER, GRANT_DATABASE AS BEGIN
   SET NOCOUNT ON;
   SET ANSI_PADDING ON;
 
   DECLARE @data xml;
   DECLARE @user sysname;
   DECLARE @role sysname;
   DECLARE @type sysname;
   DECLARE @sql NVARCHAR(MAX);
   DECLARE @permissions TABLE(name sysname PRIMARY KEY);
   
   SELECT @data = EVENTDATA();
   SELECT @type = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'sysname');
    
   IF @type = 'ADD_ROLE_MEMBER' BEGIN
      SELECT @user = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'),
       @role = @data.value('(/EVENT_INSTANCE/RoleName)[1]', 'sysname');

      IF @role IN ('db_owner', 'db_backupoperator') BEGIN
         SELECT @sql = 'DENY BACKUP DATABASE, BACKUP LOG TO ' + QUOTENAME(@user);
         EXEC(@sql);
      END
   END ELSE IF @type = 'GRANT_DATABASE' BEGIN
      INSERT INTO @permissions(name)
      SELECT Permission.value('(text())[1]', 'sysname') FROM
       @data.nodes('/EVENT_INSTANCE/Permissions/Permission')
      AS DatabasePermissions(Permission);
      
      IF EXISTS (SELECT * FROM @permissions WHERE name IN ('BACKUP DATABASE',
       'BACKUP LOG'))
         RAISERROR('Cannot grant backup database or backup log', 15, 1) WITH LOG;       
   END
END


GO
ENABLE TRIGGER [rds_deny_backups_trigger] ON DATABASE
GO
USE [master]
GO
ALTER DATABASE [Utility] SET  READ_WRITE 
GO
