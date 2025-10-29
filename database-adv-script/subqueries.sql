-- SQL Subqueries Practice for Airbnb Database
-- ===========================================

-- 1. Non-correlated subquery: Find all properties where the average rating is greater than 4.0
SELECT 
    p.property_id,
    p.title AS property_title,
    p.price_per_night,
    p.city,
    p.country,
    (SELECT AVG(r.rating) 
     FROM reviews r 
     WHERE r.property_id = p.property_id) AS average_rating
FROM 
    properties p
WHERE 
    (SELECT AVG(r.rating) 
     FROM reviews r 
     WHERE r.property_id = p.property_id) > 4.0
ORDER BY 
    average_rating DESC;

-- Alternative approach using HAVING with subquery
SELECT 
    p.property_id,
    p.title AS property_title,
    p.price_per_night,
    (SELECT AVG(r.rating) FROM reviews r WHERE r.property_id = p.property_id) AS avg_rating
FROM 
    properties p
HAVING 
    avg_rating > 4.0
ORDER BY 
    avg_rating DESC;

-- 2. Correlated subquery: Find users who have made more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.created_at,
    (SELECT COUNT(*) 
     FROM bookings b 
     WHERE b.user_id = u.user_id) AS total_bookings
FROM 
    users u
WHERE 
    (SELECT COUNT(*) 
     FROM bookings b 
     WHERE b.user_id = u.user_id) > 3
ORDER BY 
    total_bookings DESC;

-- Bonus: Multiple subquery examples for practice

-- 3. Subquery in SELECT clause: Get property details with review counts
SELECT 
    p.property_id,
    p.title,
    p.price_per_night,
    (SELECT COUNT(*) FROM reviews r WHERE r.property_id = p.property_id) AS review_count,
    (SELECT AVG(rating) FROM reviews r WHERE r.property_id = p.property_id) AS avg_rating
FROM 
    properties p
ORDER BY 
    review_count DESC;

-- 4. Subquery with EXISTS: Find properties that have at least one booking
SELECT 
    p.property_id,
    p.title,
    p.host_id
FROM 
    properties p
WHERE 
    EXISTS (
        SELECT 1 
        FROM bookings b 
        WHERE b.property_id = p.property_id
    );

-- 5. Correlated subquery: Find hosts with properties having average rating above 4.5
SELECT 
    u.user_id AS host_id,
    u.first_name,
    u.last_name,
    u.email,
    (SELECT COUNT(*) 
     FROM properties p 
     WHERE p.host_id = u.user_id 
     AND (SELECT AVG(r.rating) FROM reviews r WHERE r.property_id = p.property_id) > 4.5
    ) AS high_rated_properties_count
FROM 
    users u
WHERE 
    (SELECT COUNT(*) 
     FROM properties p 
     WHERE p.host_id = u.user_id 
     AND (SELECT AVG(r.rating) FROM reviews r WHERE r.property_id = p.property_id) > 4.5
    ) > 0
ORDER BY 
    high_rated_properties_count DESC;