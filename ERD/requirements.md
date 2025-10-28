# erDiagram

# 

# &nbsp;   USER {

# &nbsp;       UUID user\_id PK

# &nbsp;       VARCHAR first\_name

# &nbsp;       VARCHAR last\_name

# &nbsp;       VARCHAR email UNIQUE

# &nbsp;       VARCHAR password\_hash

# &nbsp;       VARCHAR phone\_number

# &nbsp;       ENUM role

# &nbsp;       TIMESTAMP created\_at

# &nbsp;   }

# 

# &nbsp;   PROPERTY {

# &nbsp;       UUID property\_id PK

# &nbsp;       UUID host\_id FK

# &nbsp;       VARCHAR name

# &nbsp;       TEXT description

# &nbsp;       VARCHAR location

# &nbsp;       DECIMAL price\_per\_night

# &nbsp;       TIMESTAMP created\_at

# &nbsp;       TIMESTAMP updated\_at

# &nbsp;   }

# 

# &nbsp;   BOOKING {

# &nbsp;       UUID booking\_id PK

# &nbsp;       UUID property\_id FK

# &nbsp;       UUID user\_id FK

# &nbsp;       DATE start\_date

# &nbsp;       DATE end\_date

# &nbsp;       DECIMAL total\_price

# &nbsp;       ENUM status

# &nbsp;       TIMESTAMP created\_at

# &nbsp;   }

# 

# &nbsp;   PAYMENT {

# &nbsp;       UUID payment\_id PK

# &nbsp;       UUID booking\_id FK

# &nbsp;       DECIMAL amount

# &nbsp;       TIMESTAMP payment\_date

# &nbsp;       ENUM payment\_method

# &nbsp;   }

# 

# &nbsp;   REVIEW {

# &nbsp;       UUID review\_id PK

# &nbsp;       UUID property\_id FK

# &nbsp;       UUID user\_id FK

# &nbsp;       INTEGER rating

# &nbsp;       TEXT comment

# &nbsp;       TIMESTAMP created\_at

# &nbsp;   }

# 

# &nbsp;   MESSAGE {

# &nbsp;       UUID message\_id PK

# &nbsp;       UUID sender\_id FK

# &nbsp;       UUID recipient\_id FK

# &nbsp;       TEXT message\_body

# &nbsp;       TIMESTAMP sent\_at

# &nbsp;   }

# 

# &nbsp;   USER ||--o{ PROPERTY : "hosts"

# &nbsp;   USER ||--o{ BOOKING : "books"

# &nbsp;   PROPERTY ||--o{ BOOKING : "is booked in"

# &nbsp;   BOOKING ||--|| PAYMENT : "has"

# &nbsp;   USER ||--o{ REVIEW : "writes"

# &nbsp;   PROPERTY ||--o{ REVIEW : "receives"

# &nbsp;   USER ||--o{ MESSAGE : "sends"

# &nbsp;   USER ||--o{ MESSAGE : "receives"

# 

