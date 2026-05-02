SELECT
  *
FROM
  "BANKINGDB"."PUBLIC"."BANKING"
LIMIT
  10;

  USE DATABASE bankingdb;
USE SCHEMA PUBLIC;

--raw data check
select * from banking
select count(*) as total_rows from banking; ---3000 rows

-- Null Check Queries for BANKINGDB.PUBLIC.BANKING
-- Rows with any null values
SELECT *
FROM BANKINGDB.PUBLIC.BANKING
WHERE CLIENT_ID IS NULL
   OR NAME IS NULL
   OR AGE IS NULL
   OR ESTIMATED_INCOME IS NULL
   OR CREDIT_CARD_BALANCE IS NULL
   OR BANK_LOANS IS NULL
   OR BANK_DEPOSITS IS NULL
--duplicate check
select client_id, count(*) from banking
group by client_id
having count(*) > 1 ;
---59 rows are duplicate

SELECT COUNT(*) AS total_rows,
COUNT(DISTINCT Client_ID) AS unique_clients
FROM banking;---unique clients are 2940 from 3000 
---remove duplicate 
CREATE OR REPLACE TABLE banking_clean AS
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY CLIENT_ID
               ORDER BY Client_ID
           ) rn
    FROM banking
) x
WHERE rn = 1;
--check clean data
select * from banking_clean
select distinct * from banking_clean

--age category column add
ALTER TABLE banking_clean ADD COLUMN age_category VARCHAR(20);

UPDATE banking_clean
SET age_category = CASE
    WHEN age < 25 THEN 'Young'
    WHEN age BETWEEN 25 AND 40 THEN 'Adult'
    WHEN age BETWEEN 41 AND 60 THEN 'Middle-Aged'
    ELSE 'Senior'
END;
---age category frequency
SELECT age_category, COUNT(*) AS total
FROM banking_clean
GROUP BY age_category
ORDER BY total DESC;
--Senior customers (60+) dominate at 36.3% — the bank's largest segment, indicating a mature customer base
--65% of customers are 41+ — strong opportunity for retirement planning, wealth management, and insurance products
--Young customers (<25) are only 10.7% — suggests a gap in youth acquisition; potential to target with student/starter accounts and digital-first offerings
--Adult segment (25-40) at 23.8% represents the earning/growth phase — ideal for home loans, credit cards, and investment products.
--total_customers = 2940
select count(name) as total_customers,
       round(sum(bank_deposits), 2) as total_deposits,
       round(sum(bank_loans), 2) as total_loans,
       round(avg(estimated_income), 2) as avg_income,
       round(sum(saving_accounts), 2) as total_savings,
       round(sum(credit_card_balance), 2) as total_credit_card_balance,
       round(sum(superannuation_savings),2) as total_annual_savings
from banking_clean;
--KPI	Value
--Total Customers	2,940
--Total Deposits	$1.97B
--Total Loans	$1.74B
--Avg Income	$171,475
--Total Savings	$683.6M
--Total Credit Card Balance	$9.3M
--Total Superannuation	$75.1M
--gender wise coustomers
SELECT Gender_Id,
COUNT(*) AS customers
FROM banking_clean
GROUP BY Gender_Id;  ---gender_id 1 = 1453
                     ----gender_id 2 = 1487
--nationality wise customers
select nationality, count(*) as customers from banking_clean
group by nationality
order by customers desc; --Europe highset customers 1283
                         --Africa lowest customers 174
---Fainancial Analysis

--age category wise deposits
select age_category, sum(bank_deposits) as total_depsits from banking_clean
group by age_category
order by total_depsits desc; --highest total deposits senior category(708696072.20), lowest deposits total young category (204824471.44)

--Age Category Wise Loans
SELECT age_category,
SUM(Bank_Loans) AS total_loans
FROM banking_clean
GROUP BY age_category
ORDER BY total_loans DESC; --senior bring the highest loans (628826556.99), and young lowest total_loans (177519974.17)
--income by occupation
select occupation,round(avg(estimated_income), 2) as avg_income from banking_clean
group by occupation
order by avg_income desc; ---highest income by oocupation software engineer IV (261595.23), lowest staff Account I (97680.16)

--Total Credit Card Balance
SELECT age_category,
SUM(Credit_Card_Balance) AS total_balance
FROM banking_clean
GROUP BY age_category; --highest credit card balance Middle_age(2762544.60), lowest balance young (951423.01)
--loyality analysis
SELECT Loyalty_Classification,
COUNT(*) AS customers
FROM banking_clean
GROUP BY Loyalty_Classification
ORDER BY customers DESC;
--Risk Analysis
SELECT age_category,
ROUND(AVG(Risk_Weighting),2) AS avg_risk
FROM banking_clean
GROUP BY age_category
ORDER BY avg_risk DESC;
--Risk is nearly uniform across all age groups (2.22–2.26) — no segment stands out as high-risk.
--Middle-Aged & Senior are marginally highest at 2.26, while Young is lowest at 2.22.
--Age alone is not a strong risk differentiator — other factors like income or loan-to-deposit ratio likely matter more.

--Business Lending Users
SELECT age_category,
COUNT(*) AS business_users
FROM banking_clean
WHERE Business_Lending > 0
GROUP BY age_category; 
--Senior: 1,062 (36.3%) — largest segment, consistent with overall customer base distribution
--Middle-Aged: 853 (29.2%) — second largest lending group
--Adult: 698 (23.9%) — proportionally aligned with their population share
--Young: 313 (10.7%) — smallest but still 99% of young customers use business lending

---Which customers own multiple properties?
SELECT COUNT(*) AS multi_property_customers
FROM banking_clean
WHERE Properties_Owned > 1; ---properties 1488
--Which customers are high value?
SELECT Client_ID,
Name,
(Bank_Deposits + Saving_Accounts + Checking_Accounts) AS total_value
FROM banking_clean
ORDER BY total_value DESC
LIMIT 10;---Harry Burns highest total value is 6422950.77
--Which branch has most customers?
SELECT BR_Id,
COUNT(*) AS customers
FROM banking_clean
GROUP BY BR_Id
ORDER BY customers DESC;  -- The 3 BR_ID is the highest customers(1318)
--Which relationship manager (IA_Id) handles most customers?
SELECT IA_Id,
COUNT(*) AS customers
FROM banking_clean
GROUP BY IA_Id
ORDER BY customers DESC;-- 8,IA_ID handles the most customers (176)




