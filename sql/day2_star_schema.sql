PRAGMA foreign_keys = ON;

-- DIMENSION TABLES


CREATE TABLE IF NOT EXISTS dim_fund (
    fund_key INTEGER PRIMARY KEY AUTOINCREMENT,
    amfi_code INTEGER NOT NULL UNIQUE,
    scheme_name TEXT NOT NULL,
    fund_house TEXT,
    category TEXT,
    sub_category TEXT,
    plan TEXT,
    launch_date DATE,
    benchmark TEXT,
    expense_ratio_pct REAL,
    exit_load_pct REAL,
    min_sip_amount INTEGER,
    min_lumpsum_amount INTEGER,
    fund_manager TEXT,
    risk_category TEXT,
    sebi_category_code TEXT
);

CREATE TABLE IF NOT EXISTS dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day INTEGER,
    month INTEGER,
    month_name TEXT,
    quarter INTEGER,
    year INTEGER,
    day_of_week TEXT,
    is_weekend INTEGER
);


-- FACT TABLES


CREATE TABLE IF NOT EXISTS fact_nav (
    nav_key INTEGER PRIMARY KEY AUTOINCREMENT,
    fund_key INTEGER NOT NULL,
    date_key INTEGER NOT NULL,
    nav REAL NOT NULL CHECK (nav > 0),

    FOREIGN KEY (fund_key) REFERENCES dim_fund(fund_key),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),

    UNIQUE (fund_key, date_key)
);

CREATE TABLE IF NOT EXISTS fact_transactions (
    transaction_key INTEGER PRIMARY KEY AUTOINCREMENT,
    investor_id TEXT NOT NULL,
    fund_key INTEGER NOT NULL,
    date_key INTEGER NOT NULL,
    transaction_type TEXT NOT NULL
        CHECK (transaction_type IN ('SIP', 'Lumpsum', 'Redemption')),
    amount_inr REAL NOT NULL CHECK (amount_inr > 0),
    state TEXT,
    city TEXT,
    city_tier TEXT,
    age_group TEXT,
    gender TEXT,
    annual_income_lakh REAL,
    payment_mode TEXT,
    kyc_status TEXT NOT NULL
        CHECK (kyc_status IN ('VERIFIED', 'PENDING')),

    FOREIGN KEY (fund_key) REFERENCES dim_fund(fund_key),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key)
);

CREATE TABLE IF NOT EXISTS fact_performance (
    performance_key INTEGER PRIMARY KEY AUTOINCREMENT,
    fund_key INTEGER NOT NULL,
    return_1yr_pct REAL,
    return_3yr_pct REAL,
    return_5yr_pct REAL,
    benchmark_3yr_pct REAL,
    alpha REAL,
    beta REAL,
    sharpe_ratio REAL,
    sortino_ratio REAL,
    std_dev_ann_pct REAL,
    max_drawdown_pct REAL,
    aum_crore REAL,
    expense_ratio_pct REAL CHECK (
        expense_ratio_pct BETWEEN 0.1 AND 2.5
    ),
    morningstar_rating INTEGER,
    risk_grade TEXT,
    return_anomaly_flag INTEGER,
    expense_ratio_valid INTEGER,

    FOREIGN KEY (fund_key) REFERENCES dim_fund(fund_key)
);

CREATE TABLE IF NOT EXISTS fact_aum (
    aum_key INTEGER PRIMARY KEY AUTOINCREMENT,
    fund_house TEXT NOT NULL,
    date_key INTEGER NOT NULL,
    aum_lakh_crore REAL,
    aum_crore REAL,
    num_schemes INTEGER,

    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),

    UNIQUE (fund_house, date_key)
);

-- INDEXES FOR FASTER QUERIES


CREATE INDEX IF NOT EXISTS idx_fact_nav_fund_date
ON fact_nav (fund_key, date_key);

CREATE INDEX IF NOT EXISTS idx_fact_transactions_fund_date
ON fact_transactions (fund_key, date_key);

CREATE INDEX IF NOT EXISTS idx_fact_performance_fund
ON fact_performance (fund_key);

CREATE INDEX IF NOT EXISTS idx_fact_aum_date
ON fact_aum (date_key);