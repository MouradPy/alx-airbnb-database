# Database Schema Documentation

## Overview
This directory contains the SQL Data Definition Language (DDL) scripts for creating the Airbnb database schema.

## Files
- `schema.sql` - Main SQL script to create all tables, constraints, and indexes

## Database Structure

### Tables Created

1. **User**
   - Stores user information including guests, hosts, and admins
   - Primary Key: `user_id` (UUID)
   - Unique constraint on `email`

2. **Property**
   - Stores property listings with host information
   - Foreign Key: `host_id` references User(user_id)
   - Price validation and location indexing

3. **Booking**
   - Manages property reservations
   - Foreign Keys: `property_id`, `user_id`
   - Date validation and status tracking

4. **Payment**
   - Handles payment transactions for bookings
   - One-to-one relationship with Booking
   - Multiple payment method support

5. **Review**
   - Stores user reviews and ratings for properties
   - Rating validation (1-5 stars)
   - Unique constraint to prevent duplicate reviews

6. **Message**
   - Manages communication between users
   - Foreign Keys: `sender_id`, `recipient_id`

## Key Features

### Constraints
- Primary Keys: UUID for all tables
- Foreign Keys: Proper referential integrity
- Check Constraints: Validates ratings, prices, dates
- Unique Constraints: Prevents duplicate emails and reviews

### Indexes
- Performance indexes on frequently queried columns
- Composite indexes for common query patterns
- Foreign key indexes for join optimization

### Data Types
- UUID for primary keys
- Appropriate VARCHAR lengths
- DECIMAL for monetary values
- ENUM for fixed option sets
- TIMESTAMP for audit trails

## Usage

1. Execute the entire script to create the database:
```sql
SOURCE schema.sql;