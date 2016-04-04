/******************************************************************************
 MySky2_DB.sql 
    - Updates site constants in MySkyServerDR5.
    - Changes the Internet User password.

YOU!! should edit the password string to be something hard to guess.
Right now the password is xxxxxxxx.

You should also update the website URL if you do not like the default.

This sql file is step 2 of DoubleClickToInstall.bat. 
Step1 (MySky1_DB.sql) installed the HTM code in Master and attached this database.
  
Running the script twice is not hazardous.

Based on : 2/7/2002 code of Cathan Cook: CathanC@microsoft.com
LastUpdate: 9/24/2003
By : Gray@microsoft.com
Last  Update: April/20/2005
by nieto@pha.jhu.edu

to cleanup
--EXEC sp_dropuser  'Internet'
--exec sp_dropalias 'Internet'
--EXEC sp_droplogin 'Internet'
--EXEC sp_droprole  'SkyServerUser'
*******************************************************************************/
SET NOCOUNT ON
USE MyBestDR5


DECLARE @defaultpasswd nvarchar(128)
SET @defaultpasswd= 'PW_PL' -- ****** CHANGE THIS!!!! 


PRINT N'************************************************************'
PRINT N'Running MySqky2_DB.sql'
PRINT N'************************************************************'
PRINT ''
PRINT 'Personalizing MySkyServerDR5 '
UPDATE MyBestDR5..SiteConstants 
SET    value  = 'http://localhost/MySkyServer' 
WHERE  [name] = 'WebServerURL'

IF @@rowcount = 1 
	PRINT 'Website URL constant updated to http://localhost/MySkyServer in table SiteConstants.'
ELSE
	PRINT 'Update of SiteConstants Website URL failed.'
/********************************************************************/
PRINT 'MyBestDR5 is personalized'
/********************************************************************/

/********************************************************************/
PRINT ''
PRINT 'Setting up SkyServer Security'
/********************************************************************/

/********************************************************************/
-- Add SkyServerUser role 
/********************************************************************/
IF NOT EXISTS (SELECT N'Role Exists' FROM master..sysusers WHERE name = N'SkyServerUser')
       BEGIN
	EXEC sp_addrole SkyServerUser 
 	PRINT 'Added SkyServerUser role'       
       END
/********************************************************************/
-- Add Internet login
/********************************************************************/
IF NOT EXISTS (SELECT N'Role Exists' FROM master..sysusers WHERE name = N'Internet')
	BEGIN
	  EXEC sp_addlogin 
                 @loginame  = Internet,
	    	 @passwd    = @defaultpasswd,	
	    	 @defdb     = MyBestDR5 	-- default database
	  PRINT 'Added Internet login' 	      
	END

IF @defaultpasswd = 'xxxxxxxx'
	BEGIN
          PRINT '******* WARNING *******'  
          PRINT ' * IF THIS LINE APPEARS, YOU OBVIOUSLY DID NOT CHANGE THE DEFAULT PASSWORD'
	  PRINT ' * You should edit MySky2_DB.SQL and CHANGE THE DEFAULT PASSWORD!!'
	  PRINT ' * Then, run again DoubleClickToInstall.bat!!'
	END
	
IF NOT EXISTS (SELECT N'User Exists' FROM master..syslogins WHERE name = N'Internet')
  BEGIN
	  EXEC sp_addlogin 
              @loginame  = Internet,
	      @passwd    = @defaultpasswd,	
	      @defdb     = MyBestDR5 	-- default database
	  PRINT 'Added Internet login' 	      
  END
ELSE
  BEGIN
         EXEC sp_password 
		 @old = NULL,
    		 @new = @defaultpasswd,
    		 @loginame = Internet 
         PRINT 'Changed Internet login password' 	      
  END

 
/********************************************************************/
-- Give to Internet user access to this database.
/********************************************************************/
EXEC sp_grantdbaccess Internet 
 
/********************************************************************/
-- Add Internet login to SkyServerUser role 
/********************************************************************/
EXEC sp_addrolemember SkyServerUser, Internet 
EXEC sp_addrolemember db_datareader, Internet 
EXEC sp_change_users_login N'UPDATE_ONE', N'Internet', N'Internet'


/********************************************************************/
-- Give the role access to the user-visible tables and functions. 
/********************************************************************/
exec  spGrantAccess 'U', 'SkyServerUser'  
PRINT ''
PRINT 'User read access granted to SkyServerUser role and to Internet user.'
PRINT ''

/********************************************************************/
PRINT ''
PRINT 'MyBestDR5 database attached and personalized.'
PRINT 'Success. '
PRINT '**************************************************************'


PRINT '-----------------------------------------------------'PRINT 'TEST YOUR INSTALLATION'
PRINT ''
PRINT 'Use:'   
PRINT '	-  SQL Server authentication'
PRINT '	-  User: Internet' 
PRINT '	-  Password:  xxxxxxxx or the one you have selected.'
PRINT '	-  Open File: TestInternetUserAccess.sql'
/********************************************************************/
