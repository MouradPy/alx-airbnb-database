-- Query Performance Optimization - Airbnb Database
-- ================================================

-- INITIAL QUERY (Before Optimization)
-- ===================================

-- Query: Retrieve all bookings with user, property, and payment details
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created,
    
    -- User details
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.date_of_birth,
    u.created_at AS user_created,
    
    -- Property details
    p.property_id,
    p.title AS property_title,
    p.description AS property_description,
    p.property_type,
    p.room_type,
    p.accommodates,
    p.bedrooms,
    p.bathrooms,
    p.price_per_night,
    p.address,
    p.city,
    p.country,
    p.latitude,
    p.longitude,
    p.amenities,
    
    -- Host details
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    host.email AS host_email,
    
    -- Payment details
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.status AS payment_status,
    pay.created_at AS payment_date,
    
    -- Review details (if exists)
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
    
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
INNER JOIN users host ON p.host_id = host.user_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
LEFT JOIN reviews r ON b.booking_id = r.booking_id
ORDER BY b.created_at DESC
LIMIT 1000;

-- OPTIMIZED QUERY (After Optimization)
-- ====================================

-- Step 1: Create necessary indexes for optimization
CREATE INDEX IF NOT EXISTS idx_bookings_created_at ON bookings(created_at);
CREATE INDEX IF NOT EXISTS idx_bookings_user_property ON bookings(user_id, property_id);
CREATE INDEX IF NOT EXISTS idx_properties_host_id ON properties(host_id);
CREATE INDEX IF NOT EXISTS idx_payments_booking_id ON payments(booking_id);
CREATE INDEX IF NOT EXISTS idx_reviews_booking_id ON reviews(booking_id);

-- Step 2: Optimized Query - Reduced unnecessary joins and selected only required columns
EXPLAIN ANALYZE
SELECT 
    -- Booking details (core information)
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created,
    
    -- Essential user details only
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    
    -- Essential property details only
    p.property_id,
    p.title AS property_title,
    p.property_type,
    p.city,
    p.country,
    p.price_per_night,
    
    -- Essential host details only
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    
    -- Payment summary (avoid full payment details unless needed)
    COALESCE(pay.amount, 0) AS payment_amount,
    COALESCE(pay.status, 'pending') AS payment_status,
    
    -- Review summary (avoid full review text unless needed)
    COALESCE(r.rating, 0) AS review_rating
    
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
INNER JOIN users host ON p.host_id = host.user_id
LEFT JOIN (
    SELECT booking_id, amount, status
    FROM payments 
    WHERE status != 'failed'
) pay ON b.booking_id = pay.booking_id
LEFT JOIN (
    SELECT booking_id, rating
    FROM reviews 
    WHERE rating IS NOT NULL
) r ON b.booking_id = r.booking_id
WHERE b.created_at >= DATE_SUB(NOW(), INTERVAL 1 YEAR)  -- Limit to recent bookings
ORDER BY b.created_at DESC
LIMIT 500;  -- Reduced limit for better performance

-- Step 3: Alternative Optimization - Using Subqueries for Better Performance
EXPLAIN ANALYZE
WITH booking_summary AS (
    SELECT 
        b.booking_id,
        b.check_in_date,
        b.check_out_date,
        b.total_price,
        b.status,
        b.created_at,
        b.user_id,
        b.property_id
    FROM bookings b
    WHERE b.created_at >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
    ORDER BY b.created_at DESC
    LIMIT 500
)
SELECT 
    bs.*,
    u.first_name,
    u.last_name,
    u.email,
    p.title AS property_title,
    p.city,
    p.country,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    (SELECT amount FROM payments WHERE booking_id = bs.booking_id AND status != 'failed' ORDER BY created_at DESC LIMIT 1) AS payment_amount,
    (SELECT rating FROM reviews WHERE booking_id = bs.booking_id AND rating IS NOT NULL ORDER BY created_at DESC LIMIT 1) AS review_rating
FROM booking_summary bs
INNER JOIN users u ON bs.user_id = u.user_id
INNER JOIN properties p ON bs.property_id = p.property_id
INNER JOIN users host ON p.host_id = host.user_id
ORDER BY bs.created_at DESC;

-- PERFORMANCE ANALYSIS QUERIES
-- ============================

-- Analyze table sizes and index usage
EXPLAIN FORMAT=JSON
SELECT COUNT(*) as total_bookings FROM bookings;

-- Check index usage on bookings table
EXPLAIN
SELECT * FROM bookings WHERE user_id = 1 AND created_at > '2024-01-01';

-- Analyze JOIN performance
EXPLAIN
SELECT b.booking_id, u.first_name, p.title
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LIMIT 100;