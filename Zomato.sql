SELECT * FROM ZOMATO;

# TOTAL RESTAURANT
SELECT COUNT(`RestaurantID`) AS Total_Restaurants
FROM zomato;

# TOTAL CUISINES 
SELECT COUNT(DISTINCT Cuisines) AS Total_Cuisines
FROM zomato;

# TOTal VOTES
SELECT SUM(Votes) AS Total_Votes
FROM zomato;

# OVERALL AVERAGE RATING
SELECT
    ROUND(AVG(`rating`), 2) AS Avg_Aating
FROM zomato
WHERE `rating` > 0;

------------------------------ Country & City Wise Restaurnat Count ----------------------------------------

# COUNTRY Wise Restaurant Count
SELECT
    `Country Name` AS Country_Name,
    COUNT(`RestaurantID`) AS Total_Restaurants
FROM zomato
GROUP BY `Country Name`
ORDER BY total_restaurants DESC;

# Country & city Wise Restaurant Count
SELECT
    `Country Name` AS Country,
    City,
    COUNT(`RestaurantID`) AS Total_Restaurants
FROM zomato
GROUP BY `Country Name`, City
ORDER BY Total_Restaurants DESC;

--------------------------------  # YEAR-QUARTER-MONTH (FULL TIME HIERARCHY) ---------------------------

# YEAR WISE Restaurants COUNT
 SELECT
    YEAR(`Datekey Opening`) AS Year,
    COUNT(*) AS Restaurants_Opened
FROM zomato
GROUP BY year
ORDER BY year;

 # Year-Quater-Month wise Restaurant Count
SELECT
    YEAR(`Datekey Opening`) AS Year,
    CONCAT('Q', QUARTER(`Datekey Opening`)) AS Quarter,
    MONTH(`Datekey Opening`) AS Month_no,
    MONTHNAME(`Datekey Opening`) AS Month_Name,
    COUNT(`RestaurantID`) AS Restaurants_Opened
FROM zomato
GROUP BY year, quarter, month_no, month_name
ORDER BY year, quarter, month_no;


--------------------------------  # RATING Wise BUCKET DISTRIBUTION ------------------------------------------

SELECT
    CASE
        WHEN rating IS NULL OR rating = 0 THEN 'No Rating'
        WHEN rating BETWEEN 0.1 AND 2.0 THEN '0 – 2 (Poor)'
        WHEN rating BETWEEN 2.1 AND 3.5 THEN '2.1 – 3.5 (Average)'
        WHEN rating BETWEEN 3.6 AND 4.0 THEN '3.6 – 4.0 (Good)'
        WHEN rating BETWEEN 4.1 AND 5.0 THEN '4.1 – 5.0 (Excellent)'
    END AS Rating_Bucket,
    COUNT(*) AS Restaurant_Count
FROM zomato
GROUP BY rating_bucket
ORDER BY restaurant_count DESC;



------------------------ # PRICE Wise BUCKET ANALYSIS (₹ INSIGHT) --------------------

SELECT
CASE
    WHEN average_cost_for_two < 500 THEN 'Low Cost'
    WHEN average_cost_for_two BETWEEN 500 AND 1500 THEN 'Medium Cost'
    WHEN average_cost_for_two BETWEEN 1501 AND 3000 THEN 'High Cost'
    ELSE 'Premium'
END AS Price_Bucket,
COUNT(*) AS Restaurant_Count
FROM zomato
GROUP BY price_bucket;

SELECT
    `Price Bucket` AS Price_Bucket,
    COUNT(`RestaurantID`) AS Restaurant_Count
FROM zomato
GROUP BY `Price Bucket`
ORDER BY restaurant_count DESC;

-------------------------------- # TABLE BOOKING PERCENTAGE ---------------------------------------

SELECT
    Has_Table_Booking,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM zomato) AS Percentage
FROM zomato
GROUP BY has_table_booking;

---------------------- # ONLINE DELIVERY PERCENTAGE -------------------

SELECT
    Has_Online_Delivery,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM zomato) AS Percentage
FROM zomato
GROUP BY has_online_delivery;


-- # TOP 10 CUSINES  --------------------------------------------------------

SELECT Cuisines, COUNT(*) AS Total
FROM zomato
GROUP BY cuisines
ORDER BY total DESC
LIMIT 10;

-- #Top 10 Cities by Restaurant count -----------------------------
SELECT City, COUNT(*) AS Total
FROM zomato
GROUP BY city
ORDER BY total DESC
LIMIT 10;

