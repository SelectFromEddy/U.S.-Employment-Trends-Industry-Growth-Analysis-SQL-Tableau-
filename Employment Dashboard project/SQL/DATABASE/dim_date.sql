CREATE TABLE dimDate (
    date_id INT PRIMARY KEY,   -- e.g., 202401
    year INT NOT NULL,
    month INT NOT NULL,
    month_name VARCHAR(20),
    quarter VARCHAR(5)
);