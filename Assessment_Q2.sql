/**2. Transaction Frequency Analysis
Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
Task: Calculate the average number of transactions per customer per month and categorize them:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month)
Tables:
users_customuser
savings_savingsaccount
**/

SELECT * FROM users_customuser;
SELECT * FROM savings_savingsaccount;

-- Transaction Frequency Analysis
-- Step 1: Calculate total customers
-- Step 2: Calculates average transactions per customer per month
-- Step 3: and categorizes them based on frequency.

SELECT 
    u.id AS users_id,
	COUNT(s.id) AS customer_count,
    COUNT(s.id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) AS avg_transactions_per_month, -- calculating the average per month
    CASE 
        WHEN COUNT(s.id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) >= 10 THEN 'High Frequency'
        WHEN COUNT(s.id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id
GROUP BY u.id
ORDER BY avg_transactions_per_month DESC;


