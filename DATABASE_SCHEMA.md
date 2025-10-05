# Relaxly Hotel Management System - Database Schema

This document provides a comprehensive overview of the database schema for the Relaxly Hotel Management System.

## Core Tables

### 1. Users Management

#### `users`
Main user table for customers, staff, and administrators.
```sql
- id: bigint (Primary Key)
- name: varchar(255)
- email: varchar(255) UNIQUE
- email_verified_at: timestamp NULL
- password: varchar(255)
- shop_name: varchar(200) NULL
- shop_url: varchar(200) NULL
- phone: varchar(200) NULL
- address: text NULL
- city: varchar(200) NULL
- state: varchar(200) NULL
- zip_code: varchar(200) NULL
- country_id: int NULL (Foreign Key to countries)
- photo: varchar(255) NULL
- bactive: varchar(200) NULL
- bkey: varchar(200) NULL
- status_id: int NULL (Foreign Key to user_status)
- role_id: int NULL (Foreign Key to user_roles)
- remember_token: varchar(100) NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `user_roles`
Defines user roles (Admin, Customer, Staff).
```sql
- id: bigint (Primary Key)
- role: varchar(150) NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `user_status`
Defines user status (Active, Inactive).
```sql
- id: bigint (Primary Key)
- status: varchar(150) NULL
- created_at: timestamp
- updated_at: timestamp
```

### 2. Room Management

#### `rooms`
Room types/categories with pricing and details.
```sql
- id: bigint (Primary Key)
- title: varchar(255) NULL
- slug: varchar(255) UNIQUE
- thumbnail: text NULL
- cover_img: text NULL
- short_desc: text NULL
- description: text NULL
- total_adult: int NULL
- total_child: int NULL
- price: decimal(12,3) NULL
- old_price: decimal(12,3) NULL
- amenities: varchar(150) NULL (Comma-separated IDs)
- complements: varchar(150) NULL (Comma-separated IDs)
- beds: varchar(100) NULL (Comma-separated IDs)
- cat_id: int NULL (Foreign Key to categories)
- tax_id: int NULL (Foreign Key to taxes)
- is_discount: int NULL
- is_featured: int NULL
- is_publish: int NULL
- lan: varchar(100) NULL
- og_title: text NULL
- og_image: text NULL
- og_description: text NULL
- og_keywords: text NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `room_manages`
Individual physical rooms with availability status.
```sql
- id: bigint (Primary Key)
- roomtype_id: int NULL (Foreign Key to rooms)
- room_no: varchar(255) NULL
- in_date: date NULL
- out_date: date NULL
- book_status: int NULL (1=Booked, 2=Available)
- is_publish: int NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `room_images`
Images gallery for rooms.
```sql
- id: bigint (Primary Key)
- room_id: int NULL (Foreign Key to rooms)
- thumbnail: text NULL
- large_image: text NULL
- desc: text NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `room_assigns`
Assignment of rooms to bookings.
```sql
- id: bigint (Primary Key)
- booking_id: int NULL (Foreign Key to booking_manages)
- room_id: int NULL (Foreign Key to room_manages)
- roomtype_id: int NULL (Foreign Key to rooms)
- created_at: timestamp
- updated_at: timestamp
```

### 3. Booking Management

#### `booking_manages`
Main booking records with payment and status information.
```sql
- id: bigint (Primary Key)
- booking_no: varchar(100) NULL
- transaction_no: varchar(100) NULL
- roomtype_id: int NULL (Foreign Key to rooms)
- customer_id: int NULL (Foreign Key to users)
- payment_method_id: int NULL (Foreign Key to payment_method)
- payment_status_id: int NULL (Foreign Key to payment_status)
- booking_status_id: int NULL (Foreign Key to booking_status)
- total_room: int NULL
- total_price: decimal(12,3) NULL
- discount: decimal(12,3) NULL
- tax: decimal(12,3) NULL
- subtotal: decimal(12,3) NULL
- total_amount: decimal(12,3) NULL
- paid_amount: decimal(12,3) NULL
- due_amount: decimal(12,3) NULL
- in_date: date NULL
- out_date: date NULL
- name: varchar(255) NULL
- email: varchar(255) NULL
- phone: varchar(255) NULL
- country: varchar(255) NULL
- state: varchar(255) NULL
- zip_code: varchar(255) NULL
- city: varchar(255) NULL
- address: text NULL
- comments: text NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `booking_status`
Booking status options.
```sql
- id: bigint (Primary Key)
- bstatus_name: varchar(255)
- created_at: timestamp
- updated_at: timestamp
```
**Status Values:**
- 1: Request
- 2: Running
- 3: Completed
- 4: Canceled

### 4. Payment Management

#### `payment_status`
Payment status options.
```sql
- id: bigint (Primary Key)
- pstatus_name: varchar(255)
- created_at: timestamp
- updated_at: timestamp
```
**Status Values:**
- 1: Paid
- 2: Pending
- 3: Canceled
- 4: Incompleted

#### `payment_method`
Available payment methods.
```sql
- id: bigint (Primary Key)
- method_name: varchar(255)
- created_at: timestamp
- updated_at: timestamp
```

### 5. Hotel Configuration

