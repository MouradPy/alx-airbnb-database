# Database Seeding Scripts

## Overview
This directory contains SQL scripts for populating the Airbnb database with realistic sample data for testing and development purposes.

## Files
- `seed.sql` - Main SQL script to insert sample data into all tables

## Sample Data Summary

### Users (7 records)
- **3 Guests**: John Doe, Jane Smith, Mike Johnson
- **3 Hosts**: Sarah Wilson, David Brown, Emily Davis  
- **1 Admin**: Admin User

### Properties (6 records)
- **Sarah's Properties**: Cozy Beach House (Miami), Downtown Luxury Apartment (NY)
- **David's Properties**: Mountain Cabin Retreat (Aspen), City View Condo (Chicago)
- **Emily's Properties**: Lakeside Villa (Lake Tahoe), Garden Studio (Portland)

### Bookings (6 records)
- Various booking scenarios with different statuses:
  - Confirmed bookings
  - Pending bookings  
  - Canceled bookings
- Realistic date ranges and pricing

### Payments (4 records)
- Multiple payment methods: credit_card, paypal, stripe
- Matches confirmed bookings

### Reviews (4 records)
- Ratings from 3 to 5 stars
- Realistic comments from guests
- Covers different properties

### Messages (6 records)
- Sample conversations between guests and hosts
- Realistic message content about availability, questions, etc.

## Usage

1. **Run the entire seeding script:**
```sql
SOURCE seed.sql;