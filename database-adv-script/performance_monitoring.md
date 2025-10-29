\# Database Performance Monitoring and Refinement Report



\## Objective

Continuously monitor and refine database performance by analyzing query execution plans and making schema adjustments to optimize frequently used queries.



\## Monitoring Setup



\### Tools and Commands Used

\- \*\*EXPLAIN ANALYZE\*\*: Detailed query execution analysis

\- \*\*SHOW PROFILE\*\*: Query execution step timing

\- \*\*Performance Schema\*\*: MySQL performance metrics

\- \*\*Slow Query Log\*\*: Identification of problematic queries



\### Initial Performance Baseline

\- \*\*Database\*\*: MySQL 8.0+

\- \*\*Monitoring Period\*\*: 7 days

\- \*\*Sample Size\*\*: 1,000,000+ bookings, 500,000+ users, 50,000+ properties



\## Query Performance Analysis



\### Query 1: User Booking History



\#### Initial Query

```sql

EXPLAIN ANALYZE

SELECT 

&nbsp;   u.user\_id,

&nbsp;   u.first\_name,

&nbsp;   u.last\_name,

&nbsp;   COUNT(b.booking\_id) as total\_bookings,

&nbsp;   SUM(b.total\_price) as total\_spent,

&nbsp;   AVG(b.total\_price) as avg\_booking\_value

FROM users u

LEFT JOIN bookings b ON u.user\_id = b.user\_id

WHERE u.created\_at >= '2023-01-01'

GROUP BY u.user\_id, u.first\_name, u.last\_name

HAVING COUNT(b.booking\_id) > 5

ORDER BY total\_spent DESC

LIMIT 100;

