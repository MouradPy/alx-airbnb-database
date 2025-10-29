# SQL Join Queries

This folder contains advanced SQL join queries for the Airbnb database project.

## Queries Included

### 1. INNER JOIN: Retrieve all bookings with their respective users

* Only returns bookings that have a matching user.

### 2. LEFT JOIN: Retrieve all properties and their reviews

* Returns all properties, including those with **no reviews**.

### 3. FULL OUTER JOIN: Retrieve all users and all bookings

* Returns all users and bookings, even if **no match exists** on either side.

## How to Run

You can run the queries using any SQL client, such as:

* **MySQL**
* **PostgreSQL**
* **SQLite**

Example (PostgreSQL):

```bash
psql -U your_username -d airbnb_db -f joins_queries.sql
```

Make sure your tables (`users`, `bookings`, `properties`, `reviews`) already exist before running the queries.
# Advanced SQL Practice - Airbnb Database

This repository contains advanced SQL queries including complex joins and subqueries for an Airbnb-like database system.

## Files Overview

### 1. joins_queries.sql
Contains complex SQL join operations:
- **INNER JOIN**: Retrieve bookings with user details
- **LEFT JOIN**: Properties with reviews (including properties without reviews)
- **FULL OUTER JOIN**: Users and bookings (including unmatched records)
- **Multiple Joins**: Complex booking details with property and host information

### 2. subqueries.sql
Contains both correlated and non-correlated subqueries:
- **Non-correlated subquery**: Properties with average rating > 4.0
- **Correlated subquery**: Users with more than 3 bookings
- **Subquery in SELECT**: Property details with review counts and averages
- **EXISTS subquery**: Properties with at least one booking
- **Nested correlated subquery**: Hosts with high-rated properties

## Database Schema Assumptions

The queries assume the following tables exist:
- `users` (user_id, first_name, last_name, email, created_at, ...)
- `properties` (property_id, title, price_per_night, host_id, city, country, ...)  
- `bookings` (booking_id, user_id, property_id, check_in_date, check_out_date, total_price, status, ...)
- `reviews` (review_id, property_id, user_id, rating, comment, created_at, ...)

## Key Concepts Demonstrated

### Joins
- **INNER JOIN**: Matching records only
- **LEFT JOIN**: All left table records + matched right table records
- **FULL OUTER JOIN**: All records from both tables (using UNION in MySQL)

### Subqueries
- **Non-correlated**: Subquery can run independently of outer query
- **Correlated**: Subquery references columns from outer query
- **Subquery in SELECT**: Computed columns using subqueries
- **EXISTS/NOT EXISTS**: Check for existence of related records

## Usage

1. Execute the queries in your SQL database management tool
2. Modify table/column names to match your actual schema
3. Use these patterns as templates for your own complex queries

## Notes

- MySQL requires UNION for FULL OUTER JOIN simulation
- Always test queries with your specific database schema
- Consider adding indexes on foreign key columns for better performance
- Subqueries can impact performance; consider JOIN alternatives for large datasets

## File Structure
# Advanced SQL Practice - Airbnb Database

This repository contains advanced SQL queries including complex joins, subqueries, aggregations, and window functions for an Airbnb-like database system.

## Files Overview

### 1. joins_queries.sql
Contains complex SQL join operations:
- **INNER JOIN**: Retrieve bookings with user details
- **LEFT JOIN**: Properties with reviews (including properties without reviews)
- **FULL OUTER JOIN**: Users and bookings (including unmatched records)
- **Multiple Joins**: Complex booking details with property and host information

### 2. subqueries.sql
Contains both correlated and non-correlated subqueries:
- **Non-correlated subquery**: Properties with average rating > 4.0
- **Correlated subquery**: Users with more than 3 bookings
- **Subquery in SELECT**: Property details with review counts and averages
- **EXISTS subquery**: Properties with at least one booking
- **Nested correlated subquery**: Hosts with high-rated properties

### 3. aggregations_and_window_functions.sql
Contains aggregation and window function examples:
- **GROUP BY Aggregations**: User booking counts, property statistics
- **Window Functions**: ROW_NUMBER, RANK, DENSE_RANK for property rankings
- **PARTITION BY**: Ranking within categories (cities, neighborhoods)
- **Running Totals**: Cumulative revenue calculations
- **Advanced Analytics**: Price comparisons with neighborhood averages

## Database Schema Assumptions

The queries assume the following tables exist:
- `users` (user_id, first_name, last_name, email, created_at, ...)
- `properties` (property_id, title, price_per_night, host_id, city, country, neighborhood, ...)  
- `bookings` (booking_id, user_id, property_id, check_in_date, check_out_date, total_price, status, ...)
- `reviews` (review_id, property_id, user_id, rating, comment, created_at, ...)

## Key Concepts Demonstrated

### Joins
- **INNER JOIN**: Matching records only
- **LEFT JOIN**: All left table records + matched right table records
- **FULL OUTER JOIN**: All records from both tables (using UNION in MySQL)

### Subqueries
- **Non-correlated**: Subquery can run independently of outer query
- **Correlated**: Subquery references columns from outer query
- **Subquery in SELECT**: Computed columns using subqueries
- **EXISTS/NOT EXISTS**: Check for existence of related records

### Aggregations & Window Functions
- **GROUP BY**: Aggregate data by categories
- **COUNT, SUM, AVG, MIN, MAX**: Aggregate functions
- **ROW_NUMBER**: Sequential numbering
- **RANK/DENSE_RANK**: Ranking with/without gaps
- **PARTITION BY**: Window partitions for calculations
- **Running Totals**: Cumulative sums over ordered data

## Usage

1. Execute the queries in your SQL database management tool
2. Modify table/column names to match your actual schema
3. Use these patterns as templates for your own complex queries

## Notes

- MySQL requires UNION for FULL OUTER JOIN simulation
- Window functions require MySQL 8.0+ or other modern SQL databases
- Always test queries with your specific database schema
- Consider adding indexes on foreign key columns for better performance
- Subqueries can impact performance; consider JOIN alternatives for large datasets

## File Structure
### 4. Database Optimization Files
- **`database_index.sql`**: SQL commands to create performance-optimizing indexes
- **`index_performance.md`**: Documentation on index strategy and performance measurement

**Key Indexing Strategies:**
- Unique indexes for authentication (email)
- Composite indexes for search patterns (location, price)
- Foreign key indexes for JOIN performance
- Date-based indexes for temporal queries
