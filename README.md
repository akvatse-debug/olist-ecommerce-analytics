Olist E-Commerce Analytics Project
Tools: MySQL and Power BI 

Project Overview
End-to-end data analytics project analyzing 100,000+ orders 
from Olist, a Brazilian e-commerce platform. The project 
covers data cleaning, advanced SQL analysis, and interactive 
Power BI dashboard creation.


Tools & Technologies
Database: MySQL 8.0
Visualization**: Power BI Desktop


Dashboard Pages
| Page | Description |
| Executive Overview | KPI cards, monthly revenue, customer segmentation |
| Sales & Revenue | Revenue by category, state, payment type, leakage |
| Delivery & Reviews | Late delivery analysis, review distribution |
| Customer Analysis | RFM segmentation, cohort analysis |
| Seller Health | Custom health scoring system |
| Key Insights | Data-driven findings & recommendations |


Database Schema
8 cleaned tables used in analysis:
- `orders_clean` — 99K orders
- `orderitems_clean` — 112K items
- `customer_clean` — 99K customers
- `sellers_clean` — 3.1K sellers
- `products_clean` — 32K products
- `orderpayments_clean` — 103K payments
- `orderreview_clean` — 99K reviews
- `geo_clean` — geolocation data


Key SQL Techniques Used
CTEs — Complex multi-step analysis
Window Functions — NTILE, ROW_NUMBER, LAG
Views — 14 analytical views created
Aggregations — Revenue, KPIs, distributions
Date Functions — Cohort analysis, delivery tracking
CASE WHEN** — Health scoring, flags, segmentation



Key Findings
- Total revenue: R$ 13.59M across 99K orders
- 91.9% orders delivered on time
- Only 497 Champion customers (0.5% of base)
- 44K customers need retention attention (47%)
- R$ 219K revenue leakage identified
- Critical sellers have 19% late delivery rate
- At Risk sellers have highest avg reviews (4.45)
  — quality sellers with low order volume


Business Recommendations
1. Launch retention campaign for 44K at-risk customers
2. Reduce late deliveries in SP state — highest volume state
3. Support At Risk sellers to increase order volume
4. Expand Health & Beauty inventory — top revenue category
5. Incentivize boleto users to switch to credit card


Dashboard Screenshots

Page 1 — Executive Overview
![Executive Overview](screenshots/page1_executive_overview.png)

Page 2 — Sales & Revenue
![Sales Revenue](screenshots/page2_sales_revenue.png)

Page 3 — Delivery & Reviews
![Delivery Reviews](screenshots/page3_delivery_reviews.png)

Page 4 — Customer Analysis
![Customer Analysis](screenshots/page4_customer_analysis.png)

Page 5 — Seller Health
![Seller Health](screenshots/page5_seller_health.png)

Page 6 — Key Insights
![Key Insights](screenshots/page6_key_insights.png)


Author
Akash Vatse
