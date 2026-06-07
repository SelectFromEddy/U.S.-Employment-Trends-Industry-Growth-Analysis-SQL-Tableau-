   U.S. Employment Trends & Industry Growth Analysis
   Started: 03/15/2026

---

   ## Executive Summary

   This analysis examines employment trends across major industries using non-seasonally adjusted benchmark-revised BLS CES employment data for 2024–2025.
   Employment remains highly concentrated, with Health Care & Social Assistance (21.0%) and Professional & Business Services (20.2%) accounting for more than 41% of total jobs.

   Other major sectors include Leisure & Hospitality (15.2%), Retail Trade (13.9%), and Manufacturing (11.4%), while Financial Activities (8.3%),
   Construction (7.4%), and Information (2.6%) represent smaller shares of employment.

   Growth trends show that Health Care & Social Assistance was the strongest-performing industry, 
   recording approximately +3.5% year-over-year growth. Construction (+0.7%), Leisure & Hospitality (+0.6%), and Financial Activities (+0.4%) also expanded. In contrast, Retail Trade (-0.3%), Professional & Business Services (-0.7%), and Manufacturing (-1.2%) declined, while Information (-2.1%) experienced the largest employment loss.

   Monthly growth patterns indicate that employment gains were concentrated in a small number of industries. 
   Health Care & Social Assistance recorded the strongest average month-over-month growth (+0.25%), while several industries experienced little growth or slight declines.

   Seasonal patterns were most evident in Construction, Retail Trade, and Leisure & Hospitality, 
   which experienced recurring fluctuations throughout the year. Health Care & Social Assistance remained comparatively stable with limited seasonal variation.

   Overall, the data highlights a labor market driven by service-oriented industries, 
   with Health Care & Social Assistance leading both employment share and job growth. Meanwhile, Information, Manufacturing, and Retail Trade faced employment declines, reflecting uneven growth across the economy.
--- 

     ## Business Problem
   Understanding how employment shifts across major industries is essential for workforce planning, 
   economic forecasting, and strategic business decisions. Companies, policymakers, 
   and economists rely on labor market data to understand where job growth is occurring and which industries may be declining.

   However, raw labor statistics are difficult to interpret without proper analysis. 
   This project addresses that problem by transforming raw employment data into actionable insights that reveal industry growth trends,
   seasonal hiring behavior, and the distribution of employment across the U.S. economy.

---

   ## Stakeholder / Audience
   
   This analysis is relevant to:
   
   - Economic analysts

   - Business strategists and corporate planners

   - Labor market researchers

   - Policy makers

   - Workforce development organizations

---

   ## Dataset
   
   - Source: Non-Adjusted Benchmark Revised BLS Employment Data (2024 - 2025) 

   - Time Period: 2024–2025

   - Data Type: Public government dataset

   - Grain: One row = Monthly employment count per industry

---

   ## Objectives

   - Identify which industries employ the most workers in the U.S.

   - Determine which industries are growing or declining over time

   - Identify the fastest growing industries

   - Analyze seasonal hiring patterns across industries

   - Calculate the percentage of total employment each industry represents

   - Identify industries with the most stable versus volatile employment trends

---

   ## Tools Used
   - Excel
   Initial dataset inspection and formatting

   - SQL
   Database creation, Data cleaning, Aggregations,
   CTEs, Window functions, Ranking functions, Growth calculations

   - Microsoft SQL Server
   Data storage and transformation

   - Tableau
   Dashboard creation and visualization

---

   ## Data Pipeline / Workflow

   Data Collection
   - Downloaded employment dataset from the U.S. Bureau of Labor Statistics (non-seasonally adjusted)

   Data Inspection
   - Review the raw CSV structure.
   
   - Identify columns, missing values, and formatting issues.

   Data Staging
   
   - Import the raw dataset into a SQL staging table.

   Data Cleaning
   
   - Remove duplicate records.
   
   - Standardize text values.

   - Handle NULL values.

   - Convert numeric columns to appropriate data types.

   Data Transformation

   - Create dimension tables.

   - Generate date fields.

   - Normalize industry information.

---

   ## Data Model

   This project uses a **star schema** to structure employment data for efficient analysis and dashboard performance.

   # Fact Table: fact_employment

   - industry_id (Foreign Key)  

   - date_id (Foreign Key)  

   - employment  

   Description:  
   Stores monthly employment counts by industry and serves as the central table for all analysis.

   ---

   ## Dimension Tables

   # dim_industry
   
   - 'industry_id' (Primary Key)  
   
   - 'industry_name'  

   Description:  
   Provides industry-level categorization for grouping and comparisons.

---

   # dim_date

   - 'date_id' (Primary Key)  

   - 'date'  

   - 'month'  
   
   - 'year'  

   Description:  
   Enables time-based analysis such as trends, seasonality, and growth calculations.

