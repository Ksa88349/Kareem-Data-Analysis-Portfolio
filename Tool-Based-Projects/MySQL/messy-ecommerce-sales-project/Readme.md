# 🧼 E-Commerce Sales Data: Advanced Data Cleaning Pipeline

## 📌 Project Overview
This project targets the **Data Cleaning and Standardization** phase of a highly volatile, raw E-Commerce sales dataset using **MySQL**. Raw transactional tracking data often suffers from human operational errors, system logging glitches, and poor structural constraint validation. 

The primary objective of this script is to ingest the unrefined data, isolate systemic anomalies, execute structural repairs, and deploy a validated, pristine data schema back into production. This sets up a solid ground truth for subsequent Exploratory Data Analysis (EDA) and visualization workflows.

---

## 📐 Data Schema & Field Tracking
The target dataset logs e-commerce customer transaction funnels with the following fields:
*   `ID`: Unique primary key identifier for rows.
*   `Customer_Name`: Customer profile names.
*   `Order_ID`: Alpha-numeric tracking codes for checkouts.
*   `Order_Date`: Text-logged timestamps of customer transactions.
*   `Product`: Explicit item description.
*   `Category`: Product operational business category (e.g., Electronics).
*   `Quantity`: Count of units bought per checkout.
*   `Price`: Monetary value per unit item.
*   `Payment_Method`: Selected customer transactional medium (e.g., Credit Card).
*   `Status`: Order processing status.
*   `Total`: Gross calculated revenue derived per transaction line.

---

## 🛠️ Data Anomalies Identified & Resolved

### 1️⃣ Deduplication via Analytic Windows
*   **Problem:** The raw dataset contained redundant mirror records across identical timestamp intervals without a unique functional key constraint.
*   **Solution:** Built an analytic `ROW_NUMBER()` framework partitioned across all structural attributes within a temporary workspace model to securely isolate duplicates. Extracted the primary singular occurrences (`row_num = 1`) and truncated the duplicates out of the pipeline.

### 2️⃣ Structural Temporal Formatting
*   **Problem:** Transactional entries recorded dates under a loose `TEXT` data format using the inconsistent `%m/%d/%Y` notation, rendering standard date time queries useless.
*   **Solution:** Executed targeted exceptions handling for broken text logs (e.g., `ID = 114`) and parsed strings via `STR_TO_DATE`. Transformed the column attribute structure into a strict native SQL `DATE` data type.

### 3️⃣ Categorical Inconsistencies & String Trimming
*   **Problem:** Structural drift in category inputs led to multiple entries for the same category (e.g., `electronic` vs. `electronics`).
*   **Solution:** Deployed wildcard pattern matching strings using `LIKE` filters to map variations back to standardized industry terms.

### 4️⃣ Math Modeling Anomaly Correction (Quantity, Price, & Total)
*   **Problem:** Critical mathematical fields were corrupted with leading negative signs (`-`), unexpected alphabetical characters (`abd`, `four%`), and out-of-place currency markers (`$`).
*   **Solution:** 
    *   Applied string manipulation operators (`TRIM`, `REPLACE`) to strip negative symbols and whitespace strings from the calculations.
    *   Deployed **Regular Expressions (`REGEXP`)** validation to screen fields for non-numeric remnants and programmatically forced unresolved corrupt structures to safe `NULL` representations.
    *   Enforced data integrity by permanently altering structural column definitions from `TEXT` data values to standard computational `DECIMAL(10,2)` parameters.

---

## 🏁 Final Production State
The script finishes by dropping working dependencies and executing a secure schema migration back to the original database tables. The resulting architecture guarantees zero structural duplicates, absolute datatyping integrity, and accurate financial calculation tracks.
