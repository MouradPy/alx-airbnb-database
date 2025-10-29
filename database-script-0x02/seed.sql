-- Airbnb Database Sample Data
-- Created for ALX Airbnb Database Project

USE airbnb_db;

-- Disable foreign key checks for easier insertion
SET FOREIGN_KEY_CHECKS = 0;

-- Clear existing data (optional - for clean seeding)
DELETE FROM Message;
DELETE FROM Review;
DELETE FROM Payment;
DELETE FROM Booking;
DELETE FROM Property;
DELETE FROM User;

-- Enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- Insert sample Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Guests
('11111111-1111-1111-1111-111111111111', 'John', 'Doe', 'john.doe@email.com', '$2b$10$examplehash123', '+1234567890', 'guest', '2024-01-15 10:00:00'),
('22222222-2222-2222-2222-222222222222', 'Jane', 'Smith', 'jane.smith@email.com', '$2b$10$examplehash456', '+1234567891', 'guest', '2024-01-16 11:00:00'),
('33333333-3333-3333-3333-333333333333', 'Mike', 'Johnson', 'mike.johnson@email.com', '$2b$10$examplehash789', '+1234567892', 'guest', '2024-01-17 12:00:00'),

-- Hosts
('44444444-4444-4444-4444-444444444444', 'Sarah', 'Wilson', 'sarah.wilson@email.com', '$2b$10$examplehashabc', '+1234567893', 'host', '2024-01-10 09:00:00'),
('55555555-5555-5555-5555-555555555555', 'David', 'Brown', 'david.brown@email.com', '$2b$10$examplehashdef', '+1234567894', 'host', '2024-01-12 14:00:00'),
('66666666-6666-6666-6666-666666666666', 'Emily', 'Davis', 'emily.davis@email.com', '$2b$10$examplehashghi', '+1234567895', 'host', '2024-01-14 16:00:00'),

-- Admin
('77777777-7777-7777-7777-777777777777', 'Admin', 'User', 'admin@airbnb.com', '$2b$10$examplehashadmin', '+1234567896', 'admin', '2024-01-01 08:00:00');

-- Insert sample Properties
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night, created_at) VALUES
-- Sarah's properties
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '44444444-4444-4444-4444-444444444444', 'Cozy Beach House', 'Beautiful beach house with ocean view, perfect for couples and small families. Features a fully equipped kitchen and private beach access.', 'Miami Beach, FL', 150.00, '2024-01-20 10:00:00'),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '44444444-4444-4444-4444-444444444444', 'Downtown Luxury Apartment', 'Modern apartment in the heart of downtown. Walking distance to restaurants, shops, and entertainment.', 'New York, NY', 200.00, '2024-01-22 14:00:00'),

-- David's properties
('cccccccc-cccc-cccc-cccc-cccccccccccc', '55555555-5555-5555-5555-555555555555', 'Mountain Cabin Retreat', 'Secluded cabin in the mountains with stunning views. Perfect for nature lovers and hiking enthusiasts.', 'Aspen, CO', 120.00, '2024-01-25 11:00:00'),
('dddddddd-dddd-dddd-dddd-dddddddddddd', '55555555-5555-5555-5555-555555555555', 'City View Condo', 'Spacious condo with panoramic city views. Modern amenities and close to public transportation.', 'Chicago, IL', 95.00, '2024-01-28 16:00:00'),

-- Emily's properties
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '66666666-6666-6666-6666-666666666666', 'Lakeside Villa', 'Luxurious villa on the lake with private dock. Perfect for large groups and family gatherings.', 'Lake Tahoe, CA', 300.00, '2024-02-01 09:00:00'),
('ffffffff-ffff-ffff-ffff-ffffffffffff', '66666666-6666-6666-6666-666666666666', 'Garden Studio', 'Charming studio with beautiful garden. Quiet neighborhood with easy access to city center.', 'Portland, OR', 75.00, '2024-02-05 13:00:00');

-- Insert sample Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- John's bookings
('11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', '2024-03-01', '2024-03-05', 600.00, 'confirmed', '2024-02-15 10:00:00'),
('22222222-2222-2222-2222-222222222222', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '11111111-1111-1111-1111-111111111111', '2024-04-10', '2024-04-15', 600.00, 'pending', '2024-02-20 14:00:00'),

