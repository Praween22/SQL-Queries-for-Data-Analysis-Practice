SELECT * FROM machine.machine_testing;
-- use machine;
-- 1. I want to understand my sales in compare to categories

SELECT Category, sum(Total_Sales) AS t_sales
FROM machine_testing
group by Category
order by t_sales DESC;

-- Can you please help me with who are my best 5 customers

SELECT Customer_Name, sum(Total_Sales) as t_sales
FROM machine_testing
group by Customer_Name 
order by t_sales desc
limit 5;

-- What would be the conversion rate by payment method

SELECT Payment_Method,
concat(round(count(*)*100/(SELECT COUNT(*) FROM machine_testing),2),"%") AS Conv_rate
FROM machine_testing
group by Payment_Method;

--  Number of unique customers who placed an order per day

SELECT Date, COUNT(distinct(Customer_Name)) customers
From machine_testing
group by Date
order by Date;

-- Average Delivery Time (Assuming Date columns for Order and Delivery)

SELECT
round(AVG(datediff(Delivery_Date, Order_Date)),2) as avg_date
FROM machine_testing
WHERE Status="Completed";

SELECT Date, COUNT(*) AS orders
FROM machine_testing
GROUP BY Date
ORDER BY orders DESC
LIMIT 5;

-- Order Cancellation Rate by Location

SELECT Customer_Location,
concat(round(count(*)*100/
(SELECT count(*)
FROM machine_testing t2 WHERE t2.Customer_Location = t1.Customer_Location),2),"%") as Cancellation_Rate
FROM machine_testing t1
WHERE Status = "Cancelled"
group by Customer_Location;


-- Product Return Rate

SELECT Product,
concat(round(Count(*)*100/
(SELECT count(*) from machine_testing t2
WHERE t2.Product = t1.product),2),"%") as return_rate
FROM machine_testing t1
WHERE Status = "Cancelled"
group by product;