-- SQL Aggregations and Window Functions for Airbnb Database
-- ========================================================

-- 1. Aggregation with GROUP BY: Total number of bookings made by each user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_price) AS total_spent,
    AVG(b.total_price) AS average_booking_value
FROM 
    users u
LEFT JOIN 
    bookings b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email
ORDER BY 
    total_bookings DESC;

-- 2. Window Functions: Rank properties based on total number of bookings
SELECT 
    p.property_id,
    p.title AS property_title,
    p.city,
    p.country,
    p.price_per_night,
    COUNT(b.booking_id) AS total_bookings,
    -- ROW_NUMBER: Unique sequential number for each row
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank_row_number,
    -- RANK: Rank with gaps for ties
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank,
    -- DENSE_RANK: Rank without gaps for ties
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank_dense
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.title, p.city, p.country, p.price_per_night
ORDER BY 
    total_bookings DESC;

-- 3. Additional Aggregation: Average rating and review count per property
SELECT 
    p.property_id,
    p.title,
    p.price_per_night,
    COUNT(r.review_id) AS total_reviews,
    AVG(r.rating) AS average_rating,
    MIN(r.rating) AS min_rating,
    MAX(r.rating) AS max_rating
FROM 
    properties p
LEFT JOIN 
    reviews r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, p.title, p.price_per_night
HAVING 
    COUNT(r.review_id) > 0
ORDER BY 
    average_rating DESC;

-- 4. Window Function with PARTITION: Rank properties within each city
SELECT 
    p.property_id,
    p.title AS property_title,
    p.city,
    p.country,
    p.price_per_night,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (
        PARTITION BY p.city 
        ORDER BY COUNT(b.booking_id) DESC
    ) AS city_booking_rank,
    AVG(p.price_per_night) OVER (PARTITION BY p.city) AS avg_city_price
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.title, p.city, p.country, p.price_per_night
ORDER BY 
    p.city, city_booking_rank;

-- 5. Complex Aggregation: Monthly booking trends
SELECT 
    DATE_FORMAT(b.check_in_date, '%Y-%m') AS booking_month,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_price) AS total_revenue,
    AVG(b.total_price) AS average_booking_value,
    COUNT(DISTINCT b.user_id) AS unique_users,
    COUNT(DISTINCT b.property_id) AS unique_properties
FROM 
    bookings b
WHERE 
    b.status = 'confirmed'
GROUP BY 
    DATE_FORMAT(b.check_in_date, '%Y-%m')
ORDER BY 
    booking_month DESC;

-- 6. Window Function: Running total of revenue by month
SELECT 
    DATE_FORMAT(b.check_in_date, '%Y-%m') AS booking_month,
    SUM(b.total_price) AS monthly_revenue,
    SUM(SUM(b.total_price)) OVER (
        ORDER BY DATE_FORMAT(b.check_in_date, '%Y-%m')
        ROWS UNBOUNDED PRECEDING
    ) AS running_total_revenue
FROM 
    bookings b
WHERE 
    b.status = 'confirmed'
GROUP BY 
    DATE_FORMAT(b.check_in_date, '%Y-%m')
ORDER BY 
    booking_month;

-- 7. Advanced Window Function: Compare property price to neighborhood average
SELECT 
    p.property_id,
    p.title,
    p.city,
    p.neighborhood,
    p.price_per_night,
    AVG(p.price_per_night) OVER (PARTITION BY p.city, p.neighborhood) AS avg_neighborhood_price,
    p.price_per_night - AVG(p.price_per_night) OVER (PARTITION BY p.city, p.neighborhood) AS price_difference_from_avg,
    CASE 
        WHEN p.price_per_night > AVG(p.price_per_night) OVER (PARTITION BY p.city, p.neighborhood) THEN 'Above Average'
        WHEN p.price_per_night < AVG(p.price_per_night) OVER (PARTITION BY p.city, p.neighborhood) THEN 'Below Average'
        ELSE 'Average'
    END AS price_category
FROM 
    properties p
ORDER BY 
    p.city, p.neighborhood, p.price_per_night DESC;