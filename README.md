# DataAnalytics-Assessment

## High-Value Customers with Multiple Products

## Question
Identify users who have:
- At least one funded savings plan (is_regular_savings = 1)
- At least one funded investment plan (is_a_fund = 1)
- Sort them by total confirmed savings deposits

## Approach
1. Start from the `users_customuser` table to get all users.
2. Join the `plans_plan` table using `owner_id` to access each user’s plans.
3. Then join the `savings_savingsaccount` table using `plan_id` to get confirmed savings deposits.
4. Filter for only funded accounts using `confirmed_amount > 0`.
5. Using `COUNT(DISTINCT )`, Calculate:
   - Number of savings plans (`is_regular_savings = 1`)
   - Number of investment plans (`is_a_fund = 1`)
6. Ensure each user meets both criteria using the `HAVING` clause.
7. Finally, sum the confirmed amounts and sort the result.

## Challenges
- The initial query incorrectly filtered `is_regular_savings = 1 AND is_a_fund = 1` at the row level, which made it impossible for a row to qualify as both a savings and investment plan.
- The corrected query uses `CASE WHEN` conditions in aggregate functions to handle this check correctly across a user's different plans.

## Result
A list of high-value users who have both product types and significant deposits, helping identify potential cross-selling opportunities.
