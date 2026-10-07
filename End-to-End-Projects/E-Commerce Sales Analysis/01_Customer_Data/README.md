# 👥 Customer Data — Data Cleaning

This section focuses on cleaning and preparing the `customer_details` table for further analysis in the e-commerce project.

The goal was not simply to remove incorrect records, but to investigate the data-quality issues, understand their possible causes, and apply reasonable corrections while preserving the original data whenever possible.

## 📊 Dataset

The customer table contains information about customers, including:

* `customer_id`
* `sex`
* `customer_age`
* `tenure`

The original dataset contains **20,000 customer records**.

## 🔎 Data Quality Issues

During the initial inspection, several data-quality issues were identified:

### 1. Inconsistent `sex` Value

An unexpected value was found in the `sex` column:

`kvkktalepsilindi`

Since this value could not be treated as a standard gender category, it was standardized to:

`UNKNOWN`

### 2. Unrealistic Customer Ages

The `customer_age` column contained several unrealistic values.

Examples included:

* Negative ages
* Ages below 15
* Ages above 80
* Values such as `2022`, which clearly cannot represent a customer's age

The original age statistics also showed that the column could not be used directly for analysis.

## 🧠 Age Correction Strategy

Instead of deleting every record with an invalid age, I investigated whether another column could provide useful information for recovering some of these values.

The `tenure` column was examined for customers with invalid ages.

A reasonable analytical age range of **15–80** was used.

The correction strategy was:

1. If `customer_age` is between **15 and 80**, keep the original value.
2. If `customer_age` is outside this range and `tenure` is between **15 and 80**, use `tenure` as the replacement analytical age.
3. If both values are not suitable, the analytical age is left as `NaN`.

This approach reduces unnecessary data loss while keeping the original source value unchanged.

## 🗂️ Original vs Analytical Age

The original `customer_age` column was intentionally preserved.

A new column called:

`customer_age_analysis`

was created for analytical use.

This allows the original source data to remain available for traceability while providing a cleaner field for analysis.

## ✅ Validation

After applying the cleaning rules, the analytical age column was checked to make sure that:

* Analytical ages fall within the selected **15–80** range.
* Values that could not be reasonably recovered remain `NaN`.
* The original `customer_age` values are still preserved.
* The final table structure is suitable for the next stage of the project.

The final analytical age column contains **18,458 valid values**, while **1,542 records** remain without a reliable analytical age.

## 📁 Output

The cleaned customer dataset was exported as:

`customer_details_clean.csv`

The cleaning process is documented in:

`customer_cleaning.ipynb`

## 🛠️ Tools Used

* Python
* Pandas
* NumPy
* Google Colab

## 📌 Next Step

The cleaned customer table will later be combined with the cleaned cart data as part of the project's data modeling and analysis stage.

