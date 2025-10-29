-- Table Partitioning for Large Datasets - Airbnb Database
-- ======================================================

-- PARTITIONING IMPLEMENTATION
-- ===========================

-- 1. Check current table structure and size
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    DATA_LENGTH,
    INDEX_LENGTH,
    CREATE_TIME
FROM information_schema.TABLES 
WHERE TABLE_NAME = 'bookings' 
AND TABLE_SCHEMA = 'airbnb_db';

-- 2. Create partitioned bookings table (if starting fresh)
-- Using RANGE partitioning on check_in_date (monthly partitions)
CREATE TABLE bookings_partitioned (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled', 'completed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_user_id (user_id),
    INDEX idx_property_id (property_id),
    INDEX idx_check_in_date (check_in_date),
    INDEX idx_status (status)
)
PARTITION BY RANGE (YEAR(check_in_date) * 100 + MONTH(check_in_date)) (
    PARTITION p_202301 VALUES LESS THAN (202302),  -- Jan 2023
    PARTITION p_202302 VALUES LESS THAN (202303),  -- Feb 2023
    PARTITION p_202303 VALUES LESS THAN (202304),  -- Mar 2023
    PARTITION p_202304 VALUES LESS THAN (202305),  -- Apr 2023
    PARTITION p_202305 VALUES LESS THAN (202306),  -- May 2023
    PARTITION p_202306 VALUES LESS THAN (202307),  -- Jun 2023
    PARTITION p_202307 VALUES LESS THAN (202308),  -- Jul 2023
    PARTITION p_202308 VALUES LESS THAN (202309),  -- Aug 2023
    PARTITION p_202309 VALUES LESS THAN (202310),  -- Sep 2023
    PARTITION p_202310 VALUES LESS THAN (202311),  -- Oct 2023
    PARTITION p_202311 VALUES LESS THAN (202312),  -- Nov 2023
    PARTITION p_202312 VALUES LESS THAN (202401),  -- Dec 2023
    PARTITION p_202401 VALUES LESS THAN (202402),  -- Jan 2024
    PARTITION p_202402 VALUES LESS THAN (202403),  -- Feb 2024
    PARTITION p_202403 VALUES LESS THAN (202404),  -- Mar 2024
    PARTITION p_202404 VALUES LESS THAN (202405),  -- Apr 2024
    PARTITION p_202405 VALUES LESS THAN (202406),  -- May 2024
    PARTITION p_202406 VALUES LESS THAN (202407),  -- Jun 2024
    PARTITION p_202407 VALUES LESS THAN (202408),  -- Jul 2024
    PARTITION p_202408 VALUES LESS THAN (202409),  -- Aug 2024
    PARTITION p_202409 VALUES LESS THAN (202410),  -- Sep 2024
    PARTITION p_202410 VALUES LESS THAN (202411),  -- Oct 2024
    PARTITION p_202411 VALUES LESS THAN (202412),  -- Nov 2024
    PARTITION p_202412 VALUES LESS THAN (202501),  -- Dec 2024
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- 3. Alternative: Partition existing table (MySQL 5.7+ approach)
-- First, ensure the table doesn't have foreign key constraints
ALTER TABLE bookings 
PARTITION BY RANGE (TO_DAYS(check_in_date)) (
    PARTITION p_historical VALUES LESS THAN (TO_DAYS('2023-01-01')),
    PARTITION p_2023_q1 VALUES LESS THAN (TO_DAYS('2023-04-01')),
    PARTITION p_2023_q2 VALUES LESS THAN (TO_DAYS('2023-07-01')),
    PARTITION p_2023_q3 VALUES LESS THAN (TO_DAYS('2023-10-01')),
    PARTITION p_2023_q4 VALUES LESS THAN (TO_DAYS('2024-01-01')),
    PARTITION p_2024_q1 VALUES LESS THAN (TO_DAYS('2024-04-01')),
    PARTITION p_2024_q2 VALUES LESS THAN (TO_DAYS('2024-07-01')),
    PARTITION p_2024_q3 VALUES LESS THAN (TO_DAYS('2024-10-01')),
    PARTITION p_2024_q4 VALUES LESS THAN (TO_DAYS('2025-01-01')),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- 4. Create partitioned table with subpartitioning (for very large datasets)
CREATE TABLE bookings_advanced_partitioning (
    booking_id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled', 'completed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, check_in_date),
    INDEX idx_user_id (user_id),
    INDEX idx_property_id (property_id),
    INDEX idx_status (status)
)
PARTITION BY RANGE (YEAR(check_in_date))
SUBPARTITION BY HASH (MONTH(check_in_date))
SUBPARTITIONS 12 (
    PARTITION p_2022 VALUES LESS THAN (2023),
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_2024 VALUES LESS THAN (2025),
    PARTITION p_2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- PERFORMANCE TESTING QUERIES
-- ===========================

-- Test Query 1: Date range query (Before Partitioning)
EXPLAIN ANALYZE
SELECT 
    booking_id,
    user_id,
    property_id,
    check_in_date,
    total_price,
    status
FROM bookings
WHERE check_in_date BETWEEN '2024-01-01' AND '2024-03-31'
AND status = 'confirmed'
ORDER BY check_in_date;

-- Test Query 1: Date range query (After Partitioning)
EXPLAIN ANALYZE
SELECT 
    booking_id,
    user_id,
    property_id,
    check_in_date,
    total_price,
    status
FROM bookings_partitioned
WHERE check_in_date BETWEEN '2024-01-01' AND '2024-03-31'
AND status = 'confirmed'
ORDER BY check_in_date;

-- Test Query 2: Monthly aggregation (Before Partitioning)
EXPLAIN ANALYZE
SELECT 
    DATE_FORMAT(check_in_date, '%Y-%m') AS month,
    COUNT(*) AS total_bookings,
    SUM(total_price) AS total_revenue,
    AVG(total_price) AS avg_booking_value
FROM bookings
WHERE check_in_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY DATE_FORMAT(check_in_date, '%Y-%m')
ORDER BY month;

-- Test Query 2: Monthly aggregation (After Partitioning)
EXPLAIN ANALYZE
SELECT 
    DATE_FORMAT(check_in_date, '%Y-%m') AS month,
    COUNT(*) AS total_bookings,
    SUM(total_price) AS total_revenue,
    AVG(total_price) AS avg_booking_value
FROM bookings_partitioned
WHERE check_in_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY DATE_FORMAT(check_in_date, '%Y-%m')
ORDER BY month;

-- Test Query 3: Complex join with date filtering (Before Partitioning)
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    p.title AS property_title,
    b.check_in_date,
    b.total_price
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE b.check_in_date BETWEEN '2024-06-01' AND '2024-08-31'
AND b.status = 'confirmed'
ORDER BY b.check_in_date
LIMIT 1000;

-- Test Query 3: Complex join with date filtering (After Partitioning)
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    p.title AS property_title,
    b.check_in_date,
    b.total_price
FROM bookings_partitioned b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE b.check_in_date BETWEEN '2024-06-01' AND '2024-08-31'
AND b.status = 'confirmed'
ORDER BY b.check_in_date
LIMIT 1000;

-- PARTITION MANAGEMENT QUERIES
-- ============================

-- Check partition information
SELECT 
    PARTITION_NAME,
    TABLE_ROWS,
    AVG_ROW_LENGTH,
    DATA_LENGTH,
    INDEX_LENGTH
FROM information_schema.PARTITIONS 
WHERE TABLE_NAME = 'bookings_partitioned'
AND TABLE_SCHEMA = 'airbnb_db';

-- Add new partition for upcoming year
ALTER TABLE bookings_partitioned 
REORGANIZE PARTITION p_future INTO (
    PARTITION p_202501 VALUES LESS THAN (202502),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Merge partitions (if needed)
ALTER TABLE bookings_partitioned 
REORGANIZE PARTITION p_202301, p_202302 INTO (
    PARTITION p_2023_q1 VALUES LESS THAN (202304)
);

-- Drop old partitions (data removal - use with caution)
ALTER TABLE bookings_partitioned DROP PARTITION p_202301;

-- Analyze partition performance
ANALYZE TABLE bookings_partitioned;

-- Check which partitions are accessed by a query
EXPLAIN PARTITIONS
SELECT * FROM bookings_partitioned 
WHERE check_in_date BETWEEN '2024-01-01' AND '2024-03-31';