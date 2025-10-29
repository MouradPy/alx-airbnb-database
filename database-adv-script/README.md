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
