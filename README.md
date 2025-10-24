# 🎬 Landing Page Product Analytics – AWS · Power BI · Statistical Experimentation

## 🎯 Overview  

This project focused on analyzing the **performance and user engagement** of my company’s **landing page**, which serves as a critical entry point for user conversion and content discovery.  
The initiative was led in collaboration with the **audiovisual production team**, who aimed to identify which page elements (videos, visuals, or text) increased user retention and interaction.  

The project combined **data scraping, relational modeling, inferential statistics, and dashboard visualization** to deliver actionable insights that informed both **creative design and product strategy**.  

---

## ⚙️ Project Workflow  

### **1️⃣ Requirement Mapping**
- Conducted a **needs assessment** with the audiovisual production and web development teams to understand data availability and experimentation goals.  
- Identified key user actions and conversion triggers for analysis (clicks, dwell time, video views, and bounce rate).  

🧰 *Tools:* Interviews · Stakeholder Workshops · Figma (metric sketching)  

---

### **2️⃣ KPI Design & Approval**
- Proposed a set of **core KPIs** focused on engagement and retention:
  - CTR (Click-Through Rate)
  - Avg. Watch Time
  - Scroll Depth
  - Conversion Funnel Drop-offs
  - Revenue Share per Partner  
- Presented these metrics to stakeholders for validation prior to data collection.  

🧰 *Tools:* Power BI · Excel · Miro  

---

### **3️⃣ Data Extraction & Modeling**
- Performed **web scraping from AWS-hosted landing page data** (consumption logs, event clicks, partner data).  
- Designed a **relational data model** integrating:
  - User interaction data (clicks, scrolls)
  - Content metadata from audiovisual production
  - Revenue share per partner  
- Ensured data consistency and relational integrity across different sources.  

🧰 *Tools:* Python (BeautifulSoup, Pandas) · SQL · AWS S3 · Power BI  

---

### **4️⃣ Statistical Analysis & Sampling**
- Applied **stratified sampling** to ensure balanced representation of users and sessions.  
- Conducted **inferential analyses**:
  - Variance comparison tests (F-tests)
  - Effect size calculation (Cohen’s d)
  - Confidence intervals for engagement metrics  
- Used statistical insights to **refine KPI thresholds** and define baselines for experimentation.  

🧠 *Key Concept:* Combining inferential statistics and behavioral analytics to strengthen experimental validity.  

🧰 *Tools:* Python (scipy, statsmodels) · R (tidyverse)  

---

### **5️⃣ Iteration & Design Improvement**
- Conducted iterative feedback sessions with the audiovisual team to **improve dashboard usability and visualization layout**.  
- Adjusted metric visualization to better support storytelling and creative decision-making.  

🧰 *Tools:* Power BI · Power Query · DAX  

---

### **6️⃣ Data Filtering & Tracking**
- Built **multivariable filtering models** in Power BI for dynamic slicing by:
  - Content type
  - Partner
  - Time period
  - Device type  
- Collaborated with web developers to **add URL tracking parameters**, improving event-level traceability on the landing page.  

🧰 *Tools:* Power BI · Power Query · Web Analytics Integration  

---

### **7️⃣ Experimentation & Pilot Testing**
- Conducted a **pilot experiment** with stakeholders and the audiovisual team:
  - Compared baseline vs. experimental landing versions.
  - Measured behavioral changes in interaction and time-on-page.  
- Delivered a **final product analytics dashboard** used for weekly performance reviews and creative iteration.  

🧰 *Tools:* Power BI · Python · AWS · Excel  

---

## 📊 Results & Impact  

- Established a **reliable data model and dashboard** integrating behavioral, creative, and financial metrics.  
- Reduced reporting turnaround time by **>65%**.  
- Enabled **evidence-based creative decisions** through statistically validated experiments.  
- Increased stakeholder adoption and data literacy within non-technical teams.  

---

## 🧰 Tech Stack  

| Category | Tools & Technologies |
|-----------|---------------------|
| Data Sources | AWS Logs · Web Clickstream · Partner Revenue Data |
| Data Engineering | Python (BeautifulSoup, Pandas) · SQL · Power Query |
| Statistics | Python (scipy, statsmodels) · R (tidyverse) |
| Visualization | Power BI (DAX, KPIs, Filters) |
| Collaboration | Stakeholder Sessions · Experimentation Framework |

---

## 📁 Folder Structure  

```markdown
landingpage_product_analytics/
│
├── 📘 README.md                      # Project documentation
│
├── 📂 notebooks/
│   ├── 01_kpi_design.ipynb           # KPI exploration and definition
│   ├── 02_data_scraping_aws.ipynb    # Web scraping and data extraction
│   ├── 03_relational_modeling.ipynb  # Schema creation and joins
│   ├── 04_statistical_analysis.ipynb # Sampling, variance tests, effect size
│   ├── 05_dashboard_metrics.ipynb    # KPI validation and visualization design
│
├── 📂 data/
│   ├── raw_aws_logs.csv              # Scraped landing data (anonymized)
│   ├── partner_revenue.csv           # Partner revenue information
│   ├── content_metadata.csv          # Audiovisual content metadata
│   ├── clickstream_data.csv          # User interaction logs
│   └── sampling_results.csv          # Stratified sampling data
│
├── 📂 dashboard/
│   ├── landing_dashboard.pbix        # Final Power BI dashboard
│   ├── dax_measures.txt              # Key DAX metrics
│   └── powerquery_scripts.m          # Power Query ETL transformations
│
├── 📂 reports/
│   ├── dashboard_preview.png         # Dashboard screenshot
│   ├── pilot_experiment_results.pdf  # Experimentation summary
│   └── statistical_summary.xlsx      # Statistical analysis results
│
└── 📂 docs/
    ├── kpi_definitions.md            # KPI dictionary and formulas
    ├── stakeholder_feedback.md       # Iteration notes
    └── lessons_learned.md
