# 🏦 Banking Customer Analytics | End-to-End Data Engineering on Snowflake

![Snowflake](https://img.shields.io/badge/Platform-Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)
![SQL](https://img.shields.io/badge/Language-SQL-orange?style=for-the-badge&logo=postgresql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Dataset](https://img.shields.io/badge/Records-2,940-blue?style=for-the-badge)

---

## 📌 Project Summary

| Item | Detail |
|------|--------|
| **Domain** | Banking / Financial Services |
| **Platform** | Snowflake Cloud Data Warehouse |
| **Raw Records** | 3,000 customers |
| **Clean Records** | 2,940 customers |
| **Total Deposits** | $1.97B |
| **Total Loans** | $1.74B |
| **Business Lending** | $2.55B |
| **Approach** | Ingestion → Deduplication → Feature Engineering → Analytics |
| **Queries** | 18 analytical SQL queries |

---

## 🏗️ Architecture — Medallion-Style Pipeline

```
┌────────────────────────────────────────────────────────────────────────────────┐
│                        END-TO-END DATA PIPELINE                                │
│                                                                                │
│  ┌──────────┐    ┌───────────────┐    ┌──────────────┐    ┌───────────────┐   │
│  │  BRONZE  │───▶│    SILVER     │───▶│     GOLD     │───▶│   INSIGHTS    │   │
│  │ (Raw)    │    │ (Cleaned)     │    │ (Enriched)   │    │ (Analytics)   │   │
│  └──────────┘    └───────────────┘    └──────────────┘    └───────────────┘   │
│                                                                                │
│  • 3,000 rows     • ROW_NUMBER()    • Age categories    • Segmentation      │
│  • 27 columns     • Dedup (59 dupes)• Loyalty tiers     • Risk analysis     │
│  • Raw schema     • 2,940 clean     • Feature eng.      • Lending insights  │
│                                                                                │
└────────────────────────────────────────────────────────────────────────────────┘
```

---

## 📂 Project Structure

```
banking-data-engineering/
│
├── 📄 README.md                   ← Project documentation (you are here)
├── 📄 banking.sql                 ← All SQL queries (18 analyses)
│
├── 🔹 Bronze Layer                ← Raw data (BANKING - 3,000 rows)
├── 🔹 Silver Layer                ← Cleaned (BANKING_CLEAN - 2,940 rows)
├── 🔹 Gold Layer                  ← Derived: age_category, loyalty, risk
└── 🔹 Analytics Layer             ← Customer segmentation & financial insights
```

---

## 📊 Data Schema (27 Columns)

| # | Key Columns | Description |
|---|-------------|-------------|
| 1 | `CLIENT_ID` | Unique customer identifier |
| 2 | `AGE` | Customer age |
| 3 | `GENDER` | Male / Female |
| 4 | `NATIONALITY` | Region/continent |
| 5 | `OCCUPATION` | Job title |
| 6 | `INCOME` | Annual income ($) |
| 7 | `DEPOSITS` | Total deposits ($) |
| 8 | `LOANS` | Total loans ($) |
| 9 | `SAVINGS` | Savings balance ($) |
| 10 | `RISK_WEIGHTING` | Risk score (1-5) |
| 11 | `BUSINESS_LENDING` | Business loan amount ($) |
| 12 | `LOYALTY_CLASS` | Jade / Silver / Gold / Platinum |
| 13 | `CREDIT_CARD_BALANCE` | Outstanding CC balance |
| 14 | `NO_OF_CREDIT_CARDS` | Cards held (1-3) |
| 15 | `FEE_STRUCTURE` | Low / Mid / High |
| 16 | `PROPERTIES_OWNED` | Number of properties |
| 17 | `AGE_CATEGORY` | Derived: Young / Adult / Middle-Aged / Senior |

---

## 🔧 Pipeline Execution Steps

### 🟤 Step 1 — Bronze Layer (Raw Ingestion)
```sql
SELECT * FROM BANKINGDB.PUBLIC.BANKING;
-- 3,000 raw customer records, 27 columns
```

### ⚪ Step 2 — Silver Layer (Deduplication)

| Check | Method | Result |
|-------|--------|--------|
| Duplicate Detection | `ROW_NUMBER() OVER (PARTITION BY Client_ID)` | 59 duplicates found |
| Clean Table | `BANKING_CLEAN` (rn = 1 only) | 3,000 → 2,940 |
| Null Audit | Full column null check | ✅ All clean |

### 🟡 Step 3 — Gold Layer (Feature Engineering)
```sql
-- Age category derivation
ALTER TABLE BANKING_CLEAN ADD COLUMN age_category VARCHAR;
UPDATE BANKING_CLEAN SET age_category = 
  CASE
    WHEN AGE < 25 THEN 'Young'
    WHEN AGE BETWEEN 25 AND 40 THEN 'Adult'
    WHEN AGE BETWEEN 41 AND 60 THEN 'Middle-Aged'
    ELSE 'Senior'
  END;
```

### 🟢 Step 4 — Analytics Layer
- 18 analytical queries across demographics, finance, risk, and operations

---

## 📈 Key Performance Indicators (KPIs)

| KPI | Value | Interpretation |
|-----|-------|----------------|
| 👥 Total Customers | **2,940** | After deduplication |
| 💰 Total Deposits | **$1.97B** | Customer deposits |
| 🏦 Total Loans | **$1.74B** | Outstanding loans |
| 💼 Business Lending | **$2.55B** | Business loan portfolio |
| 💵 Avg Income | **$171,475** | Per-customer average |
| 🏠 Total Savings | **$683.6M** | Customer savings |
| 💳 Total CC Balance | **$9.3M** | Credit card outstanding |
| 🎖️ Superannuation | **$75.1M** | Retirement funds |

---

## 🔍 Deep-Dive Insights

### 1️⃣ Customer Demographics — Senior-Heavy Portfolio

| Age Category | Customers | Share | Total Deposits |
|--------------|-----------|-------|----------------|
| 👴 Senior (60+) | 1,066 | 36.3% | $708.7M |
| 🧑‍💼 Middle-Aged (41-60) | 857 | 29.2% | — |
| 👨‍💻 Adult (25-40) | 701 | 23.8% | — |
| 🧑‍🎓 Young (<25) | 316 | 10.7% | $204.8M |

> 💡 **Insight:** **65% of customers are 41+** — strong retirement/wealth management opportunity. Youth segment at only **10.7%** — acquisition gap.

---

### 2️⃣ Financial Snapshot by Segment

| Metric | Senior | Middle-Aged | Adult | Young |
|--------|--------|-------------|-------|-------|
| Total Deposits | $708.7M | — | — | $204.8M |
| Total Loans | $628.8M | — | — | $177.5M |
| CC Balance | — | **$2.76M** (highest) | — | $951K (lowest) |
| Avg Business Lending | $870,898 | $854,572 | **$880,111** | $851,994 |

> 💡 **Insight:** **Adults (25-40)** have the highest avg business lending ($880K) — high-value growth-phase borrowers.

---

### 3️⃣ Risk Analysis — Uniform Across Ages

| Age Category | Avg Risk Weighting |
|--------------|-------------------|
| Middle-Aged | 2.26 |
| Senior | 2.26 |
| Adult | 2.24 |
| Young | 2.22 |

> 💡 **Insight:** Risk is **remarkably uniform** (2.22–2.26). Age alone is NOT a risk differentiator — need multi-factor models (income, LTD ratio, properties).

---

### 4️⃣ Business Lending — Near-Universal Adoption

| Metric | Value |
|--------|-------|
| Customers with BL | 2,926 |
| Adoption Rate | **99.5%** |
| Total Portfolio | **$2.55B** |
| Top Occupation | General Manager ($1.43M avg) |
| Second | Engineer I ($1.30M avg) |

> 💡 **Insight:** **99.5% of customers** have active business lending — it's a universal product, not a niche offering.

---

### 5️⃣ Loyalty Tiers

| Tier | Customers | Share | Strategy |
|------|-----------|-------|----------|
| 💚 Jade | 1,304 | 44.4% | Upgrade campaigns |
| 🥈 Silver | 754 | 25.6% | Cross-sell opportunities |
| 🥇 Gold | 574 | 19.5% | Retention & premium offers |
| 💎 Platinum | 308 | 10.5% | Exclusive retention priority |

> 💡 **Insight:** 70% are Jade/Silver — massive base for loyalty upgrade programs.

---

### 6️⃣ Credit Card & Fee Analysis

| Cards Held | Customers | Share |
|------------|-----------|-------|
| 1 card | 1,880 | **64.0%** |
| 2 cards | 755 | 25.7% |
| 3 cards | 305 | 10.4% |

| Fee Tier | Customers | Share |
|----------|-----------|-------|
| High | 1,441 | **49.0%** |
| Mid | 944 | 32.1% |
| Low | 555 | 18.9% |

> 💡 **Insight:** 64% hold only 1 card — **significant cross-sell opportunity**. 49% on High fees — bank effectively monetizes its base.

---

### 7️⃣ Top Customers & Operations

| Metric | Value |
|--------|-------|
| 🏆 Highest-Value Customer | Harry Burns — $6.42M |
| 🏢 Busiest Branch | BR_ID 3 (1,318 customers / 45%) |
| 👨‍💼 Top RM | IA_ID 8 (176 customers) |
| 🏠 Multi-Property Owners | 1,488 (50.6%) |

---

## 📋 Complete Analysis Catalog

| # | Analysis | Category | Layer |
|---|----------|----------|-------|
| 1 | Raw data preview & row count | Exploration | Bronze |
| 2 | Null & duplicate checks | Data Quality | Silver |
| 3 | Deduplication (BANKING_CLEAN) | Cleaning | Silver |
| 4 | Age category creation | Feature Eng. | Gold |
| 5 | Age category distribution | Demographics | Analytics |
| 6 | KPI summary (deposits, loans, savings) | Overview | Analytics |
| 7 | Gender & nationality distribution | Demographics | Analytics |
| 8 | Deposits & loans by age | Financial | Analytics |
| 9 | Income by occupation | Financial | Analytics |
| 10 | Credit card balance by age | Financial | Analytics |
| 11 | Loyalty classification | Customer | Analytics |
| 12 | Risk weighting by age | Risk | Analytics |
| 13 | Business lending users & amounts | Lending | Analytics |
| 14 | Multi-property owners | Asset | Analytics |
| 15 | Top 10 high-value customers | Customer | Analytics |
| 16 | Branch & RM distribution | Operations | Analytics |
| 17 | Credit card count distribution | Product | Analytics |
| 18 | Fee structure distribution | Revenue | Analytics |

---

## 🛠️ SQL Techniques & Methods

| Technique | Use Case |
|-----------|----------|
| `ROW_NUMBER() OVER (PARTITION BY)` | Deduplication by Client_ID |
| `CASE WHEN` | Age category feature engineering |
| `SUM() / AVG() / COUNT()` | Financial aggregations |
| `GROUP BY + ORDER BY` | Segment analysis |
| `COUNT(DISTINCT)` | Unique entity counting |
| `ROUND()` | Clean financial formatting |
| `HAVING COUNT(*) > 1` | Multi-property detection |

---

## ✅ Key Findings & Recommendations

| # | Finding | Recommendation | Priority |
|---|---------|----------------|----------|
| 1 | Youth segment only 10.7% | Launch digital-first products (student accounts, starter cards) | 🔴 High |
| 2 | 64% hold only 1 credit card | Cross-sell additional cards with rewards programs | 🔴 High |
| 3 | Seniors = 36.3% of customers | Expand wealth management & retirement advisory services | 🟡 Medium |
| 4 | Adults have highest avg BL ($880K) | Target with home loans, investments, insurance bundles | 🟡 Medium |
| 5 | Risk uniform across ages (2.22-2.26) | Build multi-factor risk models (income, LTD, properties) | 🟡 Medium |
| 6 | Branch 3 handles 45% of customers | Evaluate capacity, consider redistribution or expansion | 🟢 Low |
| 7 | Top RM: 176 customers | Assess service quality; redistribute to prevent burnout | 🟢 Low |
| 8 | 70% Jade/Silver loyalty | Design tier upgrade incentives to move to Gold/Platinum | 🟢 Low |

---

## Tech Stack

| Layer | Technology |
|-------|------------|
| **Cloud Platform** | Snowflake |
| **Compute** | COMPUTE_WH (Virtual Warehouse) |
| **Database** | BANKINGDB |
| **Schema** | PUBLIC |
| **Language** | SQL |
| **Role** | ACCOUNTADMIN |
| **IDE** | Snowsight (Snowflake Web UI) |

---

 #How to Run

```sql
-- Step 1: Set context
USE DATABASE BANKINGDB;
USE SCHEMA PUBLIC;

-- Step 2: Verify raw data
SELECT * FROM BANKING LIMIT 10;

-- Step 3: Verify clean data
SELECT * FROM BANKING_CLEAN LIMIT 10;

-- Step 4: Run banking.sql queries sequentially

##  Author

**Saswat Betta Aptakam**

*Built with  Snowflake | End-to-End Data Analysis Projects*
