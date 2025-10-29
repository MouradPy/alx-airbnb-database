-- Database Indexes for Performance Optimization - Airbnb Database
-- ==============================================================

-- 1. Indexes for Users table
-- Primary key is automatically indexed in most databases

-- Index for email (unique constraint and frequent lookups)
CREATE INDEX idx_users_email ON users(email);

-- Index for authentication and user lookups
CREATE INDEX idx_users_email_password ON users(email, password_hash);

-- Index for user search and filtering
CREATE INDEX idx_users_name ON users(first_name, last_name);

-- Index for user activity analysis
CREATE INDEX idx_users_created_at ON users(created_at);

-- 2. Indexes for Properties table
-- Primary key (property_id) is automatically indexed

-- Index for host-based queries
CREATE INDEX idx_properties_host_id ON properties(host_id);

-- Index for location-based searches
CREATE INDEX idx_properties_location ON properties(city, country);

-- Index for price filtering and sorting
CREATE INDEX idx_properties_price ON properties(price_per_night);

-- Composite index for common search patterns
CREATE INDEX idx_properties_search ON properties(city, price_per_night, property_type);

-- Index for availability and status queries
CREATE INDEX idx_properties_status ON properties(status, created_at);

-- 3. Indexes for Bookings table
-- Primary key (booking_id) is automatically indexed

-- Index for user booking history
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Index for property booking analysis
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Index for date range queries (common for availability checks)
CREATE INDEX idx_bookings_dates ON bookings(check_in_date, check_out_date);

-- Index for status-based queries and reporting
CREATE INDEX idx_bookings_status ON bookings(status);

-- Composite index for user booking analysis
CREATE INDEX idx_bookings_user_dates ON bookings(user_id, check_in_date);

-- Index for financial reporting and analytics
CREATE INDEX idx_bookings_financial ON bookings(status, total_price, created_at);

-- 4. Indexes for Reviews table
-- Primary key (review_id) is automatically indexed

-- Index for property review analysis
CREATE INDEX idx_reviews_property_id ON reviews(property_id);

-- Index for user review history
CREATE INDEX idx_reviews_user_id ON reviews(user_id);

-- Index for rating-based queries and analytics
CREATE INDEX idx_reviews_rating ON reviews(rating);

-- Composite index for property rating analysis
CREATE INDEX idx_reviews_property_rating ON reviews(property_id, rating);

-- Index for recent reviews display
CREATE INDEX idx_reviews_created_at ON reviews(created_at);

-- 5. Foreign Key Indexes (if not automatically created)
-- These are crucial for JOIN performance

CREATE INDEX fk_bookings_user_id ON bookings(user_id);
CREATE INDEX fk_bookings_property_id ON bookings(property_id);
CREATE INDEX fk_reviews_user_id ON reviews(user_id);
CREATE INDEX fk_reviews_property_id ON reviews(property_id);
CREATE INDEX fk_properties_host_id ON properties(host_id);

-- 6. Composite Indexes for Common Query Patterns

-- For user dashboard: show bookings with property details
CREATE INDEX idx_user_bookings_dashboard ON bookings(user_id, status, check_in_date);

-- For host dashboard: show property performance
CREATE INDEX idx_host_properties_performance ON properties(host_id, status, created_at);

-- For search functionality: find available properties
CREATE INDEX idx_property_search_advanced ON properties(city, price_per_night, property_type, status);

-- For admin reporting: booking analytics
CREATE INDEX idx_admin_bookings_report ON bookings(created_at, status, total_price);