# 🛒 Cart Data — Data Cleaning

This section focuses on reviewing and preparing the `basket_details` table for analysis within the E-Commerce Sales Analysis project.

## 📊 Dataset

The basket table contains:

* `customer_id`
* `product_id`
* `basket_date`
* `basket_count`

The downloaded dataset contains **15,000 records**.

## 📌 Documentation Note

The Kaggle dataset description mentions **150,000 basket transactions**.

However, the downloaded `basket_details.csv` file contains **15,000 records**. All analysis in this project is based on the downloaded file as provided.

## 🔎 Data Quality Assessment

The dataset was inspected for:

* Missing values
* Duplicate records
* Invalid quantities
* Date format issues

### Results

#### Missing Values

No missing values were detected in any column.

#### Duplicate Rows

No fully duplicated records were detected.

#### Basket Quantities

The `basket_count` column was reviewed and found to contain values ranging from **2 to 10**.

No negative quantities or invalid values were detected.

#### Date Column

The `basket_date` column contained valid date values.

The only issue identified was that the column was stored as an **object** data type instead of a datetime format.

## 🧹 Cleaning Actions

### Date Conversion

The following conversion was applied:

```python
cart["basket_date"] = pd.to_datetime(cart["basket_date"])
```

This enables future time-based analysis and feature engineering.

No additional cleaning was required.

## ✅ Validation

After review:

* No missing values remained.
* No duplicate rows were found.
* Basket quantities remained within a reasonable range.
* The date column was successfully converted to datetime format.

## 📁 Output

The cleaned dataset was exported as:

`cart_details_clean.csv`

The complete cleaning workflow is documented in:

`E_Commerce_Cart_Cleaning_Final.ipynb`

## 🛠️ Tools Used

* Python
* Pandas
* NumPy
* Google Colab

## 📌 Next Step

The cleaned basket table will be integrated with the customer table to build the analytical data model and support further business analysis and dashboard development.

