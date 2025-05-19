/** 4 Customer Lifetime Value (CLV) Estimation
Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
Account tenure (months since signup)
Total transactions
Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Order by estimated CLV from highest to lowest

Tables:
users_customuser
savings_savingsaccount
**/

SELECT * FROM users_customuser;
SELECT * FROM savings_savingsaccount;

-- assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
-- Account tenure (months since signup)
-- Total transactions
-- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
-- Order by estimated CLV from highest to lowest
SELECT 
    u.id AS user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.created_on, CURDATE()) AS tenure,
    COUNT(s.id) AS total_transactions,
    ROUND((COUNT(s.id) / (TIMESTAMPDIFF(MONTH, u.created_on, CURDATE()))) 
    * 12 * AVG(s.confirmed_amount * 0.001), 2) AS estimated_clv
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id
GROUP BY u.id, name, u.created_on
ORDER BY estimated_clv DESC;
