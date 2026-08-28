# NaijaMart Retail Sales Analysis

## 📊 Project Overview

**NaijaMart Retail Sales Analysis** is a SQL-based retail analytics project focused on evaluating sales performance, profitability, customer behavior, product performance, sales channels, geographic performance, and purchasing patterns.

The analysis was performed using a **SQLite relational database** containing customer, product, order, and order-item data.

The objective was to transform raw transactional data into meaningful business insights that could support decisions around **product strategy, profitability, customer retention, sales channels, and market performance**.

---

## 🎯 Business Questions

This project answers key business questions including:

* What are NaijaMart's overall revenue, cost, profit, and profit margin?
* Which products generate the most revenue and profit?
* Which product categories are the most profitable?
* How do Online and Store sales channels compare?
* How does sales performance change throughout the year?
* Which customer segments generate the most value?
* How does purchasing performance differ by gender?
* Which states and cities generate the most revenue?
* What proportion of customers are repeat versus one-time buyers?
* Which products are frequently purchased together?

---

## 🗂️ Database Structure

The database contains four main tables:

| Table           | Description                                             |
| --------------- | ------------------------------------------------------- |
| **Customers**   | Customer demographic and segmentation information       |
| **Products**    | Product details, categories, prices and costs           |
| **Orders**      | Order dates, customers, sales channels and order status |
| **Order_items** | Products and quantities associated with each order      |

### Key Relationships

```text
Customers
    │
    │ customer_id
    ▼
Orders
    │
    │ order_id
    ▼
Order_items
    │
    │ product_id
    ▼
Products
```

---

## 🛠️ Tools & Technologies

* **SQLite** — Database management and SQL analysis
* **SQL** — Data querying, transformation and analysis
* **GitHub** — Project version control and portfolio presentation

### SQL Techniques Used

* `SELECT`
* `WHERE`
* `JOIN`
* `GROUP BY`
* `ORDER BY`
* `CASE`
* `COUNT`
* `SUM`
* `ROUND`
* `strftime`
* Subqueries
* Conditional aggregation
* Distinct counting
* Profit and margin calculations
* Customer retention analysis
* Product basket analysis

---

## 📈 Key Performance Indicators

Analysis was based on **completed orders**.

| KPI                     |         Result |
| ----------------------- | -------------: |
| **Total Revenue**       | ₦1,521,397,000 |
| **Total Cost**          | ₦1,081,584,000 |
| **Total Profit**        |   ₦439,813,000 |
| **Profit Margin**       |     **28.91%** |
| **Completed Orders**    |          4,418 |
| **Units Sold**          |         21,582 |
| **Average Order Value** |    ₦344,363.29 |

---

## 🔎 Key Insights

### 1. Electronics drives revenue and profit

Electronics generated approximately **₦1.406 billion in revenue** and **₦390.37 million in profit**, making it the dominant category by overall financial contribution.

However, Accessories achieved a significantly higher profit margin:

* **Electronics:** 27.76%
* **Accessories:** 42.98%

This indicates that Electronics is the primary **scale driver**, while Accessories are a stronger **margin contributor**.

---

### 2. Oraimo Laptop was the leading product by revenue

The **Oraimo Laptop** generated approximately **₦248.04 million in revenue** and **₦52.47 million in profit**, making it the strongest individual product by revenue in the completed-order analysis.

---

### 3. August recorded the highest monthly revenue

August was the strongest month, generating approximately **₦154.27 million in revenue**.

February recorded the lowest monthly revenue at approximately **₦107.28 million**.

This indicates noticeable variation in monthly sales performance throughout the year.

---

### 4. Online sales generated more revenue

The Online channel generated approximately **₦918.01 million in revenue**, compared with **₦603.39 million** from Store sales.

However, the profit margins were relatively similar:

* **Online:** 28.86%
* **Store:** 28.98%

This suggests that Online sales provide greater sales volume without a major difference in profitability.

