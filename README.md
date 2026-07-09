# Bank Transaction Fraud Detection & Risk Operations Audit

## Project Overview
This project analyzes transactional ledger data from 200,000 active banking customer accounts to identify environmental and behavioral factors associated with financial fraud status. 

Using SQL Server (T-SQL) and Power BI, I optimized back-end tables, built an in-flight predictive view engine, constructed a confusion matrix validation framework, and designed an interactive dashboard to communicate risk metrics and process constraints to executive stakeholders.

## Business Problem
A retail banking security team wanted to understand how localized geographic hotspots, temporal transaction windows, account categories, and hardware channels differ between verified fraudulent actions and legitimate user records. 

The goal was to transform raw historical database transactions into actionable insights that optimize real-time risk blocking, minimize manual compliance backlogs, and protect client user experiences.

## Tools Used
* **SQL Server (T-SQL)**
* **Power BI Desktop**
* **Power Query**
* **DAX**
* **Data Modeling**
* **Confusion Matrix Validation**
* **Business Intelligence**

## Dashboard Features
* **Executive KPI Command Center:** Tracks total volume, actual fraud volume, and the global system baseline fraud rate.
* **Demographic Risk Infiltration:** Maps fraud counts across calculated age groups to identify primary data cohorts.
* **Geographic Hotspot Bar Chart:** Displays the top 10 cities ranked via visual filters to surface localized geographic outliers.
* **Temporal Line Chart:** Traces chronological mapping of transaction volume spikes across hours of the day.
* **Interactive Slicer Sidebar:** Allows risk managers to instantly filter the entire canvas view by account type, device type, and gender.
* **Operational Volume KPI Banner:** Arranged horizontally with display units disabled to force precise, unrounded counts.
* **Automated Confusion Matrix Grid:** Built as a 2x2 matrix visual featuring cell background color data gradients to highlight quadrant distributions.
* **Treemap Visual:** Maps out caught fraud by the specific rule category to analyze downstream investigator workloads.
* **Canvas Explanatory Text Box:** Embeds a simplified data constraint summary explaining row-level transaction isolation.

## Key Findings
* The predictive engine successfully caught **762 real fraud cases** and maintained an overall data processing accuracy of **88.61%**.
* The static rule layers generated **13,461 false alarms**, resulting in a **7.09% Customer Disruption Rate** alongside a **7.55% Fraud Detection Rate**.
* **9,326 fraud cases** bypassed the rules entirely because fraud perfectly mimics clean row-level transaction footprints across demographic data.
* Transactions executed via **desktop environments** and physical **Debit/Credit Cards** dominated unauthorized ledger actions.
* The city of **Haridwar (Uttarakhand)** and the **Midnight window (00:00 to 04:59)** were isolated as the highest-risk geo-temporal spikes.
* **Business accounts (5.17%)** and **Savings accounts (5.03%)** slightly outpaced traditional checking accounts in fraud penetration.
* Transaction monetary sizes showed **no statistically significant variance**, proving basic transaction value thresholds fail to isolate risks.

## Recommendations
* Transition the system logic from static, standalone client identity profiles to **Stateful Behavioral Tracking Rules**.
* Deploy spatial and chronological velocity metrics using **`LAG()` and `LEAD()` window functions** to track impossible travel and rapid card testing.
* Remove or reduce basic transaction value thresholds from active automated blocking triggers to avoid non-value-adding false alarms.
* Scale manual investigation capacity and allocate dedicated compliance analysts to review queues originating from **Haridwar, Uttarakhand**.
* Configure dynamic automated pipeline routing to push transactions from high-fraud branch hubs into a secondary review status rather than immediate block status.
* Establish a permanent **Continuous Integration (CI) logic audit** by scheduling the SQL confusion matrix query weekly to monitor shifting fraud patterns.

## Dashboard Preview
* `[Screenshot 1]` - Executive Risk Command Center
* `[Screenshot 2]` - Predictive Engine Performance Audit

## Files Included
* **Back-End T-SQL View Script** (`.sql`)
* **SQL Diagnostic Exploratory Script** (`.sql`)
* **Power BI Dashboard File** (`.pbix`)
* **Financial Risk & Fraud Detection Operations Report** (`.docx`)

## Skills Demonstrated
* Relational Database Management (RDBMS)
* T-SQL Views & Aggregations
* Data Query Optimization
* Common Table Expressions (CTEs)
* Power Query Data Profiling
* Advanced DAX Context Modifiers (`CALCULATE`, `SWITCH(TRUE())`)
* Semantic Data Modeling
* Confusion Matrix Validation Math
* Financial Risk Reporting & Data Storytelling

## Contact
**Mbulelo Majola**  
* **LinkedIn:** [://linkedin.com](https://://linkedin.com)  
* **Email:** [mbulelomdletshe7@gmail.com](mailto:mbulelomdletshe7@gmail.com)

