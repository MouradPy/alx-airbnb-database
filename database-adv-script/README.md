\# Complex SQL Joins - Airbnb Database



This repository contains complex SQL queries demonstrating different types of joins for an Airbnb-like database system.



\## Queries Overview



\### 1. INNER JOIN Query

\*\*Purpose\*\*: Retrieve all bookings along with the users who made them.

\- Shows only records where there's a match in both `bookings` and `users` tables

\- Useful for getting complete booking information with user details



\### 2. LEFT JOIN Query  

\*\*Purpose\*\*: Retrieve all properties and their reviews, including properties without any reviews.

\- Returns all properties regardless of whether they have reviews

\- Properties without reviews will have NULL values in review-related columns

\- Essential for displaying property listings with optional review data



\### 3. FULL OUTER JOIN Query

\*\*Purpose\*\*: Retrieve all users and all bookings, including unmatched records from both sides.

\- Shows users without bookings AND bookings without associated users

\- Uses UNION of LEFT and RIGHT JOINs for MySQL compatibility

\- Important for data analysis and identifying orphaned records



\## Database Schema Assumptions



The queries assume the following tables exist:

\- `users` (user\_id, first\_name, last\_name, email, ...)

\- `properties` (property\_id, title, price\_per\_night, host\_id, ...)  

\- `bookings` (booking\_id, user\_id, property\_id, check\_in\_date, check\_out\_date, total\_price, status, ...)

\- `reviews` (review\_id, property\_id, user\_id, rating, comment, created\_at, ...)



\## Usage



1\. Execute the queries in your SQL database management tool

2\. Modify table/column names to match your actual schema

3\. Use these patterns as templates for your own complex join queries



\## Notes



\- The FULL OUTER JOIN implementation uses UNION since MySQL doesn't natively support FULL OUTER JOIN

\- Always test queries with your specific database schema

\- Consider adding indexes on foreign key columns for better performance



\## File Structure

