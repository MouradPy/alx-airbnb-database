# Database Index Performance Optimization

## Objective
Identify and create indexes to improve query performance for the Airbnb database.

## High-Usage Columns Identified

### Users Table
- **email**: Frequent lookups for authentication
- **first_name, last_name**: User search functionality
- **created_at**: User analytics and reporting

### Properties Table
- **host_id**: Host dashboard and property management
- **city, country**: Location-based searches
- **price_per_night**: Price filtering and sorting
- **status**: Property availability queries

### Bookings Table
- **user_id**: User booking history
- **property_id**: Property booking analysis
- **check_in_date, check_out_date**: Availability checks
- **status**: Booking management and reporting

### Reviews Table
- **property_id**: Property rating calculations
- **user_id**: User review history
- **rating**: Quality analysis and filtering

## Performance Measurement

### Query 1: User Booking History (Before Index)
```sql
EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, COUNT(b.booking_id) as booking_count
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE u.email = 'user@example.com'
GROUP BY u.user_id, u.first_name, u.last_name;