---

### 5. Regular customers generated the highest total value

Regular customers generated approximately:

* **₦804.28 million in revenue**
* **₦230.30 million in profit**

Premium customers had the highest revenue per customer, at approximately **₦1.56 million**, indicating that although the Premium segment is smaller, each customer represents significant value.

---

### 6. Customer repeat purchasing was very strong

Among customers with completed purchases:

* **946 customers (95.36%)** were repeat customers.
* **46 customers (4.64%)** were one-time customers.

This indicates a strong repeat-purchase pattern within the dataset.

---

### 7. Geographic performance varied across states

Anambra was the strongest state by revenue, generating approximately **₦176.59 million**, followed by Rivers at approximately **₦168.11 million**.

Lagos generated approximately **₦127.79 million** among the states represented in the dataset.

These results describe performance within this dataset and should not be interpreted as a measure of the overall economic size of each state.

---

### 8. Product combinations reveal potential cross-selling opportunities

Several product combinations appeared repeatedly in completed orders.

The most frequent combinations occurred together in **8 completed orders**.

Because the frequency is relatively small compared with the total number of completed orders, these combinations should be treated as **potential cross-selling opportunities for further investigation**, rather than definitive bundling recommendations.

---

## 💡 Business Recommendations

Based on the analysis, the following actions could be considered:

### 1. Protect the Electronics revenue base

Electronics is the primary revenue and profit driver. High-performing products should receive continued attention through inventory planning, pricing strategy, and promotional activity.

### 2. Increase Accessories cross-selling

Accessories have a much higher profit margin than Electronics. NaijaMart could investigate opportunities to recommend complementary accessories during Electronics purchases.

### 3. Investigate August sales drivers

August produced the highest monthly revenue. Further analysis could examine whether promotions, product availability, customer behavior, or seasonal factors contributed to the increase.

### 4. Strengthen Online sales

Online sales generated substantially more revenue than Store sales while maintaining a similar profit margin. Improving the online customer experience could provide an opportunity to scale this channel further.

### 5. Continue customer retention initiatives

The high proportion of repeat customers suggests that retention is an important strength in the dataset. Loyalty initiatives and personalized offers could be used to maintain customer engagement.

---

## 🖼️ Project Screenshots

### Overall Business KPIs

![KPI Analysis](screenshots/kpi-analysis.png)

### Category Performance

![Category Performance](screenshots/category-performance.png)

### Monthly Revenue Performance

![Monthly Revenue](screenshots/monthly-revenue.png)

### Customer Retention

![Customer Retention](screenshots/customer-retention.png)

---

## 📁 Project Structure

```text
NaijaMart-Retail-SQL-Analysis/
│
├── sql/
│   └── naijamart_retail_analysis_final.sql
│
├── database/
│   └── naijamart_retail.db
│
├── screenshots/
│   ├── kpi-analysis.png
│   ├── category-performance.png
│   ├── monthly-revenue.png
│   └── customer-retention.png
│
└── README.md
```

---

## ▶️ How to Reproduce the Analysis

1. Download or clone the repository.
2. Open `database/naijamart_retail.db` using a SQLite-compatible application.
3. Confirm the four tables are available:

   * Customers
   * Products
   * Orders
   * Order_items
4. Open `sql/naijamart_retail_analysis_final.sql`.
5. Connect the SQL editor to the NaijaMart database.
6. Execute the queries to reproduce the analysis and results.

---

## 📌 Project Outcome

This project demonstrates the use of SQL to move from **raw transactional data to structured business analysis**.

The analysis covers financial performance, product and category profitability, sales channels, monthly trends, customer segmentation, geographic performance, retention, and product purchasing patterns.

It also demonstrates how SQL can be used not only to retrieve data, but to **answer practical business questions and support data-driven recommendations**.

---

## 👤 Author

**Opeyemi Obikoya**

Data Analytics | SQL | Power BI | Excel | Data Analysis
