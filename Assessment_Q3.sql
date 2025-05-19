/**3. Account Inactivity Alert
Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .
Tables:
plans_plan
savings_savingsaccount **/

SELECT * FROM plans_plan;
SELECT * FROM savings_savingsaccount;

-- Account Inactivity Alert
-- Find all plan (savings or investments) with no inflow transactions in the last 365 days.

SELECT 
    p.id AS plan_id,
    p.owner_id AS owner_id,
    p.description AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id
GROUP BY p.id, p.owner_id
HAVING MAX(s.transaction_date) IS NULL OR DATEDIFF(CURDATE(), MAX(s.transaction_date)) > 365
ORDER BY inactivity_days DESC;