#### `categories`
Room categories/types.
```sql
- id: bigint (Primary Key)
- name: varchar(255) NULL
- slug: varchar(255) UNIQUE
- thumbnail: text NULL
- description: text NULL
- lan: varchar(100) NULL
- is_publish: int NULL
- og_title: text NULL
- og_image: text NULL
- og_description: text NULL
- og_keywords: text NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `amenities`
Available room amenities.
```sql
- id: bigint (Primary Key)
- name: varchar(255) NULL
- is_publish: int NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `complements`
Room complements/accessories.
```sql
- id: bigint (Primary Key)
- name: varchar(255) NULL
- item: varchar(255) NULL
- is_publish: int NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `bedtypes`
Types of beds available.
```sql
- id: bigint (Primary Key)
- name: varchar(255) NULL
- is_publish: int NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `taxes`
Tax configurations.
```sql
- id: bigint (Primary Key)
- title: varchar(255) NULL
- percentage: decimal(12,3)
- is_publish: int NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `countries`
Country list for user addresses.
```sql
- id: bigint (Primary Key)
- country_name: varchar(255) NULL
- is_publish: int NULL
- created_at: timestamp
- updated_at: timestamp
```

### 6. System Tables

#### `password_resets`
Laravel password reset tokens.
```sql
- email: varchar(255)
- token: varchar(255)
- created_at: timestamp NULL
```

#### `failed_jobs`
Failed job queue records.
```sql
- id: bigint (Primary Key)
- uuid: varchar(255) UNIQUE
- connection: text
- queue: text
- payload: longtext
- exception: longtext
- failed_at: timestamp DEFAULT CURRENT_TIMESTAMP
```

#### `shoppingcart`
Shopping cart functionality.
```sql
- identifier: varchar(255)
- instance: varchar(255)
- content: longtext
- created_at: timestamp NULL
- updated_at: timestamp NULL
```

### 7. CMS & Content Management

#### `languages`
Multi-language support.
```sql
- id: bigint (Primary Key)
- language_name: varchar(255) NULL
- language_code: varchar(10) NULL
- direction: varchar(10) NULL
- is_default: int NULL
- status: int NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `lankeyvalues`
Language key-value pairs for translations.
```sql
- id: bigint (Primary Key)
- language_id: int NULL
- lan_key: varchar(255) NULL
- lan_value: text NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `pages`
Static pages content.
```sql
- id: bigint (Primary Key)
- title: varchar(255) NULL
- slug: varchar(255) UNIQUE
- description: longtext NULL
- meta_title: text NULL
- meta_description: text NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `blogs`
Blog posts.
```sql
- id: bigint (Primary Key)
- title: varchar(255) NULL
- slug: varchar(255) UNIQUE
- thumbnail: text NULL
- description: longtext NULL
- category_id: int NULL
- is_publish: int NULL
- created_at: timestamp
- updated_at: timestamp
```

#### `blog_categories`
Blog categories.
```sql
- id: bigint (Primary Key)
- name: varchar(255) NULL
- slug: varchar(255) UNIQUE
- description: text NULL
- is_publish: int NULL
- created_at: timestamp
- updated_at: timestamp
```

## Key Relationships

### Primary Relationships:
1. **users.role_id** → **user_roles.id**
2. **users.status_id** → **user_status.id**
3. **users.country_id** → **countries.id**
4. **rooms.cat_id** → **categories.id**
5. **rooms.tax_id** → **taxes.id**
6. **room_manages.roomtype_id** → **rooms.id**
7. **booking_manages.customer_id** → **users.id**
8. **booking_manages.roomtype_id** → **rooms.id**
9. **booking_manages.payment_method_id** → **payment_method.id**
10. **booking_manages.payment_status_id** → **payment_status.id**
11. **booking_manages.booking_status_id** → **booking_status.id**
12. **room_assigns.booking_id** → **booking_manages.id**
13. **room_assigns.room_id** → **room_manages.id**
14. **room_assigns.roomtype_id** → **rooms.id**
15. **room_images.room_id** → **rooms.id**

## Dashboard Metrics Queries

The dashboard uses these key data points:

1. **Financial Metrics:**
   - Total Earnings: SUM(total_amount) WHERE booking_status_id=3 AND payment_status_id=1
   - Pending Payments: SUM(total_amount) WHERE payment_status_id=2
   - Canceled Payments: SUM(total_amount) WHERE payment_status_id=3
   - Incompleted Payments: SUM(total_amount) WHERE payment_status_id=4

2. **Booking Metrics:**
   - Total Completed Bookings: COUNT(*) WHERE booking_status_id=3 AND payment_status_id=1
   - Running Bookings: COUNT(*) WHERE booking_status_id=2
   - Booking Requests: COUNT(*) WHERE booking_status_id=1
   - Canceled Bookings: COUNT(*) WHERE booking_status_id=4

3. **Room Metrics:**
   - Total Room Types: COUNT(*) FROM rooms WHERE is_publish=1
   - Total Rooms: COUNT(*) FROM room_manages WHERE is_publish=1
   - Today's Booked Rooms: COUNT(*) WHERE book_status=1 AND DATE(created_at)=TODAY
   - Available Rooms: COUNT(*) WHERE book_status=2 AND is_publish=1
   - Total Booked Rooms: COUNT(*) WHERE book_status=1 AND is_publish=1

4. **Customer Metrics:**
   - Active Customers: COUNT(*) WHERE role_id=2 AND status_id=1
   - Inactive Customers: COUNT(*) WHERE role_id=2 AND status_id=2
   - Total Users: COUNT(*) WHERE role_id IN (1,3)

## Notes

- The system uses Laravel's standard timestamp fields (created_at, updated_at)
- Many tables include `is_publish` fields for content management
- Financial amounts use decimal(12,3) precision
- The system supports multi-language content through the languages and lankeyvalues tables
- Room amenities, complements, and bed types are stored as comma-separated IDs in the rooms table