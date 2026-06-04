DELETE FROM staging_table 
WHERE year < 1900 
OR year > (GETDATE());