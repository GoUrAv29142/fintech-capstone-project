import pandas as pd
import os

# Base directory
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
RAW_DATA = os.path.join(BASE_DIR, "data", "raw")

# List of datasets
datasets = {
    "Fund Master": "01_fund_master.csv",
    "NAV History": "02_nav_history.csv",
    "AUM by Fund House": "03_aum_by_fund_house.csv",
    "Monthly SIP Inflows": "04_monthly_sip_inflows.csv",
    "Category Inflows": "05_category_inflows.csv",
    "Industry Folio Count": "06_industry_folio_count.csv",
    "Scheme Performance": "07_scheme_performance.csv",
    "Investor Transactions": "08_investor_transactions.csv",
    "Portfolio Holdings": "09_portfolio_holdings.csv",
    "Benchmark Indices": "10_benchmark_indices.csv"
}

print("=" * 70)
print("DAY 1 - DATA INGESTION")
print("=" * 70)

for name, file in datasets.items():
    path = os.path.join(RAW_DATA, file)

    print(f"\n{name}")
    print("-" * 70)

    try:
        df = pd.read_csv(path)

        print(f"Shape: {df.shape}")
        print("\nData Types:")
        print(df.dtypes)

        print("\nFirst 5 Rows:")
        print(df.head())

        print("\nMissing Values:")
        print(df.isnull().sum())

    except Exception as e:
        print(f"Error loading {file}: {e}")

print("\nData ingestion completed successfully.")