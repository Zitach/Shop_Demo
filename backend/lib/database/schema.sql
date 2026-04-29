-- Shop Demo Database Schema
-- PostgreSQL 16

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- Users
-- ============================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    avatar_url TEXT,
    phone VARCHAR(20),
    bio TEXT,
    is_host BOOLEAN DEFAULT FALSE,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_is_host ON users(is_host);

-- ============================================
-- Categories
-- ============================================
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    icon_url TEXT,
    description TEXT,
    parent_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_categories_slug ON categories(slug);
CREATE INDEX idx_categories_parent_id ON categories(parent_id);

-- ============================================
-- Listings
-- ============================================
CREATE TABLE listings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    category_id UUID NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    unit_type VARCHAR(20) DEFAULT 'night' CHECK (unit_type IN ('night', 'hour', 'day', 'week', 'month')),
    max_guests INTEGER DEFAULT 1,
    bedrooms INTEGER,
    bathrooms INTEGER,
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    latitude DECIMAL(10, 7),
    longitude DECIMAL(10, 7),
    is_active BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE,
    avg_rating DECIMAL(3, 2) DEFAULT 0.00,
    review_count INTEGER DEFAULT 0,
    min_nights INTEGER DEFAULT 1,
    max_nights INTEGER DEFAULT 365,
    check_in_time VARCHAR(10) DEFAULT '15:00',
    check_out_time VARCHAR(10) DEFAULT '11:00',
    cancellation_policy VARCHAR(20) DEFAULT 'moderate' CHECK (cancellation_policy IN ('flexible', 'moderate', 'strict', 'non_refundable')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_listings_host_id ON listings(host_id);
CREATE INDEX idx_listings_category_id ON listings(category_id);
CREATE INDEX idx_listings_city ON listings(city);
CREATE INDEX idx_listings_country ON listings(country);
CREATE INDEX idx_listings_price ON listings(price_per_unit);
CREATE INDEX idx_listings_is_active ON listings(is_active);
CREATE INDEX idx_listings_is_featured ON listings(is_featured);
CREATE INDEX idx_listings_avg_rating ON listings(avg_rating);
CREATE INDEX idx_listings_location ON listings(latitude, longitude);

-- ============================================
-- Images
-- ============================================
CREATE TABLE images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    listing_id UUID NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    url TEXT NOT NULL,
    alt_text VARCHAR(255),
    width INTEGER,
    height INTEGER,
    sort_order INTEGER DEFAULT 0,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_images_listing_id ON images(listing_id);

-- ============================================
-- Amenities
-- ============================================
CREATE TABLE amenities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    icon_url TEXT,
    category VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_amenities_slug ON amenities(slug);

-- ============================================
-- Listing Amenities (junction table)
-- ============================================
CREATE TABLE listing_amenities (
    listing_id UUID NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    amenity_id UUID NOT NULL REFERENCES amenities(id) ON DELETE CASCADE,
    PRIMARY KEY (listing_id, amenity_id)
);

CREATE INDEX idx_listing_amenities_amenity_id ON listing_amenities(amenity_id);

-- ============================================
-- Bookings
-- ============================================
CREATE TABLE bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    listing_id UUID NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    guest_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    host_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    num_guests INTEGER NOT NULL DEFAULT 1,
    total_price DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed', 'refunded')),
    special_requests TEXT,
    cancelled_at TIMESTAMP WITH TIME ZONE,
    cancellation_reason TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    CONSTRAINT booking_dates CHECK (end_date > start_date)
);

CREATE INDEX idx_bookings_listing_id ON bookings(listing_id);
CREATE INDEX idx_bookings_guest_id ON bookings(guest_id);
CREATE INDEX idx_bookings_host_id ON bookings(host_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);

-- ============================================
-- Reviews
-- ============================================
CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    listing_id UUID NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    author_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    booking_id UUID UNIQUE REFERENCES bookings(id) ON DELETE SET NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(200),
    comment TEXT,
    response TEXT,
    response_at TIMESTAMP WITH TIME ZONE,
    is_visible BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_reviews_listing_id ON reviews(listing_id);
CREATE INDEX idx_reviews_author_id ON reviews(author_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);

-- ============================================
-- Favorites
-- ============================================
CREATE TABLE favorites (
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    listing_id UUID NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    PRIMARY KEY (user_id, listing_id)
);

CREATE INDEX idx_favorites_listing_id ON favorites(listing_id);

-- ============================================
-- Seed Data
-- ============================================

-- Admin user (password: admin123 - bcrypt hash)
INSERT INTO users (id, email, password_hash, display_name, is_host, is_verified)
VALUES (
    'a0000000-0000-0000-0000-000000000001',
    'admin@shopdemo.com',
    '$2a$10$xVqYLGveHpSM0FwGqW0J3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e',
    'Admin User',
    TRUE,
    TRUE
);