-- Jane's bookings
('33333333-3333-3333-3333-333333333333', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', '2024-03-10', '2024-03-12', 400.00, 'confirmed', '2024-02-18 11:00:00'),
('44444444-4444-4444-4444-444444444444', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '22222222-2222-2222-2222-222222222222', '2024-05-01', '2024-05-07', 1800.00, 'confirmed', '2024-02-25 16:00:00'),

-- Mike's bookings
('55555555-5555-5555-5555-555555555555', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '33333333-3333-3333-3333-333333333333', '2024-03-20', '2024-03-25', 475.00, 'confirmed', '2024-02-22 09:00:00'),
('66666666-6666-6666-6666-666666666666', 'ffffffff-ffff-ffff-ffff-ffffffffffff', '33333333-3333-3333-3333-333333333333', '2024-04-05', '2024-04-08', 225.00, 'canceled', '2024-02-28 13:00:00');

-- Insert sample Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 600.00, '2024-02-15 10:30:00', 'credit_card'),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '33333333-3333-3333-3333-333333333333', 400.00, '2024-02-18 11:30:00', 'paypal'),
('cccccccc-cccc-cccc-cccc-cccccccccccc', '44444444-4444-4444-4444-444444444444', 1800.00, '2024-02-25 16:30:00', 'stripe'),
('dddddddd-dddd-dddd-dddd-dddddddddddd', '55555555-5555-5555-5555-555555555555', 475.00, '2024-02-22 09:30:00', 'credit_card');

-- Insert sample Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- Reviews for Beach House
('11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 5, 'Amazing beach house! The view was breathtaking and the location was perfect. Will definitely come back!', '2024-03-06 10:00:00'),

-- Reviews for Luxury Apartment
('22222222-2222-2222-2222-222222222222', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', 4, 'Great apartment in a fantastic location. Everything was clean and modern. Would recommend!', '2024-03-13 14:00:00'),

-- Reviews for City View Condo
('33333333-3333-3333-3333-333333333333', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '33333333-3333-3333-3333-333333333333', 5, 'Perfect stay! The condo had everything we needed and the city views were incredible at night.', '2024-03-26 11:00:00'),

-- Reviews for Garden Studio
('44444444-4444-4444-4444-444444444444', 'ffffffff-ffff-ffff-ffff-ffffffffffff', '22222222-2222-2222-2222-222222222222', 3, 'Nice studio but the garden needs maintenance. Location was good though.', '2024-04-09 16:00:00');

-- Insert sample Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Messages between John and Sarah
('11111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', 'Hi Sarah, I''m interested in your beach house. Is it available for March 1-5?', '2024-02-14 09:00:00'),
('22222222-2222-2222-2222-222222222222', '44444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', 'Hi John! Yes, those dates are available. The beach house would be perfect for your dates!', '2024-02-14 09:30:00'),

-- Messages between Jane and David
('33333333-3333-3333-3333-333333333333', '22222222-2222-2222-2222-222222222222', '55555555-5555-5555-5555-555555555555', 'Hello David, I''d like to book your mountain cabin for April 10-15. What''s the check-in process?', '2024-02-19 14:00:00'),
('44444444-4444-4444-4444-444444444444', '55555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222', 'Hi Jane! Check-in is after 3 PM. I''ll send you detailed instructions after booking confirmation.', '2024-02-19 14:45:00'),

-- Messages between Mike and Emily
('55555555-5555-5555-5555-555555555555', '33333333-3333-3333-3333-333333333333', '66666666-6666-6666-6666-666666666666', 'Hi Emily, is there parking available at the garden studio?', '2024-02-27 11:00:00'),
('66666666-6666-6666-6666-666666666666', '66666666-6666-6666-6666-666666666666', '33333333-3333-3333-3333-333333333333', 'Hi Mike! Yes, there is free street parking available right outside the studio.', '2024-02-27 11:20:00');

-- Display sample data counts
SELECT 
    'Users' as table_name, COUNT(*) as record_count FROM User
UNION ALL
SELECT 'Properties', COUNT(*) FROM Property
UNION ALL
SELECT 'Bookings', COUNT(*) FROM Booking
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payment
UNION ALL
SELECT 'Reviews', COUNT(*) FROM Review
UNION ALL
SELECT 'Messages', COUNT(*) FROM Message;