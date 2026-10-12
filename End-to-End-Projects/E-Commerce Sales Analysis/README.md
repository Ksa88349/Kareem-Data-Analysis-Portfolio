# 🛒 E-Commerce Sales Analysis

This project was started as part of my **30 Projects in 30 Days** challenge to practice a complete data analysis workflow using an e-commerce dataset.

During the initial data preparation stage, data quality and consistency issues were identified. Further investigation raised concerns about the reliability of the data and the relationships between the available tables.

After assessing these issues, I decided to discontinue the project rather than proceed with analysis and business conclusions that could not be sufficiently supported by the available data.

Although the project did not reach the dashboard or reporting stages, it provided practical experience in data quality assessment, data cleaning, validation, and documenting analytical decisions.

## 🎯 Project Objective

The original objective was to prepare the raw e-commerce data for analyzing customer behavior, shopping activity, and sales performance.

The planned workflow included:

* Data quality assessment
* Data cleaning and validation
* Customer data preparation
* Cart data preparation
* Data modeling / Data Warehouse
* Exploratory analysis
* Power BI dashboard
* Business insights and final reporting

**Project outcome:** The project was discontinued during the data preparation stage because of data quality and consistency concerns that limited confidence in the dataset's suitability for reliable analysis.

## 📂 Project Structure

```text
E-Commerce Sales Analysis/
│
├── 01_Customer_Data/
│   └── Customer Cleaning/
│       ├── E_Commerce_Customer_Cleaning_Final.ipynb
│       └── customer_details_clean.csv
│
├── 02_Cart_Data/
│
└── README.md
```

*Note: The structure above reflects the customer data preparation work and the current project organization. Additional files may be added as the repository evolves.*

## 🛠️ Tools

* Python
* Pandas
* NumPy
* Google Colab

## 🔍 Work Completed

### Customer Data Quality Assessment and Cleaning

The customer table was inspected to identify duplicates, inconsistent categorical values, missing values, and unrealistic age values.

The cleaning process included:

* Inspecting the structure and quality of the dataset.
* Identifying inconsistent categorical values.
* Investigating unrealistic and invalid customer ages.
* Developing a documented correction strategy using available data, while preserving the original age column.
* Validating the resulting analytical age column.
* Exporting the prepared customer dataset.

### Reason for Discontinuation

During the initial investigation, concerns arose about the consistency and interpretability of the data, particularly the reliability of the available fields and the relationship between the tables.

Because these concerns could affect subsequent analysis and business conclusions, I decided not to proceed with data modeling, dashboard development, or final business reporting without sufficient confidence in the underlying data.

The decision to discontinue the project was made to prioritize analytical reliability over completing a workflow using questionable data.

## 📌 Project Status

**Status: Discontinued during data preparation.**

* [x] Customer data quality assessment
* [x] Customer data cleaning and validation
* [ ] Complete and validate the full dataset
* [ ] Data Warehouse / Data Model
* [ ] Exploratory Analysis
* [ ] Power BI Dashboard
* [ ] Final Business Report

The completed work is retained as a learning exercise in practical data cleaning and analytical decision-making. No final business insights or conclusions are claimed from this project.

## 👤 About

This project was part of my learning journey toward becoming a **Data Analyst**, with a focus on understanding data quality, making defensible analytical decisions, and using data to support business decisions.

One of the key lessons from this project is that a successful analysis does not start with a dashboard or a set of charts. It starts with understanding the data, evaluating its reliability, and deciding whether it is suitable for the questions we want to answer.
