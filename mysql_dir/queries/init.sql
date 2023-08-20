-- Example of initializing "sellers" and "buyers" tables with 15 entries each
CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

-- Create the "sellers" table
CREATE TABLE sellers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    product VARCHAR(100) NOT NULL
);

-- Insert 15 entries into the "sellers" table
INSERT INTO sellers (name, product) VALUES
    ('John', 'Laptop'),
    ('Alice', 'Smartphone'),
    ('Bob', 'Tablet'),
    ('Emma', 'Digital Camera'),
    ('David', 'Headphones'),
    ('Olivia', 'Television'),
    ('Michael', 'Coffee Maker'),
    ('Sophia', 'Bluetooth Speaker'),
    ('William', 'Gaming Console'),
    ('Mia', 'Fitness Tracker'),
    ('James', 'Kitchen Blender'),
    ('Ella', 'Vacuum Cleaner'),
    ('Benjamin', 'E-book Reader'),
    ('Ava', 'Smartwatch'),
    ('Samuel', 'Drone');

-- Create the "buyers" table
CREATE TABLE buyers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    purchased_product VARCHAR(100) NOT NULL
);

-- Insert 15 entries into the "buyers" table
INSERT INTO buyers (name, purchased_product) VALUES
    ('Sophie', 'Laptop'),
    ('Noah', 'Smartphone'),
    ('Liam', 'Tablet'),
    ('Isabella', 'Digital Camera'),
    ('Oliver', 'Headphones'),
    ('Charlotte', 'Television'),
    ('Lucas', 'Coffee Maker'),
    ('Ava', 'Bluetooth Speaker'),
    ('Elijah', 'Gaming Console'),
    ('Amelia', 'Fitness Tracker'),
    ('Mason', 'Kitchen Blender'),
    ('Harper', 'Vacuum Cleaner'),
    ('Ethan', 'E-book Reader'),
    ('Abigail', 'Smartwatch'),
    ('Logan', 'Drone');



