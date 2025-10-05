# Hotel Management System - Database Schema Diagram

## Entity Relationship Diagram (Mermaid)

```mermaid
erDiagram
    %% User Management
    users {
        bigint id PK
        string name
        string email UK
        string password
        string phone
        text address
        string city
        string state
        string zip_code
        int country_id FK
        string photo
        int status_id FK
        int role_id FK
        timestamp created_at
        timestamp updated_at
    }
    
    user_roles {
        bigint id PK
        string role
        timestamp created_at
        timestamp updated_at
    }
    
    user_status {
        bigint id PK
        string status
        timestamp created_at
        timestamp updated_at
    }
    
    countries {
        bigint id PK
        string country_name
        int is_publish
        timestamp created_at
        timestamp updated_at
    }
    
    %% Room Management
    rooms {
        bigint id PK
        string title
        string slug UK
        text thumbnail
        text cover_img
        text description
        int total_adult
        int total_child
        decimal price
        decimal old_price
        string amenities
        string complements
        string beds
        int cat_id FK
        int tax_id FK
        int is_discount
        int is_featured
        int is_publish
        string lan
        timestamp created_at
        timestamp updated_at
    }
    
    room_manages {
        bigint id PK
        int roomtype_id FK
        string room_no
        date in_date
        date out_date
        int book_status
        int is_publish
        timestamp created_at
        timestamp updated_at
    }
    
    room_images {
        bigint id PK
        int room_id FK
        text thumbnail
        text large_image
        text desc
        timestamp created_at
        timestamp updated_at
    }
    
    room_assigns {
        bigint id PK
        int booking_id FK
        int room_id FK
        int roomtype_id FK
        timestamp created_at
        timestamp updated_at
    }
    
    categories {
        bigint id PK
        string name
        string slug UK
        text thumbnail
        text description
        string lan
        int is_publish
        timestamp created_at
        timestamp updated_at
    }
    
    amenities {
        bigint id PK
        string name
        int is_publish
        timestamp created_at
        timestamp updated_at
    }
    
    complements {
        bigint id PK
        string name
        string item
        int is_publish
        timestamp created_at
        timestamp updated_at
    }
    
    bedtypes {
        bigint id PK
        string name
        int is_publish
        timestamp created_at
        timestamp updated_at
    }
    
    %% Booking Management
    booking_manages {
        bigint id PK
        string booking_no
        string transaction_no
        int roomtype_id FK
        int customer_id FK
        int payment_method_id FK
        int payment_status_id FK
        int booking_status_id FK
        int total_room
        decimal total_price
        decimal discount
        decimal tax
        decimal subtotal
        decimal total_amount
        decimal paid_amount
        decimal due_amount
        date in_date
        date out_date
        string name
        string email
        string phone
        string country
        string state
        string zip_code
        string city
        text address
        text comments
        timestamp created_at
        timestamp updated_at
    }
    
    booking_status {
        bigint id PK
        string bstatus_name
        timestamp created_at
        timestamp updated_at
    }
    
    %% Payment Management
    payment_status {
        bigint id PK
        string pstatus_name
        timestamp created_at
        timestamp updated_at
    }
    
    payment_method {
        bigint id PK
        string method_name
        timestamp created_at
        timestamp updated_at
    }
    
    %% Configuration
    taxes {
        bigint id PK
        string title
        decimal percentage
        int is_publish
        timestamp created_at
        timestamp updated_at
    }
    
    %% Content Management
    pages {
        bigint id PK
        string title
        string slug UK
        longtext description
        text meta_title
        text meta_description
        timestamp created_at
        timestamp updated_at
    }
    
    blogs {
        bigint id PK
        string title
        string slug UK
        text thumbnail
        longtext description
        int category_id FK
        int is_publish
        timestamp created_at
        timestamp updated_at
    }
    
    blog_categories {
        bigint id PK
        string name
        string slug UK
        text description
        int is_publish
        timestamp created_at
        timestamp updated_at
    }
    
    languages {
        bigint id PK
        string language_name
        string language_code
        string direction
        int is_default
        int status
        timestamp created_at
        timestamp updated_at
    }
    
    lankeyvalues {
        bigint id PK
        int language_id FK
        string lan_key
        text lan_value
        timestamp created_at
        timestamp updated_at
    }
    
    %% Relationships
    users ||--o{ booking_manages : "customer_id"
    users }o--|| user_roles : "role_id"
    users }o--|| user_status : "status_id"
    users }o--|| countries : "country_id"
    
    rooms ||--o{ room_manages : "roomtype_id"
    rooms ||--o{ room_images : "room_id"
    rooms ||--o{ booking_manages : "roomtype_id"
    rooms }o--|| categories : "cat_id"
    rooms }o--|| taxes : "tax_id"
    
    room_manages ||--o{ room_assigns : "room_id"
    
    booking_manages ||--o{ room_assigns : "booking_id"
    booking_manages }o--|| payment_method : "payment_method_id"
    booking_manages }o--|| payment_status : "payment_status_id"
    booking_manages }o--|| booking_status : "booking_status_id"
    
    blogs }o--|| blog_categories : "category_id"
    
    lankeyvalues }o--|| languages : "language_id"
```

