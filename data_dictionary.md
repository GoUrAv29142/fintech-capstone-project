# Data Dictionary — Fintech Capstone Project

## Project Data Sources

| Source File                  | Cleaned File                      | Description                                |
| ---------------------------- | --------------------------------- | ------------------------------------------ |
| 01_fund_master.csv           | fund_master_cleaned.csv           | Mutual fund scheme master information      |
| 02_nav_history.csv           | nav_history_cleaned.csv           | Historical mutual fund NAV values          |
| 03_aum_by_fund_house.csv     | aum_by_fund_house_cleaned.csv     | Fund-house Assets Under Management         |
| 04_monthly_sip_inflows.csv   | monthly_sip_inflows_cleaned.csv   | Monthly SIP inflow data                    |
| 05_category_inflows.csv      | category_inflows_cleaned.csv      | Category-wise fund inflow data             |
| 06_industry_folio_count.csv  | industry_folio_count_cleaned.csv  | Industry-level folio count data            |
| 07_scheme_performance.csv    | scheme_performance_cleaned.csv    | Fund return, risk, and performance metrics |
| 08_investor_transactions.csv | investor_transactions_cleaned.csv | Investor mutual fund transactions          |
| 09_portfolio_holdings.csv    | portfolio_holdings_cleaned.csv    | Scheme portfolio security holdings         |
| 10_benchmark_indices.csv     | benchmark_indices_cleaned.csv     | Benchmark index historical values          |

---

## 1. Fund Master

**File:** `fund_master_cleaned.csv`
**Source:** `01_fund_master.csv`
**Purpose:** Stores master information for each mutual fund scheme.

| Column            | Data Type | Business Definition                             |
| ----------------- | --------- | ----------------------------------------------- |
| amfi_code         | Integer   | Unique AMFI identifier for a mutual fund scheme |
| scheme_name       | Text      | Full name of the mutual fund scheme             |
| fund_house        | Text      | Asset Management Company managing the fund      |
| category          | Text      | Mutual fund category                            |
| plan              | Text      | Fund plan, such as Direct or Regular            |
| expense_ratio_pct | Float     | Annual fund management expense as a percentage  |
| risk_category     | Text      | Risk classification of the scheme               |

---

## 2. NAV History

**File:** `nav_history_cleaned.csv`
**Source:** `02_nav_history.csv`
**Purpose:** Stores historical Net Asset Value records.

| Column      | Data Type | Business Definition                  |
| ----------- | --------- | ------------------------------------ |
| amfi_code   | Integer   | Unique mutual fund scheme identifier |
| date        | Date      | NAV record date                      |
| nav         | Float     | Net Asset Value of the scheme        |
| scheme_name | Text      | Mutual fund scheme name              |

**Cleaning rules:** Dates standardized, records sorted by AMFI code and date, duplicates removed, NAV validated to be greater than zero.

---

## 3. AUM by Fund House

**File:** `aum_by_fund_house_cleaned.csv`
**Source:** `03_aum_by_fund_house.csv`
**Purpose:** Stores Assets Under Management by fund house.

| Column         | Data Type | Business Definition           |
| -------------- | --------- | ----------------------------- |
| fund_house     | Text      | Asset Management Company name |
| date           | Date      | Reporting date                |
| aum_lakh_crore | Float     | AUM in lakh crore rupees      |
| aum_crore      | Float     | AUM in crore rupees           |
| num_schemes    | Integer   | Number of schemes managed     |

---

## 4. Monthly SIP Inflows

**File:** `monthly_sip_inflows_cleaned.csv`
**Source:** `04_monthly_sip_inflows.csv`
**Purpose:** Stores monthly SIP investment inflows.

| Column           | Data Type | Business Definition           |
| ---------------- | --------- | ----------------------------- |
| month            | Date      | Reporting month               |
| sip_inflow_crore | Float     | SIP inflow in crore rupees    |
| sip_accounts     | Integer   | Number of active SIP accounts |

---

## 5. Category Inflows

**File:** `category_inflows_cleaned.csv`
**Source:** `05_category_inflows.csv`
**Purpose:** Stores inflow and outflow values by mutual fund category.

| Column           | Data Type | Business Definition                      |
| ---------------- | --------- | ---------------------------------------- |
| date             | Date      | Reporting date                           |
| category         | Text      | Mutual fund category                     |
| inflow_crore     | Float     | Total investment inflow in crore rupees  |
| outflow_crore    | Float     | Total redemption outflow in crore rupees |
| net_inflow_crore | Float     | Net inflow after outflows                |

---

## 6. Industry Folio Count

**File:** `industry_folio_count_cleaned.csv`
**Source:** `06_industry_folio_count.csv`
**Purpose:** Stores mutual fund investor folio counts.

| Column        | Data Type | Business Definition               |
| ------------- | --------- | --------------------------------- |
| date          | Date      | Reporting date                    |
| total_folios  | Integer   | Total mutual fund investor folios |
| equity_folios | Integer   | Equity mutual fund folios         |
| debt_folios   | Integer   | Debt mutual fund folios           |
| hybrid_folios | Integer   | Hybrid mutual fund folios         |

