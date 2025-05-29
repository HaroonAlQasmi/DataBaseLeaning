-- This was written because it gave me an error that the DB was in Use the below command shuts it by force
ALTER DATABASE TrainingDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

DROP DATABASE TrainingDB;

-- 1. Restore FULL backup
RESTORE DATABASE TrainingDB  
FROM DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\TrainingDB_Full.bak'  
WITH NORECOVERY;

-- 2. Restore DIFFERENTIAL backup
RESTORE DATABASE TrainingDB  
FROM DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\TrainingDB_Diff.bak'  
WITH NORECOVERY;

-- 3. Restore TRANSACTION LOG backup
RESTORE LOG TrainingDB  
FROM DISK = 'C:\Users\Codeline User\Desktop\Haroon_Folder\DataBaseLeaning\DBBackUps\TrainingDB_Log.trn'  
WITH RECOVERY;


-- Test if restoration worked
USE TrainingDB;
SELECT * FROM Students;