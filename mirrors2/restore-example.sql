-- Use the first command to get a list of files in the DB.  Change the
-- path of the first backup file as needed.
RESTORE FILELISTONLY FROM DISK = 'x:\somedir\BestDR7.backup.01'

-- Use this command to actually restore the DB, change the file paths
-- in the "WITH" to the path that you want to copy them to.
RESTORE DATABASE BESTDR7 FROM
	DISK = 'x:\backupdir\BESTDR7.backup.01',
	DISK = 'x:\backupdir\BESTDR7.backup.02',
	DISK = 'x:\backupdir\BESTDR7.backup.03',
	DISK = 'x:\backupdir\BESTDR7.backup.04',
	DISK = 'x:\backupdir\BESTDR7.backup.05',
	DISK = 'x:\backupdir\BESTDR7.backup.06',
	DISK = 'x:\backupdir\BESTDR7.backup.07',
	DISK = 'x:\backupdir\BESTDR7.backup.08',
	DISK = 'x:\backupdir\BESTDR7.backup.09',
	DISK = 'x:\backupdir\BESTDR7.backup.10',
	DISK = 'x:\backupdir\BESTDR7.backup.11',
	DISK = 'x:\backupdir\BESTDR7.backup.12',
	DISK = 'x:\backupdir\BESTDR7.backup.13',
	DISK = 'x:\backupdir\BESTDR7.backup.14',
	DISK = 'x:\backupdir\BESTDR7.backup.15',
	DISK = 'x:\backupdir\BESTDR7.backup.16',
	DISK = 'x:\backupdir\BESTDR7.backup.17',
	DISK = 'x:\backupdir\BESTDR7.backup.18',
	DISK = 'x:\backupdir\BESTDR7.backup.19',
	DISK = 'x:\backupdir\BESTDR7.backup.20',
	DISK = 'x:\backupdir\BESTDR7.backup.21',
	DISK = 'x:\backupdir\BESTDR7.backup.22',
	DISK = 'x:\backupdir\BESTDR7.backup.23',
	DISK = 'x:\backupdir\BESTDR7.backup.24',
	DISK = 'x:\backupdir\BESTDR7.backup.25',
	DISK = 'x:\backupdir\BESTDR7.backup.26',
	DISK = 'x:\backupdir\BESTDR7.backup.27',
	DISK = 'x:\backupdir\BESTDR7.backup.28',
	DISK = 'x:\backupdir\BESTDR7.backup.29',
	DISK = 'x:\backupdir\BESTDR7.backup.30',
	DISK = 'x:\backupdir\BESTDR7.backup.31',
	DISK = 'x:\backupdir\BESTDR7.backup.32',
	DISK = 'x:\backupdir\BESTDR7.backup.33',
	DISK = 'x:\backupdir\BESTDR7.backup.34',
	DISK = 'x:\backupdir\BESTDR7.backup.35',
	DISK = 'x:\backupdir\BESTDR7.backup.36',
	DISK = 'x:\backupdir\BESTDR7.backup.37',
	DISK = 'x:\backupdir\BESTDR7.backup.38',
	DISK = 'x:\backupdir\BESTDR7.backup.39',
	DISK = 'x:\backupdir\BESTDR7.backup.40',
	DISK = 'x:\backupdir\BESTDR7.backup.41',
	DISK = 'x:\backupdir\BESTDR7.backup.42',
	DISK = 'x:\backupdir\BESTDR7.backup.43',
	DISK = 'x:\backupdir\BESTDR7.backup.44',
	DISK = 'x:\backupdir\BESTDR7.backup.45',
	DISK = 'x:\backupdir\BESTDR7.backup.46',
	DISK = 'x:\backupdir\BESTDR7.backup.47',
	DISK = 'x:\backupdir\BESTDR7.backup.48',
	DISK = 'x:\backupdir\BESTDR7.backup.49',
	DISK = 'x:\backupdir\BESTDR7.backup.50',
	DISK = 'x:\backupdir\BESTDR7.backup.51',
	DISK = 'x:\backupdir\BESTDR7.backup.52',
	DISK = 'x:\backupdir\BESTDR7.backup.53',
	DISK = 'x:\backupdir\BESTDR7.backup.54',
	DISK = 'x:\backupdir\BESTDR7.backup.55',
	DISK = 'x:\backupdir\BESTDR7.backup.56',
	DISK = 'x:\backupdir\BESTDR7.backup.57',
	DISK = 'x:\backupdir\BESTDR7.backup.58',
	DISK = 'x:\backupdir\BESTDR7.backup.59',
	DISK = 'x:\backupdir\BESTDR7.backup.60'
   WITH
	MOVE 'BESTDR2_Data' to 'x:\somedir\BESTDR7_Data.MDF',
	MOVE 'BESTDR2_Log' to 'y:\somedir\BESTDR7_Log.LDF'
-- Note that the DR2 file names above are correct, since this is
-- a database originally created for DR2 and incrementally
-- loaded since then.

