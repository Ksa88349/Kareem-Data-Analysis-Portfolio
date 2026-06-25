# 📉 World Layoffs: Data Cleaning & Exploratory Data Analysis (EDA)

## 📌 Project Overview
This project delivers a complete SQL-based data pipeline designed to clean, structure, and analyze a raw dataset tracking global tech company layoffs from the start of the COVID-19 pandemic up to **2026**. 

The project is split into two distinct SQL scripts:
1.  **`Data-cleaning-Project.sql`**: Transforming noisy, inconsistent raw data into a reliable, production-ready table.
2.  **`EDA-Project.sql`**: Interrogating the cleaned database using advanced metrics to discover macroeconomic trends, industry vulnerabilities, and temporal patterns.

---

## 🛠️ Data Schema
The database consists of a single refined table featuring the following core attributes:
*   `company`: Name of the organization.
*   `location`: Headquarters/City location.
*   `industry`: Sector of operations (e.g., Fintech, E-commerce, Aerospace).
*   `total_laid_off`: Total number of employees laid off in a single announcement.
*   `percentage_laid_off`: The fraction of the company's total workforce laid off.
*   `date`: Explicit timestamp of the layoff event.
*   `stage`: Funding round of the company (e.g., Series B, Post-IPO, Seed).
*   `country`: Country of origin.
*   `funds_raised_millions`: Total capital raised by the company in millions of USD.

---

## 🧼 Phase 1: Data Cleaning & Standardization
The main goal of this script (`Data-cleaning-Project.sql`) was to establish data integrity before performing any calculations. The workflow followed these rigorous steps:

1.  **Duplicate Removal**: Because the raw data lacked a unique primary key, I leveraged a Window Function (`ROW_NUMBER()`) partitioned across all columns within a Common Table Expression (CTE) to flag and safely purge identical records.
2.  **Text Standardization**: Fixed typos and structural variations in text data. For example, collapsing multiple distinct variations of the "Crypto" industry into a single, uniform category.
3.  **Temporal Adjustments**: Converted the raw, text-based `date` field into a proper SQL `DATE` format using `STR_TO_DATE` to enable time-series functionality.
4.  **Handling Nulls & Blanks**: Populated missing `industry` fields by running self-joins against other existing entries for the same company. 
5.  **Data Trimming**: Deleted rows where both critical target metrics (`total_laid_off` and `percentage_laid_off`) were entirely null, making them useless for analysis. I then dropped temporary structural columns used during deduplication.

---

## 🔍 Phase 2: Exploratory Data Analysis (EDA)
With clean data secured, the analysis script (`EDA-Project.sql`) was deployed to act as a business intelligence tool. Key milestones achieved include:

*   **Descriptive Benchmarks**: Uncovered the baseline limits of the crisis, identifying single-day layoff spikes peaking as high as **12,000 employees**.
*   **The "Millionaire" Bankruptcy Check**: Filtered companies with 100% layoffs (`percentage_laid_off = 1`) and ordered them by total funding to look at highly-funded giants that completely collapsed.
*   **Industry & Location Heat**: Grouped and aggregated totals to find out which sectors absorbed the heaviest impact. **Fintech** and **E-commerce** emerged as the most volatile sectors globally.
*   **Macroeconomic Trajectory**: Grouped data by `YEAR(date)` to trace whether the tech market contraction was slowing down or accelerating across the multi-year timeline.
*   **Monthly Rolling Total**: Created a progressive cumulative counter using a subquery/CTE paired with an analytic window function:
    ```sql
    SUM(total_off) OVER(ORDER BY Month_Year)
    ```
    This allowed us to chart the exact velocity of global workforce reductions month-over-month.

---

## 💡 Top Business Insights Found
*   **The January Effect**: The EDA exposed a striking, recurring seasonal trend: layoffs dramatically spike every single year in **January**. Companies likely wait until the end of Q4 to close their fiscal books before executing major structural downsizings in the new year.
*   **Funding vs. Survival**: High venture-capital backing (`funds_raised_millions`) did not guarantee safety. Several unicorn startups experienced total liquidation, proving that operational efficiency outweighs massive funding during market downturns.

---

## 💻 Tech Stack & SQL Mastery Demonstrated
*   **DDL & DML Operations**: `CREATE TABLE`, `INSERT INTO`, `UPDATE`, `DELETE`.
*   **Advanced Control**: Common Table Expressions (CTEs), Subqueries, and Self-Joins.
*   **Analytic Power**: Window Functions (`ROW_NUMBER()`, `SUM() OVER()`).
*   **Data Wrangling**: String functions (`SUBSTRING`, `TRIM`), Date manipulation (`STR_TO_DATE`), and complex conditional aggregation (`GROUP BY`, `HAVING`).
