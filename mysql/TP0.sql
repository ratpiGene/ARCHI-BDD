-- CREATE DATABASE IF NOT EXISTS TP0;
-- USE TP0;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(255),
  `last_name` varchar(255),
  `email` varchar(255) UNIQUE NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `address` varchar(255),
  `role` varchar(50),
  `is_active` boolean,
  `is_abroad` boolean,
  `created_at` datetime
);

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100)
);

CREATE TABLE IF NOT EXISTS `products` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `description` text,
  `price` decimal(10,2),
  `stock` int,
  `category_id` int,
  `updated_at` datetime
);

CREATE TABLE IF NOT EXISTS `carts` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `created_at` datetime,
  `is_active` boolean
);

CREATE TABLE IF NOT EXISTS `cart_items` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `cart_id` int,
  `product_id` int,
  `quantity` int,
  `unit_price` decimal(10,2)
);

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `created_at` datetime,
  `status` varchar(50),
  `payment_status` varchar(50)
);

CREATE TABLE IF NOT EXISTS `order_items` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `order_id` int,
  `product_id` int,
  `quantity` int,
  `unit_price` decimal(10,2)
);

CREATE TABLE IF NOT EXISTS `order_status_history` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `order_id` int,
  `status` varchar(50),
  `changed_at` datetime
);

ALTER TABLE `products` ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

ALTER TABLE `carts` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `cart_items` ADD FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`);

ALTER TABLE `cart_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `order_status_history` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
