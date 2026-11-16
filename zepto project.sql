DROP TABLE IF EXISTS zepto;

TRUNCATE TABLE products;

CREATE TABLE zepto (
    Serial_no INT PRIMARY KEY,
    Category VARCHAR(100),
    name VARCHAR(150),
    mrp NUMERIC(10,2),
    discount_Percent NUMERIC(5,2),
    available_Quantity INT,
    discounted_SellingPrice NUMERIC(10,2),
    weightInGms NUMERIC(10,2),
    outOfStock BOOLEAN,
    quantity INT
);

--COUNT OF ROWS

SELECT COUNT(*) FROM zepto;

--SAMPLE DATA

SELECT * FROM zepto
WHERE name IS NULL 
OR
 Category IS NULL 
OR
 mrp IS NULL 
OR
 discount_Percent IS NULL 
OR
 discounted_SellingPrice IS NULL 
OR
 weightInGms IS NULL 
OR
 outOfStock IS NULL 
OR
 quantity  IS NULL ;


--DIFFERENT PRODUCTS CATEGORIES

SELECT DISTINCT Category
FROM zepto
ORDER BY category ;

--PRODUCT INSTOCK VS OUTOFSTOCK

SELECT outofstock , COUNT(serial_no) AS stock
FROM zepto
GROUP BY outofstock ;

--PRODUCTS PRESENT MULTIPLE TIMES

SELECT name ,COUNT(serial_no) AS Total_products
FROM zepto
GROUP BY name
HAVING COUNT(serial_no)>1
ORDER BY total_products DESC;


--DATA CLEANING

SELECT * FROM zepto
WHERE mrp = 0 OR c = 0;

DELETE FROM zepto
WHERE mrp = 0;

--CONVERT PAISE TO RUPEES

UPDATE zepto
SET mrp = mrp/100;

UPDATE zepto
SET discounted_sellingprice = discounted_sellingprice/100;

-- Q1. FIND THE TOP 10 BEST-VALUE PRODUCTS BASED ON THE DISCOUNT PERCENTAGE.

SELECT DISTINCT name,category,Mrp,discount_percent,discounted_sellingprice
FROM zepto
ORDER BY discount_percent DESC
LIMIT 10;

-- Q2. WHAT ARE THE PRODUCTS WITH HIGH MRP BUT OUT OF STOCK

SELECT DISTINCT name ,mrp ,outofstock
FROM zepto
WHERE outofstock = 'true' and mrp>300
ORDER BY mrp DESC;

-- Q3. CALCULATE ESTIMATED REVENUE FOR EACH CATEGORY

SELECT category, SUM(discounted_sellingprice * quantity )AS revenue
FROM zepto
GROUP BY category
ORDER BY revenue;


-- Q4. FIND ALL PRODUCTS WHERE MRP IS GREATER THAN ₹500 AND DISCOUNT IS LESS THAN 10%.

SELECT * FROM zepto
WHERE mrp>500 AND  Discount_percent<10
ORDER BY serial_no ASC;

-- Q5. IDENTIFY THE TOP 5 CATEGORIES OFFERING THE HIGHEST AVERAGE DISCOUNT PERCENTAGE.

SELECT DISTINCT category , ROUND(AVG(discount_percent),2) AS average
FROM zepto
GROUP BY category
ORDER BY average DESC
LIMIT 5;

-- Q6. FIND THE PRICE PER GRAM FOR PRODUCTS ABOVE 100G AND SORT BY BEST VALUE.

SELECT name ,ROUND(discounted_sellingprice/NULLIF(weightingms,0),2) AS price_per_gm
from zepto
ORDER BY price_per_gm ASC;

-- Q7. GROUP THE PRODUCTS INTO CATEGORIES LIKE LOW, MEDIUM, BULK.

SELECT name ,quantity ,
CASE
WHEN quantity BETWEEN 1 AND 10 THEN 'low'
WHEN quantity BETWEEN 11 AND 50 THEN 'medium'
ELSE 'Bulk'
END AS stock
FROM zepto
ORDER BY quantity ASC ;


-- Q8. WHAT IS THE TOTAL INVENTORY WEIGHT PER CATEGORY

SELECT category,SUM(weightingms * quantity) AS Total_in_weight
FROM zepto
GROUP BY category
ORDER BY total_in_weight;
 
