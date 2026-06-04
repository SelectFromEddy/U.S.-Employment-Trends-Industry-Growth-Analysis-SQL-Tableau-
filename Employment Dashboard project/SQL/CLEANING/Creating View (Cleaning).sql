CREATE VIEW clean_data AS
SELECT * 
FROM staging_table
WHERE employment IS NOT NULL;