-- Test host user (password: host123)
INSERT INTO users (id, email, password_hash, display_name, is_host, is_verified, bio)
VALUES (
    'a0000000-0000-0000-0000-000000000002',
    'host@shopdemo.com',
    '$2a$10$xVqYLGveHpSM0FwGqW0J3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e',
    'Sarah Host',
    TRUE,
    TRUE,
    'Experienced host with multiple properties'
);

-- Test guest user (password: guest123)
INSERT INTO users (id, email, password_hash, display_name, is_verified)
VALUES (
    'a0000000-0000-0000-0000-000000000003',
    'guest@shopdemo.com',
    '$2a$10$xVqYLGveHpSM0FwGqW0J3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e',
    'John Guest',
    TRUE
);

-- Categories
INSERT INTO categories (id, name, slug, description, sort_order) VALUES
    ('b0000000-0000-0000-0000-000000000001', 'Entire Homes', 'entire-homes', 'Rent an entire home', 1),
    ('b0000000-0000-0000-0000-000000000002', 'Private Rooms', 'private-rooms', 'Rent a private room', 2),
    ('b0000000-0000-0000-0000-000000000003', 'Shared Spaces', 'shared-spaces', 'Rent a shared space', 3),
    ('b0000000-0000-0000-0000-000000000004', 'Unique Stays', 'unique-stays', 'Unique accommodations', 4),
    ('b0000000-0000-0000-0000-000000000005', 'Experiences', 'experiences', 'Local experiences', 5);

-- Subcategories
INSERT INTO categories (id, name, slug, description, parent_id, sort_order) VALUES
    ('b0000000-0000-0000-0000-000000000006', 'Apartments', 'apartments', 'Modern apartments', 'b0000000-0000-0000-0000-000000000001', 1),
    ('b0000000-0000-0000-0000-000000000007', 'Houses', 'houses', 'Full houses', 'b0000000-0000-0000-0000-000000000001', 2),
    ('b0000000-0000-0000-0000-000000000008', 'Cabins', 'cabins', 'Cozy cabins', 'b0000000-0000-0000-0000-000000000001', 3),
    ('b0000000-0000-0000-0000-000000000009', 'Beach Houses', 'beach-houses', 'Oceanfront properties', 'b0000000-0000-0000-0000-000000000001', 4);

-- Amenities
INSERT INTO amenities (id, name, slug, category) VALUES
    ('c0000000-0000-0000-0000-000000000001', 'WiFi', 'wifi', 'basic'),
    ('c0000000-0000-0000-0000-000000000002', 'Kitchen', 'kitchen', 'basic'),
    ('c0000000-0000-0000-0000-000000000003', 'Air Conditioning', 'air-conditioning', 'comfort'),
    ('c0000000-0000-0000-0000-000000000004', 'Heating', 'heating', 'comfort'),
    ('c0000000-0000-0000-0000-000000000005', 'Washer', 'washer', 'basic'),
    ('c0000000-0000-0000-0000-000000000006', 'Dryer', 'dryer', 'basic'),
    ('c0000000-0000-0000-0000-000000000007', 'Free Parking', 'free-parking', 'convenience'),
    ('c0000000-0000-0000-0000-000000000008', 'Pool', 'pool', 'luxury'),
    ('c0000000-0000-0000-0000-000000000009', 'Hot Tub', 'hot-tub', 'luxury'),
    ('c0000000-0000-0000-0000-000000000010', 'TV', 'tv', 'entertainment'),
    ('c0000000-0000-0000-0000-000000000011', 'Gym', 'gym', 'fitness'),
    ('c0000000-0000-0000-0000-000000000012', 'Workspace', 'workspace', 'convenience'),
    ('c0000000-0000-0000-0000-000000000013', 'Pet Friendly', 'pet-friendly', 'policy'),
    ('c0000000-0000-0000-0000-000000000014', 'Smoking Allowed', 'smoking-allowed', 'policy'),
    ('c0000000-0000-0000-0000-000000000015', 'Balcony', 'balcony', 'outdoor'),
    ('c0000000-0000-0000-0000-000000000016', 'Garden', 'garden', 'outdoor');

