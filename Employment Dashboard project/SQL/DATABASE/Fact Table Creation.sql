CREATE TABLE fact_table (

fact_id INT IDENTITY (1,1) PRIMARY KEY,
employment INT NOT NULL,
date_id INT NOT NULL,
industry_id INT NOT NULL,

FOREIGN KEY (date_id) REFERENCES dimDate(date_id),
FOREIGN KEY (industry_id) REFERENCES dimindustry(industry_id) );
