drop database jnc;
create database jnc;
use jnc;

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `name` varchar(300) NOT NULL,
  `orders` int DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
  );

DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`name`)
);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(200) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `roles` json NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` varchar(255) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` text,
  `image_feedback` json DEFAULT NULL,
  `images` json DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `name` varchar(300) NOT NULL,
  `price` bigint DEFAULT NULL,
  `sale_price` bigint DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `status` int DEFAULT NULL,
  `total_sold` bigint DEFAULT NULL,
  `product_view` int DEFAULT NULL,
  `brand_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`brand_id`),
  CONSTRAINT FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`)
);

DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `product_id` varchar(255) NOT NULL,
  `category_id` bigint NOT NULL,
  KEY (`category_id`),
  KEY (`product_id`),
  CONSTRAINT FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
);

DROP TABLE IF EXISTS `product_size`;
CREATE TABLE `product_size` (
  `product_id` varchar(255) NOT NULL,
  `size` int NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`product_id`,`size`)
);

DROP TABLE IF EXISTS `promotion`;
CREATE TABLE `promotion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `coupon_code` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `discount_type` int DEFAULT NULL,
  `discount_value` bigint DEFAULT NULL,
  `expired_at` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `maximum_discount_value` bigint DEFAULT NULL,
  `name` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`coupon_code`)
);

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `price` bigint DEFAULT NULL,
  `promotion` json DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `receiver_address` varchar(255) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `receiver_phone` varchar(255) DEFAULT NULL,
  `size` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `total_price` bigint DEFAULT NULL,
  `buyer` bigint DEFAULT NULL,
  `created_by` bigint DEFAULT NULL,
  `modified_by` bigint DEFAULT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`buyer`),
  KEY (`created_by`),
  KEY (`modified_by`),
  KEY (`product_id`),
  CONSTRAINT FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT FOREIGN KEY (`modified_by`) REFERENCES `users` (`id`),
  CONSTRAINT FOREIGN KEY (`buyer`) REFERENCES `users` (`id`),
  CONSTRAINT FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
);

DROP TABLE IF EXISTS `statistic`;
CREATE TABLE `statistic` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `profit` bigint DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `sales` bigint DEFAULT NULL,
  `order_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`order_id`),
  CONSTRAINT FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
);

DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text,
  `created_at` datetime(6) DEFAULT NULL,
  `description` text,
  `modified_at` datetime(6) DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `slug` varchar(600) NOT NULL,
  `status` int DEFAULT '0',
  `thumbnail` varchar(255) DEFAULT NULL,
  `title` varchar(300) NOT NULL,
  `created_by` bigint DEFAULT NULL,
  `modified_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`created_by`),
  KEY (`modified_by`),
  CONSTRAINT FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT FOREIGN KEY (`modified_by`) REFERENCES `users` (`id`)
);

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text,
  `created_at` datetime(6) DEFAULT NULL,
  `post_id` bigint DEFAULT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`post_id`),
  KEY  (`product_id`),
  KEY  (`user_id`),
  CONSTRAINT FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
);

DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `id` varchar(255) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `size` bigint DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`link`),
  KEY (`created_by`),
  CONSTRAINT FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
);
-- tai khoan admin: admin@gmail.com/admin@123 --
INSERT INTO `users` VALUES (2,NULL,NULL,'2025-05-07 13:43:08.676000','admin@gmail.com','Admin',NULL,'$2a$12$6vOrz9fOe1OFg5/9jzP8KeJEAIS4zjZe5RyuuPe6.pprqua3J/AUu','0969708715','[\"ADMIN\"]',1);
select * from users