-- Sample listings
INSERT INTO listings (id, host_id, category_id, title, description, price_per_unit, max_guests, bedrooms, bathrooms, city, country, latitude, longitude, avg_rating, review_count, is_featured) VALUES
    ('d0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000006', 'Modern Downtown Apartment', 'Stunning 2-bedroom apartment in the heart of the city with panoramic views. Walking distance to restaurants, shops, and attractions.', 150.00, 4, 2, 1, 'New York', 'United States', 40.7127753, -74.0059728, 4.75, 12, TRUE),
    ('d0000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000008', 'Cozy Mountain Cabin', 'Escape to this charming cabin nestled in the mountains. Perfect for a romantic getaway or family retreat.', 200.00, 6, 3, 2, 'Aspen', 'United States', 39.1910983, -106.8175387, 4.90, 8, TRUE),
    ('d0000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000009', 'Beachfront Villa', 'Luxurious beachfront villa with private pool and direct beach access. Wake up to the sound of waves.', 350.00, 8, 4, 3, 'Miami', 'United States', 25.7616798, -80.1917902, 4.95, 15, TRUE),
    ('d0000000-0000-0000-0000-000000000004', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000007', 'Historic Brownstone', 'Beautifully restored brownstone in a quiet neighborhood. Original hardwood floors and modern amenities.', 175.00, 5, 3, 2, 'Boston', 'United States', 42.3600825, -71.0588801, 4.60, 6, FALSE),
    ('d0000000-0000-0000-0000-000000000005', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000006', 'Loft in Arts District', 'Industrial-chic loft in the vibrant arts district. High ceilings, exposed brick, and natural light.', 125.00, 2, 1, 1, 'Los Angeles', 'United States', 34.0522342, -118.2436849, 4.80, 10, FALSE);

-- Link amenities to listings
INSERT INTO listing_amenities (listing_id, amenity_id) VALUES
    ('d0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000001'), -- WiFi
    ('d0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000002'), -- Kitchen
    ('d0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000003'), -- AC
    ('d0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000010'), -- TV
    ('d0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000012'), -- Workspace
    ('d0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000001'), -- WiFi
    ('d0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000002'), -- Kitchen
    ('d0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000004'), -- Heating
    ('d0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000009'), -- Hot Tub
    ('d0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000007'), -- Parking
    ('d0000000-0000-0000-0000-000000000003', 'c0000000-0000-0000-0000-000000000001'), -- WiFi
    ('d0000000-0000-0000-0000-000000000003', 'c0000000-0000-0000-0000-000000000002'), -- Kitchen
    ('d0000000-0000-0000-0000-000000000003', 'c0000000-0000-0000-0000-000000000003'), -- AC
    ('d0000000-0000-0000-0000-000000000003', 'c0000000-0000-0000-0000-000000000008'), -- Pool
    ('d0000000-0000-0000-0000-000000000003', 'c0000000-0000-0000-0000-000000000007'), -- Parking
    ('d0000000-0000-0000-0000-000000000003', 'c0000000-0000-0000-0000-000000000016'), -- Garden
    ('d0000000-0000-0000-0000-000000000004', 'c0000000-0000-0000-0000-000000000001'), -- WiFi
    ('d0000000-0000-0000-0000-000000000004', 'c0000000-0000-0000-0000-000000000002'), -- Kitchen
    ('d0000000-0000-0000-0000-000000000004', 'c0000000-0000-0000-0000-000000000004'), -- Heating
    ('d0000000-0000-0000-0000-000000000004', 'c0000000-0000-0000-0000-000000000005'), -- Washer
    ('d0000000-0000-0000-0000-000000000005', 'c0000000-0000-0000-0000-000000000001'), -- WiFi
    ('d0000000-0000-0000-0000-000000000005', 'c0000000-0000-0000-0000-000000000003'), -- AC
    ('d0000000-0000-0000-0000-000000000005', 'c0000000-0000-0000-0000-000000000010'), -- TV
    ('d0000000-0000-0000-0000-000000000005', 'c0000000-0000-0000-0000-000000000015'); -- Balcony

-- Sample reviews
INSERT INTO reviews (id, listing_id, author_id, rating, title, comment) VALUES
    ('e0000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000003', 5, 'Amazing stay!', 'The apartment was exactly as pictured. Great location and very clean.'),
    ('e0000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000003', 5, 'Perfect getaway', 'The cabin was cozy and the views were breathtaking. Highly recommend!'),
    ('e0000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000003', 5, 'Luxury at its best', 'The villa exceeded all expectations. Private pool and beach access were incredible.');

-- Sample booking
INSERT INTO bookings (id, listing_id, guest_id, host_id, start_date, end_date, num_guests, total_price, status) VALUES
    ('f0000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000002', '2026-05-01', '2026-05-05', 2, 600.00, 'confirmed');

-- Sample favorites
INSERT INTO favorites (user_id, listing_id) VALUES
    ('a0000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000001'),
    ('a0000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000002'),
    ('a0000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000003');