---

   ##  Schema Diagram

          dim_industry
                |
                |
          fact_employment -------- dim_date
                |
          (employment)


   Analysis
   - Perform analysis using advanced SQL queries, including window functions and CTEs.

   Visualization
   - Connected the SQL database to tableau

   - Build interactive visualizations. 

   Reporting
   - Summarize key insights in the dashboard and GitHub documentation.

   ## Interactive Dashboard
   
   [ Link: https://public.tableau.com/views/Employmentdashboard_17785513107330/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link]
   
   # How to Use the Dashboard

   - Use the Industry filter to select specific industries

   - Adjust the Top N parameter to control how many industries are displayed

   - Hover over charts for detailed metrics

   - Analyze trends, growth, and volatility across industries
   
   - * = All Industries
   

   The Tableau dashboard provides an interactive view of employment trends across major U.S. industries.

   # Key Features:

   - Time-series analysis of employment trends  

   - Month-over-month (MoM) growth tracking  

   - Year-over-year (YoY) comparisons  

   - Moving averages to smooth short-term fluctuations  

   - Volatility analysis across industries  

   - Industry-level filtering for deeper insights  



   ## Data Cleaning Summary

   - Removed duplicate rows from the dataset

   - Standardized industry names

   - Trimmed whitespace from text fields

   - Converted employment values to integer data types

   - Handled missing values and invalid records

   - Verified date formats for time-series analysis
   
   - Validated employment totals against benchmark-revised BLS CES releases 

---

   ## SQL Highlights

   This project uses advanced SQL techniques including **CTEs** and **window functions** for time-series analysis.

   # Year-over-Year Growth
   --- This query uses the LAG() window function to compare employment levels with the same month in the previous year.
   LAG(employment, 12) OVER (
       PARTITION BY industry_name
       ORDER BY date
   ) AS prev_year
   ,

   # Moving Average 
   --- This query uses a 3 month moving average to find trends through out the years
   AVG(employment) OVER (
       PARTITION BY industry_name
       ORDER BY date
       ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
   ) AS moving_avg_MoM

   Full SQL scripts with detailed explanations are available in the SQL folder.

---

   ## Key Findings
   
  - Health Care & Social Assistance was the largest employer, representing approximately 21.0% of total employment, 
    while Professional & Business Services accounted for 20.2%, meaning these two sectors alone comprised over 41% of all jobs.

  - Health Care & Social Assistance also recorded the strongest year-over-year growth (+3.5%), 
    reinforcing its role as the primary driver of employment expansion.

  - Information experienced the largest employment decline (-2.1%), 
    while Manufacturing (-1.2%) and Professional & Business Services (-0.7%) also contracted.

  - Seasonal employment fluctuations were most evident in Construction, Retail Trade, and Leisure & Hospitality, 
    whereas Health Care & Social Assistance remained comparatively stable.

  - Employment growth was concentrated in a limited number of industries rather than being broadly distributed across the labor market.

---

   ## Why It Matters

   Labor market trends influence economic policy, corporate strategy, 
   and workforce planning. By identifying which industries are growing,
   shrinking, or experiencing seasonal changes, organizations can make better decisions about hiring, 
   investment, and resource allocation.

--- 
   ## Recommendations

   - Monitor Health Care & Social Assistance as a leading indicator of labor market expansion due to its large employment share and sustained growth.

   - Account for seasonal hiring patterns when evaluating industries such as Construction, Retail Trade, and Leisure & Hospitality to avoid misinterpreting temporary fluctuations.
   
   - Investigate declining sectors, particularly Information and Manufacturing, to identify potential structural changes affecting employment.
   
   - Expand the analysis by integrating additional labor market and economic indicators to provide broader context for employment trends.

---

   ## Limitations

   - This analysis uses non-seasonally adjusted, benchmark-revised BLS CES employment data for 2024–2025. As a result, recurring seasonal hiring patterns may influence short-term trends and month-to-month comparisons.

   - The dataset covers only a two-year period, limiting the ability to capture longer-term labor market cycles or structural economic changes.

   - Employment data is aggregated into broad industry categories, which may conceal important differences among individual sub-industries.

   - External economic factors such as inflation, interest rates, population growth, and government policy changes are not included in the analysis and may help explain observed employment trends.

   - The project is intended to provide a descriptive analysis of employment patterns and does not attempt to establish causal relationships between economic conditions and changes in employment.

---

   ## Next Steps (Optional)
   
   - Expand the dataset to include additional years for long-term trend analysis.

   - Incorporate complementary economic indicators such as unemployment rates, inflation, and GDP growth.

   - Develop predictive forecasting models using historical employment trends.

   - Enhance the Tableau dashboard with additional drill-down functionality and sub-industry analysis.

   - Compare seasonal and non-seasonally adjusted BLS data to evaluate the impact of seasonal effects

---
