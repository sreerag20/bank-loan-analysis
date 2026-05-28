# Bank Loan Analysis Dashboard

> End-to-end bank loan analytics project examining loan performance, borrower risk profiles, repayment behaviour, and interest rate patterns across 39,717 loan records using SQL, Excel, and Power BI.

![SQL](https://img.shields.io/badge/SQL-MySQL-blue?logo=mysql&logoColor=white)
![Excel](https://img.shields.io/badge/Data-Excel-217346?logo=microsoft-excel&logoColor=white)
![PowerBI](https://img.shields.io/badge/Viz-PowerBI-F2C811?logo=powerbi&logoColor=black)
![CSV](https://img.shields.io/badge/Data-CSV-informational?logo=files&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

---

## Table of Contents

- [Project Overview](#project-overview)
- [Tech Stack](#tech-stack)
- [Folder Structure](#folder-structure)
- [Data Sources](#data-sources)
- [How to Run / Reproduce](#how-to-run--reproduce)
- [Key Findings](#key-findings)
- [Future Improvements](#future-improvements)
- [License](#license)

---

## Project Overview

This project delivers a multi-tool analytical solution for understanding bank loan performance across customer segments, geographies, and time periods. It combines structured SQL querying for KPI generation with interactive Excel and Power BI dashboards for business storytelling.

**Three dashboards were built:**

- **Excel Dashboard — Page 1** (`bank_loan_analysis_excel.xlsx`) — Covers 5 KPIs: year-wise loan amount trends by loan status, grade & sub-grade wise revolving balance, verified vs non-verified payment totals, state & credit pull date wise loan status, and home ownership vs last payment date breakdown.
- **Excel Dashboard — Page 2** (`bank_loan_analysis_excel.xlsx`) — Covers additional KPIs: year-wise average loan amount by status, grade-wise average revolving balance, max vs average interest rate, max vs average installment, and loan amount distribution by member count.
- **Power BI Dashboard** (`bank_loan_analysis_powerbi.pbix`) — Consolidated executive view with top-line KPI cards (39.72K customers, $446M total loan amount, $482.70M total payment, 25% max interest rate, $89.91M total interest, $1.31K max installment), interactive state and year filters, and all 8 KPI charts in a single scrollable canvas.

---

## Tech Stack

| Layer         | Tool / Format            | Purpose                                           |
|---------------|--------------------------|---------------------------------------------------|
| Raw Data      | CSV (.csv)               | Source loan records split across two files        |
| Database      | MySQL                    | Schema creation, date normalization, KPI tables   |
| Query Script  | SQL (.sql)               | 8 analytical KPI queries with `CREATE TABLE` outputs |
| Visualization | Microsoft Excel (.xlsx)  | Dual-page interactive KPI dashboard               |
| Visualization | Power BI (.pbix)         | Executive retention dashboard with KPI cards      |
| Presentation  | PowerPoint (.pptx)       | Project findings and methodology summary          |

---

## Folder Structure

```
bank-loan-analysis-dashboard/
│
├── data/
│   ├── raw/                                # Original source files — never modify
│   │   ├── finance_1_raw.csv               # Loan application & borrower data (39,717 rows, 24 cols)
│   │   └── finance_2_raw.csv               # Payment history & credit data (39,717 rows, 25 cols)
│   └── processed/
│       └── bank_loan_combined_export.csv   # Merged dataset after SQL join (optional)
│
├── sql/
│   └── bank_loan_analysis_final.sql        # Schema setup + 8 KPI queries
│
├── dashboards/
│   ├── bank_loan_analysis_excel.xlsx       # Excel dual-page dashboard
│   └── bank_loan_analysis_powerbi.pbix     # Power BI executive dashboard
│
├── visualizations/
│   ├── excel_dashboard_page1_v1.png        # Excel KPI 1–5 screenshot
│   ├── excel_dashboard_page2_v1.png        # Excel KPI averages & distribution screenshot
│   └── powerbi_dashboard_v1.png           # Power BI full dashboard screenshot
│
├── presentations/
│   └── bank_loan_analysis_slides.pptx      # Project summary deck
│
├── docs/
│   └── data_dictionary.md                  # Field definitions for Finance_1 and Finance_2
│
├── .gitignore
├── LICENSE
└── README.md
```

---

## Data Sources

### Finance_1 — Loan Application & Borrower Attributes
- **File:** `data/raw/finance_1_raw.csv`
- **Rows:** 39,717 &nbsp;|&nbsp; **Columns:** 24
- **Join Key:** `id`

| Field                 | Type    | Description                                               |
|-----------------------|---------|-----------------------------------------------------------|
| `id`                  | INT     | Unique loan identifier (primary join key)                 |
| `member_id`           | INT     | Unique borrower identifier                                |
| `loan_amnt`           | INT     | Requested loan amount in USD                              |
| `funded_amnt`         | INT     | Actual funded loan amount                                 |
| `funded_amnt_inv`     | FLOAT   | Amount funded by investors                                |
| `term`                | VARCHAR | Loan term: `36 months` / `60 months`                      |
| `int_rate`            | VARCHAR | Annual interest rate (stored as string, e.g. `10.65%`)    |
| `installment`         | FLOAT   | Monthly payment amount                                    |
| `grade`               | VARCHAR | Loan grade assigned by lender: A through G                |
| `sub_grade`           | VARCHAR | Loan sub-grade (e.g., A1, B3)                             |
| `emp_length`          | VARCHAR | Borrower employment length                                |
| `home_ownership`      | VARCHAR | Housing status: MORTGAGE, RENT, OWN, NONE, OTHER          |
| `annual_inc`          | FLOAT   | Borrower annual income                                    |
| `verification_status` | VARCHAR | Income verification: Verified / Not Verified / Source Verified |
| `issue_d`             | DATE    | Loan issue date (2007–2011)                               |
| `loan_status`         | VARCHAR | Current status: Fully Paid / Charged Off / Current        |
| `addr_state`          | VARCHAR | US state abbreviation (borrower address)                  |
| `dti`                 | FLOAT   | Debt-to-income ratio                                      |

### Finance_2 — Payment History & Credit Behaviour
- **File:** `data/raw/finance_2_raw.csv`
- **Rows:** 39,717 &nbsp;|&nbsp; **Columns:** 25
- **Join Key:** `id`

| Field                    | Type    | Description                                      |
|--------------------------|---------|--------------------------------------------------|
| `id`                     | INT     | Foreign key → `Finance_1.id`                     |
| `revol_bal`              | INT     | Total revolving credit balance                   |
| `revol_util`             | VARCHAR | Revolving credit utilization rate                |
| `total_pymnt`            | FLOAT   | Total payment received to date                   |
| `total_rec_prncp`        | FLOAT   | Principal received to date                       |
| `total_rec_int`          | FLOAT   | Interest received to date                        |
| `last_pymnt_d`           | DATE    | Date of last payment                             |
| `last_pymnt_amnt`        | FLOAT   | Last payment amount                              |
| `last_credit_pull_d`     | DATE    | Most recent credit inquiry date                  |
| `earliest_cr_line`       | DATE    | Date of borrower's earliest credit line          |
| `delinq_2yrs`            | INT     | Number of delinquencies in last 2 years          |
| `inq_last_6mths`         | INT     | Credit inquiries in last 6 months                |
| `open_acc`               | INT     | Number of open credit accounts                   |
| `pub_rec`                | INT     | Number of derogatory public records              |
| `out_prncp`              | FLOAT   | Remaining outstanding principal                  |
| `recoveries`             | FLOAT   | Post charge-off gross recovery                   |

> **Join Key:** `Finance_1.id = Finance_2.id`

---

## How to Run / Reproduce

### Prerequisites

- MySQL 8.0+
- Microsoft Excel 2016+ or Microsoft 365
- Power BI Desktop (free from Microsoft)

### Step 1 — Set Up the Database

```sql
CREATE DATABASE project_bank;
USE project_bank;
```

### Step 2 — Import Raw Data

Import `finance_1_raw.csv` and `finance_2_raw.csv` into MySQL as `finance_1` and `finance_2` using MySQL Workbench's **Table Data Import Wizard**, or convert programmatically:

```bash
# Load CSVs into MySQL via command line
mysqlimport --local --fields-terminated-by=',' --lines-terminated-by='\n' \
  --columns='id,member_id,loan_amnt,...' \
  -u your_user -p project_bank data/raw/finance_1_raw.csv
```

### Step 3 — Run SQL Script

The script handles date column type corrections, removes invalid rows, and creates 8 KPI output tables (`kpi1` through `kpi8`):

```bash
mysql -u your_user -p project_bank < sql/bank_loan_analysis_final.sql
```

**KPI queries included:**

| KPI | Description |
|-----|-------------|
| KPI 1 | Year-wise loan amount stats by loan status |
| KPI 2 | Grade and sub-grade wise total revolving balance |
| KPI 3 | Total payment: Verified vs Non-Verified borrowers |
| KPI 4 | State-wise and last credit pull year wise loan status |
| KPI 5 | Home ownership vs last payment date stats |
| KPI 6 | Average revolving balance by loan grade |
| KPI 7 | Average loan amount by loan status |
| KPI 8 | Count of members by loan amount band |

### Step 4 — Open Dashboards

**Excel:**
```
Open: dashboards/bank_loan_analysis_excel.xlsx
Navigate between Page 1 (KPI 1–5) and Page 2 (KPI averages & distributions)
Refresh pivot tables if connected to a live data source
```

**Power BI:**
```
File → Open → dashboards/bank_loan_analysis_powerbi.pbix
Use the Year and State slicers on the right panel to filter all visuals
```

---

## Key Findings

- **Fully Paid loans dominate loan volume ($358M)** versus Charged Off ($68M) and Current ($19M), indicating an overall healthy repayment portfolio — yet the ~17% charge-off rate signals meaningful default risk that warrants grade-based risk pricing.
- **Grade B carries the highest revolving balance ($161M)**, followed by Grade A ($115M) and Grade C ($110M), suggesting mid-tier risk borrowers hold the largest share of outstanding credit exposure.
- **Not Verified borrowers account for 45.55% of total payments ($219.9M)**, the largest share, raising questions about whether income verification correlates with repayment reliability — a key risk monitoring opportunity.
- **Current-status borrowers have the highest average loan amount ($17K)** compared to Fully Paid ($11K) and Charged Off ($12K), indicating that larger loans in active repayment carry disproportionate portfolio risk if conditions deteriorate.

---

## Future Improvements

1. **Default Risk Prediction Model** — Train a binary classifier (logistic regression or gradient boosting) on borrower attributes from Finance_1 and payment history from Finance_2 to predict charge-off probability at origination.
2. **Geographic Risk Heatmap** — Build a US state-level choropleth map in Power BI or Tableau to visualize charge-off rates and average loan amounts by state, enabling regional risk monitoring.
3. **Automated Monthly Refresh Pipeline** — Set up a scheduled Python or dbt pipeline to ingest new loan data, rerun KPI queries, and refresh both dashboards automatically without manual SQL execution.

---

## License

This project is licensed under the [MIT License](LICENSE).

> Dataset contains anonymized retail lending records used for educational and analytical purposes only. No personally identifiable information (PII) is present in the published dataset.
