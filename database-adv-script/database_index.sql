-- Database Indexes for Performance Optimization - Airbnb Database
-- ==============================================================

-- PERFORMANCE MEASUREMENT: BEFORE INDEXES
-- ========================================

-- Query 1: User Booking History (Before Index)
EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, COUNT(b.booking_id) as booking_count
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE u.email = 'user@example.com'
GROUP BY u.user_id, u.first_name, u.last_name;

-- Query 2: Property Search (Before Index)
EXPLAIN ANALYZE
SELECT p.property_id, p.title, p.price_per_night, AVG(r.rating) as avg_rating
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id
WHERE p.city = 'Paris' 
  AND p.price_per_night BETWEEN 50 AND 200
  AND p.status = 'active'
GROUP BY p.property_id, p.title, p.price_per_night
ORDER BY avg_rating DESC;

-- Query 3: Host Property Management (Before Index)
EXPLAIN ANALYZE
SELECT p.property_id, p.title, 
       COUNT(b.booking_id) as total_bookings,
       SUM(b.total_price) as total_revenue
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
WHERE p.host_id = 123
  AND b.status = 'confirmed'
  AND b.check_in_date >= '2024-01-01'
GROUP BY p.property_id, p.title;

-- CREATE INDEX COMMANDS
-- =====================

-- 1. Indexes for Users table
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_email_password ON users(email, password_hash);
CREATE INDEX idx_users_name ON users(first_name, last_name);
CREATE INDEX idx_users_created_at ON users(created_at);

-- 2. Indexes for Properties table
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(city, country);
CREATE INDEX idx_properties_price ON properties(price_per_night);
CREATE INDEX idx_properties_search ON properties(city, price_per_night, property_type);
CREATE INDEX idx_properties_status ON properties(status, created_at);

-- 3. Indexes for Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_dates ON bookings(check_in_date, check_out_date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_user_dates ON bookings(user_id, check_in_date);
CREATE INDEX idx_bookings_financial ON bookings(status, total_price, created_at);

-- 4. Indexes for Reviews table
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);
CREATE INDEX idx_reviews_property_rating ON reviews(property_id, rating);
CREATE INDEX idx_reviews_created_at ON reviews(created_at);

-- 5. Foreign Key Indexes
CREATE INDEX fk_bookings_user_id ON bookings(user_id);
CREATE INDEX fk_bookings_property_id ON bookings(property_id);
CREATE INDEX fk_reviews_user_id ON reviews(user_id);
CREATE INDEX fk_reviews_property_id ON reviews(property_id);
CREATE INDEX fk_properties_host_id ON properties(host_id);

-- 6. Composite Indexes for Common Query Patterns
CREATE INDEX idx_user_bookings_dashboard ON bookings(user_id, status, check_in_date);
CREATE INDEX idx_host_properties_performance ON properties(host_id, status, created_at);
CREATE INDEX idx_property_search_advanced ON properties(city, price_per_night, property_type, status);
CREATE INDEX idx_admin_bookings_report ON bookings(created_at, status, total_price);

-- PERFORMANCE MEASUREMENT: AFTER INDEXES
-- ======================================

-- Query 1: User Booking History (After Index)
EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, COUNT(b.booking_id) as booking_count
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE u.email = 'user@example.com'
GROUP BY u.user_id, u.first_name, u.last_name;

-- Query 2: Property Search (After Index)
EXPLAIN ANALYZE
SELECT p.property_id, p.title, p.price_per_night, AVG(r.rating) as avg_rating
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id
WHERE p.city = 'Paris' 
  AND p.price_per_night BETWEEN 50 AND 200
  AND p.status = 'active'
GROUP BY p.property_id, p.title, p.price_per_night
ORDER BY avg_rating DESC;

-- Query 3: Host Property Management (After Index)
EXPLAIN ANALYZE
SELECT p.property_id, p.title, 
       COUNT(b.booking_id) as total_bookings,
       SUM(b.total_price) as total_revenue
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
WHERE p.host_id = 123
  AND b.status = 'confirmed'
  AND b.check_in_date >= '2024-01-01'
GROUP BY p.property_id, p.title;

-- PERFORMANCE COMPARISON QUERIES
-- ==============================

-- Compare execution plans for a specific query
EXPLAIN FORMAT=JSON
SELECT * FROM bookings WHERE user_id = 123 AND status = 'confirmed';

-- Analyze index usage statistics (PostgreSQL example)
-- SELECT * FROM pg_stat_user_indexes WHERE indexrelname LIKE 'idx_%';

-- MySQL index usage analysis
-- SELECT * FROM information_schema.statistics WHERE table_schema = 'airbnb_db';

-- Query to show index usage (MySQL)
EXPLAIN
SELECT u.first_name, p.title, b.check_in_date, b.total_price
FROM users u
JOIN bookings b ON u.user_id = b.user_id
JOIN properties p ON b.property_id = p.property_id
WHERE u.email = 'test@example.com'
  AND b.check_in_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY b.total_price DESC;