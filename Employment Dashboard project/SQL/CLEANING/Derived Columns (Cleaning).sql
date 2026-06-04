UPDATE staging_table
SET [date] = DATEFROMPARTS([year], [month], 1);

UPDATE staging_table
SET month_name = DATENAME(MONTH, [date]);