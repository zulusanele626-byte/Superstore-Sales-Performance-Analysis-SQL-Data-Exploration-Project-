--preview data 
SELECT*
FROM superstore_dataset

--checking for null values 

SELECT *
FROM superstore_dataset
WHERE Order_Date IS NULL
   OR Sales IS NULL;

--removing duplicated values 
SELECT DISTINCT *
FROM superstore_dataset;

--summing the total sales 
SELECT 
    SUM(Sales) AS total_sales
FROM superstore_dataset;

--the avg salales per order
SELECT 
    AVG(Sales) AS avg_sales
FROM superstore_dataset;

--analysing Sales Performance by Years 
SELECT 
    YEAR(Order_Date) AS year,
    SUM(Sales) AS total_sales
FROM superstore_dataset
GROUP BY YEAR(Order_Date)
ORDER BY year;

--analysing Sales Performance by Months 
SELECT 
    YEAR(Order_Date) AS year,
    MONTH(Order_Date) AS month,
    SUM(Sales) AS total_sales
FROM superstore_dataset
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY year, month;


--analysing Sales Performance Per Region 
SELECT 
    Region,
    SUM(Sales) AS total_sales
FROM superstore_dataset
GROUP BY Region
ORDER BY total_sales DESC;


--top ten sales by States 
SELECT TOP 10
    State,
    SUM(Sales) AS total_sales
FROM superstore_dataset
GROUP BY State
ORDER BY total_sales DESC

--total sales per customer 
SELECT 
    State,
    SUM(Sales) AS total_sales
FROM superstore_dataset
GROUP BY State
ORDER BY total_sales DESC

--repeat cutomer orders(order count)
SELECT 
    Customer_ID,
    COUNT(DISTINCT Order_ID) AS order_count,
    SUM(Sales) AS total_spent
FROM superstore_dataset
GROUP BY Customer_ID
ORDER BY order_count DESC;


--sales by segment 

SELECT 
    Segment,
    SUM(Sales) AS total_sales
FROM superstore_dataset
GROUP BY Segment
ORDER BY total_sales DESC;



--sales by category
SELECT 
    Category,
    SUM(Sales) AS total_sales
FROM superstore_dataset
GROUP BY Category
ORDER BY total_sales DESC;


---sales by sub category

SELECT 
    Sub_Category,
    SUM(Sales) AS total_sales
FROM superstore_dataset
GROUP BY Sub_Category
ORDER BY total_sales DESC;


--top 10 products 

SELECT TOP 10
    Product_Name,
    SUM(Sales) AS total_sales
FROM superstore_dataset
GROUP BY Product_Name
ORDER BY total_sales DESC;



--average shipping time 
SELECT 
    Ship_Mode,
    AVG(
        DATEDIFF(
            DAY,
            TRY_CONVERT(date, Order_Date),
            TRY_CONVERT(date, Ship_Date)
        )
    ) AS avg_shipping_days
FROM superstore_dataset
WHERE 
    TRY_CONVERT(date, Order_Date) IS NOT NULL
    AND TRY_CONVERT(date, Ship_Date) IS NOT NULL
GROUP BY Ship_Mode;


--number of orders per month

SELECT 
    YEAR(Order_Date) AS year,
    MONTH(Order_Date) AS month,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM superstore_dataset
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY year, month;


--customer lifetime value 
SELECT 
    Customer_ID,
    SUM(Sales) AS lifetime_value
FROM superstore_dataset
GROUP BY Customer_ID
ORDER BY lifetime_value DESC;


--Top customers per region
SELECT *
FROM (
    SELECT 
        Region,
        Customer_ID,
        SUM(Sales) AS total_sales,
        RANK() OVER (PARTITION BY Region ORDER BY SUM(Sales) DESC) AS rank
    FROM superstore_dataset
    GROUP BY Region, Customer_ID
) t
WHERE rank <= 3;