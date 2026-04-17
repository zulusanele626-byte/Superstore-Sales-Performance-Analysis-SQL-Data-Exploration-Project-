--PROFITABILITY LOGIC
SELECT 
    Category,
    SUM(Sales) AS total_sales,
    AVG(Sales) AS avg_order_value
FROM superstore_dataset
GROUP BY Category
ORDER BY total_sales DESC;
--ORDER FREQUENCY ANALYSIS
SELECT 
    Customer_ID,
    COUNT(Order_ID) AS total_orders
FROM superstore_dataset
GROUP BY Customer_ID
HAVING COUNT(Order_ID) > 5
ORDER BY total_orders DESC;

--SALES CONSISTENCY OVER TIME

SELECT 
    YEAR(Order_Date) AS year,
    MONTH(Order_Date) AS month,
    SUM(Sales) AS monthly_sales
FROM superstore_dataset
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY year, month;

--DELIVERY EFFICIENCY
SELECT 
    Ship_Mode,
    AVG(DATEDIFF(DAY, Order_Date, Ship_Date)) AS avg_delivery_time
FROM superstore_dataset
GROUP BY Ship_Mode
ORDER BY avg_delivery_time;


--CUSTOMER DEPENDENCY

SELECT 
    Segment,
    COUNT(DISTINCT Customer_ID) AS total_customers,
    SUM(Sales) AS total_sales
FROM superstore_dataset
GROUP BY Segment;