## Simplified Core Relationships

```mermaid
graph TB
    %% Core entities
    Users[👥 Users<br/>Admin, Staff, Customers]
    Rooms[🏨 Room Types<br/>Deluxe, Standard, Suite]
    RoomManages[🚪 Physical Rooms<br/>Room 101, 102, etc.]
    Bookings[📋 Bookings<br/>Reservations]
    
    %% Status tables
    BookingStatus[📊 Booking Status<br/>Request, Running, Completed]
    PaymentStatus[💳 Payment Status<br/>Paid, Pending, Canceled]
    
    %% Configuration
    Categories[🏷️ Categories]
    Amenities[🛏️ Amenities]
    Taxes[💰 Taxes]
    
    %% Relationships
    Users --> Bookings
    Rooms --> RoomManages
    Rooms --> Bookings
    RoomManages --> Bookings
    Categories --> Rooms
    Amenities -.-> Rooms
    Taxes --> Rooms
    BookingStatus --> Bookings
    PaymentStatus --> Bookings
    
    %% Styling
    classDef userClass fill:#e1f5fe
    classDef roomClass fill:#f3e5f5
    classDef bookingClass fill:#e8f5e8
    classDef configClass fill:#fff3e0
    
    class Users userClass
    class Rooms,RoomManages,Categories,Amenities roomClass
    class Bookings,BookingStatus,PaymentStatus bookingClass
    class Taxes configClass
```

## Dashboard Data Flow

```mermaid
flowchart TD
    A[Dashboard Controller] --> B{Fetch Metrics}
    
    B --> C[Financial Metrics]
    B --> D[Booking Metrics]
    B --> E[Room Metrics]
    B --> F[Customer Metrics]
    
    C --> C1[Total Earnings<br/>booking_status_id=3 AND payment_status_id=1]
    C --> C2[Pending Payments<br/>payment_status_id=2]
    C --> C3[Canceled Payments<br/>payment_status_id=3]
    C --> C4[Incomplete Payments<br/>payment_status_id=4]
    
    D --> D1[Completed Bookings<br/>booking_status_id=3]
    D --> D2[Running Bookings<br/>booking_status_id=2]
    D --> D3[Booking Requests<br/>booking_status_id=1]
    D --> D4[Canceled Bookings<br/>booking_status_id=4]
    
    E --> E1[Total Room Types<br/>rooms WHERE is_publish=1]
    E --> E2[Total Rooms<br/>room_manages WHERE is_publish=1]
    E --> E3[Today's Booked<br/>book_status=1 AND today]
    E --> E4[Available Rooms<br/>book_status=2]
    
    F --> F1[Active Customers<br/>role_id=2 AND status_id=1]
    F --> F2[Inactive Customers<br/>role_id=2 AND status_id=2]
    F --> F3[Total Users<br/>role_id IN (1,3)]
    
    style A fill:#ff9999
    style C fill:#99ccff
    style D fill:#99ff99
    style E fill:#ffcc99
    style F fill:#cc99ff
```