---

## 7. Scheme Performance

**File:** `scheme_performance_cleaned.csv`
**Source:** `07_scheme_performance.csv`
**Purpose:** Stores fund returns, risk measures, and ratings.

| Column              | Data Type | Business Definition                      |
| ------------------- | --------- | ---------------------------------------- |
| amfi_code           | Integer   | Unique AMFI scheme identifier            |
| scheme_name         | Text      | Mutual fund scheme name                  |
| fund_house          | Text      | Fund management company                  |
| category            | Text      | Fund category                            |
| plan                | Text      | Direct or Regular plan                   |
| return_1yr_pct      | Float     | One-year fund return percentage          |
| return_3yr_pct      | Float     | Three-year fund return percentage        |
| return_5yr_pct      | Float     | Five-year fund return percentage         |
| benchmark_3yr_pct   | Float     | Three-year benchmark return percentage   |
| alpha               | Float     | Excess return relative to benchmark      |
| beta                | Float     | Sensitivity to market movement           |
| sharpe_ratio        | Float     | Risk-adjusted return measure             |
| sortino_ratio       | Float     | Downside-risk-adjusted return measure    |
| std_dev_ann_pct     | Float     | Annualized volatility percentage         |
| max_drawdown_pct    | Float     | Largest decline from peak value          |
| aum_crore           | Float     | Assets Under Management in crore rupees  |
| expense_ratio_pct   | Float     | Annual expense ratio percentage          |
| morningstar_rating  | Integer   | Morningstar rating                       |
| risk_grade          | Text      | Risk grade                               |
| return_anomaly_flag | Boolean   | Indicates unusual return values          |
| expense_ratio_valid | Boolean   | Indicates whether expense ratio is valid |

**Cleaning rules:** Return values converted to numeric, anomalies flagged, and expense ratio validated between 0.1% and 2.5%.

---

## 8. Investor Transactions

**File:** `investor_transactions_cleaned.csv`
**Source:** `08_investor_transactions.csv`
**Purpose:** Stores investor-level mutual fund transaction data.

| Column             | Data Type | Business Definition                 |
| ------------------ | --------- | ----------------------------------- |
| investor_id        | Text      | Unique investor identifier          |
| amfi_code          | Integer   | Mutual fund scheme identifier       |
| transaction_date   | Date      | Date of investment or redemption    |
| transaction_type   | Text      | SIP, Lumpsum, or Redemption         |
| amount_inr         | Float     | Transaction amount in Indian Rupees |
| state              | Text      | Investor state                      |
| city               | Text      | Investor city                       |
| city_tier          | Text      | City classification                 |
| age_group          | Text      | Investor age group                  |
| gender             | Text      | Investor gender                     |
| annual_income_lakh | Float     | Annual income in lakh rupees        |
| payment_mode       | Text      | Payment method                      |
| kyc_status         | Text      | KYC verification status             |

**Cleaning rules:** Transaction type standardized to SIP, Lumpsum, or Redemption; amount validated above zero; dates standardized; KYC values validated.

---

## 9. Portfolio Holdings

**File:** `portfolio_holdings_cleaned.csv`
**Source:** `09_portfolio_holdings.csv`
**Purpose:** Stores securities held by mutual fund schemes.

| Column             | Data Type | Business Definition             |
| ------------------ | --------- | ------------------------------- |
| amfi_code          | Integer   | Mutual fund scheme identifier   |
| scheme_name        | Text      | Mutual fund scheme name         |
| security_name      | Text      | Company or security held        |
| sector             | Text      | Industry sector                 |
| holding_pct        | Float     | Portfolio allocation percentage |
| market_value_crore | Float     | Market value in crore rupees    |

---

## 10. Benchmark Indices

**File:** `benchmark_indices_cleaned.csv`
**Source:** `10_benchmark_indices.csv`
**Purpose:** Stores historical benchmark index data.

| Column         | Data Type | Business Definition           |
| -------------- | --------- | ----------------------------- |
| date           | Date      | Index record date             |
| benchmark_name | Text      | Name of the benchmark index   |
| index_value    | Float     | Closing benchmark index value |
| return_pct     | Float     | Benchmark return percentage   |

---

## SQLite Database

**Database file:** `data/bluestock_mf.db`

| Table             | Purpose                          |
| ----------------- | -------------------------------- |
| dim_fund          | Mutual fund scheme dimension     |
| dim_date          | Calendar date dimension          |
| fact_nav          | NAV history fact table           |
| fact_transactions | Investor transactions fact table |
| fact_performance  | Fund performance fact table      |
| fact_aum          | Fund-house AUM fact table        |

---

## Data Quality Rules Applied

* Duplicate records removed where applicable.
* Dates standardized into date/datetime format.
* Text values trimmed and standardized.
* NAV values validated to be greater than zero.
* Transaction amounts validated to be greater than zero.
* Expense ratios validated between 0.1% and 2.5%.
* Transaction types standardized to SIP, Lumpsum, and Redemption.
* KYC status values checked for valid values.
