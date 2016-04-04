/******************************************************************************
 MySky1_DB.sql
    - Copies HTM code to SQL binn directory.
    - Installs the HTM extended stored procedures and grants public access to them.
    - Attaches MyBestDR5 database. 

This sql file is step 1 of DoubleClickToInstall.bat
Step2 (MySky2_DB.sql) personalizes the database.
  
Running the script twice is not hazardous.

Based on : 2/7/2002 code of Cathan Cook: CathanC@microsoft.com
LastUpdate: 9/24/2003
By : Gray@microsoft.com
Last  Update: April/20/2005
by nieto@pha.jhu.edu
*******************************************************************************/
SET NOCOUNT ON
USE MASTER

PRINT N'************************************************************'
PRINT N'Running MySqky1_DB.sql'
PRINT N'************************************************************'


/******************************************************************************/
--   Copy HTM DLL to SQL Binn directory and grant public access to entry points          
/******************************************************************************/


PRINT ''
PRINT N'Installing HTM2 extended procedures'
/********************************************************************/
IF exists (SELECT * FROM master.dbo.sysobjects WHERE NAME = N'xp_HTM_Cover')
	BEGIN
	exec sp_dropextendedproc N'[dbo].[xp_HTM2_Lookup]'
        exec sp_dropextendedproc N'[dbo].[xp_HTM2_Cover]'
        exec sp_dropextendedproc N'[dbo].[xp_HTM2_toNormalForm]'
	exec sp_dropextendedproc N'[dbo].[xp_HTM2_toPoint]'
	exec sp_dropextendedproc N'[dbo].[xp_HTM2_toVertices]'
	exec sp_dropextendedproc N'[dbo].[xp_HTM2_Version]'
	DBCC Htm_V2 (FREE) WITH NO_INFOMSGS
	END
/********************************************************************/
PRINT ''
PRINT N'Copying DLL to SQL Server BINN directory'
/********************************************************************/
EXEC master..xp_cmdshell 'copy INST_ROOT\MySkyServerDB\HTM_v2_R56\htm_v2.dll "MS_SS_ROOT\Binn\" /y', no_output


/********************************************************************/
PRINT ''
PRINT N'Adding HTM stored procedures to master database and granting public access.'
/********************************************************************/
EXEC sp_addextendedproc N'xp_HTM2_Lookup',       N'Htm_V2.dll'
EXEC sp_addextendedproc N'xp_HTM2_Cover',        N'Htm_V2.dll'
EXEC sp_addextendedproc N'xp_HTM2_toNormalForm', N'Htm_V2.dll' 
EXEC sp_addextendedproc N'xp_HTM2_toPoint',      N'Htm_V2.dll' 
EXEC sp_addextendedproc N'xp_HTM2_toVertices',   N'Htm_V2.dll' 
EXEC sp_addextendedproc N'xp_HTM2_Version',      N'Htm_V2.dll' 
GRANT EXECUTE ON xp_HTM2_Lookup       TO PUBLIC
GRANT EXECUTE ON xp_HTM2_Cover        TO PUBLIC
GRANT EXECUTE ON xp_HTM2_Cover        TO PUBLIC
GRANT EXECUTE ON xp_HTM2_toNormalForm TO PUBLIC
GRANT EXECUTE ON xp_HTM2_toPoint      TO PUBLIC
GRANT EXECUTE ON xp_HTM2_toVertices   TO PUBLIC
GRANT EXECUTE ON xp_HTM2_Version      TO PUBLIC
/********************************************************************/
PRINT N'HTM code installed in SQL.'
/********************************************************************/


/******************************************************************************/
--   ATTACH           
/******************************************************************************/
PRINT ''
PRINT 'Attaching Best SDSS database.'
DECLARE @DBname NVARCHAR(1000), @dataFile NVARCHAR(1000), @logFile NVARCHAR(1000)

DECLARE @Path nVarChar(2000)
SET @Path = N'INST_ROOT\MySkyServerDB'

SET     @DBname = N'MyBestDR5' --this needs updating to something none drx specific
SET     @dataFile = @Path + N'\' + @DBname + '_Data.MDF'

--Attach the database files, if not already attached.
IF NOT EXISTS (SELECT [name] FROM master..sysdatabases where name = @DBname)
   BEGIN
	EXEC sp_attach_db  @DBname, @dataFile
   END
-- Test and report status.
IF NOT EXISTS(SELECT [name] FROM master..sysdatabases where name = @DBname)
   BEGIN
        PRINT @DBname + N' failed to attach correctly.  Please alter script and try again.'
        PRINT N'Unable to continue script without errors.'
   END
ELSE
   BEGIN
        PRINT @DBname + N' Status ATTTACHED and ' + CAST(DATABASEPROPERTYEX(@DBname,N'Status') AS NVARCHAR(15) ) 
	PRINT ''
   END
