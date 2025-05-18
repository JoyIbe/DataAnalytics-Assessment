/**1. High-Value Customers with Multiple Products
Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
Tables:
users_customuser
savings_savingsaccount
plans_plan
**/

SELECT * FROM plans_plan;
SELECT * FROM users_customuser;
SELECT * FROM savings_savingsaccount;

-- Find users with at least one funded savings plan and one funded investment plan
-- sorted by their total confirmed deposits

SELECT 
    u.id,
    CONCAT(u.first_name, ' ', u.last_name) AS Name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    SUM(s.confirmed_amount) AS total_deposit
FROM users_customuser u
JOIN plans_plan p ON p.owner_id = u.id
JOIN savings_savingsaccount s ON s.plan_id = p.id
GROUP BY u.id, u.first_name, u.last_name
HAVING 
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) > 0 AND
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) > 0
ORDER BY total_deposit DESC;
