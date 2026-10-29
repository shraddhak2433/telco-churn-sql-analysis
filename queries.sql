-- Q1: Overall churn rate
SELECT COUNT(*) AS customers, SUM(Churn = 'Yes') AS churned,
       ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 1) AS churn_pct
FROM customers;

-- Q2: Churn rate by contract type
SELECT Contract, COUNT(*) AS customers,
       ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 1) AS churn_pct
FROM customers
GROUP BY Contract
ORDER BY churn_pct DESC;

-- Q3: Average tenure and monthly charges, churned vs stayed
SELECT Churn, ROUND(AVG(tenure), 1) AS avg_tenure_months,
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM customers
GROUP BY Churn;

-- Q4: Churn rate by internet service
SELECT InternetService, COUNT(*) AS customers,
       ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 1) AS churn_pct
FROM customers
GROUP BY InternetService
ORDER BY churn_pct DESC;

-- Q5: Payment methods with churn above the overall average (HAVING + subquery)
SELECT PaymentMethod,
       ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 1) AS churn_pct
FROM customers
GROUP BY PaymentMethod
HAVING churn_pct > (SELECT 100.0 * SUM(Churn = 'Yes') / COUNT(*) FROM customers)
ORDER BY churn_pct DESC;

-- Q6: Monthly revenue lost to churned customers
SELECT ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_lost
FROM customers
WHERE Churn = 'Yes';

-- Q7: Churn rate by tenure group (CASE)
SELECT CASE WHEN tenure <= 12 THEN '1: 0-12 months'
            WHEN tenure <= 24 THEN '2: 13-24 months'
            WHEN tenure <= 48 THEN '3: 25-48 months'
            ELSE '4: 49+ months' END AS tenure_group,
       COUNT(*) AS customers,
       ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 1) AS churn_pct
FROM customers
GROUP BY tenure_group
ORDER BY tenure_group;

-- Q8: Rank contract types by churn risk (CTE + window function)
WITH rates AS (
  SELECT Contract, ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 1) AS churn_pct
  FROM customers GROUP BY Contract
)
SELECT Contract, churn_pct, RANK() OVER (ORDER BY churn_pct DESC) AS risk_rank
FROM rates;

-- Q9: High-risk segment: month-to-month, fiber optic, no tech support
SELECT COUNT(*) AS customers,
       ROUND(100.0 * SUM(Churn = 'Yes') / COUNT(*), 1) AS churn_pct
FROM customers
WHERE Contract = 'Month-to-month' AND InternetService = 'Fiber optic' AND TechSupport = 'No';
