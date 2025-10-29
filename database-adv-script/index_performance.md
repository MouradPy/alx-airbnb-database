\# Database Index Performance Optimization



\## Objective

Identify and create indexes to improve query performance for the Airbnb database.



\## High-Usage Columns Identified



\### Users Table

\- \*\*email\*\*: Frequent lookups for authentication

\- \*\*first\_name, last\_name\*\*: User search functionality

\- \*\*created\_at\*\*: User analytics and reporting



\### Properties Table

\- \*\*host\_id\*\*: Host dashboard and property management

\- \*\*city, country\*\*: Location-based searches

\- \*\*price\_per\_night\*\*: Price filtering and sorting

\- \*\*status\*\*: Property availability queries



\### Bookings Table

\- \*\*user\_id\*\*: User booking history

\- \*\*property\_id\*\*: Property booking analysis

\- \*\*check\_in\_date, check\_out\_date\*\*: Availability checks

\- \*\*status\*\*: Booking management and reporting



\### Reviews Table

\- \*\*property\_id\*\*: Property rating calculations

\- \*\*user\_id\*\*: User review history

\- \*\*rating\*\*: Quality analysis and filtering



\## Performance Measurement



\### Query 1: User Booking History (Before Index)

```sql

EXPLAIN ANALYZE

SELECT u.first\_name, u.last\_name, COUNT(b.booking\_id) as booking\_count

FROM users u

JOIN bookings b ON u.user\_id = b.user\_id

WHERE u.email = 'user@example.com'

GROUP BY u.user\_id, u.first\_name, u.last\_name;

