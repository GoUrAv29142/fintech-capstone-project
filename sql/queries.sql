-- 1. Top 5 funds by AUM
SELECT
    scheme_name,
    fund_house,
    category,
    aum_crore
FROM scheme_performance
ORDER BY aum_crore DESC
LIMIT 5;


-- 2. Average NAV per month
SELECT
    substr(date, 1, 7) AS month,
    ROUND(AVG(nav), 4) AS average_nav
FROM nav_history
GROUP BY substr(date, 1, 7)
ORDER BY month;


-- 3. SIP year-over-year growth
SELECT
    substr(transaction_date, 1, 4) AS year,
    SUM(amount_inr) AS sip_amount,
    ROUND(
        (
            SUM(amount_inr) -
            LAG(SUM(amount_inr)) OVER (
                ORDER BY substr(transaction_date, 1, 4)
            )
        ) * 100.0 /
        LAG(SUM(amount_inr)) OVER (
            ORDER BY substr(transaction_date, 1, 4)
        ),
        2
    ) AS sip_yoy_growth_pct
FROM investor_transactions
WHERE transaction_type = 'SIP'
GROUP BY substr(transaction_date, 1, 4)
ORDER BY year;


-- 4. Transactions by state
SELECT
    state,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount_inr), 2) AS total_transaction_amount
FROM investor_transactions
GROUP BY state
ORDER BY total_transaction_amount DESC;


-- 5. Funds with expense ratio below 1%
SELECT
    scheme_name,
    fund_house,
    category,
    plan,
    expense_ratio_pct
FROM scheme_performance
WHERE expense_ratio_pct < 1
ORDER BY expense_ratio_pct ASC;


-- 6. Top 10 investors by total investment amount
SELECT
    investor_id,
    ROUND(SUM(amount_inr), 2) AS total_investment_amount
FROM investor_transactions
WHERE transaction_type IN ('SIP', 'Lumpsum')
GROUP BY investor_id
ORDER BY total_investment_amount DESC
LIMIT 10;


-- 7. Transactions by payment mode
SELECT
    payment_mode,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount_inr), 2) AS total_transaction_amount
FROM investor_transactions
GROUP BY payment_mode
ORDER BY total_transaction_amount DESC;


-- 8. Category-wise average returns and AUM
SELECT
    category,
    ROUND(AVG(return_1yr_pct), 2) AS avg_return_1yr_pct,
    ROUND(AVG(return_3yr_pct), 2) AS avg_return_3yr_pct,
    ROUND(AVG(aum_crore), 2) AS avg_aum_crore
FROM scheme_performance
GROUP BY category
ORDER BY avg_return_3yr_pct DESC;


-- 9. Top 10 funds by Sharpe ratio
SELECT
    scheme_name,
    category,
    sharpe_ratio,
    return_3yr_pct,
    std_dev_ann_pct
FROM scheme_performance
ORDER BY sharpe_ratio DESC
LIMIT 10;


-- 10. Monthly investments versus redemptions
SELECT
    substr(transaction_date, 1, 7) AS month,
    ROUND(SUM(
        CASE
            WHEN transaction_type IN ('SIP', 'Lumpsum')
            THEN amount_inr
            ELSE 0
        END
    ), 2) AS investment_amount,
    ROUND(SUM(
        CASE
            WHEN transaction_type = 'Redemption'
            THEN amount_inr
            ELSE 0
        END
    ), 2) AS redemption_amount
FROM investor_transactions
GROUP BY substr(transaction_date, 1, 7)
ORDER BY month;