SHOW TABLES IN guest_room_booking;

SHOW TABLES;

USE guest_room_booking;
SELECT * FROM house_owner;

SHOW DATABASES;


CREATE TABLE house_owner (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);
INSERT INTO house_owner (username, email, phone_number, password_hash) VALUES
('owner1', 'owner1@example.com', '1234567890', 'pbkdf2:sha256:600000$samplehash1'),
('owner2', 'owner2@example.com', '1234567891', 'pbkdf2:sha256:600000$samplehash2'),
('owner3', 'owner3@example.com', '1234567892', 'pbkdf2:sha256:600000$samplehash3'),
('owner4', 'owner4@example.com', '1234567893', 'pbkdf2:sha256:600000$samplehash4'),
('owner5', 'owner5@example.com', '1234567894', 'pbkdf2:sha256:600000$samplehash5'),
('owner6', 'owner6@example.com', '1234567895', 'pbkdf2:sha256:600000$samplehash6'),
('owner7', 'owner7@example.com', '1234567896', 'pbkdf2:sha256:600000$samplehash7'),
('owner8', 'owner8@example.com', '1234567897', 'pbkdf2:sha256:600000$samplehash8'),
('owner9', 'owner9@example.com', '1234567898', 'pbkdf2:sha256:600000$samplehash9'),
('owner10', 'owner10@example.com', '1234567899', 'pbkdf2:sha256:600000$samplehash10');

SELECT * FROM house_owner;

CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

INSERT INTO customer (username, email, phone_number, password_hash) VALUES
('customer1', 'customer1@example.com', '0987654321', 'pbkdf2:sha256:600000$samplehash1'),
('customer2', 'customer2@example.com', '0987654322', 'pbkdf2:sha256:600000$samplehash2'),
('customer3', 'customer3@example.com', '0987654323', 'pbkdf2:sha256:600000$samplehash3'),
('customer4', 'customer4@example.com', '0987654324', 'pbkdf2:sha256:600000$samplehash4'),
('customer5', 'customer5@example.com', '0987654325', 'pbkdf2:sha256:600000$samplehash5');

SHOW TABLES;

DESCRIBE house_owner;
DESCRIBE customer;

SELECT * FROM house_owner;

SHOW TABLES;

CREATE TABLE room (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    floor_size FLOAT NOT NULL,
    beds INT NOT NULL,
    amenities VARCHAR(200),
    rent_per_day FLOAT NOT NULL,
    owner_id INT,
    FOREIGN KEY (owner_id) REFERENCES house_owner(id)
);



SELECT * FROM customer;

SELECT email, password_hash FROM house_owner;
SELECT email, password_hash FROM customer;
