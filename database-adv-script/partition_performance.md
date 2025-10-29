\# Table Partitioning Performance Report



\## Objective

Implement table partitioning on the Booking table based on the `check\_in\_date` column to optimize query performance on large datasets.



\## Partitioning Strategy



\### Chosen Partitioning Method: RANGE Partitioning

\- \*\*Partition Key\*\*: `check\_in\_date`

\- \*\*Partition Type\*\*: Monthly partitions

\- \*\*Rationale\*\*: 

&nbsp; - Bookings are frequently queried by date ranges

&nbsp; - Monthly partitions align with common business reporting cycles

&nbsp; - Easy maintenance and archiving of old data



\### Partition Structure

```sql

PARTITION BY RANGE (YEAR(check\_in\_date) \* 100 + MONTH(check\_in\_date)) (

&nbsp;   PARTITION p\_202301 VALUES LESS THAN (202302),  -- Jan 2023

&nbsp;   PARTITION p\_202302 VALUES LESS THAN (202303),  -- Feb 2023

&nbsp;   ... monthly partitions ...

&nbsp;   PARTITION p\_future VALUES LESS THAN MAXVALUE

)

