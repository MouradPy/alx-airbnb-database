-- Complex SQL Joins for Airbnb Database
-- ======================================

-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id
ORDER BY 
    b.booking_id;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties with no reviews
SELECT 
    p.property_id,
    p.title AS property_title,
    p.price_per_night,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date,
    u.first_name AS reviewer_name
FROM 
    properties p
LEFT JOIN 
    reviews r ON p.property_id = r.property_id
LEFT JOIN 
    users u ON r.user_id = u.user_id
ORDER BY 
    p.property_id, r.created_at DESC;

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if user has no booking or booking has no user
-- Note: MySQL doesn't support FULL OUTER JOIN directly, so we use UNION of LEFT and RIGHT JOINs
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price,
    b.status
FROM 
    users u
LEFT JOIN 
    bookings b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price,
    b.status
FROM 
    users u
RIGHT JOIN 
    bookings b ON u.user_id = b.user_id
WHERE 
    u.user_id IS NULL
ORDER BY 
    user_id, booking_id;

-- Bonus: Complex query with multiple joins to get booking details with property and user info
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    u.email AS guest_email,
    p.property_id,
    p.title AS property_title,
    p.price_per_night,
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id
INNER JOIN 
    properties p ON b.property_id = p.property_id
INNER JOIN 
    users host ON p.host_id = host.user_id
ORDER BY 
    b.booking_id;