# banking-snowflake-sql-project
# Banking Customer Analytics

## Project Overview
Exploratory data analysis of a banking dataset using Snowflake SQL — covering data cleaning, customer segmentation, financial analysis, risk assessment, and business lending insights.

**Database:** `BANKINGDB.PUBLIC`
**Raw Table:** `BANKING` (3,000 rows)
**Cleaned Table:** `BANKING_CLEAN` (2,940 rows after deduplication)
**Columns:** 27 (Client_ID, Age, Nationality, Occupation, Income, Deposits, Loans, Risk_Weighting, etc.)

---

## Data Cleaning Steps
- Identified 59 duplicate rows using `Client_ID`
- Created `BANKING_CLEAN` using `ROW_NUMBER()` to retain one record per client
- Verified no NULL values in key columns
- Added derived column `age_category` (Young <25 / Adult 25-40 / Middle-Aged 41-60 / Senior 60+)

---

## Key Performance Indicators

| KPI | Value |
|-----|-------|
| Total Customers | 2,940 |
| Total Deposits | $1.97B |
| Total Loans | $1.74B |
| Avg Income | $171,475 |
| Total Savings | $683.6M |
| Total Credit Card Balance | $9.3M |
| Total Superannuation | $75.1M |

---

## Analysis & Insights

### 1. Customer Demographics

| Age Category | Count | % |
|---|---|---|
| Senior (60+) | 1,066 | 36.3% |
| Middle-Aged (41-60) | 857 | 29.2% |
| Adult (25-40) | 701 | 23.8% |
| Young (<25) | 316 | 10.7% |

- 65% of customers are 41+ — strong opportunity for retirement planning & wealth management
- Young segment at only 10.7% — gap in youth acquisition
- **Gender:** Nearly even split (1,453 vs 1,487)
- **Nationality:** Europe highest (1,283), Africa lowest (174)

### 2. Financial Analysis

| Metric | Senior | Middle-Aged | Adult | Young |
|--------|--------|-------------|-------|-------|
| Total Deposits | $708.7M | — | — | $204.8M |
| Total Loans | $628.8M | — | — | $177.5M |
| Credit Card Balance | — | $2.76M (highest) | — | $951K (lowest) |

- **Income by Occupation:** Software Engineer IV highest ($261,595), Staff Account I lowest ($97,680)
- Seniors dominate both deposits and loans due to segment size

### 3. Risk Analysis

| Age Category | Avg Risk Weighting |
|---|---|
| Middle-Aged | 2.26 |
| Senior | 2.26 |
| Adult | 2.24 |
| Young | 2.22 |

- Risk is **remarkably uniform** across all age groups (2.22–2.26)
- Age alone is NOT a strong risk differentiator
- Other factors (income, loan-to-deposit ratio) likely matter more

### 4. Business Lending

| Age Category | Users | Total Lending | Avg Lending |
|---|---|---|---|
| Senior | 1,062 | $928.4M | $870,898 |
| Middle-Aged | 853 | $732.4M | $854,572 |
| Adult | 698 | $617.0M | $880,111 |
| Young | 313 | $269.2M | $851,994 |

- **99.5%** of customers (2,926/2,940) have active business lending — near-universal adoption
- Total portfolio: **$2.55B**
- Adults have the highest avg lending ($880K) — high-value growth-phase borrowers
- Top occupations: General Manager ($1.43M), Engineer I ($1.30M), Food Chemist ($1.25M)

### 5. Loyalty Classification

| Tier | Customers | % |
|---|---|---|
| Jade | 1,304 | 44.4% |
| Silver | 754 | 25.6% |
| Gold | 574 | 19.5% |
| Platinum | 308 | 10.5% |

- Over 70% are Jade/Silver — large base for loyalty upgrade campaigns
- Only 10.5% are Platinum — exclusive tier, high retention priority

### 6. Credit Card Distribution

| Cards Held | Customers | % |
|---|---|---|
| 1 | 1,880 | 64.0% |
| 2 | 755 | 25.7% |
| 3 | 305 | 10.4% |

- 64% hold only 1 card — significant cross-sell opportunity
- 10.4% hold 3 cards — premium segment for rewards programs

### 7. Fee Structure

| Fee Tier | Customers | % |
|---|---|---|
| High | 1,441 | 49.0% |
| Mid | 944 | 32.1% |
| Low | 555 | 18.9% |

- Nearly half the customer base is on High fee structure — largest revenue contributors
- Only 19% on Low fees — bank successfully monetizes its customer base

### 8. Additional Findings
- **Multi-property owners:** 1,488 customers own more than 1 property
- **Highest-value customer:** Harry Burns — $6.42M total value
- **Busiest branch:** BR_ID 3 (1,318 customers)
- **Top relationship manager:** IA_ID 8 (176 customers)

---

## Recommendations
1. **Youth Acquisition:** Launch digital-first products (student accounts, starter credit cards) to grow the 10.7% Young segment
2. **Senior Wealth Management:** Offer premium advisory and retirement planning for the 36.3% Senior segment
3. **Adult Cross-Sell:** Highest avg business lending ($880K) — target with home loans, investments, and insurance
4. **Risk-Based Pricing:** Build models using income, loan-to-deposit ratio, and property ownership instead of age
5. **Branch Optimization:** BR_ID 3 handles 45% of customers — evaluate capacity and staffing
6. **RM Workload Balancing:** Top RM handles 176 customers — assess service quality and redistribute
7. **Loyalty Upgrades:** 70% at Jade/Silver — run engagement campaigns to drive tier upgrades
8. **Credit Card Cross-Sell:** 64% hold only 1 card — promote additional card products

---

## SQL Analyses Included (banking.sql)

| # | Analysis | Type |
|---|----------|------|
| 1 | Raw data & row count | Exploration |
| 2 | Null & duplicate checks | Data Quality |
| 3 | Deduplication (banking_clean) | Cleaning |
| 4 | Age category creation | Feature Engineering |
| 5 | Age category distribution | Demographics |
| 6 | KPI summary | Overview |
| 7 | Gender & nationality distribution | Demographics |
| 8 | Deposits & loans by age | Financial |
| 9 | Income by occupation | Financial |
| 10 | Credit card balance by age | Financial |
| 11 | Loyalty classification | Customer |
| 12 | Risk weighting by age | Risk |
| 13 | Business lending users | Lending |
| 14 | Multi-property owners | Asset |
| 15 | Top 10 high-value customers | Customer |
| 16 | Branch & RM distribution | Operations |
| 17 | Credit card count distribution | Product |
| 18 | Fee structure distribution | Revenue |

---

## Tech Stack
- **Platform:** Snowflake
- **Role:** ACCOUNTADMIN
- **Warehouse:** COMPUTE_WH
- **Database:** BANKINGDB
- **Language:** SQL

## Author
Saswat Betta
