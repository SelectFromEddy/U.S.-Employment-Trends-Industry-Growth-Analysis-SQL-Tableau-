DELETE FROM staging_table
WHERE year < 0
   OR month < 0
   OR employment < 0;