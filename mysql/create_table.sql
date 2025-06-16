mysql -u Gene -p
-- Create a database named 'test'
-- and a table named 'test_table' with a primary key and an auto-incrementing column
CREATE DATABASE test;
USE test;
CREATE TABLE test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);
EXIT;