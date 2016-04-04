-- Use the first command to get a list of files in the DB.  Change the
-- path of the first backup file as needed, by replacing 
-- "\\backup_source_dir" with your actual local path.
RESTORE FILELISTONLY FROM DISK = '\\backup_source_dir\BestDR12.bak.01'

-- Use this command to actually restore the DB, change the file paths
-- in the "FROM" and "WITH" sections to the actual paths that you want to
-- copy them from and to, respectively.  Note that there are 8 data files
-- amd 4 log files.  Their sizes are indicated for convenience in the 
-- comments.  For best performance, each of these files should be on a
-- different disk drive/partition. 
RESTORE DATABASE BESTDR12 FROM
	DISK = '\\backup_source_dir\BESTDR12.bak.01',
	DISK = '\\backup_source_dir\BESTDR12.bak.02',
	DISK = '\\backup_source_dir\BESTDR12.bak.03',
	DISK = '\\backup_source_dir\BESTDR12.bak.04',
	DISK = '\\backup_source_dir\BESTDR12.bak.05',
	DISK = '\\backup_source_dir\BESTDR12.bak.06',
	DISK = '\\backup_source_dir\BESTDR12.bak.07',
	DISK = '\\backup_source_dir\BESTDR12.bak.08',
	DISK = '\\backup_source_dir\BESTDR12.bak.09',
	DISK = '\\backup_source_dir\BESTDR12.bak.10',
	DISK = '\\backup_source_dir\BESTDR12.bak.11',
	DISK = '\\backup_source_dir\BESTDR12.bak.12',
	DISK = '\\backup_source_dir\BESTDR12.bak.13',
	DISK = '\\backup_source_dir\BESTDR12.bak.14',
	DISK = '\\backup_source_dir\BESTDR12.bak.15',
	DISK = '\\backup_source_dir\BESTDR12.bak.16',
	DISK = '\\backup_source_dir\BESTDR12.bak.17',
	DISK = '\\backup_source_dir\BESTDR12.bak.18',
	DISK = '\\backup_source_dir\BESTDR12.bak.19',
	DISK = '\\backup_source_dir\BESTDR12.bak.20',
	DISK = '\\backup_source_dir\BESTDR12.bak.21',
	DISK = '\\backup_source_dir\BESTDR12.bak.22',
	DISK = '\\backup_source_dir\BESTDR12.bak.23',
	DISK = '\\backup_source_dir\BESTDR12.bak.24',
	DISK = '\\backup_source_dir\BESTDR12.bak.25',
	DISK = '\\backup_source_dir\BESTDR12.bak.26',
	DISK = '\\backup_source_dir\BESTDR12.bak.27',
	DISK = '\\backup_source_dir\BESTDR12.bak.28',
	DISK = '\\backup_source_dir\BESTDR12.bak.29',
	DISK = '\\backup_source_dir\BESTDR12.bak.30',
	DISK = '\\backup_source_dir\BESTDR12.bak.31',
	DISK = '\\backup_source_dir\BESTDR12.bak.32',
	DISK = '\\backup_source_dir\BESTDR12.bak.33',
	DISK = '\\backup_source_dir\BESTDR12.bak.34',
	DISK = '\\backup_source_dir\BESTDR12.bak.35',
	DISK = '\\backup_source_dir\BESTDR12.bak.36',
	DISK = '\\backup_source_dir\BESTDR12.bak.37',
	DISK = '\\backup_source_dir\BESTDR12.bak.38',
	DISK = '\\backup_source_dir\BESTDR12.bak.39',
	DISK = '\\backup_source_dir\BESTDR12.bak.40',
	DISK = '\\backup_source_dir\BESTDR12.bak.41',
	DISK = '\\backup_source_dir\BESTDR12.bak.42',
	DISK = '\\backup_source_dir\BESTDR12.bak.43',
	DISK = '\\backup_source_dir\BESTDR12.bak.44',
	DISK = '\\backup_source_dir\BESTDR12.bak.45',
	DISK = '\\backup_source_dir\BESTDR12.bak.46',
	DISK = '\\backup_source_dir\BESTDR12.bak.47',
	DISK = '\\backup_source_dir\BESTDR12.bak.48',
	DISK = '\\backup_source_dir\BESTDR12.bak.49',
	DISK = '\\backup_source_dir\BESTDR12.bak.50',
	DISK = '\\backup_source_dir\BESTDR12.bak.51',
	DISK = '\\backup_source_dir\BESTDR12.bak.52',
	DISK = '\\backup_source_dir\BESTDR12.bak.53',
	DISK = '\\backup_source_dir\BESTDR12.bak.54',
	DISK = '\\backup_source_dir\BESTDR12.bak.55',
	DISK = '\\backup_source_dir\BESTDR12.bak.56',
	DISK = '\\backup_source_dir\BESTDR12.bak.57',
	DISK = '\\backup_source_dir\BESTDR12.bak.58',
	DISK = '\\backup_source_dir\BESTDR12.bak.59',
	DISK = '\\backup_source_dir\BESTDR12.bak.60',
	DISK = '\\backup_source_dir\BESTDR12.bak.61',
	DISK = '\\backup_source_dir\BESTDR12.bak.62',
	DISK = '\\backup_source_dir\BESTDR12.bak.63',
	DISK = '\\backup_source_dir\BESTDR12.bak.64'
WITH   -- Note: the BestDR8 in the names below is correct since data is loaded incrementally since DR8.
	MOVE 'BESTDR8_Data1' TO 'c:\destination_dir\BESTDR8_Data1.mdf', --1.7TB
	MOVE 'BESTDR8_Data2' TO 'c:\destination_dir\BESTDR8_Data1.ndf', --1.1TB
	MOVE 'BESTDR8_Data3' TO 'c:\destination_dir\BESTDR8_Data1.ndf', --1.1TB
	MOVE 'BESTDR8_Data4' TO 'c:\destination_dir\BESTDR8_Data1.ndf', --1.1TB
	MOVE 'BESTDR8_Data5' TO 'c:\destination_dir\BESTDR8_Data1.ndf', --1.1TB
	MOVE 'BESTDR8_Data6' TO 'c:\destination_dir\BESTDR8_Data1.ndf', --1.1TB
	MOVE 'BESTDR8_Data7' TO 'c:\destination_dir\BESTDR8_Data1.ndf', --1.1TB
	MOVE 'BESTDR8_Data8' TO 'c:\destination_dir\BESTDR8_Data1.ndf', --1.8TB
	MOVE 'BESTDR8_Log1' TO 'c:\destination_dir\BESTDR8_Log1.ldf',  -- 216GB
	MOVE 'BESTDR8_Log2' TO 'c:\destination_dir\BESTDR8_Log2.ldf', -- 216GB
	MOVE 'BESTDR8_Log3' TO 'c:\destination_dir\BESTDR8_Log3.ldf', -- 162GB
	MOVE 'BESTDR8_Log4' TO 'c:\destination_dir\BESTDR8_Log4.ldf' -- 162GB

