# DataAnalytics-Assessment

## 1. High-Value Customers with Multiple Products

### Question
Identify users who have:
- At least one funded savings plan (is_regular_savings = 1)
- At least one funded investment plan (is_a_fund = 1)
- Sort them by total confirmed savings deposits

### Approach
1. Start from the `users_customuser` table to get all users.
2. Join the `plans_plan` table using `owner_id` to access each user’s plans.
3. Then join the `savings_savingsaccount` table using `plan_id` to get confirmed savings deposits.
4. Filter for only funded accounts using `confirmed_amount > 0`.
5. Using `COUNT(DISTINCT )`, Calculate:
   - Number of savings plans (`is_regular_savings = 1`)
   - Number of investment plans (`is_a_fund = 1`)
6. Ensure each user meets both criteria using the `HAVING` clause.
7. Finally, sum the confirmed amounts and sort the result.

### Challenges
- The initial query incorrectly filtered `is_regular_savings = 1 AND is_a_fund = 1` at the row level, which made it impossible for a row to qualify as both a savings and investment plan.
- The corrected query uses `CASE WHEN` conditions in aggregate functions to handle this check correctly across a user's different plans.

## 2: Transaction Frequency Analysis
### Question 
- Calculate total customers
- Calculates average transactions per customer per month
- and categorizes them based on frequency:
  
   - High Frequency (≥10 transactions/month)
   - Medium Frequency (3–9 transactions/month)
   - Low Frequency (≤2 transactions/month)

### Approach:
1. Join the relevant tables:
Joined `users_customuser` with `savings_savingsaccount` on the `owner_id` key to associate transactions with customers.

2. Group by customer:
The query groups results by `user_id`, meaning each row represents one customer.

3. Calculate monthly transaction frequency:
We count total transactions per customer.
We count distinct months using `DATE_FORMAT(transaction_date, '%Y-%m')`.
We divide the two to compute the average number of transactions per month per customer.

4. Classify customers into frequency tiers using a `CASE` statement.

### Result
A list of high-value users who have both product types and significant deposits, helping identify potential cross-selling opportunities.

## 3. Account Inactivity Alert
### Question:
flag accounts with no inflow activity for over 1 year (365 days).

### Approach:
1. Join Plans and Transactions:
We join `plans_plan` with `savings_savingsaccount` on `plan_id` to connect plans to transactions.

2. Find Latest Transaction:
Using `MAX(transaction_date)` per plan to find the most recent inflow.

3. Calculate Inactivity Days:
Using `DATEDIFF()` to calculate the number of days since the last transaction.

4. Filter Inactive Accounts:
Accounts with `NULL` transaction dates (never funded) or those with last activity more than 365 days ago are included.

5. Query Logic Summary:
`LEFT JOIN` ensures all plans are considered, even if they have no associated transactions.

`GROUP BY` plan ID and owner to analyze per account.

6. HAVING clause filters:
Plans that never had a transaction `(MAX(...) IS NULL)`
Or where the last transaction was more than 365 days ago.

### Challenges & Resolutions:
Challenge | Resolution
|---|---|
Handling accounts with no transactions	| Used LEFT JOIN and MAX(...) IS NULL logic to include these.
Calculating accurate inactivity	| Used DATEDIFF(CURDATE(), MAX(...)) to compute days since last activity.



 ## 4. Customer Lifetime Value (CLV) Estimation
 
 ### Question: Estimate the CLV for each customer
For each customer:
- Calculate **tenure in months** since signup.
- Count total number of transactions.
- Compute average profit per transaction (0.1% of transaction value).
- Calculate Estimate CLV using the formula

### Approach:
Used a single SQL query with the following structure:

1. Join `users_customuser` with `savings_savingsaccount` on `owner_id` to link each transaction with its user.

2. Account tenure was calculated using `TIMESTAMPDIFF(MONTH, created_on, CURDATE())`.

3. Total transactions was calculated using `COUNT(s.id)`.

4. Average profit per transaction was derived from `AVG(s.confirmed_amount * 0.001)`.

5. The CLV formula was applied using `ROUND()` for readability.

6. The final output was sorted by `estimated_clv` in descending order to show the highest-value customers first.


