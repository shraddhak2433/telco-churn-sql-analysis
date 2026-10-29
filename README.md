# Telco Customer Churn: SQL Analysis

Answering business questions about customer churn using SQL on a SQLite database.

![SQL](https://img.shields.io/badge/SQL-SQLite-1d5f8a) ![Python](https://img.shields.io/badge/Python-3.x-1d5f8a) ![pandas](https://img.shields.io/badge/pandas-loader-1d5f8a)

## Questions answered

1. What is the overall churn rate?
2. Which contract types lose the most customers?
3. How do tenure and monthly charges differ between churned and retained customers?
4. Which internet services and payment methods have above-average churn?
5. How much monthly revenue is lost to churn?
6. How does churn change with customer tenure?
7. Which segment is the riskiest?

## SQL concepts used

`GROUP BY`, `HAVING`, aggregate functions, `CASE`, subqueries, CTEs (`WITH`) and a window function (`RANK() OVER`).

## Key findings

- **Overall churn is 26.5%** (1,869 of 7,043 customers).
- **Contract type is the strongest signal.** Month-to-month customers churn at 42.7%, versus 11.3% on one-year and 2.8% on two-year contracts.
- **Customers leave early.** Churned customers had an average tenure of 18.0 months versus 37.6 for retained ones. The churn rate is 47.4% in the first 12 months and falls to 9.5% after 49 months.
- **Higher bills, higher churn.** Churned customers paid 74.44 per month on average versus 61.27 for retained customers.
- **Fiber optic customers churn at 41.9%**, compared with 19.0% for DSL and 7.4% for customers without internet service.
- **Electronic check is the only payment method above the average** churn rate (45.3%).
- **Highest-risk segment:** month-to-month, fiber optic customers without tech support. That group has 1,796 customers and a 57.5% churn rate.
- The monthly charges of churned customers add up to 139,130.85 per month in lost recurring revenue.

These are associations in the data, not proof of cause.

## Dataset

[Telco Customer Churn](https://www.kaggle.com/datasets/blastchar/telco-customer-churn) (Kaggle). Save as `telco_churn.csv` in this folder.

## Run it yourself

```
pip install pandas
python run_sql.py
```

The queries are in `queries.sql`. The script loads the CSV into `telco.db` and writes the output to `results.txt`.

## Next steps

- Visualise these results in a Tableau dashboard.
- Add a second table and practise `JOIN`s.
